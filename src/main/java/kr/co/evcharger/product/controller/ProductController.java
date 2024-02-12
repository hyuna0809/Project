package kr.co.evcharger.product.controller;

import kr.co.evcharger.product.dao.ProductRepository;
import kr.co.evcharger.product.dto.Product;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;


@Controller
public class ProductController {
    @GetMapping("/products")
    public String products() {

        return "product/products";
    }

    @GetMapping("/shippingInfo")
    public String shippingInfo() {

        return "product/shippingInfo";
    }

    @GetMapping("/product")
    public String product(@RequestParam("p_id") String productId, Model model) {
        model.addAttribute("p_id", productId);
        return "product/product";
    }

    @PostMapping("/updateCart")
    @ResponseBody
    public String updateCart(@RequestBody List<Product> cartList, HttpSession session) {
        // 기존 세션에서 기존 장바구니 정보를 가져옴
        List<Product> existingCartList = (List<Product>) session.getAttribute("cartlist");

        // 만약 세션에 기존 장바구니 정보가 없으면 새로운 리스트 생성
        if (existingCartList == null) {
            existingCartList = new ArrayList<>();
        }

        // 장바구니 정보 업데이트
        for (Product newProduct : cartList) {
            boolean productExists = false;

            // 기존 장바구니에 같은 상품이 있는지 확인
            for (Product existingProduct : existingCartList) {
                if (existingProduct.getProductId().equals(newProduct.getProductId())) {
                    // 이미 있는 경우 수량 증가
                    existingProduct.setQuantity(existingProduct.getQuantity() + newProduct.getQuantity());
                    productExists = true;
                    break;
                }
            }

            // 기존 장바구니에 없는 경우 새로운 상품 추가
            if (!productExists) {
                existingCartList.add(newProduct);
            }
        }

        // 세션 업데이트
        session.setAttribute("cartlist", existingCartList);

        return "{\"status\": \"success\"}";
    }

    @RequestMapping("/cart")
    public String showCart(Model model, HttpSession session) {
        List<Product> cartList = (List<Product>) session.getAttribute("cartlist");
        model.addAttribute("cartList", cartList);

        return "product/cart";
    }


    @GetMapping("/connector")
    public String connector() {
        return "product/connector";
    }

    @GetMapping("/cover")
    public String cover() {
        return "product/cover";
    }

    @GetMapping("/goods")
    public String goods() {
        return "product/goods";
    }

    @GetMapping("/menu")
    public String menu() {
        return "product/menubar";
    }
    @PostMapping("/removeCart")
    @ResponseBody
    public String removeCartItem(@RequestBody Map<String, List<Map<String, String>>> request, HttpSession session) {
        try {
            // 세션에서 장바구니 목록을 가져옴
            List<Product> existingCartList = (List<Product>) session.getAttribute("cartlist");

            if (existingCartList != null && request.containsKey("cartList")) {
                List<Map<String, String>> cartList = request.get("cartList");

                // 장바구니에 있는 각 상품에 대해 제거 여부 확인
                for (Map<String, String> cartProduct : cartList) {
                    String productIdToRemove = cartProduct.get("productId");

                    // 기존 장바구니 목록에서 제품 ID가 일치하는 항목을 찾아 제거
                    Iterator<Product> existingIterator = existingCartList.iterator();
                    while (existingIterator.hasNext()) {
                        Product existingProduct = existingIterator.next();
                        if (existingProduct.getProductId().equals(productIdToRemove)) {
                            existingIterator.remove();
                            break;
                        }
                    }
                }

                // 세션에서 장바구니 목록을 업데이트
                session.setAttribute("cartlist", existingCartList);

                // 성공적으로 처리되었음을 클라이언트에게 알림
                return "{\"status\": \"success\"}";
            } else {
                // 요청 형식이 올바르지 않은 경우
                return "{\"status\": \"error\", \"message\": \"Invalid request format\"}";
            }
        } catch (Exception e) {
            // 실패한 경우 에러 처리 로직을 추가할 수 있습니다.
            return "{\"status\": \"error\", \"message\": \"Internal server error\"}";

        }

    }

    @PostMapping("/processShippingInfo")
    public String processShippingInfo(
            @RequestParam String cartId,
            @RequestParam String name,
            @RequestParam String shippingDate,
            @RequestParam String country,
            @RequestParam String zipCode,
            @RequestParam String addressName,
            HttpServletResponse response,
            Model model) {

        // 여기에서 데이터를 처리하고 필요한 로직을 추가할 수 있습니다.

        // 쿠키 생성 및 설정
        Cookie cartIdCookie = new Cookie("Shipping_cartId", cartId);
        response.addCookie(cartIdCookie);

        // 나머지 쿠키도 설정
        Cookie nameCookie = new Cookie("Shipping_name", name);
        response.addCookie(nameCookie);

        Cookie shippingDateCookie = new Cookie("Shipping_shippingDate", shippingDate);
        response.addCookie(shippingDateCookie);

        Cookie countryCookie = new Cookie("Shipping_country", country);
        response.addCookie(countryCookie);

        Cookie zipCodeCookie = new Cookie("Shipping_zipCode", zipCode);
        response.addCookie(zipCodeCookie);

        Cookie addressNameCookie = new Cookie("Shipping_addressName", addressName);
        response.addCookie(addressNameCookie);

        // 쿠키를 설정한 후에 다른 페이지로 리다이렉트 또는 응답을 처리할 수 있습니다.
        return "redirect:/orderConfirmation"; // 성공 페이지로 리다이렉트 예시
    }
    // orderConfirmation 메서드에서 @CookieValue 어노테이션을 사용, 쿠키 값을 받아오고 모델에 추가
    // 따로 쿠키를 설정할 필요가 없어서 processShippingInfo.jsp 필요없음 ,페이지에서 모델을 통해 쿠키 값을 사용할 수 있다.
    @GetMapping("/orderConfirmation")
    public String orderConfirmation(Model model, @CookieValue(value = "Shipping_cartId", defaultValue = "") String shippingCartId,
                                    @CookieValue(value = "Shipping_name", defaultValue = "") String shippingName,
                                    @CookieValue(value = "Shipping_shippingDate", defaultValue = "") String shippingShippingDate,
                                    @CookieValue(value = "Shipping_country", defaultValue = "") String shippingCountry,
                                    @CookieValue(value = "Shipping_zipCode", defaultValue = "") String shippingZipCode,
                                    @CookieValue(value = "Shipping_addressName", defaultValue = "") String shippingAddressName) {

        // 기존 쿠키들을 다시 설정
        model.addAttribute("Shipping_cartId", shippingCartId);
        model.addAttribute("Shipping_name", shippingName);
        model.addAttribute("Shipping_shippingDate", shippingShippingDate);
        model.addAttribute("Shipping_country", shippingCountry);
        model.addAttribute("Shipping_zipCode", shippingZipCode);
        model.addAttribute("Shipping_addressName", shippingAddressName);

        // 추가적인 모델 속성 등을 설정

        return "product/orderConfirmation"; // orderConfirmation.jsp 또는 해당 뷰 이름으로 수정
    }


    @GetMapping("/thankCustomer")
    public String thankCustomer(){
        return "product/thankCustomer";
    }

    @GetMapping("/checkOutCancelled")
    public String checkOutCancelled(){
        return "product/checkOutCancelled";
    }

}
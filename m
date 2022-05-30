Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDD7537803
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbiE3IyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 04:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbiE3Ixz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 04:53:55 -0400
Received: from sonic309-19.consmr.mail.sg3.yahoo.com (sonic309-19.consmr.mail.sg3.yahoo.com [106.10.244.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B1613F65
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 01:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com.tw; s=s2048; t=1653900783; bh=pFufFWe4/hvmh/UF2IjAYcVzbttmJoCx8ZLbp3kR0E8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=eOB+jbY7mNihFbZ5/On+yfKgSuG1VMcMwFhQ3qpuhtoMaqcmbPmy7iB39gLsehWDriJqNcPoZ7WQdKIrc4EYi+JiXG7qtfLGihPmW6e1srf4I/st+zIX8zjXDW07cAax1Cc9RvmMyrJF9+2+zqYQ7ltGF2TtVL+qBbAvNyeMsnMLdyqXjYycKE/dxio+JZ4QGWRSvQipPMON5bwDeegyAMB1Njtu7AEz1HCf6PRCdmktnCinnF2/fD5N9n02IO6Q5xO+pZEOCFxFE1klj9nAydcBHCVV9I1IrdyJhOBDhoOa04CdhUwvO7PcS5OMWdzvQQthooyVywE2NIaY0ZpGiw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1653900783; bh=1S0ZbSLQkydb6m6LTIm9wp0V93qCMYioO6sU5Yiky8E=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=RM1ebcBAIxNjlBxlBMjv70evPklI3W1lw05x7OXoz/8dtG5Euwvmlvz1wvgYH9GQFTdK1eNDpk0lDT/LFrA4KEbda/IAGo0DHkIKoF4Shotj9g0m2eBG7TicLriC1zcVTybQOPyKXBGSprbza5tk2Mm7DPoW3nn/tc/6pYikM/35auP2qNx7ajf2/TJXueMd0zjMp9EIzDIXLwTgdq52yC6RyliRu7/UiLCEKuggCYDTHn6bzGM0ttiS4pilVOd3XAoNt50oZuHJ0mBf8X6tvX7Vjky9IyAlg0eQLXGNzUcT2QfrB9tKRm2UzVZNYVAl24TnK5mOGlw1bIOoodQBNg==
X-YMail-OSG: Ax_qbXwVM1kxaLdMT7dNlrz1TsWxcbn33GLBeRUGGmDgvw4L.9byX.2rpmdJcuG
 S_TOkG6HGYzRGyE9E7_mJ3PwzYtuE7SRZavKy8T2xMQvku53aBZdEZPR4NEJfblmlREOONdiIuxq
 r8eg0sent1._fJbctl1iBa_j2_xuEtv59G.QbuUz1AYLGvC2Uvcgb8jysUdjzEFhb4HU0lx1Zn9N
 72aZ4EN9KheYjDDTqwYk4XMnmT36n.hy5Dyj.qTGxEoC11SWTUZ_DUabylCKmbaZl1tAx08S0EI0
 USd93m3RsqKTbuek9DPg4pS4zi9CsIDTGVy_c9w6rx_OwWTiJEBURpaQ5ytw7YOwuOaE19LpR9Gp
 ILEMk7gllXN1TAAnUyuJJ9.lP6SDUxtKKLkRj8Rqt7ZOajFRFoDdK7i.4PEAZ3qIGcrGrCNsf1oG
 6oJ08UO4ewEUr.ROgyVp4Mfc1mzcsnVM8rYl5409GvPZDtwids0vusa1722oJt9gh82QSdYskBxU
 vzf604ejde2xUgbSVXCPtRU8aLV2Ze8qbH6Xbz9iLvrnaS3A0Fr5NG14ek99z.89D.5lnFL95zFm
 5ye4H1stkra6CrabAGkxHysVEZ3WYRREyaaPvn.dTwyH1VRhNQ8dJPikJTB3pzKE2i90f6FihWZg
 PqzZTG1m3GACVHg1FgnF.ChVf805mrsjArM2cHHFeV9YwHnajcuzPaGlreNcEOW12GBJaFESLCKt
 PCVWuCkDEksY3JvRS70oaDwyBw.8Ep7R9kMuD8bRlGR5mI7eSvWme.A5qsU8AdKU4b3cb6jorsPD
 aTQ2e0mBqKbZDhBFEmazbwIw8NLMerMfR1JJ0nrH2WmZ0CjaP3T53LuBtxTmWcPRmzJswY7t7pJk
 ZxxpPNjJJTGF2VT7NwbH29vH8rU4tDkDAEW7zhPMaudg6pjqPMCIC8HsyffaMdKSypJzOcJ3Sek6
 YXhHaT3YFyPv_EEb13_gaKD2XJ8VqNJdBbZ8h2yEUIXjKd9V2PMusGdUr4BNwFPrUCeqpBrCDBTO
 At.82Ki_rezhpxYbTx.WM3q9xzX7wET8rTCNOGTFXecfgQAj9q__JsM_7ZUyyd0LZ1xOEF_CKIXL
 Mge0FR.KTrFM_ksrfjD1fy2hThz_9JBJXHVr2KYggbBfT9xHWkyWBHjyGP3f1PexFCXqiepWCLU0
 7aLt2zELGcQklPRPOqP1exMFSBHRD1f8eirSW1rtwrCohVLWK91DhVBqtOjIpfdngk0dZxASaZhf
 JvT1KGrlmJgzLmScGmOueJkmyaiI0w.h06zxOMD82ZoBSNsAfnVE6PhLGaMeMPut0Exzqn5ha38v
 DEXb0_YO6I6NR.XoANmlIBpvYKo6sEoLlryOFVxFqhiozRLMNeS1evcO6.45U_FL88K7wKQTw0wh
 XUG5ryE9sOMCKWfXw6FB6mijutv1CRg5zQCtALtv5ElWPOWPBrUzk3uwTZ5wRPZIvk.AP0eKL0j3
 Ma9P7E8awnL92jtrj7kdQZEfSokhf0LxjsyuTQCqvaWb9IdENGDtB4.jNglyzaU0MhAYMFsWzdW1
 SXib.jf9GC8RpH33vggzudzx.eEEz6_4LQnFdqurOSREw9C4MrbhfKxUaJMBNrstm_Ae5C_lF61y
 VDb71lkkE3JgISCbhgfpHSSuK5Z6M5lgWtlu7Yue_cQtIscCY38u5ujwTsUTJbPktWxOObmie6d6
 WU1yqRXf3jhh4epArA3bVb8EPLCR9_7kY0LEhpQTXFxxiamE3JVD1q5qjEMgs.tGbgHX8uXD35Ke
 AQxrEqTgJtiq5CyhEWRwcfBkK0_CNvv9hc2eyhzsNaJEe2QaYZLcumeaLuuPapUZimmoxLCiLS7f
 2W2VgMWurP_PbbiSk4NQ7nkLfyvv.BajPnZseJicE41Frr6SUVIEHh1GE2Oe.GEX0YcK9ait_dMr
 yNu18BjfECU8b3oIyVnmUkUUERS6WEVzuEA62s__9SWJnTOp86itoK6rsj3N4YI4YHEeMF1moWLD
 rARGfGSb5Y4OmoFN7omeYnbEVLmjm8ffwCRGXVzkZWGIfhhDoNxK4WzaXKum1A3gkEAGDi7t55CY
 guj2RWi_8POjkkoMVLi5rbpjSmnxLFOrkHTlY6.MQ2ZgMZ.dVUKxYoZZAEXaJEiQH5pDP76uHM76
 5jlH2PLGAx_PDorn6LFyHSO13kEZsul0whvBox0ZhldtXKX.aScYLmREl1GKpr9fcPi.g8ZnomNy
 MPzfxF9lS6C88pFYrCzyit_IT.hjff9cBOYV4eeCI0qWrZVELt8ujxZtzW0maGQKNeqM8wZN9oey
 GykZCfg--
X-Sonic-MF: <ae40515@yahoo.com.tw>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.sg3.yahoo.com with HTTP; Mon, 30 May 2022 08:53:03 +0000
Received: by hermes--canary-production-sg3-5f7658c994-snt2x (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4bfcb23823043c6a9188dedc10ad49b5;
          Mon, 30 May 2022 08:53:00 +0000 (UTC)
From:   Alec Su <ae40515@yahoo.com.tw>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, y.oudjana@protonmail.com,
        Alec Su <ae40515@yahoo.com.tw>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH v3 1/2] dt-bindings: arm: qcom: Document xiaomi,natrium board
Date:   Mon, 30 May 2022 08:52:26 +0000
Message-Id: <20220530085227.29264-2-ae40515@yahoo.com.tw>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220530085227.29264-1-ae40515@yahoo.com.tw>
References: <20220530085227.29264-1-ae40515@yahoo.com.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Xiaomi Mi 5s Plus (xiaomi-natrium) smartphone which is based on
Snapdragon 821 SoC.

Signed-off-by: Alec Su <ae40515@yahoo.com.tw>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 5c06d1bfc046..7ee852079d13 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -190,6 +190,7 @@ properties:
               - sony,kagura-row
               - sony,keyaki-row
               - xiaomi,gemini
+              - xiaomi,natrium
               - xiaomi,scorpio
           - const: qcom,msm8996
 
-- 
2.35.3


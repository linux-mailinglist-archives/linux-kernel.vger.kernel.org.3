Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE3A53DFCE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 04:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352250AbiFFCrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 22:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352226AbiFFCrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 22:47:25 -0400
Received: from sonic308-21.consmr.mail.sg3.yahoo.com (sonic308-21.consmr.mail.sg3.yahoo.com [106.10.241.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21A4B1FE
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 19:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com.tw; s=s2048; t=1654483642; bh=pFufFWe4/hvmh/UF2IjAYcVzbttmJoCx8ZLbp3kR0E8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=d0f0NFNdtmzg4Sx1CCABznG/rRqC5kVxZjkm882uwSNglqO+piOuVKY8rdU4s1Tcre0Le0geSOJIOdMiuxJuRBR4fZNWpy+cY6v5Hzu7D5waThfMdtcRuE1D+CNMhYMFH2VFCUFpn+f6LXTbkrBroZLislxZ0lLYBjFVzlX6noDovqo10mSa6qhuinu0AwcxrVQl8EmIsU773B1xY61c/75xHGEmmKqNNwfZqraZhS+7XMSmWLjVWuc4lhyQrpGx/N3WzR3lu0BhDFp30rCZYNSiyY15/KSUutVn0hl15onMTUwkNICyMtsK/S/2yqO72cZcI8qG0/mLJNqYAO2Xgg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654483642; bh=Nuuoc66IFOfvwKgb/My8kCi2SyVolRXD+i9oS+3rh2i=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=MHqpjDCuzS0pYVRaLm/GluUTLhEz7NM8cXv7xWlD7hwWKMo9waEg4RnBSYh7D6xiNtbqY87AYuzwFeSVyvfO4UnOIMruFZ8Zflifpee480l6qBRqHFmqgblwL3/9HYDmk6i6gaoYg/uqFKpIr1W0nEQZEx62YhOKRGllByHCbTxeMLNQTpJ/76qx6/rm0g6ZOFqK9rIe2DVWriILvbCAKc1mj2rRRteiltqO1CmvJ+//DckltGvvUUWD6LUi6TclXQy1PZO9BIarDqLcJTDKWiErKWD5H6NTdhpBVanW0QP9mTONqioEaSNyRy0XG2S9dQMLynHnChtshlSgScv0rA==
X-YMail-OSG: RA5gxTYVM1kGpcFqHDvGOxhYfHKhujVEiYxg..iLDKIU4_ejhR3dcJQAD0lZAlY
 MV6riTePNDbMDLRRHQVUG4O9jz1IqZ1jSxqAh36P2gNeuniqPKRm_La329zma.3Bs74KhHis1yM3
 pYM5qYSF0dWM2Yimkf2blX5cO7YfJwJXtUfRkpCqKKeRp9lgxVJw2t3vEsxwfABx7aPasom936SI
 _WWGuI5BtXslSzTdKX_426TgmZnzAioY7dJApn8yb5TngCUwFtHFUL7NrtkmKdzi0k9AjCyBuRK.
 YnOSmmW.TWQuBOKHpI.gWKY_fEortR0lT.RSDWXUN8JQPrlbwvLPfAXOJT8aO_WeF4TcZn6gKNU8
 LXEMyS9WvksPBfQdNSw5LynIWd7_Lyhh_XPGhjze7aYVqaFzIQkJK8evGBUnhHGxgIjzKQQkylMt
 V7c3MDq1eZ7y84cWsvlZz.9m5NQo1IPylgTs05soUJDzwWaAetUyPTho5jGVGlTnU.1ReYGnFF61
 _CIijYoY3kOF9e4HcSCpudDqfYRk1AYyGRNCUpAy7ePaed2QpDuH78S9e.PgNSrk4iH53vqxW7Ot
 1zC8UTpbBEZCBPVUu7dpDLqQXCBISClmIV54R89QCTrPHgfwa80D0xXQQ3e0MYIVXuq9LR4y2UQ7
 UcWJsA0633OZpDTGxSBkf..HfHxa4SNLNrsHItp_cXZlQqvBruTzwuuTh8Upi4RVr2cmACsJMAzr
 m.i2wakD9C9xiIihQtbsLMKSIgrYeVUyPblK1qsGXkI63vkEFGt_5kMStba_AfRrl9KSYgaGI9sk
 GHeYynP_myHupjvT42i0Lr6uxZzIhjKY5HFuomybDYl6sVfBFdzDNOVaTIN8MtlXdIJb4O2T8_7j
 yPKxKuIhgOMqNtgvE6.Welo.v2Zgutyf4_DEBoo9FyOnTv9ElhWxBUq427FO3yd8IH69ZQGL8Sqw
 10JcG.m1ddn5IDp2TemWtE4l_2b08vZ28zggfRlZD0noOmOLc08wIt4dWMLX.FRiKyXMxc8XxVOJ
 VXXL1cyd8XC6_dE5Cy3E2e9Cf2u5OQ53Wc.yY1xNgm9x8vs_jTNuGE8W3N8MXN9Tu0BoJRh31dZp
 7Dup6pxnu_BXy_xPpFBo3NzcEzM96wVunBY3tfdpuHINygY7sPU6z1lqkRTvqxwnxMsAr66VKmT2
 7_dpaen1WKLyykZvxKadc9XYliUsC2hJ_E_FdxbHMmi9cCOamc1q_Xc0uywa0yisHm5zE6oLWvCD
 H3JuZE9VxSyc2RLejwNiQkuqr040.RHsS8A6mS9XaEDQHexod8GkQlS99HyWObGzmRKQ4wpXZo1a
 iI8Z8S4WKbui8yl8PPsQauWZgNvamgYeIbQV.jTrXx2VUbIfnNw40G3nI_mLpwIJQEPdJdGiGZ0p
 B19HezxtOAZk4LEHPlMsy6uLLHgOkYDmivYFGANJ1Uyqdql2H60.j19gOXSg9iSUkMro8r56r0iM
 D8h8F6LQY7jPgIHYByomdWyhOhjAemiieZie25_Kiil6UiChdQbimIEDhIAYkfYSFpwvyltrq4Bl
 Dfc8fBoYM2fgN7Bd4Mi7d4wGVS3km858hhLPcOB45e6gyVXHI2VTlJ1ZeSEl07plwA4Tbo5KK8CW
 Yicv6i9e16rrB5WajwDmV9ytykCjmPEx1zFBB78i.Nu5o0o5Uvc.6B0bY8_vqys6jt8ZNkjcwSLK
 YT90ZubD1SBIAaRZwbxNt77Ok.dphGkKqeCdUEEQUWr07TVV2P.E2EdPB6lXMybr73d2WX66tvwG
 niuZ8ZwIEDrg01cBNa258h9bgvstGeTbWooDQQLz5owZaRg9C1_4VQ6ZJYuARth8Mh0HBwbcXxzE
 k49boBxJlRJpCiBW8TX2gRMiztRSDGvuB5YjUKZZLXpAI6C3oI6T59N__Z4PIaQKp8bJVC5PxqGE
 nbdMh7muvuQULbpn0Ph51t.MWViK36eWdksn_4jROOF4ZDQG1v6U3nAV2_QYSO0kPyu5Xaj34ujE
 rVZrr6Q9c4WBU6.i2HkH3q5GW5I8Hah_WObHjLLUCtrkxW83oopADn6E8CKzoLo.xs0H0fC9KrCV
 FAe49ywzsoMLYNouSLhlM6eGEQ5ds1vktNu9NYizksfMqDibUZKDs840aUg9H6UB3xCXk4Fy._8Q
 EAQQKnA8AVJvVfxAzHidE8VO7Ak.xE4wUetydVbIUMibFbRKQedpj58R6eVun8YuH3hAATrye5Zp
 rVgVEb9RN_PL_8C24OykZmZfYu6VLI6tSWKmJ0eMFtXOZjyqREI9GIo0Qaa3WFHjtvNPG9WKp94D
 nknWIDg--
X-Sonic-MF: <ae40515@yahoo.com.tw>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.sg3.yahoo.com with HTTP; Mon, 6 Jun 2022 02:47:22 +0000
Received: by hermes--canary-production-sg3-5f7658c994-q45vr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3a7a87dc6523ee7d3426ceda942b505a;
          Mon, 06 Jun 2022 02:47:19 +0000 (UTC)
From:   Alec Su <ae40515@yahoo.com.tw>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, y.oudjana@protonmail.com,
        Alec Su <ae40515@yahoo.com.tw>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/2] dt-bindings: arm: qcom: Document xiaomi,natrium board
Date:   Mon,  6 Jun 2022 02:47:05 +0000
Message-Id: <20220606024706.22861-2-ae40515@yahoo.com.tw>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220606024706.22861-1-ae40515@yahoo.com.tw>
References: <20220606024706.22861-1-ae40515@yahoo.com.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
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


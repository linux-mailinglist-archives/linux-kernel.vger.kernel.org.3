Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F18E52E552
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 08:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242837AbiETGul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 02:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346027AbiETGuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 02:50:32 -0400
Received: from sonic301-19.consmr.mail.sg3.yahoo.com (sonic301-19.consmr.mail.sg3.yahoo.com [106.10.242.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BCD14D78A
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 23:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com.tw; s=s2048; t=1653029427; bh=pFufFWe4/hvmh/UF2IjAYcVzbttmJoCx8ZLbp3kR0E8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=MsKaidovpJ+MxR8oK7j/ZASYzdpwR9cUbDxZh/YKKpurHvOPYGMM+c6JEmCto/kWAMvN0ubDqQSXhFgXIIV0oIE9DJQOg90TOdv9zzx+Ck99dEwj4WJSxc+hbslfo+PUxP2GSZ+GNl9ZWS3L12+grbVn8r+bB9xTC/8D1w8qLYVtPh265NWSxcNz/zCOz+VOcdtuDpxEcwytSdk9yP2X7//ft8z+3Rsmj5S6Bg4CP0jhJLY32jQcbtfMoh5cdR+IRhHCn5Gzo+K9/69wHYHWpa26szRiNB5/WTe3nli83ySNck33cexrBP89ikuI6b8wDEjotbYXGgA7M5zTswoi6w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1653029427; bh=1BbFXEKqqIDb1OIlS5TJgZerAq+cp/+08M07fBmD+Eq=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=mkfvBogRibf4zFUZIdFKfj9IfbeODrqc3KhHlW47kxmwutirPSzhiD27hkevweUuhcKVQbaDXbpSj1xzsCy76m3tM+cYJGvwC85B2QBYy74h1gT2F3pqaOQdEacQQSw5uFaSS2hVnNJZOdLx7Xw2/LcxhdZ0gd/Cy13QE5E/eo4aQPsnMXawzsbwhxwUwbbjgzBPX1YZ2yqSzE6o4lgELurYDfT/2uI+whsLX2a/TYuYKCuhbtd9rrY+Z7m9AcSjEieZFt/dSa3CYjqNU+E/pDu4MWmR8/jYu5BiMXlOp+YQY6p+WyZoFm4TvagfcCalnY+89tIkLGVgA/408KgrRQ==
X-YMail-OSG: o4rXdggVM1ml8LzHqyplwBPr8Pn00wAihQNJfyCF4GEtvUDzipPnGmPSXCBxVJk
 LIO2Xga2FEaUELCI58cW65Iu2vTzF3TV1d7MLKAL9sYUQ0y9mic.zU64dr_oj4RAefYIBzH0iCNF
 Gdj3n_zFOWiLK8VXsVkeLi5EFR6i3Nxnvdm63GDap8SCovi2oauljTxz6MTquvfxGaJWJNvnxn7o
 tyjS75fL5aYbgLwKt05CBVpk4tNYCIjVuasrC2bo.iPnDUqXhY7NgWImGBtl7Tqf5DGyEPqy_4Hl
 Q8x9lqGaWryoN98troAkYMmIxJ7y0eUxBJ_w7qHC61MPG0HbnfssI6jlqMygFoNOMCQ3FKO_cLE6
 VoVlw97RpJ6HicRNzIiUiy6NYAV32BgHwYZsv1HVtkEnK9eUCvoCYrwGv6uVoMzSNBOSIu.lokbl
 0Yd8HKk2g8amDP9HPhGp7OmD9hThYRmJ0VRTD_aDJlnNWChv6vaCYn.wQvuiiXae4IRTKcH3ah7F
 tuxfQITOTFQnPpzV6Rboel01WwHvZ9l7VN.V2vsiayM9JU.yp1RodQX41q4dvoFxoC_K6J5sNkNk
 K5TBCYgeE3J8kbcdsiPnmax.WTLrnn8Vh6BTsoWd241h0eiobr8SaYILYwq8LXtbVG2EWNi6NaT5
 xr4Iwx8mAihfYt6__I3bOvH.aWy4kQoHbvlbVrhpV5V4wXf0_aCpkEKBZGjxWRiJUYLs4iFVFMU4
 zAPvHXlX_gANNBDdHlJ_2Z3eo2E_16UE0TnT1mqn8hxIhOaI2xyrsyUwSYNtLSfvvi_o17tk_AwU
 pvpjEkEFNNjGDZBsgF4t7.qZ3IXQzGbHNGEA2yMq8yr2nvXaQ1lmd12qf40OYJLfEeAr6QoSc.zY
 Z7fqslJnP1ayF0K3jjS2Tq_FG_amZ2kRYcAbcX.wTmAO2xRp0CCDzsiEGpHV6RsmHNtoMuCb51Ny
 E3IkdYVFu5FQaotcpt7VNhpTqVG3BvnMjSIgW6pCNE4YojYxZHMUjS2CZYkQ2aXteEXAcsZ8Jhgp
 db1e33ZAyWLUt33vX_Upeywq6XkRfoV.HDbM7HQ6VE7MTra8zvwGmk2zbGNiJhiBRrujy.Jymv7o
 IjWFSFzEfhnS0iZJmeZunVEGkMaEJUqZICF9.pyc8_WLaiwrQ3EiCNXubxhDYS7bygf0VAEHWamk
 KjylKLMusIE0eJ7eSHRKA_Cz.4mvpFt.aZGis0oKOecfBixegMpa0VrmQLo9Xbomdw0cq1vp_FR1
 qkHwGfGFOTIwiWCkDLYRrz05PXhmVXCJtwaucWlECNz0yo3dK4Ykt4wGC7B73aoXfIHkYoOM9eLK
 Pt74l9tN39g6CGJqqpoa9nv_fko0TktTOjweXnmj9rt21YdJFarRXHWAKGqWTDsVdPRjEv20HiQ2
 gaR.9DIImb9tVVc6jUMCx.Vd.V47Jgz8sZwrBn_WAFWh4KTTY58IALJN3IJ2U8pBTtmE02kabBIR
 KVpgjtwWRq.i729SOiALLDvPdneA70nAqJmTexs.rZCps6bJ7H2aAP5zfG1Z6QnUDjBF.tG9Xht4
 yHuWozbP8lxy5MC.af7Glgqac5lE1PI96ceo38iUgbVCY2P9K6RcM43a3KiQSdrIjlqtbI70FyWW
 wZiz_fTa8wG2cgFmJcnN0JnhuL3j_2SviO0xzyE7m2KNrJ9QFnhpTFv4mvy.UzwqFSxTAg2ReNvN
 FBmQBw67x0LDCFabUuCvbm8aVUmjX39ldCb9vd1xxFSQa1_w2YyNn2DWHJUOQ8LS8hAVbszwoJC.
 yFXNrGDW321DI1r5Gn_kQ5VdadC1kKhGSzbGECSFEkuTwO82OIj34h59aQEtbo.jBJSOA2D0gn5o
 r6M4k9Og8ZNZLpEefcQ9B5diiQadfBCSteiC7cc5rZyZHyrxjjHllfyZ8WaOkqiH0wsGO7K9amEM
 JHA0o.RyYtaToct1TcXpdJ4Y2a70ca_sXpbf6jcH0SnrXCKv8SfrJTFudTVDH6VcnKOTTTxYPjkx
 JmxqvnD8sAI5QyVQp58UE90tDgRRJuyayponDWwsCwT1gx4EclSeEcQqR.msKySTxtXhKUaiihuO
 iLBzkmVz52AX9d2lMvPKtQt2Y01Ulm7IWufVqb5YfRhU2nrU2zqIAFIQU8kPWoELHGpGR_54_4xx
 .9p0cGqXo4gWXbFysHgRqLpBFhlwlKOX03OD1YKTeKH818GgTivw4w3iQkusN6lUd5PAgcho3qCE
 vWtF_B_fIfJF_2iXIAwFnY7hrh.M.eZs_n1yFDC7_x9J5Gh4n8Ddqt49uIpGAS_z5gcdbeUUMaIG
 pcQkyFLc-
X-Sonic-MF: <ae40515@yahoo.com.tw>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.sg3.yahoo.com with HTTP; Fri, 20 May 2022 06:50:27 +0000
Received: by hermes--canary-production-sg3-7959d4d9bd-9nmmr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5604052a25d99ee7dc2ed819d2227320;
          Fri, 20 May 2022 06:50:22 +0000 (UTC)
From:   Alec Su <ae40515@yahoo.com.tw>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, y.oudjana@protonmail.com,
        Alec Su <ae40515@yahoo.com.tw>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: arm: qcom: Document xiaomi,natrium board
Date:   Fri, 20 May 2022 06:50:12 +0000
Message-Id: <20220520065013.25808-2-ae40515@yahoo.com.tw>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220520065013.25808-1-ae40515@yahoo.com.tw>
References: <20220520065013.25808-1-ae40515@yahoo.com.tw>
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


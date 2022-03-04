Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D104CDED4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 21:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiCDU1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiCDU0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:26:55 -0500
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A126B13CA2B;
        Fri,  4 Mar 2022 12:26:04 -0800 (PST)
Received: by mail-oo1-f50.google.com with SMTP id y15-20020a4a650f000000b0031c19e9fe9dso10671984ooc.12;
        Fri, 04 Mar 2022 12:26:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VKUwEbVW5qva5LIGoRYiFCyDMYv3Hk5QudM2GDoBnd0=;
        b=iDgeRUH2QGSF4I7bON5tYDPRyk4djb7ITptJNzOEa7sGDs4LmQwtnOp3/iYepR+gv0
         Q3bYg7ZAOidEHnoS93uHXvSwsTke0exyCQiLqqFUlmpnosnLoszhNVJ/cRMTbe1+CMdp
         7XIVU1uhtFiYC9Qv3otq+vXbuaxp9C1IMEEI0opza9tIuS5BxdqryFPkQIToAMAJxuuW
         oewnJf6mZQJrW1SgybMXLQs0SWhVp2t+CtsIZjFMCl1hEB9JugtpbVeMLRWQUsqEQcu0
         mmqzh8MIN+dlsEKhhVktPTuWTfbpYbtdMOmUfTtPJVzmZyfcInhRPBtnyJfdMGZ8xaOt
         t31w==
X-Gm-Message-State: AOAM531VoOgVxN2tB+vGHHsWKCeG8JzhUaWlEWyuZAvNxrqAqd7YD+A/
        sjr+kDJIDyU+rnSsHvo0LlVW1QGw/w==
X-Google-Smtp-Source: ABdhPJwSBGIHNUpRZ0bfIYe9CuLf2+8hnWW01T2QGbHOl3kTnWhsSEtfc97+93tC1NmqLkzw3HInpg==
X-Received: by 2002:a05:6870:340c:b0:da:b3f:325a with SMTP id g12-20020a056870340c00b000da0b3f325amr104907oah.266.1646425563994;
        Fri, 04 Mar 2022 12:26:03 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id s184-20020acaa9c1000000b002d97bda386asm2943377oie.47.2022.03.04.12.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 12:26:03 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: firefly: Fix SDIO regulator supply properties
Date:   Fri,  4 Mar 2022 14:25:58 -0600
Message-Id: <20220304202559.317749-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A label reference without brackets is a path string, not a phandle as
intended. Add the missing brackets.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
index c4dd2a6b4836..f81ce3240342 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
@@ -770,8 +770,8 @@ &sdio0 {
 	sd-uhs-sdr104;
 
 	/* Power supply */
-	vqmmc-supply = &vcc1v8_s3;	/* IO line */
-	vmmc-supply = &vcc_sdio;	/* card's power */
+	vqmmc-supply = <&vcc1v8_s3>;	/* IO line */
+	vmmc-supply = <&vcc_sdio>;	/* card's power */
 
 	#address-cells = <1>;
 	#size-cells = <0>;
-- 
2.32.0


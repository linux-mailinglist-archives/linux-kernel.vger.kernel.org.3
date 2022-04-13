Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E419E4FFED1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238114AbiDMTOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238163AbiDMTMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:12:00 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D4A716CE
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:07:53 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id c7so4045855wrd.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X4PiWPA2z+YwiPjwmkViEPpFlveGzLMoVQh4AfeqXKE=;
        b=C/qAk6G4NiYUU7imkWzxTVcy+jWPhtrMBcEY1VpgYiGNTigN76B5hrAraH9OPjkCng
         uvTk1YM8YQYAAOm9cswIf1PZigEi5Qs9c4VbSgt0zJ3Npdp4bWVuJtuJVtkbnozJRHhc
         furNtTN582R6tzoy1Zi6VEOpZcX2UAkjdPLNV10bhyMLcCg27jSnOrXkQRniA5hjJ5ow
         FwZMl2tyx/p3dRk0KhkbG6Wlbe2pQ+xwcJNyJ2EcnY62vGx+zxEaSAqvi0veVtTRXo0v
         hGfR1Oh7y4IzLJsu8o/KPbSqWD60CR2nQsoq1FCWxyuX37f30XxFAb84NVmaKjICKldE
         IIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X4PiWPA2z+YwiPjwmkViEPpFlveGzLMoVQh4AfeqXKE=;
        b=QS3+cDp4r0NU7I9eQDgbBMDSFDaQPP3jAv8srGJHMCSzdPGTTScTTVzWevGkh9MGB9
         lPVIi9Zf2SWwkOWnlIF3JfRRl9Wy6C5xMVgaYtqnMbyIIu/c211LVz36OqOjGUiOAU/O
         qbL10a2QeTCroXcrQ/07FWoab4YkyD76LXiL25l1lAjP6sh4t54QDKsOK2J/HaEhVeMt
         pVMp+UzxKSItX7JTzX9iKnMnQQPKLY4XAZIOGHBnh3hvq1FoKdq/8swPmb2xzh5AZz4D
         UTMkzVC2QOV0YN0UBIWJyaqhpqm5j2LU0gokAOvMREckrAYBJEcSHRS6qvpOg9hMIBiE
         BhvQ==
X-Gm-Message-State: AOAM53331/+VOfbKYPwA5ekC+uUbxqGxr+j/j/Aov6Z+55obdr25VlQh
        iiu9jboOesuJUxWjoqwam3rD2g==
X-Google-Smtp-Source: ABdhPJx54Vb7E9c+Pkar02daKFssprFjEyOoa3rUt+CZLrNTNtjjYYLGhb1I73t8K4nwcQ+4ixZSKg==
X-Received: by 2002:adf:f152:0:b0:207:b0fb:b332 with SMTP id y18-20020adff152000000b00207b0fbb332mr232332wro.17.1649876871988;
        Wed, 13 Apr 2022 12:07:51 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o29-20020a05600c511d00b0038e3532b23csm3551852wms.15.2022.04.13.12.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:07:51 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v5 28/33] arm64: dts: rockchip: rk3399: add crypto node
Date:   Wed, 13 Apr 2022 19:07:08 +0000
Message-Id: <20220413190713.1427956-29-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220413190713.1427956-1-clabbe@baylibre.com>
References: <20220413190713.1427956-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rk3399 has a crypto IP handled by the rk3288 crypto driver so adds a
node for it.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index a90beec50f6a..b9b16008813e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -582,6 +582,26 @@ saradc: saradc@ff100000 {
 		status = "disabled";
 	};
 
+	crypto0: crypto@ff8b0000 {
+		compatible = "rockchip,rk3399-crypto";
+		reg = <0x0 0xff8b0000 0x0 0x4000>;
+		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru HCLK_M_CRYPTO0>, <&cru HCLK_S_CRYPTO0>, <&cru SCLK_CRYPTO0>;
+		clock-names = "hclk_master", "hclk_slave", "sclk";
+		resets = <&cru SRST_CRYPTO0>, <&cru SRST_CRYPTO0_S>, <&cru SRST_CRYPTO0_M>;
+		reset-names = "rst_master", "rst_slave", "crypto-rst";
+	};
+
+	crypto1: crypto@ff8b8000 {
+		compatible = "rockchip,rk3399-crypto";
+		reg = <0x0 0xff8b8000 0x0 0x4000>;
+		interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru HCLK_M_CRYPTO1>, <&cru HCLK_S_CRYPTO1>, <&cru SCLK_CRYPTO1>;
+		clock-names = "hclk_master", "hclk_slave", "sclk";
+		resets = <&cru SRST_CRYPTO1>, <&cru SRST_CRYPTO1_S>, <&cru SRST_CRYPTO1_M>;
+		reset-names = "rst_master", "rst_slave", "crypto-rst";
+	};
+
 	i2c1: i2c@ff110000 {
 		compatible = "rockchip,rk3399-i2c";
 		reg = <0x0 0xff110000 0x0 0x1000>;
-- 
2.35.1


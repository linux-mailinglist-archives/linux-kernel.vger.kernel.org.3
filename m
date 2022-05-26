Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9574753547D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243676AbiEZUfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbiEZUfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:35:25 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6185FDFF75
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:35:23 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id j28so3119493eda.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7aFyhUYktZMytnPH54CE9qvOB2J8zazlj78TSnY6dHI=;
        b=xE31XGRXQTXWWsH/PD6XVwFgzymMNSrvAE992lEQ6rNFl5Y0uZgb8GBVWYMOzzGIvX
         8l+Sgo9Pe3iMp8tp5UWHyTV4HZu0se2Bi1bRrgDB1ydmWTXRiVp7t5lTK+B3x2ZrBk02
         SiAvBTLOgBScViiBv035J19O1x6Cdyq8vF9DX8hHgTojrlLvu9hqMuaiNlGbV549Aurv
         qytDtHHVD+ikoRbdEESr0B96/Ge7lQJLNwOCxfn29Cyc4EiIg4JQoTsydQXgFJ8RNzqZ
         z3ogirY1LxOuPXqHMbN0ojulyEgjTWlvH2r8jyLqLdR853qbH0hoOTKNgjsE59q+QQ+J
         de6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7aFyhUYktZMytnPH54CE9qvOB2J8zazlj78TSnY6dHI=;
        b=krdWeZiL3lPnifN8ZhJOC9Li39wKk45QPf90ROT5h7iDFblBw6YRrJRM0OmwECRhM1
         olwdo/e6D9DuE2Lq+OdJ3BMpVEp7hqaPpsCng2GciVo8oj5BJFD86War5RecJ7KuqUp9
         YmMxe8k+W4ofvdlwN/YjIcKdD9pKgDp2ObyWl4EPFwTi/jv+X0CRPl3tAi9CNGqPN/uh
         rFIaYfYrEJ91lyW0nmCIUyzsqrPv88rMAFSrvc9HJJMKkZWS1IBpxNg8eD7j/16sBeXv
         vVRwkYlqbpK9RwWqOUMY6SKvKS2RqcKTvRHlBY/dpHioPdyaHyGS4F2gi/+9gYXXeT4t
         0Log==
X-Gm-Message-State: AOAM531dZTLbjnpBRtBrQrkxhSGG5QXJOo0wVyIBuS0hBenDBNaEnN2w
        lKt8EQwD6v3uAelrtqIx0cRJvw==
X-Google-Smtp-Source: ABdhPJzpqtfNQJwwnE7YXz29UgQ575vWJPJF1Q7jVbAt/Zd/NS8glMzhHKQhULg4GlweLYxNNlYKXg==
X-Received: by 2002:aa7:d9cf:0:b0:42b:db5e:ec24 with SMTP id v15-20020aa7d9cf000000b0042bdb5eec24mr4938090eds.388.1653597321976;
        Thu, 26 May 2022 13:35:21 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id o14-20020a170906774e00b006fec6e1d856sm816826ejn.82.2022.05.26.13.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:35:21 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] ARM: dts: tegra: adjust whitespace around '='
Date:   Thu, 26 May 2022 22:35:16 +0200
Message-Id: <20220526203518.830765-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix whitespace coding style: use single space instead of tabs or
multiple spaces around '=' sign in property assignment.  No functional
changes (same DTB).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Output compared with dtx_diff and fdtdump.
---
 arch/arm/boot/dts/tegra20-acer-a500-picasso.dts           | 2 +-
 arch/arm/boot/dts/tegra20-asus-tf101.dts                  | 2 +-
 arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi | 6 +++---
 arch/arm/boot/dts/tegra30-asus-nexus7-tilapia.dtsi        | 2 +-
 arch/arm/boot/dts/tegra30-colibri.dtsi                    | 6 +++---
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts b/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
index a170a4ba36c1..bf1126d26aff 100644
--- a/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
+++ b/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
@@ -417,7 +417,7 @@ bluetooth {
 			vddio-supply = <&vdd_1v8_sys>;
 
 			device-wakeup-gpios = <&gpio TEGRA_GPIO(U, 1) GPIO_ACTIVE_HIGH>;
-			shutdown-gpios =      <&gpio TEGRA_GPIO(U, 0) GPIO_ACTIVE_HIGH>;
+			shutdown-gpios = <&gpio TEGRA_GPIO(U, 0) GPIO_ACTIVE_HIGH>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/tegra20-asus-tf101.dts b/arch/arm/boot/dts/tegra20-asus-tf101.dts
index a054d39db466..f3b0166f7a9c 100644
--- a/arch/arm/boot/dts/tegra20-asus-tf101.dts
+++ b/arch/arm/boot/dts/tegra20-asus-tf101.dts
@@ -477,7 +477,7 @@ bluetooth {
 			vddio-supply = <&vdd_1v8_sys>;
 
 			device-wakeup-gpios = <&gpio TEGRA_GPIO(U, 1) GPIO_ACTIVE_HIGH>;
-			shutdown-gpios =      <&gpio TEGRA_GPIO(U, 0) GPIO_ACTIVE_HIGH>;
+			shutdown-gpios = <&gpio TEGRA_GPIO(U, 0) GPIO_ACTIVE_HIGH>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi b/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
index 2c2ad2a38f04..55e6171a411d 100644
--- a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
+++ b/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
@@ -63,7 +63,7 @@ trustzone@bfe00000 {
 	gpio@6000d000 {
 		init-mode-hog {
 			gpio-hog;
-			gpios =	<TEGRA_GPIO(DD, 7) GPIO_ACTIVE_HIGH>,
+			gpios = <TEGRA_GPIO(DD, 7) GPIO_ACTIVE_HIGH>,
 				<TEGRA_GPIO(CC, 6) GPIO_ACTIVE_HIGH>,
 				<TEGRA_GPIO(R, 0) GPIO_ACTIVE_HIGH>;
 			output-low;
@@ -820,7 +820,7 @@ bluetooth {
 			vddio-supply = <&vdd_1v8>;
 
 			device-wakeup-gpios = <&gpio TEGRA_GPIO(U, 1) GPIO_ACTIVE_HIGH>;
-			shutdown-gpios =      <&gpio TEGRA_GPIO(U, 0) GPIO_ACTIVE_HIGH>;
+			shutdown-gpios = <&gpio TEGRA_GPIO(U, 0) GPIO_ACTIVE_HIGH>;
 		};
 	};
 
@@ -833,7 +833,7 @@ i2c@7000c400 {
 		status = "okay";
 
 		touchscreen@10 {
-			compatible ="elan,ektf3624";
+			compatible = "elan,ektf3624";
 			reg = <0x10>;
 
 			interrupt-parent = <&gpio>;
diff --git a/arch/arm/boot/dts/tegra30-asus-nexus7-tilapia.dtsi b/arch/arm/boot/dts/tegra30-asus-nexus7-tilapia.dtsi
index cd63e0ef7445..1b241f0542b8 100644
--- a/arch/arm/boot/dts/tegra30-asus-nexus7-tilapia.dtsi
+++ b/arch/arm/boot/dts/tegra30-asus-nexus7-tilapia.dtsi
@@ -25,7 +25,7 @@ panel-timing {
 	gpio@6000d000 {
 		init-mode-3g-hog {
 			gpio-hog;
-			gpios =	<TEGRA_GPIO(D, 2) GPIO_ACTIVE_HIGH>,
+			gpios = <TEGRA_GPIO(D, 2) GPIO_ACTIVE_HIGH>,
 				<TEGRA_GPIO(C, 6) GPIO_ACTIVE_HIGH>,
 				<TEGRA_GPIO(W, 3) GPIO_ACTIVE_HIGH>,
 				<TEGRA_GPIO(P, 1) GPIO_ACTIVE_HIGH>,
diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index 22231d450b1b..310dff05910d 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -239,7 +239,7 @@ gen2-i2c-scl-pt5 {
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			spdif-in-pk6 {
-				nvidia,pins =	"spdif_in_pk6";
+				nvidia,pins = "spdif_in_pk6";
 				nvidia,function = "hda";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
@@ -364,7 +364,7 @@ gmi-wp-n-pc7 {
 			};
 			/* Multiplexed and therefore disabled */
 			cam-mclk-pcc0 {
-				nvidia,pins =	"cam_mclk_pcc0";
+				nvidia,pins = "cam_mclk_pcc0";
 				nvidia,function = "vi_alt3";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
@@ -511,7 +511,7 @@ uart2-rxd {
 
 			/* Colibri USBC_DET */
 			spdif-out-pk5 {
-				nvidia,pins =	"spdif_out_pk5";
+				nvidia,pins = "spdif_out_pk5";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4BE4FC08E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347962AbiDKP0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347923AbiDKPZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:25:23 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986943C73F;
        Mon, 11 Apr 2022 08:22:59 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k22so4998538wrd.2;
        Mon, 11 Apr 2022 08:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VzoF0NzW809mCpL/YQGaNbrwhO30YcPreUZTtAfsVfo=;
        b=MSDwGxyt+JaxRCSLH+OWyCwcevK3/Gp33DZ/nv2pU7zStbg4A215tcVIWtb+0UxS6H
         YcF+2NoQ5+SEzpSrgCBWduk8B8cXz9NNJbZ34wlgxEcNTbYrBjRkpdU/kG2P9kysCERi
         JChZw6G3or5q3UVWaYLN6lok3RryyFUGUt6oY1hAY6OK4g4qtgv1FhFyQ+cy0z9arkuQ
         7RngKOccF9rcL7WmAexMYazi2S//Gk+gU+RBvpuf066Ki52q2DJ/GKPaSX9IYEoB3WW7
         yXa3+dpkeFvTINo/IUsJ1O8cOKLpXzKkVceXkvRHuL1oiCh1aUNA6uRXMSYjaS8GVg1t
         74EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VzoF0NzW809mCpL/YQGaNbrwhO30YcPreUZTtAfsVfo=;
        b=kMo7GnGy2dxH/N7AuvbWpSmVXVihFDZt1G7+6gTcTnNsHcZ+8wCOMKaIkrnWntjcmV
         ADkTfTnR8+2loLdWW63NuWLrpbn4HZqHZW3PUrzxb64KBvn5xFeGAUUK4P79GnOkL3Yf
         G0yHbS9uMD8lXgwIEERW5GAaTAquy3c9oBS8gh2zw36RsiFA5bo3btvxdxjbcjgrCpVY
         iDe0vy4Ue3nqKsj+SySDwdUYUEVzfCzpMbqtfiRHbHLnRKqwDEFFqOaZuY3gs7Wf4YSI
         IKZuWtIDUde3mnW4Z/maeZuoxl2gRU0qqEhgWsAt0nGELrclPnjxbe6ES1K5eKuaKPek
         69Ww==
X-Gm-Message-State: AOAM533XTlS1IqQuUWfmCYj3G5AlFOhFi4Pk+N4qaJVrqonEykQgUWeC
        X4RZZtQH51KHtzX+CDjl+bY=
X-Google-Smtp-Source: ABdhPJxdq2S0YTjPnyM1ng+Zy5N32fYPlqP7RD+KGQd+AOjAeS1qHrT2n7BSGQyCSVMfd13ij5fAAA==
X-Received: by 2002:adf:ee81:0:b0:206:1b32:d6f2 with SMTP id b1-20020adfee81000000b002061b32d6f2mr24755166wro.144.1649690578198;
        Mon, 11 Apr 2022 08:22:58 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-124.static.upc.ch. [31.10.206.124])
        by smtp.gmail.com with ESMTPSA id a9-20020a7bc1c9000000b0038eb67e966esm5209374wmj.29.2022.04.11.08.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:22:57 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/14] ARM: dts: imx6dl-colibri: Add usdhc1 sleep pin configuration
Date:   Mon, 11 Apr 2022 17:22:31 +0200
Message-Id: <20220411152234.12678-12-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220411152234.12678-1-max.oss.09@gmail.com>
References: <20220411152234.12678-1-max.oss.09@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Krummenacher <max.krummenacher@toradex.com>

The Toradex board Iris V2 has a SD-card slot with switchable
power.
Add a pinctrl sleep used when the card power is off to avoid
backfeeding to the card and add the "sleep" pinctrl to the
usdhc1 controller.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

(no changes since v1)

 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index 1c3c34bbfe98..c383e0e4110c 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -680,10 +680,11 @@
 	bus-width = <4>;
 	no-1-8-v;
 	disable-wp;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
 	pinctrl-0 = <&pinctrl_usdhc1 &pinctrl_mmc_cd>;
 	pinctrl-1 = <&pinctrl_usdhc1_100mhz &pinctrl_mmc_cd>;
 	pinctrl-2 = <&pinctrl_usdhc1_200mhz &pinctrl_mmc_cd>;
+	pinctrl-3 = <&pinctrl_usdhc1_sleep &pinctrl_mmc_cd_sleep>;
 	vmmc-supply = <&reg_module_3v3>;
 	vqmmc-supply = <&vgen3_reg>;
 	status = "disabled";
@@ -951,6 +952,12 @@
 		>;
 	};
 
+	pinctrl_mmc_cd_sleep: mmccdslpgrp {
+		fsl,pins = <
+			MX6QDL_PAD_NANDF_D5__GPIO2_IO05	0x0
+		>;
+	};
+
 	pinctrl_pwm1: pwm1grp {
 		fsl,pins = <
 			MX6QDL_PAD_GPIO_9__PWM1_OUT	0x1b0b1
@@ -1097,6 +1104,18 @@
 		>;
 	};
 
+	/* avoid backfeeding with removed card power */
+	pinctrl_usdhc1_sleep: usdhc1sleepgrp {
+		fsl,pins = <
+			MX6QDL_PAD_SD1_CMD__SD1_CMD	0x3000
+			MX6QDL_PAD_SD1_CLK__SD1_CLK	0x3000
+			MX6QDL_PAD_SD1_DAT0__SD1_DATA0	0x3000
+			MX6QDL_PAD_SD1_DAT1__SD1_DATA1	0x3000
+			MX6QDL_PAD_SD1_DAT2__SD1_DATA2	0x3000
+			MX6QDL_PAD_SD1_DAT3__SD1_DATA3	0x3000
+		>;
+	};
+
 	pinctrl_usdhc3: usdhc3grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD3_CMD__SD3_CMD	0x17059
-- 
2.20.1


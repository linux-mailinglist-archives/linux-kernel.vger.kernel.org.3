Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A525008CA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241161AbiDNIyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238425AbiDNIyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:54:06 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60B353E2D;
        Thu, 14 Apr 2022 01:51:42 -0700 (PDT)
Received: from toolbox.toradex.int ([31.10.206.124]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MtwtU-1nxQW10pX2-00uKRE;
 Thu, 14 Apr 2022 10:51:25 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 02/14] ARM: dts: imx6ull-colibri: fix vqmmc regulator
Date:   Thu, 14 Apr 2022 10:50:54 +0200
Message-Id: <20220414085106.18621-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414085106.18621-1-marcel@ziswiler.com>
References: <20220414085106.18621-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9g+6LZTA59EY2u8QJDsvNnL4DnkE6vAD6PPNCALvJFoS/aw78RS
 SS8WD64lr2iA748OroF/hnkzpJU/fWrHK+1VG0OhrTHYh3AZ4Ul9F73pW1CSvcRI+y7I8i+
 7IL5iSCgSTeAhFYT/Stx3GvXvRnWdfoFs4RAbj+yfLkQ+5d+u+hQTsavyo71IBD35RspRnH
 tAHwummRfJppyZ6VW/4KQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PWRvpDk5y2M=:cwmC9SOSmrzvfyar94IA7u
 A3xiE47abBORsnl7t8FdsP8NJoeRjJh9OplbY0L0VKIFZ9FGKb1/CeYbCbtZWFeZSDd3TVlao
 m67lobgCy1CcxynCObAawL0rvoYcPyk24s1d6Z1uM688M266k4HvUnLNKXJdZxVQA7x/C/WPM
 rE0CjM0j6Yq2i54RnfOddqjgAqe4XPJki6d92ZqRDtyjTLGk2mJ0DoAdl9qRnCHY2HRMURTr+
 VESwwKkFHfAhdyL84cjVdINkNoNztCKlyeTdQ1oSz+GQaPRK0rmjYjiwAHT51J2cHj1Q9VldA
 b31q+Y0990Z7QMmQ/xwBVVJ+aQjJhA201vRwP6y6GzJJH2B5fuaKh3upqKekyai4QAMswEHES
 MhM9gMJZpduDIQ/CioVvdAZlcOYp4iZCHYi5L+RZf+UZlMm2EPYPhdObtuYFNf9fZd637dBq8
 KE6hQ2oB6TC+YM65tL3nPc9dyhqoppvpUSD+9jPw6j0GiIzCobJUKsLNR//HXiDlYotKkAoa0
 B/c/8hHAdbItrFkFp909JVQiHba6mW8/RIuCpyczaM3emjRJ1WyYhfrT8YRROGvTj3mvrK4r4
 zxNAXtfSUEY2sT8ZXcU6Bn6F10h2vCpOtawCN8edJXsUunP+jOGUXjjYQUG/QR3wcsPxGg7Kq
 ocZgDtzSTSY14Nma6WISJomHz3gzlTSXY+dYg7b+yc22U8SLMgwWldWlSeoxG6nHjmqk=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Krummenacher <max.krummenacher@toradex.com>

The correct spelling for the property is gpios. Otherwise, the regulator
will neither reserve nor control any GPIOs. Thus, any SD/MMC card which
can use UHS-I modes will fail.

Fixes: c2e4987e ("ARM: dts: imx6ull: add Toradex Colibri iMX6ULL support")
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
Signed-off-by: Denys Drozdov <denys.drozdov@toradex.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/imx6ull-colibri.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx6ull-colibri.dtsi
index 84bb7574d211..eb13ed60d2e4 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -37,7 +37,7 @@ reg_module_3v3_avdd: regulator-module-3v3-avdd {
 
 	reg_sd1_vmmc: regulator-sd1-vmmc {
 		compatible = "regulator-gpio";
-		gpio = <&gpio5 9 GPIO_ACTIVE_HIGH>;
+		gpios = <&gpio5 9 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_snvs_reg_sd>;
 		regulator-always-on;
-- 
2.35.1


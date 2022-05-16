Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F80B5285CA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243421AbiEPNsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240370AbiEPNsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:48:20 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C92939154;
        Mon, 16 May 2022 06:48:17 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MPF2s-1nuyn70Eee-004TEh;
 Mon, 16 May 2022 15:48:05 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Stefan Agner <stefan.agner@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/24] ARM: dts: imx7-colibri: set lcdif clock source to video pll
Date:   Mon, 16 May 2022 15:47:13 +0200
Message-Id: <20220516134734.493065-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516134734.493065-1-marcel@ziswiler.com>
References: <20220516134734.493065-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:KI/YkFLCDjAY+3c3UUvuXsypBbJks46mbuh5jgvWwFJOW57NCHW
 ZmNh+HbS4vy++WdRDL24+AFoF1rcRT+t7+qPW1JYcuUIQlCXurMYCvEVWb6itnwEsOTsxWY
 8B0nIt4O1/ejlKOkk7QhLVJWRSqw1QcrJO6tahVw10sENs78KCYNIf7jVcvVhx+mMmQmfuP
 ovvfdvq+ull4RwdMvzdZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aPGPxHU1qHQ=:h1GE1ecC8GfWpUhw7HW61R
 MzhOipyAHm1eDu5JuS1kio2c9wJSYxG+y6pDVmpaozFJ78Z07b9ArbCGy0HvrafzACPSzhm9g
 Qr3ltmZbdYN7KMntXqDSuNolBl4BwYnciLf87W/Pf55iI7rLvs8HTRUyOfA/cm0mbMeQ5sEaj
 78k4JC6T+T1FHf91PbYWqf6Q7/Ksf4YXUSsoNG7DCyVrF2efBaFx52CdBVGaKQD3ia0CQ567Y
 ckxNReuQjXZOd94kw3OW12XE5QwZAFaGC9CpsVoTFiC/rrfxJdXFnxcIaheacHHDMpMvQOMjK
 GzOCoQZZyDMb0LCxKMpuADy3oIgiNxiHSrCkxLYkTPOjyWtyxc0GnSEiQ1EVH8JlDRM5hZdJl
 Q1QgmeRK3eHh/9VgTRGMor2IorEOwkB4KOfqjxmy0WQGzLjWHjbE9k3X9LJzPqUYOsf8jqe0C
 tca/DIm946m3rwUMUX7UR9HW9b0bnfgIfDIdB3GYylI7ZkmxXRchCGfU2kagBBFhgOxYRn9hv
 p3hAZVH67sf2FjZjSHbBbEmQnppNTLcGKywJYrdCIY/nGfVGudojh47VH/CU47LtGyTcekXyd
 whA3Z5s4pDQBuW+EzHsESG/A4d5gNhT7tywn2bXv/FB0GwC7k/AE0nuNbXG+X9z1wjdcWcGkB
 KuYDT+1+7wMmXg1Jolsw56D8Y9MO5e36fQibU3WfALP0uAXtNgnS9GK8BrX7HsXMopa4=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Agner <stefan.agner@toradex.com>

Use the video PLL as clock source to assure proper pixel clock
generation.

Signed-off-by: Stefan Agner <stefan.agner@toradex.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

(no changes since v1)

 arch/arm/boot/dts/imx7-colibri.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index 074ebb0f8001..3c1cfd766645 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -441,6 +441,8 @@ atmel_mxt_ts: touchscreen@4a {
 };
 
 &lcdif {
+	assigned-clocks = <&clks IMX7D_LCDIF_PIXEL_ROOT_SRC>;
+	assigned-clock-parents = <&clks IMX7D_PLL_VIDEO_POST_DIV>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lcdif_dat
 		     &pinctrl_lcdif_ctrl>;
-- 
2.35.1


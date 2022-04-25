Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9E550E5B8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243362AbiDYQ2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243531AbiDYQ1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:27:54 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435E111F97B;
        Mon, 25 Apr 2022 09:24:50 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MXab2-1nLMMz0i7K-00WVig;
 Mon, 25 Apr 2022 18:24:39 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
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
Subject: [PATCH v2 11/14] ARM: dts: imx6ull-colibri: fix nand bch geometry
Date:   Mon, 25 Apr 2022 18:23:53 +0200
Message-Id: <20220425162356.176665-12-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220425162356.176665-1-marcel@ziswiler.com>
References: <20220425162356.176665-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VPvbNQmlE2SkG8+cY0c+w5lLEPlSKKBcNKtm47mUvAqrpNmgFYX
 j+IhkW/XtLJQb09apN7GZkg9jqD4ify51guGplTI2ClxEqGAWWYsoys9OILPzi7YKM+/Vys
 83JjrHwLf2OHDLjGGucDBRHy4Np2b51jg8iOkH/5AqyoJwbd0mwgMjXfnit+AudWH01m2jU
 pAQGkyJnBRtb5hn+LUmqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:djS0+e1cOrg=:tJr1Qc8WBCQ3kQaRL9zTdN
 zN4AhtlDmQHP4jZz8r4i/RXUptDAuos9u4VxQoaIDxULdNU1eOHFbqKfZTahz6kr9Z/ReoS09
 BoYb4PWoqTExKpgTG3kjW2SXb7mCOKxtqfM9jvXuPT7OKe0j4osUmGAjjE9qwhbxE6O0MBpt+
 qfLxfEIkTc8u0oysfXAB2kcDJRTE5y2+CMuOmlWi0f037oGYqigOyqf8168se6lfUto+ooUaL
 KrFzdMvTFWm8kNUmzO/2UpNzRsVkdt1ijjlGDuSUqYnhhLzBkW0/3dp54yOi3BVLTerDBQx6X
 eNctA13pKvoZn52SlZoEQu9QQhEhNV9VcKRTVsOaV441WYylqbSsgC0VuDFJ2n0rARWMH/6ma
 e9DlK4cetokNbbhE8yznGzYtid8t+aG3wtlUpPzY/jhZfWo8T+rOJ3Fi+YBxmmyICQ6nGLgEN
 J+57qZ6Vs2bKjfO0SDKGRBbPVzB3HKlPUw1rzY31vJDa5m6v1D/z1VJMQ26qWDnepbkf7y+RT
 sqUfqHrWitUIHxxSQ5+BR3hGtRM5GEGKBR7LIMx6s4VjYV+IBDxVLSQGJEMDUNHiibJUYltv4
 4ZwbYU5b4xz5QDz1pXEWwlW+wcHi99nNLRl5Bmi0cS+Os1DViJmWIOa0ZZgXx8/Uoxn76nByq
 3sKclVnx5I1hmYGcE3g9FcEqVAgCccHwlA2mv8HG7BeDF3tjezuxYNNjsnFXU6AaQBktSz2q4
 8wvtG3n+3vzp76Ct
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Fix NAND BCH geometry relevant mainly for U-Boot.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

(no changes since v1)

 arch/arm/boot/dts/imx6ull-colibri.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx6ull-colibri.dtsi
index 86855738f2bd..10e5242fd516 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -128,6 +128,7 @@ ethphy1: ethernet-phy@2 {
 &gpmi {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpmi_nand>;
+	fsl,use-minimum-ecc;
 	nand-on-flash-bbt;
 	nand-ecc-mode = "hw";
 	nand-ecc-strength = <8>;
-- 
2.35.1


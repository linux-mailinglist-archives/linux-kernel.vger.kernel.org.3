Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CA35008E5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241260AbiDNIzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241250AbiDNIyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:54:52 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F1865798;
        Thu, 14 Apr 2022 01:52:12 -0700 (PDT)
Received: from toolbox.toradex.int ([31.10.206.124]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MulRf-1nvUaK2uax-00rqnX;
 Thu, 14 Apr 2022 10:52:00 +0200
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
Subject: [PATCH v1 12/14] ARM: dts: imx6ull-colibri: fix nand bch geometry
Date:   Thu, 14 Apr 2022 10:51:04 +0200
Message-Id: <20220414085106.18621-13-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414085106.18621-1-marcel@ziswiler.com>
References: <20220414085106.18621-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XxbB439krdV/bwopLiYcp8T6UyVX2isIwVPw/tjKqC3RNfjSuG6
 oQXrg7r9YcHyxM0r/1FVzif48de62pBxm37P+qMc8XX+l9jDy+FRsagDFMj+q05LF93AKsx
 +LiSzMls786etjIM8ftFzfFL+m4O9bMz1AqB0rZgSekqPAhpoKxzXY51ClgoypXdWb9NSif
 vNfYVd4QEi/ZkQ2jXIOeA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TZyNMa1bln8=:zhWTyQU5mH5VckOx4fdXCo
 cJWQHyflr3m4S4owI3tpuU6fHhMg3r1AoL3LBokgRH6rbJEtcfKI4y9Qbo+e1d3qWYV3aJVB8
 GAGMhp3mzpYrdUjQHsG4YR8URNR2wfimDLEfQlaShEfzPoKEhbSycsEw5GLVa2TCevPO4IQd+
 gfGuMcSNWup3Tku8jzAFD47IZ1yi2/dtOjr9+uzLqy498AnvOiAgwM4SbK3rKGv9ieeUhO4bJ
 S/7XqFO5R+FLImudDjPNu9eDQeE5a50e0FYL9k5Ar+jm0kFYZC2ldNPRhq3nJOVQ2iHRPjIGw
 B591ecBXUqyuiy9PjQ31Ddk3LYNIketgm581kvPDgaZUsrz1V54nP4V5pJPtV3s82eX+wl5Vz
 JVBrdT+P0ifmHoLC27KtA/WAVKmwpn3y1dCsHnpqLxhefh5+G49u/qogmWklfrrQ0HxPEogMk
 6i+aNuAAwmhi4mCZYCwnf6hZBY0LBkTLRN56VyolH2QUh6pMsogZkJNwsb4D4SzbJE8SrPBiP
 kHEjufjNQ0DZWWQMqPkrnhm2Am/5bTu0ufQj7l1f+/CWwwNySpfbCoVTRcNKX/NFRxCT9bNGM
 ggEXQEcK4khNX9p/xYS/OAga0tE0nRMB5uAmGs/wu4rEhDACKL9mVbNtnZvQvy+kOBboUX8Gp
 f6+xhCurMzCFcVK+TLuVGgj32VZp/ux5rzQFClB9c6aqhmtsfdda8xEwCzsd6xo5w/iSy9KRu
 1JFpsRNKvmEVDl0S
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Fix NAND BCH geometry relevant mainly for U-Boot.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/imx6ull-colibri.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx6ull-colibri.dtsi
index 59731ae7d04d..04384139b512 100644
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


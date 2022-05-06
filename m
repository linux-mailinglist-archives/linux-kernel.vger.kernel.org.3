Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4705F51DC1D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443042AbiEFPd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442893AbiEFPcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:32:55 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E70F6D380;
        Fri,  6 May 2022 08:29:12 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MPXEU-1nRb9K2qZO-00Md2A;
 Fri, 06 May 2022 17:29:01 +0200
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
Subject: [PATCH v1 13/24] ARM: dts: imx7d-colibri-emmc: add cpu1 supply
Date:   Fri,  6 May 2022 17:27:58 +0200
Message-Id: <20220506152809.295409-14-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506152809.295409-1-marcel@ziswiler.com>
References: <20220506152809.295409-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZtdpBUcyBrED0IOtOgVJiS9oS5aSbP7SDlhYFVsFE6DikhNiP6E
 0g6OAwT5E7pnEAhOLvXzZyBZMgZDGZmUmVnKvWYrr4XSSIMLT005AxRdPcCanq7PLxd6UZV
 mqQGvwQ0kHsnmqGPTFaQC16tfiuGux/OiwrPwBxpp2r8COEXrvURs6D7Ucqy72BcSY1R1xZ
 9ZkekBrxs5zON/5wLXN0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iIYxQciHq+4=:fwqSBlTFa1RWexWqZLkYfX
 BH0ry8N0A+rKuZWxib6dGjbsdWoMwsWcASs05j0WMiPG2KWDogUce8zZNXuW9V8A2UGwLImUA
 w0i5V1OilbUGPJkSzfigUtm5693NIHgakp84WUZ7EsCl8mBnICmKJqj1F24ZYEBfrMvq1vYqR
 YfrT8RLMc3rBEmCRukA65jkzYeXSuevsb84LdYdzctlliZbNnIT1PBvZ1F05OzveG1wz051Wg
 XGWv4pWjHI2QQsUk3MwajiFAjdoPRtiA59b8faUCXwaeAZNBG9fK9tiW3+2//OsICmZOIl2H0
 HRGfwFCCs7fMCkm6jPEtcwYLhItaWyD/V6gvcsnA52ODbMq7x2xOwZgoJr3MdHK5iEm6pEKxS
 SB68UysYvs2DfGdkWRPI/F8YOvLzPfEirGt2vSd0LC+q+wvDDRNi+rDxZdEMphhI2UgojqmrY
 cxwNfDdLFq3owVq2bG3xQ3YuDmImUHXRmgDuoiyc51w3f0DbY7C6+QXOGoGecQlxczB8SuHPF
 xv/TTumANgOsvciqflDONz1hkH6cEoImw6vL3dJrF6LPmO81fc6Pf8pVFqIsG6WW5UsQaE3GO
 os3OW25R1ZARyXwvoxl67xQ4FohhlJtEbt/IvDbrKOtWWQKdhqVxwMJ5qWsjGA2r3wywmTQtH
 inWzDzfBRoFm3LaneZH3411YFXALNkYb5ExawKIaNmBupO0cXRHeq8emPJHLphn4WT6UWwBQ6
 /YYtqiv5qNrl9PMS
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Each cpu-core is supposed to list its supply separately, add supply for
cpu1.

Fixes: 2d7401f8632f ("ARM: dts: imx7d: Add cpu1 supply")
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/imx7d-colibri-emmc.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi b/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi
index 45b12b0d8710..2b4be7646631 100644
--- a/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi
+++ b/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi
@@ -19,6 +19,10 @@ memory@80000000 {
 	};
 };
 
+&cpu1 {
+	cpu-supply = <&reg_DCDC2>;
+};
+
 &gpio6 {
 	gpio-line-names = "",
 			  "",
-- 
2.35.1


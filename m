Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAF84E667C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 16:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351534AbiCXP7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 11:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346038AbiCXP7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 11:59:06 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B72AD109;
        Thu, 24 Mar 2022 08:57:34 -0700 (PDT)
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MC3TF-1nLdCe1hpl-00CR0B;
 Thu, 24 Mar 2022 16:57:13 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Olof Johansson <olof@lixom.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 05/10] arm64: dts: imx8mm-verdin: comment about i2c level shifter
Date:   Thu, 24 Mar 2022 16:56:44 +0100
Message-Id: <20220324155649.285924-6-marcel@ziswiler.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220324155649.285924-1-marcel@ziswiler.com>
References: <20220324155649.285924-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ic0yijoEF/TdmUsbIqazQ69rCiZtacpW24i1q9eIrnz6wILkbns
 1cLk0o/dtya9DBhWNi+7Cs8NvB5u18YUhybAaEJ8oZUg2LVYLUNqYRWCJTOFOpcMDN9RKc9
 ZSdYdRhrWmzuyv9P7PgsiO0ris3dYUO0CS+EXe+SHYaZWjZxGCLFciH9CFAIssL/sXeLCsI
 gS3qLHE6BbkM7bvyWk1ZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Cxp9rczoV5k=:Dg5O1Kr23Tkyqe1Z2JO9qF
 /Z9zuk8BpMWupywfJUP4cUHgT+tJ6DWqVpSAfn5Kl0Dol9HWhSI4TvaWr0VEXg8AeXxpyl96r
 YfS4GNhG9N8KrQ8xl+no8Vk6ynJ9EMCZ+bDwBw8nhDwWa6FOK1Z7FsZwUE7aMJ3VixtreYUpM
 y4UdvhCYATC3kfsu/Iey1pPLtyJE6rRgZGrCO4bp+Rlug0LZzoB2O7XEQoDKTx/Cw8GEZaj6L
 GgMJyVPp9olq3fUuYqrsQxX5NC4HTvNwKmi4A5L4Hi/LmnQ8bLSxMf2O4jLymp5nXpZafaQEV
 qqtJni2pFYUh5/GQjSMGQmJHgOs+0TAhFvV5TAob1/AfJ5+VpQEtGW0eHzb10VVHRGzkiza4c
 Ddw0MEiB7j0p8IF8GcGnFx17GyFtejoZ4ehvmP4P0Zpof3o/l2/27ppvssGVfoLmMznLZLv4Y
 f90EYOI9sCpyV7R6ryoWi+tsZLKf4TI9XmuRzG9dLfqe86nxP3rkhOdCuYjmSzMaeQLuWHKAt
 hqQODw193ky+FMtkvJUdoEDSvqBmb7di57MtkTpIZ9PyTb+A8/RtnMmH2+FxWf8waFYKSHuck
 WJkqqtQzgVZwD1YODbHEE3FzwL5RMr8dH27Mnfe+flMycUjK3BUN/MW44/n9SHCQIS1GOUFl6
 4kSA7lX/qjIRaLAcw8uSyWsEIqPwC8VELj69SnQ4nZR2PBSXTFR63BAyx5gCadVXzXbA=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add a note about the bootloader being expected to switch on the I2C
level shifter for the TLA2024 ADC behind this PMIC.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
index 599b620ae04d..4542c99ce906 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
@@ -337,6 +337,11 @@ pca9450: pmic@25 {
 		reg = <0x25>;
 		sd-vsel-gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
 
+		/*
+		 * The bootloader is expected to switch on the I2C level shifter for the TLA2024 ADC
+		 * behind this PMIC.
+		 */
+
 		regulators {
 			reg_vdd_soc: BUCK1 {
 				nxp,dvs-run-voltage = <850000>;
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3B74E667D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 16:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351644AbiCXP7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 11:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351535AbiCXP7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 11:59:25 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3BBADD5C;
        Thu, 24 Mar 2022 08:57:39 -0700 (PDT)
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MWj1Y-1nZi4P42VE-00X74s;
 Thu, 24 Mar 2022 16:57:22 +0100
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
Subject: [PATCH v1 08/10] arm64: dts: imx8mm-verdin: capitalisation of verdin comments
Date:   Thu, 24 Mar 2022 16:56:47 +0100
Message-Id: <20220324155649.285924-9-marcel@ziswiler.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220324155649.285924-1-marcel@ziswiler.com>
References: <20220324155649.285924-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6kX55W9sLgwtsyohFXwEzFjDJUKqLvHn7CEU3AJQ+HQyOv9ocOH
 0JEix7eb+LUQnwBMpAhXl3Fy6ypcYuJQ9XKzO1HoqzF1vhlAaTwQ7X+TVZNxv+8INd1VuNP
 lL7U4FL95CxFsU5ql7nuC7KfSk+Cr0UBqFI9pmHKQoEXIXYKqby9odG0qKTRVbOMtRTAd61
 Lx+9PLRnHkbVzgYxheXQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Bzr5A7SmETI=:zH3NgoNZ5tTUyDfOd6Eggx
 TlqQPyaubukv6CCMI7uCRdQfLMKC1+dWxnq9oYh///zxSedTf2aT+soGVGxLqdilrnBAP+NGd
 3t39atpW4ACMvvtP1ftVBU8RnJpyJnbhgXyCdSQtCq/nn1oH4RCOSIcdTSjca0yxaE2A/T2h5
 JfvqV/CTrBClOuwOHjd8+7B1v8f7IXRJ43CVRdhzb2kPUrpm3yCC3MP0RK2deQHiYPAeQdnYz
 WXShmm65r6guPhGt38SUtH7Tg7RXJPauXgU+1R2eDsbs3GklCaY+AV2+jb6cNi8ytkvHAuPvV
 jOzbtb3B1g5SE8CF/rddVr4S6q7yQlc7nBh4xXc3soj4t4MFXA94xDWCmCA91WNFKbm+kKlPu
 9yopp5zqbB6b3WK7ZzCqiONuibrIKTnzyhNS5XEuThfRRzEa7wAgQzO9ZCH8AyuGxIE1EZZ0w
 AsN43szxypUcZ21d3NrLNQwRYAbvmkcCGocXDZZMsLMITzEM3TEIMYttIrMgerhvZnipZG14Q
 N86ToiovlNhJ151YlWm844RtN5pB6H+DEHyO5f5eEPOAd6Xmwn8lZb5y98QzuiGQJ1kEKgcWo
 m4K4HWDM/vJ6/vqJVsvJZ+Ai1uMHbJCWVt9T7JDCNJaLqQK81S6oLAAQ+5LGVKSRCh+SfjyDW
 B1nOZs2w2lDhblDMxAkPAmV5JfdCKo5wjh/vVsoXOiH+wfVKAjRZIx66zBoJekSfitZ+bHE7k
 X1LW8H95TsNPZDdx
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Fix capitalisation of Verdin in comments.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi
index aca5ae0d307d..c2a5c2f7b204 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi
@@ -114,7 +114,7 @@ &pwm3 {
 	status = "okay";
 };
 
-/* VERDIN I2S_1 */
+/* Verdin I2S_1 */
 &sai2 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
index f188ac187c37..6e1c762fd2e7 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
@@ -668,7 +668,7 @@ &pwm3 {
 	#pwm-cells = <3>;
 };
 
-/* VERDIN I2S_1 */
+/* Verdin I2S_1 */
 &sai2 {
 	#sound-dai-cells = <0>;
 	assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4D451DC08
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442922AbiEFPdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442847AbiEFPcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:32:39 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71796D1AC;
        Fri,  6 May 2022 08:28:56 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1N0naj-1nz0Up2Ju9-00wn49;
 Fri, 06 May 2022 17:28:43 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
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
Subject: [PATCH v1 06/24] ARM: dts: imx7-colibri: improve wake-up with gpio key
Date:   Fri,  6 May 2022 17:27:51 +0200
Message-Id: <20220506152809.295409-7-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506152809.295409-1-marcel@ziswiler.com>
References: <20220506152809.295409-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OUON0wBayrK4VSZPx38avOTfrnSMy+YAaQ9kRRRaPgRJlXPV14O
 /dr2Bgs0C8AxcsVEn3LWmnl5qiOlY9rMUd9VWbggzybDuDCrVrsf1BrT9AnbPbK89wSVY6U
 HHZVylsjutGIBE410hDpXEF6lHzNtcSo0IfHBGhrmN2QT/w2kDfRES9PVx5u9DW8JvtrIC4
 aMTxpJ8tZw+lVQZa2lCCw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WUg0/6t8/6o=:o6s7DxZtPKm3AeNXIJbkth
 1JBmx9ce+4RfsCEYFxoUJyAirnQ2xVVLHT0Sh9kiYQONVma7E6wjRLyiBLNTNUTL9FpgOapCG
 +VBSYfL53RrI/gUunuldU9hMXIfwBISLtG7/0UN1zmMdCLl3PKmh3tZxlbVsz0ktNRKFHWjDL
 e4zBn5f1q2TAEm/Nj5t3Nvfyh5oePJBha3k5BMXzXrgZGZ5sFuS/KyG/Pbp4juQF8K+LMBSEz
 DJ+UnAXcpKkcHeSOJBQR5vhTNwTmr9sYCO74YfHri+C3xRM9+hvS9fBgbJGpFsR8rxZFlfBxn
 huNyKgKqEWc9miD7YsP8wpkNfExQnyRULgoZcQpXPTo9zY5ECkMw6DEfhsixm3g6zIP9uURCS
 GvMNsOS/j/LXpodVvAEIjZIJyon0IywD047BV7YtT/alN1DH/FSEVkJVttMmZqFZBoyuQeQyA
 hm/h5cxU03+X74rao3vfc9xYgPDkKH/rdzaI27wDzg/pYlKI+3/8F+p1PiAIRpeV02hNvkSK6
 JrVkSCSOk00+lrRxw/MW9GKddNykqZDHtr6XANG0WrYAdel+qrfxUz75SQdVGEUkzftRaHw0F
 +O8AVk8gpJKpetRqzgBoLFMpeeji4JH7i+N0c9ksARbBmYg5aENMto98n01wexCCAkBlIv4X6
 FqHgKpNF2fRen3EcLHKbwuOVh63OcPly8Z3ACiH/mrev9Scn9MR/CV3zLh/6ny7R7efXR9EIq
 Us0kHHOrGUw2rGg1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

The pin GPIO1_IO01 externally pulls down, it is required to sequentially
connect this pin (signal WAKE_MICO#) to +3v3 and then disconnect it to
trigger a wakeup interrupt.
Adding the flag GPIO_PULL_DOWN allows the system to be woken up just
connecting the pin GPIO1_IO01 to +3v3.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/imx7-colibri-aster.dtsi   | 2 +-
 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx7-colibri-aster.dtsi b/arch/arm/boot/dts/imx7-colibri-aster.dtsi
index bfadb3a3124a..9148c54403f3 100644
--- a/arch/arm/boot/dts/imx7-colibri-aster.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-aster.dtsi
@@ -15,7 +15,7 @@ gpio-keys {
 
 		power {
 			label = "Wake-Up";
-			gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
+			gpios = <&gpio1 1 (GPIO_ACTIVE_HIGH | GPIO_PULL_DOWN)>;
 			linux,code = <KEY_WAKEUP>;
 			debounce-interval = <10>;
 			wakeup-source;
diff --git a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
index 074c96f09191..4a7e593e9ac6 100644
--- a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
@@ -34,7 +34,7 @@ gpio-keys {
 
 		power {
 			label = "Wake-Up";
-			gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
+			gpios = <&gpio1 1 (GPIO_ACTIVE_HIGH | GPIO_PULL_DOWN)>;
 			linux,code = <KEY_WAKEUP>;
 			debounce-interval = <10>;
 			wakeup-source;
-- 
2.35.1


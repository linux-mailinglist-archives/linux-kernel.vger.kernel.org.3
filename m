Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D72457D499
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 22:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiGUUGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 16:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbiGUUFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 16:05:47 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A7779EC8;
        Thu, 21 Jul 2022 13:05:41 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.243.92]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1N4hat-1nXtr73Hyp-011k6X;
 Thu, 21 Jul 2022 22:00:07 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 02/12] ARM: dts: imx6qdl-mba6: don't use multiple blank lines
Date:   Thu, 21 Jul 2022 21:59:25 +0200
Message-Id: <20220721195936.1082422-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220721195936.1082422-1-marcel@ziswiler.com>
References: <20220721195936.1082422-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LaNQS/gBU+NLrf48pJjDltYZR/YhEflCNEzteXLF1UusfkT0A4i
 gFa9dmaMdbyPjLBqevj1w9yPGuWr3r9JLRk+ZF5HKTGFs834lD/vbQ2mBPJLJMuQUJpuXo6
 JL8Jc/Nf1qwuKYCVKt5eF6tj/t1ox0atLdItlNMj5fXm28PnMSXO4ZbcuhGa7brinF16ItC
 upRQWUZETtTFkh5H/sXOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+YHNptPkVC0=:z1jL0ZWBQao/ODoqGK88Gr
 IqC3ZxYBU8fObvgKh1ykGITMOMKiqUv5ppFnyjK1YyyP9/+rTozmBKt5bkPgivItYhqu+ESWH
 hTIPKTzSKguIfxPL23P4AyvSQU0ofeNPlz27jEviOKjlWdKjlw0v6LChQ01f1mcke7sxQd3mc
 lCdaCkfK9RJypGSp88DOC62hazuyRSsQmALsCRR1HGpPmZeI1LbdMVStQiJuW3sCLbi+IraOh
 MjcjC30YyxPbneRNsC3Rg1Q3Vuhk6LhWGto4RWnvUaU+v2DoEPUDUqBRyfHiB77ilNDdnLfEe
 3HiG+2bUifAHWNeZ4nkebMo4cquT7vuuhGjjUXV6xeVuUTFAjlRucyVfVGmlgwot4+jeQfmF1
 3VjCdIgSsejP1+8ipByatkek59hcU1cwUjG5I9BpbSOKDB1452OU1BombKQphXgQuKhLle3lE
 QrCtUi/9q11iYgvW8rvo2uqyT3Sp9AONAWU4g8uzCPyNhcdHv057CW5KHFLVYx0VLI23ag0RA
 byacwySug/uxi7BWYG9XYznJsmoVgyU0vGbvW0V+jIl0WkrLniXHnL0MSwUBN3v6ApA+pZHJA
 IqUZoYVN9hInwFmsAzGZGQuw7RwJY1UlTegkl4CA5mXVHxfGKdBo7LmOXlmmef8fwXhWWvYTV
 XZCU6BiHsLaC/NlY0SySLyYzyaoGZrfwz9G4N5obO0FPtfN9OrHMTJN9Nk8mlHaK021z/QAGk
 yLDwuCyRQ8JiYSsaifOrQZuReGXRs5yFDJsLUg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Avoid the following checkpatch warning:

arch/arm/boot/dts/imx6qdl-mba6.dtsi:247: check: Please don't use
 multiple blank lines

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/imx6qdl-mba6.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-mba6.dtsi b/arch/arm/boot/dts/imx6qdl-mba6.dtsi
index f4dca20669d6..78555a618851 100644
--- a/arch/arm/boot/dts/imx6qdl-mba6.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-mba6.dtsi
@@ -244,7 +244,6 @@ &uart2 {
 	status = "okay";
 };
 
-
 &uart3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart3>;
-- 
2.35.1


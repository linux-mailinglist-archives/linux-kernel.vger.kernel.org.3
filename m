Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840B857E957
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 23:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbiGVV4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 17:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236566AbiGVVzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 17:55:32 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB83C22534;
        Fri, 22 Jul 2022 14:55:31 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.243.92]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MQ4Bx-1o9loQ1lch-005LdP;
 Fri, 22 Jul 2022 23:55:05 +0200
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
Subject: [PATCH v2 03/12] ARM: dts: imx6qdl: phytec: no spaces at start of line, indent use tabs
Date:   Fri, 22 Jul 2022 23:54:36 +0200
Message-Id: <20220722215445.3548530-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220722215445.3548530-1-marcel@ziswiler.com>
References: <20220722215445.3548530-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:brHYG2L9NnoyFfSRkD8nkD5k6dEkGXl1svX1O//cLM2WspZ/PM+
 v/mmP1oVLZSDqCqA9eMYbFqATqSO9Y44s+V5zf3odldeGekPnp+Vkv0tmCxCUnbq/F9tigP
 fo/yVbP2B1mURu71c6F+7scYnRztMwGtXpVtUuZhNFTmDXrKgeDM2gCEcpcns0IjG3P2WFw
 1BsAanmglNq19xqosgnhg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L2PI+EvTnWk=:SWd/nPPBdRXpU19rJrrdww
 JhxExYVDFkrhMCbl1d9eByvGnGs2KwxMo0ihGVEZSbJgIbv5PCtyFRddFooEOwImFS2GApv5/
 QfF3UxHZqapxQddvVDQH5/lSSlseN0BOYrektRex5LfmWYIGd5E76/gq99JkfEyI1fbaFt6rb
 449EpQQYmPR7rA2BE9uFESRLBUPUWqDT25WyWRm28PssjbryLgIexqXM4jEJHogAvdW/OYk/E
 WWSTWffUu2cpPd5tvQQBtT/iCeUSCpDOcUwmbhwsvb/TYmGkRPWBu0npzefQzHFjgCjbZe5n+
 5RvvGaIe+PfnfdUk4t6ho8ZCIH0hvBmTDmTeSFDPi2mhC8SKwpBjxhT6NFiUbg7Z7ck7G2PGF
 nG9FwDkaTImaCbXJ5bdcgkSHY2SbdwxZWBZNwk4LYWlFYw6TAfVEPRkq+XL/bTDv55DRTBZ+x
 hY1HrD0WIoO7eW6R/QFhVRysny0ptkjnUBwtQIX2RYNOk4PREyyQDd34zIhZdlvJFha/wzMjr
 HTqpHEvVG0h1tsh4lwiKxrIG+mgETqk65hIdelJbRr9UZFid9kF5iPn+n8YHQOQMAkPxe1Rgv
 inojuiEklLvX2OOAvwTIFFwcBzzwLU5UrHj0sD6S96aeQTWu627pqzMR0cNTe5Lm19mi+frFi
 uxKwrGhVAcipKNFdn/FX4vBmKGbxF/1kqt4u8ZQwHEQn4JggFaLFZFqp7XZlS0Hlb+7KmvIgV
 WIpkDk71kK473O6i786JrmzuK4SyEW+opBqdA5y5WYQ+cHD2CvQGQyNMMhg=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Avoid the following checkpatch warnings:

arch/arm/boot/dts/imx6qdl-phytec-mira-peb-av-02.dtsi:67: error: code
 indent should use tabs where possible
arch/arm/boot/dts/imx6qdl-phytec-mira-peb-av-02.dtsi:67: warning:
 please, no spaces at the start of a line

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

(no changes since v1)

 arch/arm/boot/dts/imx6qdl-phytec-mira-peb-av-02.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-mira-peb-av-02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-mira-peb-av-02.dtsi
index 393475cb0f4d..0020dbb1722c 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-mira-peb-av-02.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-mira-peb-av-02.dtsi
@@ -64,7 +64,7 @@ edt_ft5x06: touchscreen@38 {
 		interrupt-parent = <&gpio3>;
 		interrupts = <2 IRQ_TYPE_NONE>;
 		status = "disabled";
-        };
+	};
 };
 
 &ipu1_di0_disp0 {
-- 
2.35.1


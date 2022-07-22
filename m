Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5D957E958
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 23:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236768AbiGVV4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 17:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235576AbiGVVzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 17:55:35 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE532316B;
        Fri, 22 Jul 2022 14:55:32 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.243.92]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Lt0Wa-1nUUmL2y4I-012Uec;
 Fri, 22 Jul 2022 23:55:20 +0200
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
Subject: [PATCH v2 09/12] arm64: dts: imx8mm-venice-gw72xx-0x: blank line at end of file
Date:   Fri, 22 Jul 2022 23:54:42 +0200
Message-Id: <20220722215445.3548530-10-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220722215445.3548530-1-marcel@ziswiler.com>
References: <20220722215445.3548530-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:epBj1BHJ1EXNHdLJ/Z+ICYVeEA7n8kJoF0p3aEw2IE+aAjQ1qtm
 JJovgnlgdPgBLq63Adlw4CInvEamLFFdQvSmVlBPHRC+3SYT7YhNQ7WSCZEYRBf0r9FFGud
 jwOfkunjoHacQ2BHXDs3jsMb1U9ehC+81KMkjEBQNT4KrgS8RyCkPJrvaqVDltl6ciYCvwb
 OSbkWa7YrxmiGTTdcYRaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:djRZF9YFoKY=:431L4yVqMui4HoBZKzQV77
 PYWCO3Cm3n09UHagrpjL6+dsSCIqQK31HzBO3gHkjlh/14J4vA/ix82nSwPlAvP14fgNa25Bi
 ED6d0e/ZxmIHTk7lzM4qd6jIJi0FE9bkTCDypvADi8R88HUQyCjuaB17fnPzyya5bEOUGxAl+
 isgadV0HChJAwVoBWdggJy9+x3tEI1v50k/DmZG1pvKpkBaOpx/KvEXU+WjXC3uOKhTRYEimO
 920S0B0FN1LZLDtcaF3W/zR2X9p1YkM5BcgeKbhJcgu9DIUz1eZYD0oD7tAV2/Ysdt9RBEkS+
 mUDSyGZ7iGNnFXEPHB8ihuHSr5QD7KYMuF/wQvbJyjsrCM6GWosyMSwV7uPpV2RZQ5L0uU0LX
 ucb5Y7gFxltN38S8O8ILysOC06QY0ms4G2lEfiT/HR2ZbXJ7SX4OqW6Gn0HG0gtSAtuWm7oce
 Cm8Y5RMRqU1YRpyFZskXsJJg79I8XJcyQTgJWqAG60eCFZv8ygTxZJoPw11RQDfpUvbJ6b1Uh
 pcCYxEqHQRirZt0fGSYixxzDnuRxfyGvpNzvG6doKeqJ7KB0N0xRgGJ2H2jYz4f0I4DrTEyNm
 6l24yZQtox3EL3NHwlgmOJF1efUjU7IsCyEOfstEQ6+WBO1/vVTtd3KOajMg+hBzqWwkWdNiq
 gVS0KFTnlnqyItAKCFt1MMPXIlcy9g3+2Kmq7cb6FoZ261jpQk7l90VYqyZlhliLL8pNOD/I9
 5X9Rbqevh2Xvtjt13JrJu3qN0BxqLLsePCx5THxURtjhB2grAb/AbfwzAIk=
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

Found possible blank line(s) at end of file
 'arch/arm/boot/dts/imx8mm-venice-gw72xx-0x.dts'

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

(no changes since v1)

 arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dts
index b1e7540f0281..641be3af989d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dts
@@ -17,4 +17,3 @@ chosen {
 		stdout-path = &uart2;
 	};
 };
-
-- 
2.35.1


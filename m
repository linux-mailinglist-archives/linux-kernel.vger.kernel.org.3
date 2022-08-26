Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431635A2FE3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 21:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiHZTX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 15:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238927AbiHZTXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 15:23:23 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64702BD4FF;
        Fri, 26 Aug 2022 12:23:21 -0700 (PDT)
Received: from toolbox.int.toradex.com ([104.5.61.88]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LgJSE-1pFJ152lGe-00njR1;
 Fri, 26 Aug 2022 21:22:59 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/5] ARM: arm64: dts/clk: imx: indentation permission whitespace cleanup 2
Date:   Fri, 26 Aug 2022 21:22:47 +0200
Message-Id: <20220826192252.794651-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VoDgq9lYEHnNho3cG7ChG/Y/OtsKMHJBzk7vlKhhojNj1hPH87L
 lNoZqHashK5LU5KaEFT4CAa717GNqwgDBnn5pM2/22MaEa3l/xhTvjHjL/vifyDhCYUxufl
 jdIfEaOA1xuw9Dii42uug1x+p15lyX+grmR2q7X6WOLihJqbwR+BtIFOWWNkHobq1l9cvm1
 a5LpXVAKWpDa99K7CioAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VdyUJT2x4YU=:vdggwwCV+rKRn2Ko65Piy7
 yU9zkmkslhTBG5V/zzVGD9215cOwn7D0RuL1yMJm5WfKEQVaIj1co7yuHDZ65UOVT2Jo/T5Qr
 1VfQO8BtSypDJb0lNQmJAApQCScWvErYBBflPD755o/ktp9dM8hKamoFNW1VO6cjKCwHfpjOr
 FVjsL8JKADaQDfEio9vFvShqx+BnLMGe6jCGDV1OhxfQmpvSCGglGdOUvmDF5TbfogdDZxdf6
 hPuQ/pMsLKSNiyjdoSD/190Ht4W/YTJQUzv7cd+1/Ykj/JDfmEHe0NJRDBsFrtOxGAal+QeCH
 SMO87796ldf8GCchfbhwXfVBhvWRNy5rfWVjtSTcTWUKC+smKsJPXYLAYz+fDp1GWROYOVCZs
 qxcq+g2cQE79YxjGjy2wuBSncla/sDGkH02sHtkbBxFYrMunMIuuyyN8lFTbvglZlwEDz1Ea/
 O4JJZFmOLdIyMFZx+/8E/NyQgG8Vkfaz1x1QhSFQSaFEwzxxxp1E8YxYfMAk1njty6NPZBSs/
 qFbfd4YJEy333pqej1rVrrGO26v1+2kLIPvQNjA7GIPMbzFy7E+N0t/BFNmDxhhwWPKMyyFyZ
 nfd811B5HrV7sHntsewGO++VsXP2JFRIecWDGO4fJUGpwO3k+L2f48Sfx9nM3taSZx22+8GlV
 ShSbconPLWTIwXNpR8Cwb13oelAVrIFp2XyxM92fAsTVBz9tigavU+jGmg2UZAG51vVRKJAHL
 wPx1xHfCvJT881+YgB1K104Buvrb/f6WPNyMiA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>


While further synchronising them imx device trees with U-Boot I stumbled
over more checkpatch warnings. This series addresses those trivial
indentation, file permission and/or whitespace cleanups.


Marcel Ziswiler (5):
  ARM: dts: imx6sl: use tabs for code indent
  ARM: dts: imx6sx-udoo-neo: don't use multiple blank lines
  arm64: dts: imx8ulp: no executable source file permission
  clk: imx6sll: add proper spdx license identifier
  dt-bindings: imx8ulp: clock: no spaces before tabs

 arch/arm/boot/dts/imx6sl.dtsi                 | 20 +++++++++----------
 arch/arm/boot/dts/imx6sx-udoo-neo.dtsi        | 14 ++++++-------
 .../boot/dts/freescale/imx8ulp-pinfunc.h      |  0
 include/dt-bindings/clock/imx6sll-clock.h     |  2 +-
 include/dt-bindings/clock/imx8ulp-clock.h     |  4 ++--
 5 files changed, 19 insertions(+), 21 deletions(-)
 mode change 100755 => 100644 arch/arm64/boot/dts/freescale/imx8ulp-pinfunc.h

-- 
2.36.1


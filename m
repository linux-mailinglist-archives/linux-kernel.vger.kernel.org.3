Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7ED57D49D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 22:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbiGUUGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 16:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbiGUUFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 16:05:47 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C199E78DF8;
        Thu, 21 Jul 2022 13:05:41 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.243.92]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MUGJb-1o68991iJX-00RItF;
 Thu, 21 Jul 2022 22:00:04 +0200
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
Subject: [PATCH v1 01/12] ARM: dts: imx6-sabrelite: change to use SPDX identifiers
Date:   Thu, 21 Jul 2022 21:59:24 +0200
Message-Id: <20220721195936.1082422-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220721195936.1082422-1-marcel@ziswiler.com>
References: <20220721195936.1082422-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sVhnkp14e+NHBRhmC48Ban+H1rQXXGXNh1NfmLBggvRe3qdg8jr
 GZsgnP2fMdckhWl/AEJl8N8Q2HF1hNw49qcKwULsRs5sQDwbbq/+Kcxco4imzvNnDngHDQB
 QyonKYjlse3txr56O/q0djADO95EgSfa9701mEE66moByHRh8/0Yf8PiNDf0G4OFiB/mpoz
 Mt9TjEkIhTbWDmMB0tf+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+HPziHGVYPg=:x2hqVSs9I/NeDiehc/mPe4
 ZQNcBMLTgxuK59ZX4Z0QJgQS9jKsIu6V2wAs8YKiNIIEmS4NoVmlAtAamxMgzdT6FxpbwgKAT
 VmOFY5MSvRDmwjRxxCcLTjg+ZGNUM9sdmhIsRHhPtEoIG6rQuUXEyfb6wbQ/JdvvgecT0icXd
 9EGmSR0amRIh27XBUSgud5856xCAOqKdyuXuZZPIh+M1vZyZzXOOn4PCQ6hS/dpI8kvRNHk/w
 dQP2iaf1DhojYK7WaXQAhm38EeHSL2tKibmjvulGLntA/+hI+TKXX+txhDWZVQdU5I5/ASWDT
 mdYfzW86ekRdmpCHGwe82pioeId06EMZxG6Ffknxpll+YQHu0fHLw9PY8bZPlP9h6APqNGg97
 bdHrTnKHwPlqGWe+HVoFvasz+eWKlehoqhXxV9LYMm/mPAvkZsnvJljYkO54BWbxC/Uh13INi
 0Id7vAuSQxLUxPIs4obdYX1EwlXntDsVPqYTJfQjFTDwyP0gOExYA7jJU1TpfyyprROyXhd1a
 J8/5lBNQKGDyTvl5k1b0GbXHNzU0L9BzaBOLIt0tPtsAMQo8CqwCgB3jMnId0fbgMLsK3aEl8
 dhC8qm+6Y/Bpu7t2WhWccRkjjr+zQAmnspnZNTXd97dSeg0Zgb80yfFl0mXk8Bvmah272hlQu
 MXy9FJ76uVw4s2MIw92hnViAa19UADcfaOtFmJdRZkrQJrn/n93vB0noBHEGKrbNMm8VF5t0j
 sOV6KLy+3Bd7FmdAZbTCjlr5iV60Es9VcaZhhHnPm0WdppfUlbVU6BRtSig=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Replace the license text with SPDX identifiers.

Avoid the following checkpatch warning:

arch/arm/boot/dts/imx6q-sabrelite.dts:1: warning: Missing or malformed
 SPDX-License-Identifier tag in line 1

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/imx6q-sabrelite.dts | 37 +--------------------------
 1 file changed, 1 insertion(+), 36 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index dc51262e7b2f..af0692cdb58b 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -1,43 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR X11
 /*
  * Copyright 2011 Freescale Semiconductor, Inc.
  * Copyright 2011 Linaro Ltd.
  *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License
- *     version 2 as published by the Free Software Foundation.
- *
- *     This file is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
 /dts-v1/;
-- 
2.35.1


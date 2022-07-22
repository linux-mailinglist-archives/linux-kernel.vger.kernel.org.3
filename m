Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42ACC57E94A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 23:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236615AbiGVVzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 17:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236477AbiGVVz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 17:55:26 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A5511818;
        Fri, 22 Jul 2022 14:55:23 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.243.92]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0M3ys8-1nNs1h3NlS-00rWIo;
 Fri, 22 Jul 2022 23:55:08 +0200
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
Subject: [PATCH v2 04/12] ARM: dts: imx6qdl-sabre: change to use SPDX identifiers
Date:   Fri, 22 Jul 2022 23:54:37 +0200
Message-Id: <20220722215445.3548530-5-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220722215445.3548530-1-marcel@ziswiler.com>
References: <20220722215445.3548530-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:eHJSavm0LH00PW/itzzUZfwNeEKkG4bkylPaIW7RJ62yDsLoC4R
 pzHd4IFA5YtVwPYohxXis03oOPku1AXdSyeawkibC1B9yCbtgWBZwNuhmNks1QVXCauOze3
 JX2X367LqCWa6wX9nNQfXfAd+X8J+oSf+rIi6K1+xkJLm2OhdXFp/dTafmRgEadsgsNOtSO
 5h5SRp2dVRrFj7AFj87zg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FyD9/9Du60A=:evlfBDERdWUeXTiU3TKjIO
 381fXkHSL+CXi3rOYQgfLZ00WZgwcNixUU13C+hXIizzS7Dq0tREeDvMeG2l6B8HoGfKcgs6Z
 hv1Xa0Deou5LBidSFlhMku/kkhBcoeDzVJ9g1WUZHPND5arjqYC8K0nJ//lO0lbbEE5vpTENH
 Xvr9Yy9YkgG1OWrKtFAbojsMwfPtGvNSMu4rYXqlkEISfRkr675TrO1gwM4Swgp7cr61pDWFS
 z2bsgRKQjefnBUUYCAlSCpKTjY/hhPPH9WuwxeHuvkZpiVFNgYzA+83r2fzzJRO7qMuRF8X0D
 ycUHDjE0m2MVoiaIl2BwooPTqKuT3Pl3zNXn4Pg7s6z4u1MZ/rakPMiRif9pk0e1xsnRmiX5m
 4xcsy/GAXfdjB9lMUaPtYuQ8qHwLFNmLPaHec8O4tswBycOZ+c6+K+lzOhsGqUtyfedD3A9VA
 tOJYV6BAeH9a2mRRV1063iqJrIo7EBfnwZOf0c4dbFCKQwxld0wS8WZZSqODF1lSjov+PSouH
 /vCkm4SK8colL/uDB/SgOuYqZBUNbs/khQSp8mSSzrMg/GxPPZXeDpifcVUL7iOb85B/QVjwO
 SazJ0WOzVnmIrcp3VJNWmgcp0YlgjRrZUjN198tHQf5FYb3ViM6Vd1SLaG4wyMyrsb6EnVg7n
 wr7TdYqgADJwOs/rpGtfVsJpHBw+O7PmG7eLkd2tBhlFPoBECeVmCdvm7c/OvKDW4dYDQG7kQ
 hmFmfJYiyavSadzAqfF7oxs+EqrOD+b00IwdEg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Replace the license text with SPDX identifiers.

Avoid the following checkpatch warning:

arch/arm/boot/dts/imx6qdl-sabrelite.dtsi:1: warning: Missing or
 malformed SPDX-License-Identifier tag in line 1

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- The GPL part of the boilerplate license was actually GPL-2.0 only.

 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 37 +-----------------------
 1 file changed, 1 insertion(+), 36 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index 901b9a761b66..22f8e2783cdf 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -1,43 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0 OR X11
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
 
 #include <dt-bindings/clock/imx6qdl-clock.h>
-- 
2.35.1


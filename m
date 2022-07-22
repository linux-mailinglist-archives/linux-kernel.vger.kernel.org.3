Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A1157E94D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 23:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236592AbiGVVzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 17:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236461AbiGVVzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 17:55:25 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1AC64F1;
        Fri, 22 Jul 2022 14:55:23 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.243.92]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Lh8XB-1nkdet0xBX-00oYGx;
 Fri, 22 Jul 2022 23:55:00 +0200
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
Subject: [PATCH v2 01/12] ARM: dts: imx6-sabrelite: change to use SPDX identifiers
Date:   Fri, 22 Jul 2022 23:54:34 +0200
Message-Id: <20220722215445.3548530-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220722215445.3548530-1-marcel@ziswiler.com>
References: <20220722215445.3548530-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nQ1jigqJiu0hN4s8Kp4208rDf8F+y54KwEWcklTy165yOsIOZe6
 hWzWT926jIyRk29nDbaPlo5268Y8Erm/pn8GBy1NsUpWeBkhTnq0nKa/Mmpv0PkAeWyFR69
 rJ5BGneXgqlqQjdoffl7fNDYYtqAwAN3FX8BCShGDcOxo3++2zSpJBYrTw9PUGMNL0Qxci7
 ir9gEjwjgic4P5hCUknvg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:htGtwYRZtc4=:pB7VAyhY1iDpob2Jf6sZWo
 KKR/d0qguv/+pYRGVwezU5ZskC0Vs+GqZUyOtvz+ocl7dAQWU9BHH/8h13/Xy9PDQfchQYpGG
 lZvOkAWTlfA+Sqsp5ks8d92QWwPWONIpAmvxWdiy3Duvmnl0QwcESIQF7lULszsoMYQdfRihC
 LTlpzpJMCYroW3UN/TVTs2CtdoBfyfoja8GCQnp4DLO/i1TM8IBZ0PSaO7abeicxsvaXWUPfJ
 0eFt3tq3lXh+YM34bPLOzDrvOKllHWzt6+hod2RYrwql7n5mo/RC+vNMPb4urz8ozRATETV30
 2OAzrg75V4j4lMJGO3If26DNrGUhS9L9U6HnAV2eQ2/ngpY/CiqBduv9LvLYvLHQP3ebZX4hh
 PAHJuuiiTkpCfkip8StJnqQDwhJMyRGakoomRWinJq3AXQHY02Vk+OluflERA0gr1XIct8XLP
 diTha4RxZxyZ/XiO+ljOmQ/jE6cfj9cTSfrcyGiwiwrKERIocNTPeIY5ZFAbxoEJgPROyjSSN
 lTTWTbN0LwVD6ekoerukGdbmknSyaKPyQcaF4xQ9M2TEcqQ649nZYaFjadd7E3bwVAyedefIM
 Gy3buO/fSC+C31LaTz8/y+mkzlPwH9g0MypsvLxjzZJyra/EQfZ8s/fkrYiroGSDvtJ6Bgu+F
 BWL9RWAOeDr18+yc0ad2CM5HcSGQgOoy7weMmLZYLjZssCvwCdVUsUZTmwO2QIFMlEybhYdRJ
 UyDNFyWe56GLeu7pbcla1+kT64LgUaUAqWTBjw==
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

arch/arm/boot/dts/imx6q-sabrelite.dts:1: warning: Missing or malformed
 SPDX-License-Identifier tag in line 1

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- The GPL part of the boilerplate license was actually GPL-2.0 only.

 arch/arm/boot/dts/imx6q-sabrelite.dts | 37 +--------------------------
 1 file changed, 1 insertion(+), 36 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index dc51262e7b2f..7c6a2f234ccb 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
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
 
 /dts-v1/;
-- 
2.35.1


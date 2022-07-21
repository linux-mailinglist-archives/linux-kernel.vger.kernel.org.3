Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2257957D490
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 22:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbiGUUGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 16:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbiGUUFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 16:05:40 -0400
X-Greylist: delayed 309 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 Jul 2022 13:05:36 PDT
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF5D70E41;
        Thu, 21 Jul 2022 13:05:36 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.243.92]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MId3J-1oJnQ631kb-00EbYd;
 Thu, 21 Jul 2022 22:00:12 +0200
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
Subject: [PATCH v1 04/12] ARM: dts: imx6qdl-sabre: change to use SPDX identifiers
Date:   Thu, 21 Jul 2022 21:59:27 +0200
Message-Id: <20220721195936.1082422-5-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220721195936.1082422-1-marcel@ziswiler.com>
References: <20220721195936.1082422-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:B+B3mP3pRAJMWU5aKA+QiDfNKTj1HfzIADp40JXRmDnp2rfbDrh
 9wWonLOcRTUvPjz18aVeHFfxMk0hNq7gNVdczbU6ipQXdCXq7Fo9FsvvZCLjLM2d8OW1Clc
 wUlgTZ4HsA3Jwwp33P1Yod6pcrgSipiYb3ZvTgm9AdPGPBrYaaseSclzvHnEb9hQ7VoSyYx
 IrpgLQaWWMfuJEzhe0E4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h2AGwEiaoOU=:cYIwKfszpSeBdvGOajdj1V
 qFwraR1Uomp3kwO5jn9R3Qxua97hut4W75z4r9xiwMzvkbRpI0Se+sf0h1vYevi1JtlrKXh9j
 ow7nukbSkjdrNTjZkxhIIU1R2et3UGuy/J/8BsCNar0PAdjj9YM6oOaVrelxGW99Kelaw3p05
 AyHj05jr00aVHTB2fTK5+ZMi0Esh6wiNlnPaCKGHh8Yqaodz7VKUPegTiLX1HDNSFIfLOX/62
 M0JHvqrtH+KJ13dUtmmz0kbitYQ6M7E++Hh2jabamfalRHagLEttdWFtuQq9tYEF75vN9lP/a
 ffQtYE4H7BWqSx+iSy7B2219k6RYnRAD7hYt9UcLmFW4g0ET6itE0VGvruV4FG8IIUBWc6yk7
 60DuSdRQGhWRNc7lO24a6xZqY2cPDmFolo4wQ19i6VTBZwWXuU9mhn4EHJo2OMA07sZ+CAcyv
 9F3YqhO/HXzK0DQJAA8OeRE8wJGz5AOsYNdkyXVEOIzKDg/ZB7u2IsZYmEJEZ738o26oBXy/6
 yLel1dNo8krXJEXeQ0LIf6Wbkzq1HTsuNgTh10cPACzNJwbZe79FdD9no7q2kibvz3YqgbOe8
 UH4pVFQtUdSysWdLYv95xyWTa4LOQ4yTNecY6FQPa59UJZGCRjK6Nk8Uja9prMMI66dUAxJZ2
 V/MmG4rRuu4dfafQVozJLhTBO3o9i5iZCiP2GoPCi7Kx4vAsn/B/Obzg6XHEV2IN1Ss7GgSI/
 qTVCTocO6dAoG1LZtn2eKBB4uYChdYPQnfXtnw==
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

 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 37 +-----------------------
 1 file changed, 1 insertion(+), 36 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index 901b9a761b66..32f3c92bcc52 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
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
 
 #include <dt-bindings/clock/imx6qdl-clock.h>
-- 
2.35.1


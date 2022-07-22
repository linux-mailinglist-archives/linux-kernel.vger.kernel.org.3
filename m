Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5487357E94F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 23:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236558AbiGVVzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 17:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235829AbiGVVz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 17:55:28 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13603624C;
        Fri, 22 Jul 2022 14:55:25 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.243.92]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Luwb9-1nWygL3SIj-0100c1;
 Fri, 22 Jul 2022 23:55:13 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/12] ARM: dts: vf610: no spaces in indent but tabs
Date:   Fri, 22 Jul 2022 23:54:39 +0200
Message-Id: <20220722215445.3548530-7-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220722215445.3548530-1-marcel@ziswiler.com>
References: <20220722215445.3548530-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:rvPqPbyhiCAg7IfJJmDVs/ymgxM6+9zDC711xrQO3jRR4714McI
 8tavggzImR1j00p9UISaIpd+IPb12+OWW0UQEBgoot5W+p0FZtVqjdfW31z45dRIe/dMIe/
 TTmteYTYxEq14KFItQD5feVRjkAKpxqsftmqn6Ik4uyQZcmYWAjfRKEmATYpHZqHfAxSfMA
 CfD/EgzzCrGvf7IjpcXIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/t7ncJRnXC4=:rFwPvhDQINFWQhjKy1GrWy
 VDWRBaS2M7TVnHMSZCA6URwjsnbN8SLfR9sFs65p+FfBUl/zYFJoOF3NtHwBz2nTW9AWTROJ0
 LqqQdP6r27EWXi6vC0YPQysvUYHvof5BD/v4OLWPWywcRvD5EmkALDvYSAVqrp1afF0AX7w+m
 eWtFmxIL3u4Sz/VA/NcC1mX8dFupZcbZ6rCfPhOQ8p3G59KHvBeMFnG3WKUfCayHG0Y85JwIf
 NkPyPH6pc5HKQ+CN9oY2xuo30moO4TB7GugUYv8eJrmwCqLEEdSH6WGGs5/fMh8bXjpmlhtN8
 kRvLBxzmcw2j6pzlpOuIFhsMQER1PWlL6RcEnuUmuoAMSfxWvTeBv1TPbnUFkLH9hFRkVT1NK
 W10ly95Kr3qhNAr/E4hnRD7pS6Z8+VPOnDIndcGaH7f/oy57jyifOU/KUjwm7InQ8wtQSjo1H
 pAVBdCDnetDrvJRzUccF97Wnf7mUrWiOmBFpfWSbBTXVFklWqeQE5pAEiJOaBNMbmlrZMMs0B
 AGLOoMMn9pGttHcWP2qvt13/3BSjls5meuEDa2cZxhlhfkwb3tMeeFvoBBGiljS7N+NB/pzRJ
 0kWRjuhJs17UxQMPJVp9DJiOeALR9NKtbeR43MgKULK6UpKASwweGCYuTRqG8aBPcC1PPU4wk
 HFNjrG32mE2zWqxcuy1Gffhj4BJPvbVzd1GPIun2hp35yApDsqBFsmBUNJOS0DFyoqogKfnDT
 d5neIXJR/VhMTg478oZrfPlAti9RuDCUzUo3Cw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Avoid spaces in indent but rather use tabs.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

(no changes since v1)

 arch/arm/boot/dts/vf610-pinfunc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf610-pinfunc.h b/arch/arm/boot/dts/vf610-pinfunc.h
index f1e5a7cf58a9..8bb970b0dff8 100644
--- a/arch/arm/boot/dts/vf610-pinfunc.h
+++ b/arch/arm/boot/dts/vf610-pinfunc.h
@@ -420,7 +420,7 @@
 #define VF610_PAD_PTD29__FTM3_CH2		0x104 0x000 ALT4 0x0
 #define VF610_PAD_PTD29__DSPI2_SIN		0x104 0x000 ALT5 0x0
 #define VF610_PAD_PTD29__DEBUG_OUT11		0x104 0x000 ALT7 0x0
-#define VF610_PAD_PTD28__GPIO_66	 	0x108 0x000 ALT0 0x0
+#define VF610_PAD_PTD28__GPIO_66		0x108 0x000 ALT0 0x0
 #define VF610_PAD_PTD28__FB_AD28		0x108 0x000 ALT1 0x0
 #define VF610_PAD_PTD28__NF_IO12		0x108 0x000 ALT2 0x0
 #define VF610_PAD_PTD28__I2C2_SCL		0x108 0x34C ALT3 0x1
-- 
2.35.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506BB57D49B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 22:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbiGUUGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 16:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbiGUUFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 16:05:47 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3594B78594;
        Thu, 21 Jul 2022 13:05:39 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.243.92]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1N8Won-1nRpJd3vTV-014VFr;
 Thu, 21 Jul 2022 22:00:21 +0200
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
Subject: [PATCH v1 08/12] ARM: dts: vf610: don't use multiple blank lines
Date:   Thu, 21 Jul 2022 21:59:31 +0200
Message-Id: <20220721195936.1082422-9-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220721195936.1082422-1-marcel@ziswiler.com>
References: <20220721195936.1082422-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hbOcNSEZZz7nRKDC9cIhaG4ZlFlmvQ/jt2C/FCkGSrr5wFUNoMf
 sNG0eElZ0BkG604unYa3rYUocmZgh2f8VYGfL2I8FfhL6YpTs5r0lzWQhuW8bdzV3q6OMoC
 g/fN8LOWvyMH/HvTDu5tTgVQ8KRoWHRb1A5Ft95zk8vcxraEW6ykCRgPDDGGLmlZbTC3vxM
 BkRyJD+J81C8YFgMWnpDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mtlRMMHzFvI=:m92G5Yiykfwh7TLBuyz0Lj
 /lyIlwmM1X/nHrQ9JZiUZkdwuG2ktykGTaIJbg0adlTROs4b7SAVDe5xiFI3uWnWvaNkldviQ
 GItEV4DCo8JbMTYbSvLY09STnfq0Zs5DniMhbX/9yyjZDe0C/39p2qOBbizYu5/f8p+R6r4hz
 z1j3iNfsTtA47LmVvf5x5cY7GofqQK3qa0su/f+GeTXxLXBD6ILPrwFHPlE/RaBpmeB73W3B8
 ylo2VF9/Im4qINUPIteh1ZNcYNypmbgwByf2Ww/3jmFXGzO7/TE70ZYoVhNT4CsWAJvwlC8jd
 kgWkkMivdqG1SBP7idzUH2CVHfL1Xxvn/Q2N3HbcT2owjfQcY5m6b91/CGBbRzZ+NO2efih8l
 HZvitKwH5Lz78uURmzzWYbSUSKVxfbzx+4hFCQSGKfw3xtaJvLwDPvymPNYNiHFVaqVtzMMrQ
 Wh7r3CP4u1qZ8YIqPqMih2ll5vHdWp/8PY7h7KehojFaD0lbvCkafCMzrmDfq0zWG7JAyWaLN
 Wnugce1jEDDHMxdSKFFabINt3EklbnI9zOkmTINWQQvQKN8RpzLd2IL5mLGz1E71gzahPtR5x
 GiK8ZaSty5O5lrItJb+v1Ykb8bzWAw1wOrLbmXMjQi1+9jmQa1aeNoilPEeQKYaN79iIjSd6Z
 c+SAJsWFmp47Toqez5g8HCJuQhU/jka+aI2hEKiByMEzaqyM0birQ9te7d/rksKelGA89cV62
 ze3gnyA4YO/xWl8XRs9ZwmThXPHRnbFlv0TaWgpRiOb05stpGxJcBJZajtA=
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

arch/arm/boot/dts/vf610.dtsi:5: check: Please don't use multiple blank
 lines

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/vf610.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index 956182d08e74..2fba923821d0 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -2,7 +2,6 @@
 //
 // Copyright 2013 Freescale Semiconductor, Inc.
 
-
 #include "vf500.dtsi"
 
 &a5_cpu {
-- 
2.35.1


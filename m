Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28882591447
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 18:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238991AbiHLQxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 12:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239396AbiHLQxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 12:53:05 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C83ACA0E;
        Fri, 12 Aug 2022 09:52:58 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id B96655FD09;
        Fri, 12 Aug 2022 19:52:55 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1660323175;
        bh=bBzOl1ozVTghtx6a1x8+yHWmy394M9SjIp1tfXubAc0=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=bsRIUY5V9mKHcl6TvhnxrkHLjXbYBiGSNaM8v3QYUrJhtEk+fGOLOw7kRWodYcMLX
         eMQ0e5jWmHYMv7Ou4fE85YoyOHW1qoKpugmwnOISJEETAl+yjaSO4hXbm7xA7WuiNG
         1sUE4ky8GOcEoDMf2r6mBzPazOzzItqcCAblcyjEMrY6wfMflaM6O7MGQxoNKJHDLl
         mjHZajna10f6H7KJQ7Dtsobdsa69aHI6+3ltRJ2oTeRX2In9qbXTibl6OvEBL49R/R
         Rh70SG8ql4deMwtdFoW9fN3s+NA8JJ6B4WbwNgo3gNJiA8oyofCd8URG9vOP49xHxP
         L/qrQ5Zwhh9sA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Fri, 12 Aug 2022 19:52:55 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "wsa@kernel.org" <wsa@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        "jbhayana@google.com" <jbhayana@google.com>,
        "lucas.demarchi@intel.com" <lucas.demarchi@intel.com>,
        "jani.nikula@intel.com" <jani.nikula@intel.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>
Subject: [PATCH v5 2/7] units: complement the set of Hz units
Thread-Topic: [PATCH v5 2/7] units: complement the set of Hz units
Thread-Index: AQHYrmvmE6n+ZChG30GdF46x+XWXgw==
Date:   Fri, 12 Aug 2022 16:52:26 +0000
Message-ID: <20220812165243.22177-3-ddrokosov@sberdevices.ru>
References: <20220812165243.22177-1-ddrokosov@sberdevices.ru>
In-Reply-To: <20220812165243.22177-1-ddrokosov@sberdevices.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/12 13:28:00 #20103614
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, Hz units do not have milli, micro and nano Hz coefficients.
Some drivers (IIO especially) use their analogues to calculate
appropriate Hz values. This patch includes them to units.h definitions,
so they can be used from different kernel places.

Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
 include/linux/units.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/units.h b/include/linux/units.h
index 681fc652e3d7..2793a41e73a2 100644
--- a/include/linux/units.h
+++ b/include/linux/units.h
@@ -20,6 +20,9 @@
 #define PICO	1000000000000ULL
 #define FEMTO	1000000000000000ULL
=20
+#define NANOHZ_PER_HZ		1000000000UL
+#define MICROHZ_PER_HZ		1000000UL
+#define MILLIHZ_PER_HZ		1000UL
 #define HZ_PER_KHZ		1000UL
 #define KHZ_PER_MHZ		1000UL
 #define HZ_PER_MHZ		1000000UL
--=20
2.36.0

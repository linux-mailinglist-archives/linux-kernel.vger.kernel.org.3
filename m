Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE3258042D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 20:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236081AbiGYSo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 14:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiGYSo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 14:44:56 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5711F2C2;
        Mon, 25 Jul 2022 11:44:53 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 96D5D5FD04;
        Mon, 25 Jul 2022 21:44:50 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1658774690;
        bh=2ohaLhMELb91V7BEJJEZfttiFP9L2P05/VDEIgOFXsU=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=BeuoQuSufNrajgKEu/tgsKmxWCppTcQtqmRL7PMhvQfNpfDG3wzOEyu4O4XF/o2Zz
         okuU2mAmuUgxuk1hS139jJuhCyTzKAEe8zmTL/C2K98VTzfi/iGmDQgri1NzahQ5xS
         wOg41fHQokVLQB56sjOnQbBXhMuGv+/WYM6Ze5rmIZX3t+G+5W4zssiDFt5VCKbN9d
         yu0F5Qae05fH+L9XUXfaAH1QVkuZX9u4TQZ5yEWhNV6yh8cfkEBD+Y9AgtsVfPSjy9
         RbsURGDirdeYaMZPoE664Ixg+VRyNs5i7vodUoA0fdWBGjl7nmk1hS67nURmCpp99f
         lWuZvW378sxOA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Mon, 25 Jul 2022 21:44:48 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "wsa@kernel.org" <wsa@kernel.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        "jbhayana@google.com" <jbhayana@google.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>
Subject: [PATCH v1 1/3] units: complement the set of Hz units
Thread-Topic: [PATCH v1 1/3] units: complement the set of Hz units
Thread-Index: AQHYoFaQAQbyP6ttz02qWm6Ywvl4BQ==
Date:   Mon, 25 Jul 2022 18:44:26 +0000
Message-ID: <20220725184439.7618-2-ddrokosov@sberdevices.ru>
References: <20220725184439.7618-1-ddrokosov@sberdevices.ru>
In-Reply-To: <20220725184439.7618-1-ddrokosov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/07/25 14:44:00 #19963834
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
index 681fc652e3d7..900a642f0ff8 100644
--- a/include/linux/units.h
+++ b/include/linux/units.h
@@ -20,6 +20,9 @@
 #define PICO	1000000000000ULL
 #define FEMTO	1000000000000000ULL
=20
+#define NHZ_PER_HZ		1000000000UL
+#define UHZ_PER_HZ		1000000UL
+#define MHZ_PER_HZ		1000UL
 #define HZ_PER_KHZ		1000UL
 #define KHZ_PER_MHZ		1000UL
 #define HZ_PER_MHZ		1000000UL
--=20
2.36.0

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34866586CFE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 16:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbiHAOi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 10:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbiHAOiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 10:38:24 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B9433435;
        Mon,  1 Aug 2022 07:38:19 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id E1BC15FD15;
        Mon,  1 Aug 2022 17:38:16 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1659364696;
        bh=o7OLgDbo1xqFLNJ+G6hOVPrGDC+uPcvGgiUc/M2WLx8=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=NVw/bqmCbnvrKQnptbzoNJOPXxc6YZ5d1oKKCq9CUY9NL2HzrrXMnUtmWqJbDWdkm
         5qMRk1tVqfH4jZiIlJgRVkq5bjOefzXV+MsgeUfPd9BMG2IpQFqzvuyun8+zGjU6Jy
         8GTg4LVgjsnTtZOmQOFDRNwHlX/mrqFD3rxJOanT/TKjM1J37c2gdRO1/Dx+Hc6re9
         ZstnPdU/jB1c2gWzPGhdxNEQ0pYLd4BXGCNOLzJCUusXV00+Jxl1XPdyGqVZedmkGL
         YgodkFEPclrgGwgqqVWmSkMgbCdzIeN/leS3RQuWGeNfGHHczLWgV7ZqNyhUNe3ttE
         jxZaTWEAqssig==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Mon,  1 Aug 2022 17:38:14 +0300 (MSK)
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
Subject: [PATCH v3 0/3] units: complement the set of Hz units
Thread-Topic: [PATCH v3 0/3] units: complement the set of Hz units
Thread-Index: AQHYpbQ2WkEHos67cUaK7wL1TIYVMw==
Date:   Mon, 1 Aug 2022 14:37:23 +0000
Message-ID: <20220801143811.14817-1-ddrokosov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/01 10:27:00 #20025860
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During msa311 accel IIO driver development

https://lore.kernel.org/linux-iio/20220616104211.9257-1-ddrokosov@sberdevic=
es.ru/

Andy requested to use proper units in the hz->ms calculation. Current
units.h header doesn't have milli, micro and nano HZ coefficients, so
some drivers (in the IIO subsystem) implement their own copies for that.

The current patchset resolves such a problem and intoduces general
MILLIHZ_PER_HZ, MICROHZ_PER_HZ and NANOHZ_PER_HZ definitions in the units.h=
,
and fixes all drivers which duplicate these units.

Changes:
* v2->v3:
    - changed UHZ_PER_HZ to MICROHZ_PER_HZ and NHZ_PER_HZ to
      NANOHZ_PER_HZ to save name consistency for all new HZ units

* v1->v2:
    - changed MHZ_PER_HZ to a different name as Andy suggested
      (suppose MILLIHZ_PER_HZ is good enough)

Dmitry Rokosov (3):
  units: complement the set of Hz units
  iio: accel: adxl345: use HZ macro from units.h
  iio: common: scmi_sensors: use HZ macro from units.h

 drivers/iio/accel/adxl345_core.c           | 7 ++++---
 drivers/iio/common/scmi_sensors/scmi_iio.c | 8 ++++----
 include/linux/units.h                      | 3 +++
 3 files changed, 11 insertions(+), 7 deletions(-)

--=20
2.36.0

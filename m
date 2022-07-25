Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD3458042F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 20:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbiGYSo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 14:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiGYSo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 14:44:56 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE1F1F608;
        Mon, 25 Jul 2022 11:44:53 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 8A5355FD03;
        Mon, 25 Jul 2022 21:44:50 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1658774690;
        bh=Lj82v0UordpzJx89AzCSsYuvyyMERd4RMs1Xky7GRug=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=mKE1BEtNxFgQcoadl7cOMseISPiCWTNuWWkfPLLuvP7RtPGHgmhoOQFhjoikDNia3
         rUxClU0HLU/2tz8ZEv5gj4DQlFDzT4+Wbg30QKs/u1nGGM4RxmHEIJovqyPuzj/s+J
         TnUM5+AV4ybB2ozNcpI9BC+mtaYZ7GSHWhSGSeQKjzTxLGOejxeUIKOLMkvse4/OTe
         O7wPydslTzxWDSRIkF2FHYHG+L+3i4/i0UEAM+/M5PBPccvApCfsbuMPkcBDosS4nf
         4xvmxJcDmqJJHN3gM/wJPRJIT3ieetlu7k5mBy6tEWnLzktDWJv+sw8rRkwXGvhnO0
         yqbBhJUkdmodQ==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Mon, 25 Jul 2022 21:44:47 +0300 (MSK)
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
Subject: [PATCH v1 0/3] units: complement the set of Hz units
Thread-Topic: [PATCH v1 0/3] units: complement the set of Hz units
Thread-Index: AQHYoFaPgMYOHrecNUuqyBwfZRur4g==
Date:   Mon, 25 Jul 2022 18:44:24 +0000
Message-ID: <20220725184439.7618-1-ddrokosov@sberdevices.ru>
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

During msa311 accel IIO driver development

https://lore.kernel.org/linux-iio/20220616104211.9257-1-ddrokosov@sberdevic=
es.ru/

Andy requested to use proper units in the hz->ms calculation. Current
units.h header doesn't have milli, micro and nano HZ coefficients, so
some drivers (in the IIO subsystem) implement their own copies for that.

The current patchset resolves such a problem and intoduces general
MHZ_PER_HZ, UHZ_PER_HZ and NHZ_PER_HZ definitions in the units.h, and
fixes all drivers which duplicate these units.

Dmitry Rokosov (3):
  units: complement the set of Hz units
  iio: accel: adxl345: use HZ macro from units.h
  iio: common: scmi_sensors: use HZ macro from units.h

 drivers/iio/accel/adxl345_core.c           | 2 +-
 drivers/iio/common/scmi_sensors/scmi_iio.c | 2 +-
 include/linux/units.h                      | 3 +++
 3 files changed, 5 insertions(+), 2 deletions(-)

--=20
2.36.0

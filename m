Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42574581051
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 11:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238539AbiGZJta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 05:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbiGZJt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:49:27 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B9B31DD7;
        Tue, 26 Jul 2022 02:49:24 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 0C8E95FD04;
        Tue, 26 Jul 2022 12:49:22 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1658828962;
        bh=K22w9hfJS/evEUDwB3F4Dmwu3c9LbepbkOhWPVhSDek=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=eJcVk9fvnApIOVjcBfKtwFz2dgd43sRaYr3MwXFoaGgSg60+AK4LcFV7UQIYo5EaJ
         x071z4GKx60KKh23vj2TuTfsoJDPpf94TbKoiPJPrCcrJmr1ODMAH7ajDd7iBhhSwJ
         +oqeABT1+MmD7zJz75pdqXVKCQzaE48NxjPUdZoxeS3UyvGOrbGmrgI47QRfly9AwL
         ayCJ6q+MN5P1N7ho3eaYHwcjzrZRydfWMrmRfhRebdVB1Lg1FzRML9b/yfqe78GQ1S
         PEM4ch1QYw39AGP1eMD/lSj9ecSw+FAFW2khctCxQNzChMtivvxZo5OzY+3HxQmEp1
         R6Ctr1scpBxzA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Tue, 26 Jul 2022 12:49:19 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "wsa@kernel.org" <wsa@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        "jbhayana@google.com" <jbhayana@google.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/3] units: complement the set of Hz units
Thread-Topic: [PATCH v1 1/3] units: complement the set of Hz units
Thread-Index: AQHYoFaQAQbyP6ttz02qWm6Ywvl4Ba2PaEmAgADOrYA=
Date:   Tue, 26 Jul 2022 09:49:15 +0000
Message-ID: <20220726094915.grn33xjqgkm52yja@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220725184439.7618-1-ddrokosov@sberdevices.ru>
 <20220725184439.7618-2-ddrokosov@sberdevices.ru>
 <CAHp75VcpY1vwHCOaJNb-qw+3gsMyv9mJe+QaWrjiTKOdj1xfYg@mail.gmail.com>
In-Reply-To: <CAHp75VcpY1vwHCOaJNb-qw+3gsMyv9mJe+QaWrjiTKOdj1xfYg@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E6F6CFDC59DAB14FB5D4A4DE390163A6@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/07/26 06:45:00 #19969454
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy,

Thank you for quick review.

On Mon, Jul 25, 2022 at 11:29:31PM +0200, Andy Shevchenko wrote:
> On Mon, Jul 25, 2022 at 8:44 PM Dmitry Rokosov <DDRokosov@sberdevices.ru>=
 wrote:
> >
> > Currently, Hz units do not have milli, micro and nano Hz coefficients.
> > Some drivers (IIO especially) use their analogues to calculate
> > appropriate Hz values. This patch includes them to units.h definitions,
> > so they can be used from different kernel places.
>=20
> ...
>=20
> > +#define NHZ_PER_HZ             1000000000UL
> > +#define UHZ_PER_HZ             1000000UL
> > +#define MHZ_PER_HZ             1000UL
>=20
> mHZ perhaps?
>=20

I'm afraid it will not have the same view as other HZ units.
Maybe it's better to call mHZ as MILLIHZ? What do you think?

--=20
Thank you,
Dmitry=

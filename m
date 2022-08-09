Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A63258D77C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 12:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242456AbiHIKfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 06:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242417AbiHIKfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 06:35:30 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC7EB857;
        Tue,  9 Aug 2022 03:35:28 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id C9A475FD05;
        Tue,  9 Aug 2022 13:35:25 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1660041325;
        bh=KJBBN8QxL2pA1a4tnDeW13FPwDII60vaVpI4Hj1uPoM=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=cOpKcMwO44NHoGyXHhW+c2+dgTPfIwguyELi7YRIzMpsM6RsPP7jJfFs9xaKxRzcx
         mK9JCgnLtfLNYjnjUddKqSP2SfkBUxCVIpfbFgMMDzjsBfLQdb7SeXrpCGrSuDMNdp
         VgCVtGNUJcP9ygAw0FjMN75hOqcw2qjXGfWJvBGf5t4zIIN5qKtTYNEhHkMKooU6aQ
         1FDRLbhIsf8rVSKj3Dm0b2FwHQk4YPJaceCniZBkVh9iuDZLrt/06j+k1dh2UoZ3u2
         WVmRs847yilTUdFos6JPqXL63EeR/3WY8U1gwcFM+Wl6DXMy4dpG1T4h1k9NRBuPWF
         dC+d3+OuT6q0A==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Tue,  9 Aug 2022 13:35:25 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Thread-Topic: [PATCH v4 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Thread-Index: AQHYpzqIoQnaRj7vNkq2cXUUGjAB/62dQgeAgAAYQICABG4VgIAEYneAgAADdACAAAhqgA==
Date:   Tue, 9 Aug 2022 10:35:19 +0000
Message-ID: <20220809103519.437rcude7fstxyy4@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220803131132.19630-1-ddrokosov@sberdevices.ru>
 <20220803131132.19630-3-ddrokosov@sberdevices.ru>
 <CAHp75VcVuC6yVoB1kycCOfqMa=JfCtbe3WYSK5qndtYcJy3vpg@mail.gmail.com>
 <20220803191621.tzrmndkygfe7nlpx@CAB-WSD-L081021.sigma.sbrf.ru>
 <20220806155523.37c3e587@jic23-huawei>
 <20220809095251.vpp6arac3pkntdlo@CAB-WSD-L081021.sigma.sbrf.ru>
 <CAHp75Vc9LGX-=Y2smOrKuAgSRrhA0AgGuBE-0=_-q78FpSB6ag@mail.gmail.com>
In-Reply-To: <CAHp75Vc9LGX-=Y2smOrKuAgSRrhA0AgGuBE-0=_-q78FpSB6ag@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4A44EE2DD7C669428F74395D26CCE4BE@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/09 07:32:00 #20083496
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 12:05:12PM +0200, Andy Shevchenko wrote:
> > > > > > +       indio_dev->modes =3D 0; /* setup buffered mode later */
> > > > >
> > > > > Why explicit assignment to 0? Doesn't kzalloc() do it for you?
> > > >
> > > > kzalloc() will do it for me, of course. Previously, I initialized m=
odes to
> > > > INDIO_DIRECT_MODE to just provide default value for that. Jonathan
> > > > suggested to replace it with 0.
> > >
> > > I did?  I wonder what I was smoking that day.
> > > Should be set to INDIO_DIRECT_MODE as you had it previously.
> > >
> > > (From what I recall it will work either way but we have in the past h=
ad
> > > core code that checked this and may do again in the future so drivers=
 should
> > > still be setting it to specify they provide sysfs interfaces to direc=
tly read
> > > the channels).
> >
> > Jonathan, really sorry I referred to you. I'm confused. This comment wa=
s
> > from Andy in the v3 discussion:
> >
> > https://lore.kernel.org/linux-iio/CAHp75Vc0+ckNnm2tzLMPrjeFRjwoj3zy0C4k=
oNShFRG3kP8b6w@mail.gmail.com/
>=20
> Indeed. I was confused by the comment. My understanding at that time
> was that the triggered mode is inevitable and hence assigning to
> something which _will_ be reassigned later makes a little sense. So,
> does it mean that triggered mode is optional and might not be set? In
> such a case the comment is misleading.

Actually, this comment was introduced in the early MSA311 driver
versions, when I have made buffer setup only if HW irq is enabled. In
the newest versions buffer is setup unconditionally, because buffer mode
can be used based on hrtimer software trigger.

Jonathan, why we shouldn't delete INDIO_DIRECT_MODE initialization if
after couple of lines we always setup buffer mode?

--=20
Thank you,
Dmitry=

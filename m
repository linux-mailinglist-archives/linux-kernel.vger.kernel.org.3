Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EAD58ADFE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 18:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241093AbiHEQVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 12:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237618AbiHEQVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 12:21:11 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546E71CB19;
        Fri,  5 Aug 2022 09:21:07 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id C7FEA5FD07;
        Fri,  5 Aug 2022 19:21:04 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1659716464;
        bh=xuobiR3ZIJrOhieNCkdMS7jCXSTPF1YelC1n62mxDJg=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=Ufv5t67n5sGclFkAEFCdFojOh8BuSpZDyDYpQSm4siQXKAzjSw+vX8yAPaB75HRl4
         QJZAyNKfK9twdFnv6hhiWdAPBmvlWGLcit2i7qLdnP8mIteFDLHbw97f17WCc4gF8z
         UUAEEvjCsSqiHu5Lg6iU8OcLjMJuJemHCqVWaSpHwUWG7jRNePKMveUrOOQFiA6Jq+
         LZIWuf3RbuU/SbWSfDefB3QtoohkX6nPR/l00TsZgwRWgohL1JSXgd+hYYWEkBBDIH
         i//FLFFLZg1b71azkPzLov0MCbcB5W4BWDsHt5D8Zf4bhizxCadOyGeiy8NcR5yuiW
         gylQ8DNVdfmMA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Fri,  5 Aug 2022 19:21:04 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
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
Thread-Index: AQHYpzqIoQnaRj7vNkq2cXUUGjAB/62dQgeAgAAYQICAAYHbgIAAA5UAgAFIGQCAACEqAIAABPkA
Date:   Fri, 5 Aug 2022 16:20:35 +0000
Message-ID: <20220805162100.q4ol4go3ozefmqt6@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220803131132.19630-1-ddrokosov@sberdevices.ru>
 <20220803131132.19630-3-ddrokosov@sberdevices.ru>
 <CAHp75VcVuC6yVoB1kycCOfqMa=JfCtbe3WYSK5qndtYcJy3vpg@mail.gmail.com>
 <20220803191621.tzrmndkygfe7nlpx@CAB-WSD-L081021.sigma.sbrf.ru>
 <20220804181723.4bljpxcwkj6cnn2f@CAB-WSD-L081021.sigma.sbrf.ru>
 <CAHp75Vcn6JCDDvugop2Ho1cayLi1CX78O42v3GifvnuSY5fvPA@mail.gmail.com>
 <20220805140430.c773smfzxg5zcj4b@CAB-WSD-L081021.sigma.sbrf.ru>
 <CAHp75VeHXemqJH6rCfH5Tvoq=nDBM4d9nGr-b6LN-fKMEEvyfA@mail.gmail.com>
In-Reply-To: <CAHp75VeHXemqJH6rCfH5Tvoq=nDBM4d9nGr-b6LN-fKMEEvyfA@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C54383C99145FC488C79168BCCBBE740@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/05 14:06:00 #20057365
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 06:03:12PM +0200, Andy Shevchenko wrote:
> On Fri, Aug 5, 2022 at 4:04 PM Dmitry Rokosov <DDRokosov@sberdevices.ru> =
wrote:
> >
> > On Thu, Aug 04, 2022 at 08:30:12PM +0200, Andy Shevchenko wrote:
> > > > > > > +               dev_err(dev, "cannot %s register %u from debu=
gfs (%d)\n",
> > > > > > > +                       readval ? "read" : "write", reg, err)=
;
> > > > > >
> > > > > > You may consider taking [1] as a precursor here and use str_rea=
d_write().
> > > > > >
> > > > > > [1]: https://lore.kernel.org/linux-i2c/20220703154232.55549-1-a=
ndriy.shevchenko@linux.intel.com/
> > > > >
> > > > > Oh, really... Thank you for suggestion!
> > > >
> > > > I have taken it closer, and it's really helpful and nice, but looks=
 like
> > > > it's not merged to linux-next.
> > > > Please advise how I can use it in the driver. Should I provide
> > > > "Depends-On:" tag as I did for my HZ units patchset?
> > >
> > > No, just take that patch into your series.
> >
> > Do you mean include your patch to this reply-thread through the
> > message-id linking?
>=20
> No, just take it as a part of your series. Ah, I wrote almost the same
> thing above...
>=20
> The idea is you rebase your tree interactively and put a breakpoint to
> the beginning of your series, then you take a link and run `b4 am -s
> ...` (-s is important) followed by `git am ...` (b4 will show you the
> command you need to run). Then you continue your rebasing. Now, when
> you send a new version of the series, take one more patch into it by
> changing depth from 3 (the number of patches in your series) to 4 (+
> my patch).
>=20
> Generally speaking the HZ series is something different. It's a series
> which can't be simply taken because it might touch the different
> subsystem(s). Luckily for you the "different subsystem(s)" is the same
> subsystem you are taking these patches with. Hence it might not be a
> problem to attach it as well into a chain.
>=20
> Speaking of lib/ code almost any maintainer can take it via their
> trees. So taking a _single_ patch against lib/ is fine in most cases.

Oh, got it. Thanks a lot for detailed explanation. I'll attach both of
them: my HZ units series and your str_read_write() patchset.

--=20
Thank you,
Dmitry=

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED71D58D6D2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 11:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239420AbiHIJxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 05:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239708AbiHIJw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 05:52:58 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D391F2E5;
        Tue,  9 Aug 2022 02:52:56 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 8CB585FD05;
        Tue,  9 Aug 2022 12:52:54 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1660038774;
        bh=M0hVkGi9BnyS4U+M2LNgZ5Fw0ElaAi8kx2AmE3MExoY=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=RLqx64yr+XsKPVSFbN1Zoz+3FLdJgMubI21Aq+SJIsEC2E1uym6n/NVPoiPrlVGP9
         B8LlJnnR9OjItI/KeSgXDkdLqj8ja5L/5mWQgFsy+FrMEp2wZLkIoTTmTYDwL59Pot
         eX6EacdMlAfUZbwSmgLgmLqL1wRsFXqVR10lxrV4Agp289ISAsctR3c9YoZ2GV81Ru
         gLTRs3Gss4f+GNIiXMJfKM2wsdQnjFY7BffJvbznRlVUAu7mhSi5YFGpO5je4W2zOR
         w54KKIzntduQqyPaV5DTzsMaK9vrpqTwX0fJvB0daSJO5IE5kVb68NeGbFBX3ZguO/
         y2lbqWHDsQ/XQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Tue,  9 Aug 2022 12:52:54 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
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
Thread-Index: AQHYpzqIoQnaRj7vNkq2cXUUGjAB/62dQgeAgAAYQICABG4VgIAEYneA
Date:   Tue, 9 Aug 2022 09:52:49 +0000
Message-ID: <20220809095251.vpp6arac3pkntdlo@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220803131132.19630-1-ddrokosov@sberdevices.ru>
 <20220803131132.19630-3-ddrokosov@sberdevices.ru>
 <CAHp75VcVuC6yVoB1kycCOfqMa=JfCtbe3WYSK5qndtYcJy3vpg@mail.gmail.com>
 <20220803191621.tzrmndkygfe7nlpx@CAB-WSD-L081021.sigma.sbrf.ru>
 <20220806155523.37c3e587@jic23-huawei>
In-Reply-To: <20220806155523.37c3e587@jic23-huawei>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <12645F490CB8B346AFD6E29545FC300A@sberdevices.ru>
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

On Sat, Aug 06, 2022 at 03:55:23PM +0100, Jonathan Cameron wrote:

[...]

> >=20
> > > > +       indio_dev->modes =3D 0; /* setup buffered mode later */ =20
> > >=20
> > > Why explicit assignment to 0? Doesn't kzalloc() do it for you? =20
> >=20
> > kzalloc() will do it for me, of course. Previously, I initialized modes=
 to
> > INDIO_DIRECT_MODE to just provide default value for that. Jonathan
> > suggested to replace it with 0.=20
>=20
> I did?  I wonder what I was smoking that day.=20
> Should be set to INDIO_DIRECT_MODE as you had it previously.
>=20
> (From what I recall it will work either way but we have in the past had
> core code that checked this and may do again in the future so drivers sho=
uld
> still be setting it to specify they provide sysfs interfaces to directly =
read
> the channels).

Jonathan, really sorry I referred to you. I'm confused. This comment was
from Andy in the v3 discussion:

https://lore.kernel.org/linux-iio/CAHp75Vc0+ckNnm2tzLMPrjeFRjwoj3zy0C4koNSh=
FRG3kP8b6w@mail.gmail.com/

I will revert this change. Thank you for feedback.

--=20
Thank you,
Dmitry=

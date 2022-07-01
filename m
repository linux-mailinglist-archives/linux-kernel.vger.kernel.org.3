Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8E9563406
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 15:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236267AbiGANG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 09:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbiGANGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 09:06:54 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8762013FBB;
        Fri,  1 Jul 2022 06:06:49 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id E29535FD07;
        Fri,  1 Jul 2022 16:06:46 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1656680806;
        bh=fiut9pdYBKfqzNXQNRnMFvK85CYnjZbzKdgZn+r3CAM=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=jcxySHPf7vV4fuSpiK9tYY3Jm9OBexjAzWdMPlOy+gUDKI5mhVZPhN/ro4s6L/9ug
         8splP6Rp/Gjee2R23VCA6e06TKLG1DkPoXR0p5KMSrX2n4UDzcSp5WovHLHkKH0Gu5
         gVSLJAcQFHPHJ2YBw3o5Hi6b+l9oWoiiWZlXDVMsG9lVmT2Yxkw5eXwPzusXMoNhMc
         ZrDwV7UbcOTAcz/A72Q73or/ONx3Gjs9NDgQ6l5jlxd6/DkBJ5RvT0Vba3ls897DkO
         RXvo8xseN8p7kBWnvLsYsnb1mJbonKSRz/rgJgO2cP1VXBTXBpmko2hT4aEenrmXul
         LxkdtT8Z6ktfA==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Fri,  1 Jul 2022 16:06:46 +0300 (MSK)
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
Subject: Re: [PATCH v3 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Thread-Topic: [PATCH v3 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Thread-Index: AQHYgW2+up0uMWdZgUWEAW/5cCPkBq1RwVQAgABPMQCABGtkAIAS5cEA
Date:   Fri, 1 Jul 2022 13:06:17 +0000
Message-ID: <20220701130642.pjwucd2cvbr4uq3x@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220616104211.9257-1-ddrokosov@sberdevices.ru>
 <20220616104211.9257-3-ddrokosov@sberdevices.ru>
 <CAHp75Vc0+ckNnm2tzLMPrjeFRjwoj3zy0C4koNShFRG3kP8b6w@mail.gmail.com>
 <20220616170218.dihjli46spimozeg@CAB-WSD-L081021.sigma.sbrf.ru>
 <20220619133142.0ca36d2e@jic23-huawei>
In-Reply-To: <20220619133142.0ca36d2e@jic23-huawei>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <51848E1B2B9D0449A68E08E1587CF7D1@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/07/01 07:59:00 #19867624
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 19, 2022 at 01:31:42PM +0100, Jonathan Cameron wrote:
> On Thu, 16 Jun 2022 17:02:08 +0000
> Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:
>=20
>=20
>=20
> > > > +       err =3D -EINVAL;
> > > > +       mutex_lock(&msa311->lock);
> > > > +       for (odr =3D 0; odr < ARRAY_SIZE(msa311_odr_table); ++odr)
> > > > +               if (val =3D=3D msa311_odr_table[odr].val &&
> > > > +                   val2 =3D=3D msa311_odr_table[odr].val2) {
> > > > +                       err =3D msa311_set_odr(msa311, odr); =20
> > >  =20
> > > > +                       if (err) {
> > > > +                               dev_err(dev, "cannot update freq (%=
d)\n", err);
> > > > +                               goto failed;
> > > > +                       } =20
> > >=20
> > > Why is this inside the loop and more important under lock? Also you
> > > may cover the initial error code by this message when moving it out o=
f
> > > the loop and lock.
> > >=20
> > > Ditto for other code snippets in other function(s) where applicable.
> > >  =20
> >=20
> > Yes, I can move dev_err() outside of loop. But all ODR search loop
> > should be under lock fully, because other msa311 operations should not
> > be executed when we search proper ODR place.
>=20
> I don't see why?  The search itself is for a match of the input to const =
data.
> That can occur before taking the lock to do the actual write.
>=20
> I don't see any additional race beyond the one that is always there of
> a thread updating ODR whilst another is accessing the device.  Which orde=
r
> those events happen in is not controlled by the driver, but the output
> will be consistent with one or other order of those two accesses.
>=20
> Jonathan

Agreed, will be changed in the v4.

--=20
Thank you,
Dmitry=

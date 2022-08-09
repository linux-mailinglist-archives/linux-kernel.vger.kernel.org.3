Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9F958D6B8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 11:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238652AbiHIJsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 05:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiHIJsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 05:48:04 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D9B1F63A;
        Tue,  9 Aug 2022 02:48:01 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 8A1815FD05;
        Tue,  9 Aug 2022 12:47:59 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1660038479;
        bh=1NkSog7fNwIuD5awyrROp78DqGLAA2ojxoXb1/HAoNk=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=hFDLqYrgj81gSOH5Urbg46yf1sLyfdAl9V/bmisWnmBKVIF4b1YmuFUt0gVGqYSQf
         42GnCO8zJNeHd6h6UtfkdBIDNeY38CJvqV1Qegwbs59Pdq4q1VXqy+fg7Bk0vXulxz
         juLR4kmdJ1Xf81UU+kwOUJlDS+kbIgYgE4u7Cu+ze6fXOsxrkBpZoW5+U0gUhde1rc
         Hjc8yGiVmmTzkkHrKSq5UI0GCZcA3xtrrA3yqnqsSuIu+5f55A+weRfhHDUPCNPEUb
         aC+EvHRee3fI3Cj2gAEP1KfaNPsRQqs5vq4lVJZAFLbl2Y6wGqPmm0M4L2lLhoTYaN
         9Sc/qN+ZJDdgw==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Tue,  9 Aug 2022 12:47:58 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Thread-Topic: [PATCH v4 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Thread-Index: AQHYpzqIoQnaRj7vNkq2cXUUGjAB/62h0pwAgARW1QA=
Date:   Tue, 9 Aug 2022 09:47:54 +0000
Message-ID: <20220809094754.akfed7hxcdvxoacj@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220803131132.19630-1-ddrokosov@sberdevices.ru>
 <20220803131132.19630-3-ddrokosov@sberdevices.ru>
 <20220806163204.3262c0e7@jic23-huawei>
In-Reply-To: <20220806163204.3262c0e7@jic23-huawei>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6373418BF86F2844AEE00C8459CE3039@sberdevices.ru>
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

Hello Jonathan,

On Sat, Aug 06, 2022 at 04:32:04PM +0100, Jonathan Cameron wrote:

[...]

> > +/**
> > + * struct msa311_priv - MSA311 internal private state
> > + * @regs: Underlying I2C bus adapter used to abstract slave
> > + *        register accesses
> > + * @fields: Abstract objects for each registers fields access
> > + * @dev: Device handler associated with appropriate bus client
> > + * @lock: Protects msa311 device state between setup and data access r=
outines
> > + *        (power transitions, samp_freq/scale tune, retrieving axes da=
ta, etc)
> > + * @new_data_trig: Optional NEW_DATA interrupt driven trigger used
> > + *                 to notify external consumers a new sample is ready
> > + * @vdd: Optional external voltage regulator for the device power supp=
ly
> > + */
> > +struct msa311_priv {
> > +	struct regmap *regs;
> > +	struct regmap_field *fields[F_MAX_FIELDS];
> > +
> > +	struct device *dev;
> > +	struct mutex lock; /* state guard */
>=20
> Shouldn't need this comment given documentation above that provides
> more information.

Without this comment checkpatch.pl raises a warning about uncommented
lock definition.
I agree with you, above comment is redundant, but is it okay to ignore
such warnings before sending the patch?

I'm talking about below checkpatch condition:
=3D=3D=3D=3D=3D
# check for spinlock_t definitions without a comment.
		if ($line =3D~ /^.\s*(struct\s+mutex|spinlock_t)\s+\S+;/ ||
		    $line =3D~ /^.\s*(DEFINE_MUTEX)\s*\(/) {
			my $which =3D $1;
			if (!ctx_has_comment($first_line, $linenr)) {
				CHK("UNCOMMENTED_DEFINITION",
				    "$1 definition without comment\n" . $herecurr);
			}
		}
=3D=3D=3D=3D=3D

>=20
> > +
> > +	struct iio_trigger *new_data_trig;
> > +	struct regulator *vdd;
> > +};
> >
>=20
>=20
> > +static irqreturn_t msa311_irq_thread(int irq, void *p)
> > +{
> > +	struct msa311_priv *msa311 =3D iio_priv(p);
> > +	unsigned int new_data_int_enabled;
> > +	struct device *dev =3D msa311->dev;
> > +	int err;
> > +
> > +	mutex_lock(&msa311->lock);
>=20
> > +
> > +	/*
> > +	 * We do not check NEW_DATA int status, because of based on
> > +	 * specification it's cleared automatically after a fixed time.
> > +	 * So just check that is enabled by driver logic.
>=20
> That is going to be very problematic if we can have this and events comin=
g
> through the same interrupt pin.  Not harmful for now though given you are
> only supporting NEW_DATA for now.  Just something to watch out for.
>=20

Actually, I have run some experiments with NEW_DATA status bits. And
looks like we can't determince actual status of NEW_DATA virtual
interrupt when physical IRQ is raised. I will back to this problem when
begin Motion Events feature implementation.

[...]

> > +	err =3D devm_pm_runtime_enable(dev);
> > +	if (err)
> > +		return err;
> > +
> > +	pm_runtime_get_noresume(dev);
> > +	pm_runtime_set_autosuspend_delay(dev, MSA311_PWR_SLEEP_DELAY_MS);
> > +	pm_runtime_use_autosuspend(dev);
> > +
> > +	err =3D msa311_chip_init(msa311);
> > +	if (err)
> > +		return err;
> > +
> > +	indio_dev->modes =3D 0; /* setup buffered mode later */
>=20
> As per other branch, I led you astray here it seems.
>=20

Sorry, I've made a mistake. Comment about INDIO_DIRECT_MODE was left
by Andy here:

https://lore.kernel.org/linux-iio/CAHp75Vc0+ckNnm2tzLMPrjeFRjwoj3zy0C4koNSh=
FRG3kP8b6w@mail.gmail.com/

[...]

--=20
Thank you,
Dmitry=

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CD85453BB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 20:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345246AbiFISJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 14:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245199AbiFISJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 14:09:37 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C553A81D3;
        Thu,  9 Jun 2022 11:09:32 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 7AF7E5FD07;
        Thu,  9 Jun 2022 21:09:29 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1654798169;
        bh=qN7aVhekJZ4Gb0ieS6/ZZa0LFi3wctFRNer8cdnqVIY=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=hGo9NNJ+FTYL/qWlYGlnQgROBilYfILrRbjsD0znbORaThlJaDW1PkxQ5rHDAi6QM
         zWsJ9DMHjCsjZ4nBNLZIfYRyagroqGFbWEMGOoNPJnMPDnNkH9cxhqkqKoeKGC5i5N
         1TY0DTDeMoghX35cXarSpK933M9H41T9OJz0gR8okUPMtWFYinWGz8l/LKDbb0Xszl
         kqVytYYl5Ka3RM46a+vuFtaFE3+jF/1HZlM6Ks00JekqgcEpSm6Tw62nnxcF4A/Hlg
         3zBBNQQ5OQyQRNjtFjymk/MJ+wUVRqRMiz9+m4/ndi7htBh5/Om3WzplPlqZdltAue
         aQ+UWxgWRggtg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Thu,  9 Jun 2022 21:09:28 +0300 (MSK)
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
Subject: Re: [PATCH v2 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Thread-Topic: [PATCH v2 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Thread-Index: AQHYcGNscv5GHcvjkkaBriw+oOvmsq00b84AgBLVOIA=
Date:   Thu, 9 Jun 2022 18:09:05 +0000
Message-ID: <20220609180923.e2q7hkeq5jldtdo2@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220525181532.6805-1-ddrokosov@sberdevices.ru>
 <20220525181532.6805-3-ddrokosov@sberdevices.ru>
 <20220528193335.646dd092@jic23-huawei>
In-Reply-To: <20220528193335.646dd092@jic23-huawei>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DEE87E6C42633F4B9952D7CD7E161E58@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/06/09 08:45:00 #19722238
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jonathan,

Thank you for comments. Please find my replies below.

On Sat, May 28, 2022 at 07:33:34PM +0100, Jonathan Cameron wrote:
> On Wed, 25 May 2022 18:15:32 +0000
> Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:
>=20
> > MSA311 is a tri-axial, low-g accelerometer with I2C digital output for
> > sensitivity consumer applications. It has dynamical user selectable ful=
l
> > scales range of +-2g/+-4g/+-8g/+-16g and allows acceleration measuremen=
ts
> > with output data rates from 1Hz to 1000Hz.
> >=20
> > Datasheet can be found at following URL:
> > https://cdn-shop.adafruit.com/product-files/5309/MSA311-V1.1-ENG.pdf
> >=20
> > This driver supports following MSA311 features:
> >     - IIO interface
> >     - Different power modes: NORMAL and SUSPEND (using pm_runtime)
> >     - ODR (Output Data Rate) selection
> >     - Scale and samp_freq selection
> >     - IIO triggered buffer, IIO reg access
> >     - NEW_DATA interrupt + trigger
> >=20
> > Below features to be done:
> >     - Motion Events: ACTIVE, TAP, ORIENT, FREEFALL
> >=20
> > Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
>=20
> Hi Dmitry,
>=20
> Various comments inline. One thing to think about is which of the comment=
s
> / function documentation is useful and which is just stating the obvious.
> If things are obvious it is usually better to not add documentation that
> doesn't provide additional insight because it provides a maintenance
> burden going forwards.
>=20
> In a similar fashion, consider if a failure path that isn't already resul=
ting
> in a print is remotely likely.  Error messages are something else that ca=
use
> maintenance burden, so there has to be some advantage in having them to
> pay that cost.
>=20
> Thanks,
>=20
> Jonathan
>=20

Sure, no problem. I'll send updated driver without obvious comments and
error messages in v3 patch series.

> > +/**
> > + * msa311_write_raw() - IIO interface function to write attr/accel dat=
a
> > + * @indio_dev: The IIO device associated with MSA311
> > + * @chan: IIO channel specification
> > + * @val: Input data value, first part
> > + * @val2: Input data value, second part
> > + * @mask: Value type selector
> > + *
> > + * Return: 0 on success,
> > + *         -EINVAL for unknown value type (bad mask),
> > + *         -ERRNO in other failures
> > + */
> > +static int msa311_write_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan,
> > +			    int val, int val2, long mask)
> > +{
> > +	struct msa311_priv *msa311 =3D iio_priv(indio_dev);
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_SCALE:
> > +		if (iio_buffer_enabled(indio_dev))
>=20
> This races.  We have
> iio_device_claim_direct_mode() and the matching
> release to avoid such races.  They will ensure we are in
> a mode where the buffer isn't enabled for the duration of
> any action like this.=20
>=20
>=20
> Mind you, why can't we write the scale while the buffer is turned on?
> It might be unwise given no way of knowing when it applies, but
> that is a problem for userspace dumb enough to do it ;)
>=20
> If there is a reason to not do so, good to add a comment here
> to say why not.  Same obviously applies to sampling frequency below.

I've inserted such condition, because I used pm_runtime() calls inside
trig_set_state() callback, which was wrong behavior (as you correctly
mentioned before). In those situations, if userspace changed scale or freq
during a buffer reading, it was a time slot where device could go to sleep,
and this is a bad thing. Anyway, for now I'm using pm_runtime() callbacks
during buffer_enable and buffer_disable executions, so I can remove this
condition from scale/freq write operations and race will gone.

> > +					i2c->name,
> > +					indio_dev);
> > +	if (err)
> > +		return dev_err_probe(dev, err,
> > +				     "failed to request irq (%d)\n", err);
> > +
> > +	trig =3D devm_iio_trigger_alloc(dev, "%s-new-data", i2c->name);
> > +	if (!trig)
> > +		return dev_err_probe(dev, -ENOMEM,
> > +				     "cannot allocate newdata trig\n");
> > +
> > +	msa311->new_data_trig =3D trig;
> > +	msa311->new_data_trig->dev.parent =3D dev;
> > +	msa311->new_data_trig->ops =3D &msa311_new_data_trig_ops;
> > +	iio_trigger_set_drvdata(msa311->new_data_trig, indio_dev);
> > +
> > +	err =3D devm_iio_trigger_register(dev, msa311->new_data_trig);
> > +	if (err)
> > +		return dev_err_probe(dev, err,
> > +				     "can't register newdata trig (%d)\n", err);
> > +
> > +	indio_dev->trig =3D iio_trigger_get(msa311->new_data_trig);
>=20
> Drop this.  Your driver now supports other triggers so leave
> this decision to userspace (thus avoiding the issue with remove discussed=
 in
> v1).
>=20

Okay, but many other drivers have such the same problem. May be it's
better to stay in the consistent state with them? What do you think?

> > +
> > +	/* Resume device if any */
> > +	pm_runtime_get_sync(dev);
> > +
> > +	/* Don't use autosuspend PM runtime feature anymore */
> > +	pm_runtime_dont_use_autosuspend(dev);
>=20
> this is done for you in the unwind of
> devm_pm_runtime_enable() so If you need to repeat it here, explain why.
>=20

As I understood, devm_pm_runtime_enable() executes pm_runtime_disable()
during resource utilization. I'm not sure that pm_runtime_disable()
switches off autosuspend feature. I'll take a look and remove this line
if needed.

> > +
> > +	/* Suspend device right now */
> > +	pm_runtime_put_sync_suspend(dev);
>=20
> At this point is this any different from pm_runtime_put_sync?
>=20

Yes. Function pm_runtime_put_sync() transfers device to IDLE state if
needed, we do not want it here. Using pm_runtime_put_sync_suspend() our
goal is for msa311 transition to SUSPEND state when driver unloading.

> > +}
> > +
> > +/**
> > + * msa311_probe() - MSA311 main I2C driver probe function
> > + * @i2c: I2C client associated with MSA311 device
> > + *
> > + * Return: 0 on success
> > + *         -ENOMEM due to memory allocation failures
> > + *         -ERRNO in other failures
> > + */
> > +static int msa311_probe(struct i2c_client *i2c)
> > +{
> > +	struct msa311_priv *msa311;
> > +	struct iio_dev *indio_dev;
> > +	struct device *dev =3D &i2c->dev;
> > +	int err;
> > +
> > +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*msa311));
> > +	if (!indio_dev)
> > +		return dev_err_probe(dev, -ENOMEM,
> > +				     "iio device allocation failed\n");
> > +
> > +	msa311 =3D iio_priv(indio_dev);
> > +	msa311->i2c =3D i2c;
> > +	i2c_set_clientdata(i2c, indio_dev);
> > +
> > +	err =3D msa311_regmap_init(msa311);
> > +	if (err)
> > +		return err;
> > +
> > +	mutex_init(&msa311->lock);
> > +
> > +	err =3D devm_pm_runtime_enable(dev);
> > +	if (err)
> > +		return dev_err_probe(dev, err,
> > +				     "cannot enable runtime PM (%d)\n", err);
> > +
> > +	/* Resume msa311 logic before any interactions with registers */
> > +	err =3D pm_runtime_resume_and_get(dev);
> > +	if (err)
> > +		return dev_err_probe(dev, err,
> > +				     "failed to resume runtime pm (%d)\n", err);
>=20
> Given you already report an error message on the failure path in resume,
> having one here as well is probably excessive as any other failure case
> is very unlikely.
>=20

This dev_err() message is located here, because
pm_runtime_resume_and_get() can contain internal errors which are not
dependent on driver logic. So I try to catch such errors in this place.

> > +
> > +	pm_runtime_set_autosuspend_delay(dev, MSA311_PWR_SLEEP_DELAY_MS);
> > +	pm_runtime_use_autosuspend(dev);
> > +
> > +	err =3D msa311_chip_init(msa311);
> > +	if (err)
> > +		return err;
> > +
> > +	indio_dev->modes =3D INDIO_DIRECT_MODE; /* setup buffered mode later =
*/
> > +	indio_dev->channels =3D msa311_channels;
> > +	indio_dev->num_channels =3D ARRAY_SIZE(msa311_channels);
> > +	indio_dev->name =3D i2c->name;
> > +	indio_dev->info =3D &msa311_info;
> > +
> > +	err =3D devm_iio_triggered_buffer_setup(dev,
> > +					      indio_dev,
> > +					      iio_pollfunc_store_time,
> > +					      msa311_buffer_thread,
> > +					      &msa311_buffer_setup_ops);
> > +	if (err)
> > +		return dev_err_probe(dev, err,
> > +				     "cannot setup iio trig buf (%d)\n", err);
> > +
> > +	if (i2c->irq > 0) {
> > +		err =3D msa311_setup_interrupts(msa311);
> > +		if (err)
> > +			return err;
> > +	}
> > +
> > +	pm_runtime_mark_last_busy(dev);
> > +	pm_runtime_put_autosuspend(dev);
> > +
> > +	err =3D devm_add_action_or_reset(dev, msa311_powerdown, msa311);
>=20
> It's not immediately clear what this devm action corresponds to and hence
> why it is at this point in the probe.  Needs a comment.  I think it's
> a way of forcing suspend to have definitely occurred?
>=20

Above devm action is needed to force driver to go to SUSPEND mode during
unloading. In other words, the device should be in SUSPEND mode in the two
cases:
1) When driver is loaded, but we do not have any data or configuration
requests to it (we are solving it using autosuspend feature)
2) When driver is unloaded and device is not used (devm action is used
in this case)

--=20
Thank you,
Dmitry=

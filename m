Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C1A5779BD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 05:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbiGRDYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 23:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiGRDYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 23:24:34 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B2962D5;
        Sun, 17 Jul 2022 20:24:32 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bk26so15168713wrb.11;
        Sun, 17 Jul 2022 20:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ExHD1YWVI7dhzqB7OPxXxafdaqH/UG07zGnDnS43790=;
        b=ON0mAlDBieFFfJn8KQ59K/FhCzwDKPe+22JhmRQvoaRG/RN8ldWQwc8CnBhitcM6C5
         TZH5pYH6xG0tv3vbM2Co2mkp7S0BRLyNQBy5siv1PVnhcjer9dfymrdkKVYRKLhGrKRe
         EK60U8LL8nJbf3YU6Didr7UuuA3JDkVuZn1K3VGgCH1UAbA+CllM0unwwjOzToIirfJM
         GCVeKu/HTK7mPjm0DbQB9tPmoCrBPjlXjaWKoZwH4IWzf4Jpjr8W6Hc38n74soXBZw9+
         sTPlJxva7hr08qlKCxUBJa4HHxOboLiUQeayEcTqPeDBSxUKMup8dX+sJLlXER7aHHQE
         sIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ExHD1YWVI7dhzqB7OPxXxafdaqH/UG07zGnDnS43790=;
        b=eWZlzaNP/j5FCzU9tiHeurjxAQIEBWGHUfaphkxxqlnzjQLxCdQQ+CT4uG//5mEqYG
         leXMigieZ9UVo8C0xCqoSu4yIXjg+FGE6sJ51/4JwbmsDGNM8eu8o1EUmu5lCnvsPeXW
         Qfbpx7ZItSmc52xxjqjP1SiOeBP727PI4gjCmFoG0Sbg38by6T45i8B2tYiUFGo8avAf
         awFvliVoZDpAk0SUoWW9FYKHkKJOvUWQwdX4tLFzsqy81hwVPW4OsYkJb0EuhlH73M4K
         c1CKsMdYomnUxYOS33YwRCgEgUkisIQZn64GOq4lL/5vYxXE7rjN5uK/yTq3w1nSyF8U
         bT1w==
X-Gm-Message-State: AJIora9LxeeqPbGNhusQCWy3d2yWdO+O33yYzxDi4JbE3X7zcGlOvr9z
        6LjZlXlP4dg2k4LtH3hNVrOmzLlFgh7AXl8c7nrTS1RA
X-Google-Smtp-Source: AGRyM1vwdJ99q9td66cfd6VghxwG49B9WCer6Ob9/Z7AzfsehlfrTehkfsDBMMeAQy/4hLrZE456SNnYz3h0AMSSuoE=
X-Received: by 2002:adf:f043:0:b0:21d:6a90:f3e6 with SMTP id
 t3-20020adff043000000b0021d6a90f3e6mr21215994wro.277.1658114671267; Sun, 17
 Jul 2022 20:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <1657116702-24161-1-git-send-email-u0084500@gmail.com>
 <1657116702-24161-3-git-send-email-u0084500@gmail.com> <20220707183027.342f6c88@jic23-huawei>
 <CADiBU3_KQ=WvD-1E4SODkdEY254_b-covw-0SHcAaF3XQqdbaQ@mail.gmail.com> <20220716183750.311f449c@jic23-huawei>
In-Reply-To: <20220716183750.311f449c@jic23-huawei>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Mon, 18 Jul 2022 11:24:19 +0800
Message-ID: <CADiBU3_dDUMWTAYt27ngm_arQS+CSAZrcyayWJfANymfEqug7A@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] iio: adc: Add rtq6056 support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        cy_huang <cy_huang@richtek.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Cameron <jic23@kernel.org> =E6=96=BC 2022=E5=B9=B47=E6=9C=8817=E6=
=97=A5 =E9=80=B1=E6=97=A5 =E5=87=8C=E6=99=A81:27=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, 11 Jul 2022 10:48:17 +0800
> ChiYuan Huang <u0084500@gmail.com> wrote:
>
> > Jonathan Cameron <jic23@kernel.org> =E6=96=BC 2022=E5=B9=B47=E6=9C=888=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E5=87=8C=E6=99=A81:20=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > >
> > > On Wed,  6 Jul 2022 22:11:42 +0800
> > > cy_huang <u0084500@gmail.com> wrote:
> > >
> > > > From: ChiYuan Huang <cy_huang@richtek.com>
> > > >
> > > > Add Richtek rtq6056 supporting.
> > > >
> > > > It can be used for the system to monitor load current and power wit=
h 16-bit
> > > > resolution.
> > > >
> > > > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > >
> > > Various feedback inline.
> > >
> > > Thanks,
> > >
> > > Jonathan
> > >
> > > > ---
> > > > Since v5
> > > > - Fix kernel version text for ABI.
> > > >
> > > > Since v4
> > > > - Add '__aligned(8)' for timestamp member in buffer_trigger_handler=
 function.
> > > > - Declare timestamp from 'int64_t' to more unified 's64'.
> > > >
> > > > Since v3
> > > > - Refine pm_runtime API calling order in 'read_channel' API.
> > > > - Fix vshunt wrong scale for divider.
> > > > - Refine the comment text.
> > > > - Use 'devm_add_action_or_reset' to decrease the code usage in prob=
e
> > > >   function.
> > > > - Use RUNTIME_PM_OPS to replace SET_RUNTIME_PM_OPS.
> > > > - minor fix for the comma.
> > > > - Use pm_ptr to replace the direct assigned pm_ops.
> > > >
> > > > Since v2
> > > > - Rename file from 'rtq6056-adc' to 'rtq6056'.
> > > > - Refine the ABI, if generic already defined it, remove it and chec=
k the channel
> > > >   report unit.
> > > > - Add copyright text.
> > > > - include the correct header.
> > > > - change the property parsing name.
> > > > - To use iio_chan_spec address field.
> > > > - Refine each channel separate and shared_by_all.
> > > > - Use pm_runtime and pm_runtime_autosuspend.
> > > > - Remove the shutdown callback. From the HW suggestion, it's not re=
commended to
> > > >   use battery as the power supply.
> > > > - Check all scale unit (voltage->mV, current->mA, power->milliWatt)=
.
> > > > - Use the read_avail to provide the interface for attribute value l=
ist.
> > > > - Add comma for the last element in the const integer array.
> > > > - Refine each ADC label text.
> > > > - In read_label callback, replace snprintf to sysfs_emit.
> > > >
> > > > ---
> > > >  .../ABI/testing/sysfs-bus-iio-adc-rtq6056          |   6 +
> > > >  drivers/iio/adc/Kconfig                            |  15 +
> > > >  drivers/iio/adc/Makefile                           |   1 +
> > > >  drivers/iio/adc/rtq6056.c                          | 651 +++++++++=
++++++++++++
> > > >  4 files changed, 673 insertions(+)
> > > >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-rtq=
6056
> > > >  create mode 100644 drivers/iio/adc/rtq6056.c
> > > >
> > > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-rtq6056 b/=
Documentation/ABI/testing/sysfs-bus-iio-adc-rtq6056
> > > > new file mode 100644
> > > > index 00000000..e89d15b
> > > > --- /dev/null
> > > > +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-rtq6056
> > > > @@ -0,0 +1,6 @@
> > > > +What:                /sys/bus/iio/devices/iio:deviceX/in_voltage0_=
integration_time
> > > > +What:                /sys/bus/iio/devices/iio:deviceX/in_voltage1_=
integration_time
> > > > +KernelVersion:       5.20
> > > > +Contact:     cy_huang@richtek.com
> > > > +Description:
> > > > +             Each voltage conversion time in uS
> > >
> > > Please move this entry to sysfs-bus-iio
> > >
> > > It's a natural extension of existing standard ABI so doesn't need to =
be in
> > > a driver specific documentation file.
> > >
> > > However, way back in patch 1 I gave feedback on why we don't normally=
 use integration time
> > > for voltage channels and I thought you were changing this...
> > >
> > I didn't intend to change this. Just cannot find any suitable
> > attribute for this feature.
> > From the IC interrnal, there's only one set of ADC.
> > And the conversion order is bus/shunt......, average sample count to
> > control the sample update interval.
> > That' why the sample frequency is calculated by one second to divide
> > [(bus_ct + shunt_ct) *  average sample bit] (us)
> >
> > If it's not suitable for this attribute, I think it's better to change
> > it as file attribute, not IIO channel attribute.
> >
> > How do you think?
>
> As mentioned in patch 1 discussion, we've done this before (IIRC) by defi=
ning per channel
> sampling frequencies and not providing a general one.
>
> We might want to consider improving the documentation in ABI/testing/sysf=
s-bus-iio
> to make that clear however.
>
> > > ...
> > >
> > > > +static int rtq6056_adc_read_channel(struct rtq6056_priv *priv,
> > > > +                                 struct iio_chan_spec const *ch,
> > > > +                                 int *val)
> > > > +{
> > > > +     struct device *dev =3D priv->dev;
> > > > +     unsigned int addr =3D ch->address;
> > > > +     unsigned int regval;
> > > > +     int ret;
> > > > +
> > > > +     pm_runtime_get_sync(dev);
> > > > +     ret =3D regmap_read(priv->regmap, addr, &regval);
> > > > +     pm_runtime_mark_last_busy(dev);
> > > > +     pm_runtime_put(dev);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     /* Power and VBUS is unsigned 16-bit, others are signed 16-bi=
t */
> > > > +     if (addr =3D=3D RTQ6056_REG_BUSVOLT || addr =3D=3D RTQ6056_RE=
G_POWER)
> > > > +             *val =3D regval;
> > > > +     else
> > > > +             *val =3D sign_extend32(regval, 16);
> > > > +
> > >
> > > One blank line only.
> > >
> > > > +
> > > > +     return IIO_VAL_INT;
> > > > +}
> > > > +
> > > ...
> > >
> > >
> > > > +
> > > > +static int rtq6056_adc_write_raw(struct iio_dev *indio_dev,
> > > > +                              struct iio_chan_spec const *chan, in=
t val,
> > > > +                              int val2, long mask)
> > > > +{
> > > > +     struct rtq6056_priv *priv =3D iio_priv(indio_dev);
> > > > +
> > > > +     if (iio_buffer_enabled(indio_dev))
> > >
> > > This is racy as can enter buffered mode immediately after this check.
> > > Use iio_device_claim_direct_mode() to avoid any races around this.
> > >
> > for the shunt resistor attribute write, also?
> > > > +             return -EBUSY;
> > > > +
> > > > +     switch (mask) {
> > > > +     case IIO_CHAN_INFO_INT_TIME:
> > > > +             return rtq6056_adc_set_conv_time(priv, chan, val);
> > > > +     case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> > > > +             return rtq6056_adc_set_average(priv, val);
> > > > +     default:
> > > > +             return -EINVAL;
> > > > +     }
> > > > +}
> > >
> > >
> > > > +
> > > > +static void rtq6056_remove(void *dev)
> > > > +{
> > > > +     pm_runtime_dont_use_autosuspend(dev);
> > > > +     pm_runtime_disable(dev);
> > > > +     pm_runtime_set_suspended(dev);
> > >
> > > There isn't anything here to push the device into a suspend state, so=
 why
> > > does calling pm_runtime_set_suspended() make sense?
> > >
> > As I know, It is needed, at least 'pm_runtime_set_suspended' must be ke=
pt.
> >
> > To think one case, adc is reading, module is removing.
> > Who  will change the IC state to off?
>
> That's not what set_suspended does.  We aren't telling the device to
> 'suspend' we are telling the runtime pm code that it already is.
> If you want that to be the case, then you need to manually call whatever =
your
> driver needs to do to suspend the device.
>
> Note that if runtime pm is not configured into the kernel, everything sho=
uld
> still work. That is you should always power the device up in probe() and =
down
> in remove().  That powerdown is needs to not use the runtime pm paths (as=
 they
> aren't being built in such a kernel!)
>
> >
> > pm_runtime is already disabled, the IC will be kept in 'active', right?
> > > > +}
> > > > +
> > > >
> > > > +
> > > > +static int rtq6056_probe(struct i2c_client *i2c)
> > > > +{
> > > > +     struct iio_dev *indio_dev;
> > > > +     struct rtq6056_priv *priv;
> > > > +     struct device *dev =3D &i2c->dev;
> > > > +     struct regmap *regmap;
> > > > +     unsigned int vendor_id, shunt_resistor_uohm;
> > > > +     int ret;
> > > > +
> > > > +     if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_SMBUS_WOR=
D_DATA))
> > > > +             return -EOPNOTSUPP;
> > > > +
> > > > +     indio_dev =3D devm_iio_device_alloc(dev, sizeof(*priv));
> > > > +     if (!indio_dev)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     priv =3D iio_priv(indio_dev);
> > > > +     priv->dev =3D dev;
> > > > +     priv->vshuntct_us =3D priv->vbusct_us =3D 1037;
> > > > +     priv->avg_sample =3D 1;
> > > > +     i2c_set_clientdata(i2c, priv);
> > > > +
> > > > +     regmap =3D devm_regmap_init_i2c(i2c, &rtq6056_regmap_config);
> > > > +     if (IS_ERR(regmap))
> > > > +             return dev_err_probe(dev, PTR_ERR(regmap),
> > > > +                                  "Failed to init regmap\n");
> > > > +
> > > > +     priv->regmap =3D regmap;
> > > > +
> > > > +     ret =3D regmap_read(regmap, RTQ6056_REG_MANUFACTID, &vendor_i=
d);
> > > > +     if (ret)
> > > > +             return dev_err_probe(dev, ret,
> > > > +                                  "Failed to get manufacturer info=
\n");
> > > > +
> > > > +     if (vendor_id !=3D RTQ6056_VENDOR_ID)
> > > > +             return dev_err_probe(dev, -ENODEV,
> > > > +                                  "Invalid vendor id 0x%04x\n", ve=
ndor_id);
> > > > +
> > > > +     ret =3D devm_regmap_field_bulk_alloc(dev, regmap, priv->rm_fi=
elds,
> > > > +                                        rtq6056_reg_fields, F_MAX_=
FIELDS);
> > > > +     if (ret)
> > > > +             return dev_err_probe(dev, ret, "Failed to init regmap=
 field\n");
> > > > +
> > > > +     /*
> > > > +      * By default, configure average sample as 1, bus and shunt c=
onversion
> > > > +      * timea as 1037 microsecond, and operating mode to all on.
> > > > +      */
> > > > +     ret =3D regmap_write(regmap, RTQ6056_REG_CONFIG, RTQ6056_DEFA=
ULT_CONFIG);
> > > > +     if (ret)
> > > > +             return dev_err_probe(dev, ret,
> > > > +                                  "Failed to enable continuous sen=
sing\n");
> > > > +
> > > > +     pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
> > > > +     pm_runtime_use_autosuspend(dev);
> > > > +     pm_runtime_set_active(dev);
> > > > +     pm_runtime_mark_last_busy(dev);
> > > > +     pm_runtime_enable(dev);
> > >
> > > Look at whether you can use devm_pm_runtime_enable()
> > > Note it handles disabling autosuspend for you.
> > >
> > > When using runtime_pm() you want to ensure that the device works with=
out
> > > runtime pm support being enabled.  As such, you turn the device on be=
fore
> > > enabling runtime_pm() and (this is missing I think) turn it off after=
 disabling
> > > runtime pm.  So I'd expect a devm_add_action_or_reset() call to unwin=
d
> > > setting the device into continuous sending above.
> > >
> > If so, I think it's better to configure the device keep in off state
> > in probe stage.
>
> Only keep it in off state 'if' runtime pm is configured in.
> Normally you need to power the device up in probe then
> enable runtime pm to turn it off again (if runtime pm is supported).
> If runtime pm isn't supported, we just leave the device powered up the wh=
ole
> time until remove() when we power it down.
>
> > The calling order may need to be changed as below
> > devm_add_action_or_reset...
> >
> > pm_runtime_set_autosuspend_delay
> > pm_runtime_use_auto_suspend
> > devm_pm_runtime_enable
>
>
>
> >
> > > > +
> > > > +     ret =3D devm_add_action_or_reset(dev, rtq6056_remove, dev);
> > >
> > > The callback naming is too generic. It should give some indication
> > > of what it is undoing (much of probe is handled by other devm_ callba=
cks).
> > >
> > How about to change the name to 'rtq6056_enter_shutdown_state'?
> > And in this function, to change the device state in shutdown with
> > 'pm_runtime_set_suspended' API.
>
> I think this reflects back to earlier misunderstanding of what
> pm_runtime_set_suspended() actually does (assuming I have understood it
> correctly).
>
Ok, I really misunderstand it.
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     /* By default, use 2000 micro-ohm resistor */
> > > > +     shunt_resistor_uohm =3D 2000;
> > > > +     device_property_read_u32(dev, "shunt-resistor-micro-ohms",
> > > > +                              &shunt_resistor_uohm);
> > > > +
> > > > +     ret =3D rtq6056_set_shunt_resistor(priv, shunt_resistor_uohm)=
;
> > > > +     if (ret)
> > > > +             return dev_err_probe(dev, ret,
> > > > +                                  "Failed to init shunt resistor\n=
");
> > > > +
> > > > +     indio_dev->name =3D "rtq6056";
> > > > +     indio_dev->modes =3D INDIO_DIRECT_MODE;
> > > > +     indio_dev->channels =3D rtq6056_channels;
> > > > +     indio_dev->num_channels =3D ARRAY_SIZE(rtq6056_channels);
> > > > +     indio_dev->info =3D &rtq6056_info;
> > > > +
> > > > +     ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> > > > +                                           rtq6056_buffer_trigger_=
handler,
> > > > +                                           NULL);
> > > > +     if (ret)
> > > > +             return dev_err_probe(dev, ret,
> > > > +                                  "Failed to allocate iio trigger =
buffer\n");
> > > > +
> > > > +     return devm_iio_device_register(dev, indio_dev);
> > > > +}
> > >
> > > > +
> > > > +static const struct dev_pm_ops rtq6056_pm_ops =3D {
> > > > +     RUNTIME_PM_OPS(rtq6056_runtime_suspend, rtq6056_runtime_resum=
e, NULL)
> > >
> > > Is there any reason we can't use these same ops to achieve at least s=
ome power
> > > saving in suspend?  i.e. use DEFINE_RUNTIME_PM_OPS()
> >                                                  ~~~~~~~~~~~~~~~~~~~~~~=
~
> >                                                  Where can I find this?
>
> oops. DEFINE_RUNTIME_DEV_PM_OPS()
> https://elixir.bootlin.com/linux/v5.19-rc6/source/include/linux/pm_runtim=
e.h#L37
>

OK, it's really new API. That's why I cannot find it.
Due to there's no reply in several days, so I already submit the v6 as
my understanding.

The last is to use 'DEFINE_RUNTIME_DEV_PM_OPS'.
I think it's better than just to declare 'runtime_enable' and 'runtime_disa=
ble'.
This API also consider system suspend and resume.

Will be added in v7.
> > >
> > > I have tidying this up in existing drivers on my todo list as I think=
 it is almost
> > > always a good idea.  Note this is why there isn't a define to create =
the
> > > particular combination you have here.
> > >
> > If there's no combination like as that one, why  not unify it  to
> > '_DEFINE_DEV_PM_OPS'?
> > > > +};
> > > > +
> > >
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353BC56D34B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 05:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiGKDQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 23:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGKDQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 23:16:44 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D0B13D6D;
        Sun, 10 Jul 2022 20:16:43 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id n10so5319092wrc.4;
        Sun, 10 Jul 2022 20:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HYTMIfKM+jYxy/yfsx8ohCUFBzVsY8fjeqYRwoAb3oc=;
        b=GFMAqroz56tlp/zqkkXIpKI0EK2yXt0rqV65CRPkNAjiLL/hgpG0Ul7alyI8bxCftK
         39vGe5b0Xolw8FTniy+GPJZMYygvAb0Bk27/LsXYtm2fi8daDxTwtGefWnA3tcEjUcSF
         9KBUX+92IzafGuUCfA+hGLGuJHRCV/c8tykd0CDOZghCLtqhN2RN8VloQ/IVifnrnJzx
         z5ixOqoVm81Ol3C8Dg5apdRSf87KyJsO02FweUgve9JqqQ8wGrv2aLxJCd9BzW4HhnUk
         gPiFfUAoKj45moX20UIkTQmjekElJ3yQxsHIbTJ6fHgh8bH2hPQ/N5ZbhVf1TGqv4F9z
         4oJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HYTMIfKM+jYxy/yfsx8ohCUFBzVsY8fjeqYRwoAb3oc=;
        b=N0rnpKamnpIySlwVHdVX+3b4y+Pv5Gu08aIQ9jF65rk6gLD6YFtp1K6n9zGRL2vOhY
         XUgYccEeqFfrFqUNlRsX3uG2XkSZjiypO9LyRWwrL9b2VAgjuP22KR2rWlkzYzXNjira
         Filx7h+lO4y3pSQGcg3SwPbRFXHNZznmPQkNK4AbeNpusFutpKLz970VKo4CAlIKXzPE
         Ln5N8MA9YzxmigMhJ8/u6QKA6gKQ+PegSWVhGqGYt/m0xQuJA35Z+eYXbj0tTawQ7N37
         R23K8awzFVJrtHZRF6KgS1NsGME+l+0/Xx8oxU8+rFLuKf/Y3pypVD87sz2mZMWNknMu
         7hbQ==
X-Gm-Message-State: AJIora+0aabuXhtYCzmfbzuhs1v84N0qm3rrEKjiBcRqAhDGFN8vdMse
        ANh/JFHth+pz7QUVz5pJXbElk8cZ0iG/hZONqjI=
X-Google-Smtp-Source: AGRyM1ubF0pdtPX1INpNnnD8+dXiyPBgnXh7uBW3xkx0za5Wq9zIIGFXFqnx3ySOQCHEzASupZuao7nKbjJdaUnS00Y=
X-Received: by 2002:a05:6000:15c1:b0:21b:ad5e:2798 with SMTP id
 y1-20020a05600015c100b0021bad5e2798mr14659538wry.237.1657509401404; Sun, 10
 Jul 2022 20:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <1657116702-24161-1-git-send-email-u0084500@gmail.com>
 <1657116702-24161-3-git-send-email-u0084500@gmail.com> <20220707183027.342f6c88@jic23-huawei>
 <CADiBU3_KQ=WvD-1E4SODkdEY254_b-covw-0SHcAaF3XQqdbaQ@mail.gmail.com>
In-Reply-To: <CADiBU3_KQ=WvD-1E4SODkdEY254_b-covw-0SHcAaF3XQqdbaQ@mail.gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Mon, 11 Jul 2022 11:16:29 +0800
Message-ID: <CADiBU39KYyd9=JK5wLRN1yKn9hxRHVSOATkWrPMpAdTJY04ZxQ@mail.gmail.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ChiYuan Huang <u0084500@gmail.com> =E6=96=BC 2022=E5=B9=B47=E6=9C=8811=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8810:48=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Jonathan Cameron <jic23@kernel.org> =E6=96=BC 2022=E5=B9=B47=E6=9C=888=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E5=87=8C=E6=99=A81:20=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > On Wed,  6 Jul 2022 22:11:42 +0800
> > cy_huang <u0084500@gmail.com> wrote:
> >
> > > From: ChiYuan Huang <cy_huang@richtek.com>
> > >
> > > Add Richtek rtq6056 supporting.
> > >
> > > It can be used for the system to monitor load current and power with =
16-bit
> > > resolution.
> > >
> > > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> >
> > Various feedback inline.
> >
> > Thanks,
> >
> > Jonathan
> >
> > > ---
> > > Since v5
> > > - Fix kernel version text for ABI.
> > >
> > > Since v4
> > > - Add '__aligned(8)' for timestamp member in buffer_trigger_handler f=
unction.
> > > - Declare timestamp from 'int64_t' to more unified 's64'.
> > >
> > > Since v3
> > > - Refine pm_runtime API calling order in 'read_channel' API.
> > > - Fix vshunt wrong scale for divider.
> > > - Refine the comment text.
> > > - Use 'devm_add_action_or_reset' to decrease the code usage in probe
> > >   function.
> > > - Use RUNTIME_PM_OPS to replace SET_RUNTIME_PM_OPS.
> > > - minor fix for the comma.
> > > - Use pm_ptr to replace the direct assigned pm_ops.
> > >
> > > Since v2
> > > - Rename file from 'rtq6056-adc' to 'rtq6056'.
> > > - Refine the ABI, if generic already defined it, remove it and check =
the channel
> > >   report unit.
> > > - Add copyright text.
> > > - include the correct header.
> > > - change the property parsing name.
> > > - To use iio_chan_spec address field.
> > > - Refine each channel separate and shared_by_all.
> > > - Use pm_runtime and pm_runtime_autosuspend.
> > > - Remove the shutdown callback. From the HW suggestion, it's not reco=
mmended to
> > >   use battery as the power supply.
> > > - Check all scale unit (voltage->mV, current->mA, power->milliWatt).
> > > - Use the read_avail to provide the interface for attribute value lis=
t.
> > > - Add comma for the last element in the const integer array.
> > > - Refine each ADC label text.
> > > - In read_label callback, replace snprintf to sysfs_emit.
> > >
> > > ---
> > >  .../ABI/testing/sysfs-bus-iio-adc-rtq6056          |   6 +
> > >  drivers/iio/adc/Kconfig                            |  15 +
> > >  drivers/iio/adc/Makefile                           |   1 +
> > >  drivers/iio/adc/rtq6056.c                          | 651 +++++++++++=
++++++++++
> > >  4 files changed, 673 insertions(+)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-rtq60=
56
> > >  create mode 100644 drivers/iio/adc/rtq6056.c
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-rtq6056 b/Do=
cumentation/ABI/testing/sysfs-bus-iio-adc-rtq6056
> > > new file mode 100644
> > > index 00000000..e89d15b
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-rtq6056
> > > @@ -0,0 +1,6 @@
> > > +What:                /sys/bus/iio/devices/iio:deviceX/in_voltage0_in=
tegration_time
> > > +What:                /sys/bus/iio/devices/iio:deviceX/in_voltage1_in=
tegration_time
> > > +KernelVersion:       5.20
> > > +Contact:     cy_huang@richtek.com
> > > +Description:
> > > +             Each voltage conversion time in uS
> >
> > Please move this entry to sysfs-bus-iio
> >
> > It's a natural extension of existing standard ABI so doesn't need to be=
 in
> > a driver specific documentation file.
> >
> > However, way back in patch 1 I gave feedback on why we don't normally u=
se integration time
> > for voltage channels and I thought you were changing this...
> >
> I didn't intend to change this. Just cannot find any suitable
> attribute for this feature.
> From the IC interrnal, there's only one set of ADC.
> And the conversion order is bus/shunt......, average sample count to
> control the sample update interval.
> That' why the sample frequency is calculated by one second to divide
> [(bus_ct + shunt_ct) *  average sample bit] (us)
>
> If it's not suitable for this attribute, I think it's better to change
> it as file attribute, not IIO channel attribute.
>
> How do you think?
> > ...
> >
> > > +static int rtq6056_adc_read_channel(struct rtq6056_priv *priv,
> > > +                                 struct iio_chan_spec const *ch,
> > > +                                 int *val)
> > > +{
> > > +     struct device *dev =3D priv->dev;
> > > +     unsigned int addr =3D ch->address;
> > > +     unsigned int regval;
> > > +     int ret;
> > > +
> > > +     pm_runtime_get_sync(dev);
> > > +     ret =3D regmap_read(priv->regmap, addr, &regval);
> > > +     pm_runtime_mark_last_busy(dev);
> > > +     pm_runtime_put(dev);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     /* Power and VBUS is unsigned 16-bit, others are signed 16-bit =
*/
> > > +     if (addr =3D=3D RTQ6056_REG_BUSVOLT || addr =3D=3D RTQ6056_REG_=
POWER)
> > > +             *val =3D regval;
> > > +     else
> > > +             *val =3D sign_extend32(regval, 16);
> > > +
> >
> > One blank line only.
> >
> > > +
> > > +     return IIO_VAL_INT;
> > > +}
> > > +
> > ...
> >
> >
> > > +
> > > +static int rtq6056_adc_write_raw(struct iio_dev *indio_dev,
> > > +                              struct iio_chan_spec const *chan, int =
val,
> > > +                              int val2, long mask)
> > > +{
> > > +     struct rtq6056_priv *priv =3D iio_priv(indio_dev);
> > > +
> > > +     if (iio_buffer_enabled(indio_dev))
> >
> > This is racy as can enter buffered mode immediately after this check.
> > Use iio_device_claim_direct_mode() to avoid any races around this.
> >
> for the shunt resistor attribute write, also?
> > > +             return -EBUSY;
> > > +
> > > +     switch (mask) {
> > > +     case IIO_CHAN_INFO_INT_TIME:
> > > +             return rtq6056_adc_set_conv_time(priv, chan, val);
> > > +     case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> > > +             return rtq6056_adc_set_average(priv, val);
> > > +     default:
> > > +             return -EINVAL;
> > > +     }
> > > +}
> >
> >
> > > +
> > > +static void rtq6056_remove(void *dev)
> > > +{
> > > +     pm_runtime_dont_use_autosuspend(dev);
> > > +     pm_runtime_disable(dev);
> > > +     pm_runtime_set_suspended(dev);
> >
> > There isn't anything here to push the device into a suspend state, so w=
hy
> > does calling pm_runtime_set_suspended() make sense?
> >
> As I know, It is needed, at least 'pm_runtime_set_suspended' must be kept=
.
>
> To think one case, adc is reading, module is removing.
> Who  will change the IC state to off?
>
> pm_runtime is already disabled, the IC will be kept in 'active', right?
> > > +}
> > > +
> > >
> > > +
> > > +static int rtq6056_probe(struct i2c_client *i2c)
> > > +{
> > > +     struct iio_dev *indio_dev;
> > > +     struct rtq6056_priv *priv;
> > > +     struct device *dev =3D &i2c->dev;
> > > +     struct regmap *regmap;
> > > +     unsigned int vendor_id, shunt_resistor_uohm;
> > > +     int ret;
> > > +
> > > +     if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_SMBUS_WORD_=
DATA))
> > > +             return -EOPNOTSUPP;
> > > +
> > > +     indio_dev =3D devm_iio_device_alloc(dev, sizeof(*priv));
> > > +     if (!indio_dev)
> > > +             return -ENOMEM;
> > > +
> > > +     priv =3D iio_priv(indio_dev);
> > > +     priv->dev =3D dev;
> > > +     priv->vshuntct_us =3D priv->vbusct_us =3D 1037;
> > > +     priv->avg_sample =3D 1;
> > > +     i2c_set_clientdata(i2c, priv);
> > > +
> > > +     regmap =3D devm_regmap_init_i2c(i2c, &rtq6056_regmap_config);
> > > +     if (IS_ERR(regmap))
> > > +             return dev_err_probe(dev, PTR_ERR(regmap),
> > > +                                  "Failed to init regmap\n");
> > > +
> > > +     priv->regmap =3D regmap;
> > > +
> > > +     ret =3D regmap_read(regmap, RTQ6056_REG_MANUFACTID, &vendor_id)=
;
> > > +     if (ret)
> > > +             return dev_err_probe(dev, ret,
> > > +                                  "Failed to get manufacturer info\n=
");
> > > +
> > > +     if (vendor_id !=3D RTQ6056_VENDOR_ID)
> > > +             return dev_err_probe(dev, -ENODEV,
> > > +                                  "Invalid vendor id 0x%04x\n", vend=
or_id);
> > > +
> > > +     ret =3D devm_regmap_field_bulk_alloc(dev, regmap, priv->rm_fiel=
ds,
> > > +                                        rtq6056_reg_fields, F_MAX_FI=
ELDS);
> > > +     if (ret)
> > > +             return dev_err_probe(dev, ret, "Failed to init regmap f=
ield\n");
> > > +
> > > +     /*
> > > +      * By default, configure average sample as 1, bus and shunt con=
version
> > > +      * timea as 1037 microsecond, and operating mode to all on.
> > > +      */
> > > +     ret =3D regmap_write(regmap, RTQ6056_REG_CONFIG, RTQ6056_DEFAUL=
T_CONFIG);
> > > +     if (ret)
> > > +             return dev_err_probe(dev, ret,
> > > +                                  "Failed to enable continuous sensi=
ng\n");
> > > +
> > > +     pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
> > > +     pm_runtime_use_autosuspend(dev);
> > > +     pm_runtime_set_active(dev);
> > > +     pm_runtime_mark_last_busy(dev);
> > > +     pm_runtime_enable(dev);
> >
> > Look at whether you can use devm_pm_runtime_enable()
> > Note it handles disabling autosuspend for you.
> >
> > When using runtime_pm() you want to ensure that the device works withou=
t
> > runtime pm support being enabled.  As such, you turn the device on befo=
re
> > enabling runtime_pm() and (this is missing I think) turn it off after d=
isabling
> > runtime pm.  So I'd expect a devm_add_action_or_reset() call to unwind
> > setting the device into continuous sending above.
> >
> If so, I think it's better to configure the device keep in off state
> in probe stage.
> The calling order may need to be changed as below
> devm_add_action_or_reset...
>
> pm_runtime_set_autosuspend_delay
> pm_runtime_use_auto_suspend
> devm_pm_runtime_enable
>
Ah, not correct. How about if 'PM_RUNTIME' is not enabled?
Do we need to consider about this case?

If yes, the original flow about 'pm_runtime' is correct.
> > > +
> > > +     ret =3D devm_add_action_or_reset(dev, rtq6056_remove, dev);
> >
> > The callback naming is too generic. It should give some indication
> > of what it is undoing (much of probe is handled by other devm_ callback=
s).
> >
> How about to change the name to 'rtq6056_enter_shutdown_state'?
> And in this function, to change the device state in shutdown with
> 'pm_runtime_set_suspended' API.
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     /* By default, use 2000 micro-ohm resistor */
> > > +     shunt_resistor_uohm =3D 2000;
> > > +     device_property_read_u32(dev, "shunt-resistor-micro-ohms",
> > > +                              &shunt_resistor_uohm);
> > > +
> > > +     ret =3D rtq6056_set_shunt_resistor(priv, shunt_resistor_uohm);
> > > +     if (ret)
> > > +             return dev_err_probe(dev, ret,
> > > +                                  "Failed to init shunt resistor\n")=
;
> > > +
> > > +     indio_dev->name =3D "rtq6056";
> > > +     indio_dev->modes =3D INDIO_DIRECT_MODE;
> > > +     indio_dev->channels =3D rtq6056_channels;
> > > +     indio_dev->num_channels =3D ARRAY_SIZE(rtq6056_channels);
> > > +     indio_dev->info =3D &rtq6056_info;
> > > +
> > > +     ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> > > +                                           rtq6056_buffer_trigger_ha=
ndler,
> > > +                                           NULL);
> > > +     if (ret)
> > > +             return dev_err_probe(dev, ret,
> > > +                                  "Failed to allocate iio trigger bu=
ffer\n");
> > > +
> > > +     return devm_iio_device_register(dev, indio_dev);
> > > +}
> >
> > > +
> > > +static const struct dev_pm_ops rtq6056_pm_ops =3D {
> > > +     RUNTIME_PM_OPS(rtq6056_runtime_suspend, rtq6056_runtime_resume,=
 NULL)
> >
> > Is there any reason we can't use these same ops to achieve at least som=
e power
> > saving in suspend?  i.e. use DEFINE_RUNTIME_PM_OPS()
>                                                  ~~~~~~~~~~~~~~~~~~~~~~~
>                                                  Where can I find this?
> >
> > I have tidying this up in existing drivers on my todo list as I think i=
t is almost
> > always a good idea.  Note this is why there isn't a define to create th=
e
> > particular combination you have here.
> >
> If there's no combination like as that one, why  not unify it  to
> '_DEFINE_DEV_PM_OPS'?
> > > +};
> > > +
> >

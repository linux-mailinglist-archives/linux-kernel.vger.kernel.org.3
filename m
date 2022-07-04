Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A40564EA7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 09:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbiGDH1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 03:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbiGDH1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 03:27:23 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CD865EB;
        Mon,  4 Jul 2022 00:27:22 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id s1so12093113wra.9;
        Mon, 04 Jul 2022 00:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eufznycu8qz9mid4422fOXmb7eJFPTwG4eAHQOWHEKM=;
        b=qstJgBWJL0hMR8SMOsAqOP/R259X3QpULmOpXAl/x+DCipGAoJ4V2absIn1ignbPsu
         VEywpwdTu3ycQICvmAVozPJhp1iqjsPNfLR/3uHyQK95fKYFJMzC/Nd3mgEI/+XCt5k5
         7GRf0LxqN9ycxW4ePa0NR/Kmbe+GrEBYOMYw7gojtmjxlElw2iOKW4/tM6tZRoiQrnJp
         3LIFZTFUc4bQGKHdeuLmoiJf32eJmSrhrSC/3gPh6wi7skx8xdu3ZSbUn8I5LRPzQDBo
         N7MDAAySc98iWCSw3HkSnRkzESSVlDeoAThPrOl4EUUxeXjwNU86rwNTS/aCNdaZYruJ
         3fSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eufznycu8qz9mid4422fOXmb7eJFPTwG4eAHQOWHEKM=;
        b=hmby57U2HGqk8rW0kJKTcDkOPqUB4VcJ19VHUlc33tOLApXfE7Rhs0MR8aOj6d96il
         tMqCNe/7H9oK7ioum895wVkgtEZImDNw/rqqT5yMGzojifT2CuEeMnC5Ps3nOLkH7sMw
         HJfgJ57NVD1vrOQuTCgBNj1WGevjomKGgJoH5anURAUs3bxIiu/yuz8SQq/Qp5lGESJ3
         JgH5Zqywq31QnMgdX5a3VXqK1Yt1F8Du7HKarQiTHKlGLLPvsMwa5Ff5s6QI8r63mfrD
         mkYqhxLC9Ux8nInn/4n2Hia/lIExhekahbpTXyC3vCg7Gvtvn1jusFcyo27hamLAfsUb
         Qsow==
X-Gm-Message-State: AJIora/Ay+cwia/oqWR98JDTbmf+ESU1LBE+lSFgv0xFiaheHck4oE1Q
        Kiikm9Fmqj9hTLO9UoMbH3EZ/AYAlWOvKIeEY9o=
X-Google-Smtp-Source: AGRyM1vAZBIjc2c/aeh+lgagq97ZFho/i1I9roIQ2JpvHP+x2keOtxcuZ2myAqMwkrbmGVd+ALaoXCnC7LBe29CWNls=
X-Received: by 2002:a05:6000:798:b0:21b:8ca1:9b52 with SMTP id
 bu24-20020a056000079800b0021b8ca19b52mr25985379wrb.374.1656919641003; Mon, 04
 Jul 2022 00:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <1656469212-12717-1-git-send-email-u0084500@gmail.com>
 <1656469212-12717-3-git-send-email-u0084500@gmail.com> <CAHp75Vd2bxFA5PmjEtgAjJfCf9YZENq_fb9b2VHmMmmHdqGJSw@mail.gmail.com>
 <CADiBU384ZwKL_+i1zRL9qfVt-NLo=pnf8zrGna4Sxt+toYZdWg@mail.gmail.com>
In-Reply-To: <CADiBU384ZwKL_+i1zRL9qfVt-NLo=pnf8zrGna4Sxt+toYZdWg@mail.gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Mon, 4 Jul 2022 15:27:09 +0800
Message-ID: <CADiBU3_sU8bj29x2Qs9y9fM2YDYcKvNBkBuzfpzuCkAjSeTu+Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: Add rtq6056 support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        cy_huang <cy_huang@richtek.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
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

ChiYuan Huang <u0084500@gmail.com> =E6=96=BC 2022=E5=B9=B47=E6=9C=884=E6=97=
=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8811:16=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2022=E5=B9=B47=E6=
=9C=881=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=886:05=E5=AF=AB=E9=81=
=93=EF=BC=9A
> >
> > On Wed, Jun 29, 2022 at 4:23 AM cy_huang <u0084500@gmail.com> wrote:
> >
> > > Add Richtek rtq6056 supporting.
> > >
> > > It can be used for the system to monitor load current and power with =
16-bit
> > > resolution.
> >
> > ...
> >
> > > +static int rtq6056_adc_read_channel(struct rtq6056_priv *priv,
> > > +                                   struct iio_chan_spec const *ch,
> > > +                                   int *val)
> > > +{
> > > +       struct device *dev =3D priv->dev;
> > > +       unsigned int addr =3D ch->address;
> > > +       unsigned int regval;
> > > +       int ret;
> > > +
> > > +       pm_runtime_get_sync(dev);
> > > +
> > > +       ret =3D regmap_read(priv->regmap, addr, &regval);
> > > +       if (ret) {
> > > +               pm_runtime_put(dev);
> > > +               return ret;
> > > +       }
> >
> > You can optimize this to
> >
> >        pm_runtime_get_sync(dev);
> >        ret =3D regmap_read(priv->regmap, addr, &regval);
> >        pm_runtime_mark_last_busy(dev);
> >        pm_runtime_put(dev);
> >        if (ret)
> >            return ret;
> >
> > > +       /* Power and VBUS is unsigned 16-bit, others are signed 16-bi=
t */
> > > +       if (addr =3D=3D RTQ6056_REG_BUSVOLT || addr =3D=3D RTQ6056_RE=
G_POWER)
> > > +               *val =3D regval;
> > > +       else
> > > +               *val =3D sign_extend32(regval, 16);
> >
> > > +       pm_runtime_mark_last_busy(dev);
> > > +       pm_runtime_put(dev);
> >
> > ...and get rid of these.
> >
> > > +       return IIO_VAL_INT;
> > > +}
> >
> > ...
> >
> > > +               *val2 =3D 1000000000;
> >
> > NANO ?
> >
> Yes, unit is 2.5 microvolt. I have all listed all unit comments in the
> source code.a
Sorry, I found this scale is wrong.
For voltage channel, standard binding uses millivolt as the reported value.
From this case, It must be (val * 2500) /1000000
So the '*val2' must equal to 1000000
> > ...
> >
> > > +               *val2 =3D 1000;
> >
> > MILLI ?
> >
> Yes.
As the above one. Must be millivolt as the unit.
Channel unit is 2.5mV.
This value is correct and equal to (val * 2500) / 1000
> > > +       *val =3D DIV_ROUND_UP(1000000, sample_time);
> >
> > USEC_PER_SEC ?
> >
> No, sample time is (vshunt convesion time + vbus conversion time) *
> average sample.
> And the sample freq returns the unit by HZ (sample frequency per second)
>
The 'sample time' is unit by micro-second like as you mentioned.
> > > +
> > > +       return IIO_VAL_INT;
> > > +}
> >
> > ...
> >
> > > +static int rtq6056_adc_read_label(struct iio_dev *indio_dev,
> > > +                                 struct iio_chan_spec const *chan,
> > > +                                 char *label)
> > > +{
> > > +       return sysfs_emit(label, "%s\n", rtq6056_channel_labels[chan-=
>channel]);
> > > +}
> >
> > ...
> >
> > > +       /* calibration =3D 5120000 / (Rshunt (uohm) * current lsb (1m=
A)) */
> >
> > uOhm
> >
> > ...
> >
> > > +static ssize_t shunt_resistor_show(struct device *dev,
> > > +                                  struct device_attribute *attr, cha=
r *buf)
> > > +{
> > > +       struct rtq6056_priv *priv =3D iio_priv(dev_to_iio_dev(dev));
> > > +       int vals[2] =3D { priv->shunt_resistor_uohm, 1000000 };
> >
> > MICRO ?
> >
> Yes, for this kind of sense resistor, it will choose 2 milli-Ohm, 1
> milli-Ohms,, 0.5 milli-Ohms, or less.
> > > +       return iio_format_value(buf, IIO_VAL_FRACTIONAL, 1, vals);
> > > +}
> >
> > ...
> >
> > > +       ret =3D rtq6056_set_shunt_resistor(priv, val * 1000000 + val_=
fract);
> >
> > MICRO ?
> >
> Yes
> > > +       if (ret)
> > > +               return ret;
> >
> > ...
> >
> > > +       struct {
> > > +               u16 vals[RTQ6056_MAX_CHANNEL];
> > > +               int64_t timestamp;
> > > +       } data __aligned(8);
> >
> > Hmm... alignment of this struct will be at least 4 bytes, but
> > shouldn't we rather be sure that the timestamp member is aligned
> > properly? Otherwise this seems fragile and dependent on
> > RTQ6056_MAX_CHANNEL % 4 =3D=3D 0.
> >
> Yap, from the 'max channel', it already guarantee this struct will be
> aligned at lease 4.
> Actually, It can be removed.
> > ...
> >
> > > +       pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
> > > +       pm_runtime_use_autosuspend(dev);
> > > +       pm_runtime_set_active(dev);
> > > +       pm_runtime_mark_last_busy(dev);
> > > +       pm_runtime_enable(dev);
> > > +
> > > +       /* By default, use 2000 micro-ohm resistor */
> > > +       shunt_resistor_uohm =3D 2000;
> > > +       device_property_read_u32(dev, "shunt-resistor-micro-ohms",
> > > +                                &shunt_resistor_uohm);
> > > +
> > > +       ret =3D rtq6056_set_shunt_resistor(priv, shunt_resistor_uohm)=
;
> > > +       if (ret) {
> > > +               dev_err(dev, "Failed to init shunt resistor\n");
> > > +               goto err_probe;
> >
> > return dev_err_probe();
> >
> > (see below how)
> >
> > > +       }
> > > +
> > > +       indio_dev->name =3D "rtq6056";
> > > +       indio_dev->modes =3D INDIO_DIRECT_MODE;
> > > +       indio_dev->channels =3D rtq6056_channels;
> > > +       indio_dev->num_channels =3D ARRAY_SIZE(rtq6056_channels);
> > > +       indio_dev->info =3D &rtq6056_info;
> > > +
> > > +       ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> > > +                                             rtq6056_buffer_trigger_=
handler,
> > > +                                             NULL);
> > > +       if (ret) {
> > > +               dev_err(dev, "Failed to allocate iio trigger buffer\n=
");
> >
> > Ditto.
> >
> > > +               goto err_probe;
> >
> > It is a sign of wrong ordering, either do not use devm_ calls after
> > non-devm_ or make the latter wrapped into devm_add_action_or_reset().
> > See below for additional information.
> >
> I think the another way is to register all using devm_ and to call the
> pm_runtime at the last.
> > > +       }
> > > +
> > > +       ret =3D devm_iio_device_register(dev, indio_dev);
> > > +       if (ret) {
> > > +               dev_err(dev, "Failed to allocate iio device\n");
> > > +               goto err_probe;
> > > +       }
> > > +
> > > +       return 0;
> > > +
> > > +err_probe:
> > > +       pm_runtime_dont_use_autosuspend(dev);
> > > +       pm_runtime_disable(dev);
> > > +       pm_runtime_set_suspended(dev);
> > > +
> > > +       return ret;
> >
> > ...
> >
> > > +static int rtq6056_remove(struct i2c_client *i2c)
> > > +{
> > > +       struct device *dev =3D &i2c->dev;
> >
> > Another (but usually not good option) is to call devm_..._unregister() =
here.
> >
> > > +       pm_runtime_dont_use_autosuspend(dev);
> > > +       pm_runtime_disable(dev);
> > > +       pm_runtime_set_suspended(dev);
> > > +
> > > +       return 0;
> > > +}
> >
> > ...
> >
> > > +static const struct dev_pm_ops rtq6056_pm_ops =3D {
> > > +       SET_RUNTIME_PM_OPS(rtq6056_runtime_suspend, rtq6056_runtime_r=
esume, NULL)
> >
> > RUNTIME_PM_OPS()
> >
> > > +};
> >
> > ...
> >
> > > +static const struct of_device_id rtq6056_device_match[] =3D {
> > > +       { .compatible =3D "richtek,rtq6056", },
> >
> > In this case the inner comma is not needed.
> >
> > > +       {}
> > > +};
> >
> > ...
> >
> > > +static struct i2c_driver rtq6056_driver =3D {
> > > +       .driver =3D {
> > > +               .name =3D "rtq6056",
> > > +               .of_match_table =3D rtq6056_device_match,
> >
> > > +               .pm =3D &rtq6056_pm_ops,
> >
> > pm_ptr()
> >
> > > +       },
> >
> > --
> > With Best Regards,
> > Andy Shevchenko

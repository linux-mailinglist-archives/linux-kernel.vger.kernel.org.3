Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8037577A89
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 07:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbiGRFo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 01:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbiGRFoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 01:44:20 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4DD1A9;
        Sun, 17 Jul 2022 22:44:19 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v16so15415543wrd.13;
        Sun, 17 Jul 2022 22:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WPUM0QjY/sxRNhLvinK04kERO7bObycKQncweFYJTkI=;
        b=oRBzt0FhFYqXVzXAEtQw556Tw5w86B0t4yYZKTStAMu9eCDhzx2sl9KNdD/vJ0c6o1
         ABLv7b+7D7gVjtkipmrJZJaDwLtnsL4JmQYEu9GfR2MRTsGTsu05mn8z3W5spa5Y4gH4
         HJsTbEbM1E1EIY2e5liIry5z2VzdoQgmQLeYRWCoxTcWi5QRv5ih8PjaSiXQr8Cq1YUm
         olRmc6KeUWJldSZaOtSr763eBBtG5MV/zKNOrSht0oTO4m6HYFHg9yeDcULGyoGFmtFL
         /F1GX4gDpcXQOriy5J+yciwR3P33K7erMiXHG78KaIiy7C+if+UDI0Gd+AEcAXuYrkEd
         5V5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WPUM0QjY/sxRNhLvinK04kERO7bObycKQncweFYJTkI=;
        b=vepxofrptM8gQltsdp7oGfMFvnNrVozHiIk6QJU/UY/X/7Mpi3dFW5O6zDH6yy2WoA
         n0tXK7CjokqyxIBNaia5e+zS5/xlVdDVQrNAOb6GM9LtC5D5OVWlc5ow55+t5gcX1Rpk
         4V0ezqHhCVWT0e4OdIlm7CAt6k9EgYu0pZk46UWd3Hjhf7hgvJ1UXPqMYtZtwrl/bBId
         A7LLB5hzOZ4ycCfnKsDKWlZdglAbhp7IL/upOmJdf01hbB4JAPiXbujW4J+OVNMshexA
         hI3j0NeMGzBjdjzIW3iHMVhZsjB5YXhx8MvaX6xDhGW790oGW/LcjE1TeU3vjS+bLgv8
         zXlg==
X-Gm-Message-State: AJIora+n84X2lv0HkpzmYDgrZQR1SAWlffozoeAbP2NJ1FAPZbn+F5Fi
        QMNaJYC62Sm+5cTaGeAQWD0uxqCGVkL0U9IgDgY=
X-Google-Smtp-Source: AGRyM1unQF1epCCgkSiOtHtOFcQ6HJcMMLSngoDSfaYGEHRsyFqelJ2FCdiuE6bQN8BCEukyLMeaI5HuKMD+rZq6lmU=
X-Received: by 2002:adf:f043:0:b0:21d:6a90:f3e6 with SMTP id
 t3-20020adff043000000b0021d6a90f3e6mr21496516wro.277.1658123058101; Sun, 17
 Jul 2022 22:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <1657116702-24161-1-git-send-email-u0084500@gmail.com>
 <1657116702-24161-3-git-send-email-u0084500@gmail.com> <20220707183027.342f6c88@jic23-huawei>
 <CADiBU3_KQ=WvD-1E4SODkdEY254_b-covw-0SHcAaF3XQqdbaQ@mail.gmail.com>
 <CADiBU39KYyd9=JK5wLRN1yKn9hxRHVSOATkWrPMpAdTJY04ZxQ@mail.gmail.com> <20220716183916.7b40d9d5@jic23-huawei>
In-Reply-To: <20220716183916.7b40d9d5@jic23-huawei>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Mon, 18 Jul 2022 13:44:06 +0800
Message-ID: <CADiBU39oSaSrog8pBFUUPdmfW6QCfm929_7QF7t025m7Ar+FkA@mail.gmail.com>
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

HI, Jonathan

Jonathan Cameron <jic23@kernel.org> =E6=96=BC 2022=E5=B9=B47=E6=9C=8817=E6=
=97=A5 =E9=80=B1=E6=97=A5 =E5=87=8C=E6=99=A81:29=E5=AF=AB=E9=81=93=EF=BC=9A
>
>
> > > > > +
> > > > > +static int rtq6056_probe(struct i2c_client *i2c)
> > > > > +{
> > > > > +     struct iio_dev *indio_dev;
> > > > > +     struct rtq6056_priv *priv;
> > > > > +     struct device *dev =3D &i2c->dev;
> > > > > +     struct regmap *regmap;
> > > > > +     unsigned int vendor_id, shunt_resistor_uohm;
> > > > > +     int ret;
> > > > > +
> > > > > +     if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_SMBUS_W=
ORD_DATA))
> > > > > +             return -EOPNOTSUPP;
> > > > > +
> > > > > +     indio_dev =3D devm_iio_device_alloc(dev, sizeof(*priv));
> > > > > +     if (!indio_dev)
> > > > > +             return -ENOMEM;
> > > > > +
> > > > > +     priv =3D iio_priv(indio_dev);
> > > > > +     priv->dev =3D dev;
> > > > > +     priv->vshuntct_us =3D priv->vbusct_us =3D 1037;
> > > > > +     priv->avg_sample =3D 1;
> > > > > +     i2c_set_clientdata(i2c, priv);
> > > > > +
> > > > > +     regmap =3D devm_regmap_init_i2c(i2c, &rtq6056_regmap_config=
);
> > > > > +     if (IS_ERR(regmap))
> > > > > +             return dev_err_probe(dev, PTR_ERR(regmap),
> > > > > +                                  "Failed to init regmap\n");
> > > > > +
> > > > > +     priv->regmap =3D regmap;
> > > > > +
> > > > > +     ret =3D regmap_read(regmap, RTQ6056_REG_MANUFACTID, &vendor=
_id);
> > > > > +     if (ret)
> > > > > +             return dev_err_probe(dev, ret,
> > > > > +                                  "Failed to get manufacturer in=
fo\n");
> > > > > +
> > > > > +     if (vendor_id !=3D RTQ6056_VENDOR_ID)
> > > > > +             return dev_err_probe(dev, -ENODEV,
> > > > > +                                  "Invalid vendor id 0x%04x\n", =
vendor_id);
> > > > > +
> > > > > +     ret =3D devm_regmap_field_bulk_alloc(dev, regmap, priv->rm_=
fields,
> > > > > +                                        rtq6056_reg_fields, F_MA=
X_FIELDS);
> > > > > +     if (ret)
> > > > > +             return dev_err_probe(dev, ret, "Failed to init regm=
ap field\n");
> > > > > +
> > > > > +     /*
> > > > > +      * By default, configure average sample as 1, bus and shunt=
 conversion
> > > > > +      * timea as 1037 microsecond, and operating mode to all on.
> > > > > +      */
> > > > > +     ret =3D regmap_write(regmap, RTQ6056_REG_CONFIG, RTQ6056_DE=
FAULT_CONFIG);
> > > > > +     if (ret)
> > > > > +             return dev_err_probe(dev, ret,
> > > > > +                                  "Failed to enable continuous s=
ensing\n");
> > > > > +
> > > > > +     pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
> > > > > +     pm_runtime_use_autosuspend(dev);
> > > > > +     pm_runtime_set_active(dev);
> > > > > +     pm_runtime_mark_last_busy(dev);
> > > > > +     pm_runtime_enable(dev);
> > > >
> > > > Look at whether you can use devm_pm_runtime_enable()
> > > > Note it handles disabling autosuspend for you.
> > > >
> > > > When using runtime_pm() you want to ensure that the device works wi=
thout
> > > > runtime pm support being enabled.  As such, you turn the device on =
before
> > > > enabling runtime_pm() and (this is missing I think) turn it off aft=
er disabling
> > > > runtime pm.  So I'd expect a devm_add_action_or_reset() call to unw=
ind
> > > > setting the device into continuous sending above.
> > > >
> > > If so, I think it's better to configure the device keep in off state
> > > in probe stage.
> > > The calling order may need to be changed as below
> > > devm_add_action_or_reset...
> > >
> > > pm_runtime_set_autosuspend_delay
> > > pm_runtime_use_auto_suspend
> > > devm_pm_runtime_enable
> > >
> > Ah, not correct. How about if 'PM_RUNTIME' is not enabled?
> > Do we need to consider about this case?
> >
> > If yes, the original flow about 'pm_runtime' is correct.
> I don't follow.  Perhaps next version will make it clear what you mean.
>
In v6, I  already fixed most about the comment in v5.
Only the 'DEFINE_RUNTIME_DEV_PM_OPS' is left.
Now all are clear.

Please review the v7. It includes all the fixes.
Thanks.
> Jonathan

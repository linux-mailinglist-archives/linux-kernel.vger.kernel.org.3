Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83904E758B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 15:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359438AbiCYPBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 11:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242549AbiCYPBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 11:01:17 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B78A91AF4;
        Fri, 25 Mar 2022 07:59:42 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id m3so13810345lfj.11;
        Fri, 25 Mar 2022 07:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GfDVRQr++4pgL3CtgOqQ8G/2FYhyqP1wPtfah4T1XN0=;
        b=N+/xry+CPssM5sYgR3wuCCIAkukseromAZ2CyTgQDB1W4NG9rZt2S+wu0PeIMTznOL
         +qYHb2kpENf5FxkQ57Hzwa1T8NfUH13NWLqOsjmI+aR2ijUHx/mxPCdL9l5Fha6B3n0t
         6vIZ8MRScC33vsyxAHAq57PzZh4FY3tzJARXUKgADXZYBoeIrYw+Kb5oEJGkxF1jbceO
         Iv/bhRRwS/LR4CUducORXCFNBDGFtQD0QszoFlYyKaKztps3HDeknZ68OAQKGVr8lpNy
         oDcdyQ0aKU4J3a5Ao9fG6Ysognx8YFsQVeAt8o01pwJPXWVy1hfobJHkrPSft+YyFrh+
         ibIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GfDVRQr++4pgL3CtgOqQ8G/2FYhyqP1wPtfah4T1XN0=;
        b=2vyYwRUXsY4yKrVjiNu4bkcJPo+Y2KSwU2W+wb0cqc3p/unH6y6oryqnDYMoUWQ8Hk
         QH+cb4l9F8Us7xGr7KrJ/D3ukx8H9rU4VGWhq9VY6HUZf9VZa9r8wq4fmcF59ZD0OYce
         JP70mII1IVk4fPBr88GOxPOUeAKxMD69Yqcbwh2bznnAhuLrNVkF85fN5rkcB1Sg6DUo
         QBFE2LFXft+fH0IMFL/Zp3G43kma/UhY736OlJQ3aM120a5IO0ezfYTKeF/15YZvFrIX
         9s5s8bPLiy62EvMVGah1vAzFYOkRm3BB0t0WFSWW2l3QsnQcmXanW3uZSSASMw85opod
         cJKw==
X-Gm-Message-State: AOAM5307eTe4Un2O18GX51e6BRwnl3/9Q9fzCnOt42P0lXDciGMN6e51
        bn/WKEo+cSxXP96kCzXledmHqc8/JSrJPw7VH3o=
X-Google-Smtp-Source: ABdhPJzkdzeTQI21afwaqcQ2TyleAfqBQ22j0/ebxlfj/UXC5RJ8Xza0CX09E/SaH9hROl1HEOoWdWb2qKSiO2cqrF8=
X-Received: by 2002:a05:6512:e9a:b0:44a:3491:863a with SMTP id
 bi26-20020a0565120e9a00b0044a3491863amr8525691lfb.133.1648220380893; Fri, 25
 Mar 2022 07:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <1648170401-6351-1-git-send-email-u0084500@gmail.com>
 <1648170401-6351-3-git-send-email-u0084500@gmail.com> <d2b431f8-9197-4a42-4ee2-4e771e20e0aa@kernel.org>
 <CADiBU39RGQj1-+yK18mZf3MR78KACKqb2kAxkCFKGXKpJ6Nqxw@mail.gmail.com> <e4a15ceb-c013-96be-48d1-e65267400463@kernel.org>
In-Reply-To: <e4a15ceb-c013-96be-48d1-e65267400463@kernel.org>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Fri, 25 Mar 2022 22:59:29 +0800
Message-ID: <CADiBU3-gwsh5v1NLUYr_ovXwpUxQqgR61f-Jpc3G-zHs_yV4uw@mail.gmail.com>
Subject: Re: [PATCH 2/2] regulator: rt5759: Add support for Richtek RT5759
 DCDC converter
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        cy_huang <cy_huang@richtek.com>, gene_chen@richtek.com,
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

Krzysztof Kozlowski <krzk@kernel.org> =E6=96=BC 2022=E5=B9=B43=E6=9C=8825=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8810:47=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On 25/03/2022 15:10, ChiYuan Huang wrote:
> > Krzysztof Kozlowski <krzk@kernel.org> =E6=96=BC 2022=E5=B9=B43=E6=9C=88=
25=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=888:17=E5=AF=AB=E9=81=93=EF=
=BC=9A
> >>
> >> On 25/03/2022 02:06, cy_huang wrote:
> >>> From: ChiYuan Huang <cy_huang@richtek.com>
> >>>
> >>> Add support for Richtek RT5759 high-performance DCDC converter.
> >>>
> >>> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> >>> ---
> >>>  drivers/regulator/Kconfig            |  10 +
> >>>  drivers/regulator/Makefile           |   1 +
> >>>  drivers/regulator/rt5759-regulator.c | 372 +++++++++++++++++++++++++=
++++++++++
> >>>  3 files changed, 383 insertions(+)
> >>>  create mode 100644 drivers/regulator/rt5759-regulator.c
> >>>
> >>
> >> (...)
> >>
> >>> +static int rt5759_init_device_property(struct rt5759_priv *priv)
> >>> +{
> >>> +     unsigned int val =3D 0;
> >>> +     bool wdt_enable;
> >>> +
> >>> +     /*
> >>> +      * Only RT5759A support external watchdog input
> >>> +      */
> >>> +     if (priv->chip_type !=3D CHIP_TYPE_RT5759A)
> >>> +             return 0;
> >>> +
> >>> +     wdt_enable =3D device_property_read_bool(priv->dev,
> >>> +                                            "richtek,watchdog-enable=
");
> >>> +     if (wdt_enable)
> >>
> >> No need for separate wdt_enable variable.
> >>
> > Ack in next.
> >>> +             val =3D RT5759A_WDTEN_MASK;
> >>> +
> >>> +     return regmap_update_bits(priv->regmap, RT5759A_REG_WDTEN,
> >>> +                               RT5759A_WDTEN_MASK, val);
> >>> +}
> >>> +
> >>> +static int rt5759_manufacturer_check(struct rt5759_priv *priv)
> >>> +{
> >>> +     unsigned int vendor;
> >>> +     int ret;
> >>> +
> >>> +     ret =3D regmap_read(priv->regmap, RT5759_REG_VENDORINFO, &vendo=
r);
> >>> +     if (ret)
> >>> +             return ret;
> >>> +
> >>> +     if (vendor !=3D RT5759_MANUFACTURER_ID) {
> >>> +             dev_err(priv->dev, "vendor info not correct (%d)\n", ve=
ndor);
> >>> +             return -EINVAL;
> >>> +     }
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +static bool rt5759_is_accessible_reg(struct device *dev, unsigned in=
t reg)
> >>> +{
> >>> +     struct rt5759_priv *priv =3D dev_get_drvdata(dev);
> >>> +
> >>> +     if (reg <=3D RT5759_REG_DCDCSET)
> >>> +             return true;
> >>> +
> >>> +     if (priv->chip_type =3D=3D CHIP_TYPE_RT5759A && reg =3D=3D RT57=
59A_REG_WDTEN)
> >>> +             return true;
> >>> +
> >>> +     return false;
> >>> +}
> >>> +
> >>> +static const struct regmap_config rt5759_regmap_config =3D {
> >>> +     .reg_bits =3D 8,
> >>> +     .val_bits =3D 8,
> >>> +     .max_register =3D RT5759A_REG_WDTEN,
> >>> +     .readable_reg =3D rt5759_is_accessible_reg,
> >>> +     .writeable_reg =3D rt5759_is_accessible_reg,
> >>> +};
> >>> +
> >>> +static int rt5759_probe(struct i2c_client *i2c)
> >>> +{
> >>> +     struct rt5759_priv *priv;
> >>> +     int ret;
> >>> +
> >>> +     priv =3D devm_kzalloc(&i2c->dev, sizeof(*priv), GFP_KERNEL);
> >>> +     if (!priv)
> >>> +             return -ENOMEM;
> >>> +
> >>> +     priv->dev =3D &i2c->dev;
> >>> +     priv->chip_type =3D (unsigned long)of_device_get_match_data(&i2=
c->dev);
> >>> +     i2c_set_clientdata(i2c, priv);
> >>> +
> >>> +     priv->regmap =3D devm_regmap_init_i2c(i2c, &rt5759_regmap_confi=
g);
> >>> +     if (IS_ERR(priv->regmap)) {
> >>> +             ret =3D PTR_ERR(priv->regmap);
> >>> +             dev_err(&i2c->dev, "Failed to allocate regmap (%d)\n", =
ret);
> >>> +             return ret;
> >>> +     }
> >>> +
> >>> +     ret =3D rt5759_manufacturer_check(priv);
> >>> +     if (ret) {
> >>> +             dev_err(&i2c->dev, "Failed to check device (%d)\n", ret=
);
> >>> +             return ret;
> >>> +     }
> >>> +
> >>> +     ret =3D rt5759_init_device_property(priv);
> >>> +     if (ret) {
> >>> +             dev_err(&i2c->dev, "Failed to init device (%d)\n", ret)=
;
> >>> +             return ret;
> >>> +     }
> >>> +
> >>> +     return rt5759_regulator_register(priv);
> >>> +}
> >>> +
> >>> +static const struct of_device_id __maybe_unused rt5759_device_table[=
] =3D {
> >>
> >> I don't think this can be __maybe_unused. It is always referenced via
> >> of_match_table, isn't it?
> >>
> > I think it can declared as '__maybe_unused'.
> > If 'of_device_id' is unused, then in probe stage,
> > 'of_device_get_match_data' will return NULL.
>
> But your of_device_id cannot be unused. It is always referenced.
>
I'm not sure, but your assumption is based on 'CONFIG_OF', right?
Only if 'CONFIG_OF' is not defined, then it'll be really unused.

> > priv->chip_type will get zero as the return value. And it will be
> > treated as rt5759, not rt5759a.
> > The difference between these two are only watchdog function supported o=
r not.
>
>
> Best regards,
> Krzysztof

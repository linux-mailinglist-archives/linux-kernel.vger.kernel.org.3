Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C932592950
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 08:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbiHOGLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 02:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbiHOGLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 02:11:10 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AFB18B0B;
        Sun, 14 Aug 2022 23:11:08 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id e13so8377682edj.12;
        Sun, 14 Aug 2022 23:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=uKYTaw9VXG0yF1QBvxHtXrHotaHTeuThRMHGXlGn5E4=;
        b=ZUZ+rIbxFCCyktD0ptGuPK1kcu3LGeWumo7FnBWG6lKZsoi7i0js567oXv2HLJRLEN
         GjYcN9JHKYjUfWOxcW4W+DwKOxrXqNZuMra4xdCIskNu/sAd/p3wDJaQ+LlphT5vICCf
         UR2EwfGDT22rNwWJiEd7jVmZMqvAQn2Dit98W0i+ku/o6swSpjYY1WDVX63EKeYMuIuF
         ws/Xc37Q8TXgerZDg4sF47+1U8jNxnOMG0Pr/uOUWGtHyc59U0c+DvnCs3CS9CyoKTEz
         oOxQVZSNDN2FpGU43wRtnUZS4hoQHElNXPTyWgYFys66kPgdo+8nsd5rjH68zrOuGGi4
         81Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=uKYTaw9VXG0yF1QBvxHtXrHotaHTeuThRMHGXlGn5E4=;
        b=rATxhnjOHhxTxFEJW4LzKzGwt8NNQmA+4aH5WEFAbRFVlqm7m3Bg233qaxjEZCXRs2
         5Ylygg3BR6A6W7ZZlteM4iDOhVDdKWqQzlFFI2qra7zWKDEt1SQyzgrtdpyiAkTBvXEX
         Y7yVqzNsAf1A43xEteVZDS9D85GudbWoDOLvJwZFSU9/3NSgch7lp9rpwrvwhhNiKN0l
         t6x2sb92qQT0wjbFroPRLAYXFlzX2v8RMYnngYJ7SXCk32FRzZgWQ8xh1zC9YmS5rzzX
         826U+b2Fy/tzCaCREMF/BSK3qCNh8aB2khVS9fMpS1E1ryRDHUgz9sQ6RPlKZ4yTwOC9
         npow==
X-Gm-Message-State: ACgBeo0Dp59toPPtO1ZAigVKmljfk0e2fPAjoJE3lIm8Lf8/VrKvW2lB
        sGu7ui5IBd+s3i2YzMJm1Bow2/jKFumRjfmxEMJLz+mx
X-Google-Smtp-Source: AA6agR6NKM/SYSq2MDWC5CfCmDLCA9ide1cqjQJgZ1Y6BrNbyGYnone4Ho3PYuWf0fcEAp+dRzAUlALiO0onFPsDSYY=
X-Received: by 2002:aa7:d59a:0:b0:441:ecc9:f33e with SMTP id
 r26-20020aa7d59a000000b00441ecc9f33emr13587612edq.173.1660543866508; Sun, 14
 Aug 2022 23:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <1660225318-4063-1-git-send-email-u0084500@gmail.com>
 <1660225318-4063-3-git-send-email-u0084500@gmail.com> <CANhJrGMnjSu3MMQ2PgvSWztNgG1r-PdyLBdsT3JVqZZSfqky-w@mail.gmail.com>
In-Reply-To: <CANhJrGMnjSu3MMQ2PgvSWztNgG1r-PdyLBdsT3JVqZZSfqky-w@mail.gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Mon, 15 Aug 2022 14:10:55 +0800
Message-ID: <CADiBU39c4P-ZNwjrqm-VxSZOLiobEu--y=iH+Si7a+dwUdmeaA@mail.gmail.com>
Subject: Re: [PATCH 2/2] power: supply: rt9471: Add Richtek RT9471 charger driver
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        =?UTF-8?B?5ri45a2Q6aao?= <alina_yu@richtek.com>,
        ChiYuan Huang <cy_huang@richtek.com>, alinayu829@gmail.com,
        Linux PM list <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Matti Vaittinen <mazziesaccount@gmail.com> =E6=96=BC 2022=E5=B9=B48=E6=9C=
=8815=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=881:53=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Hi ChiYuan,
>
> Thanks for the patch :)
>
> to 11. elok. 2022 klo 16.43 cy_huang (u0084500@gmail.com) kirjoitti:
> >
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Add support for the RT9471 3A 1-Cell Li+ battery charger.
> >
> > The RT9471 is a highly-integrated 3A switch mode battery charger with
> > low impedance power path to better optimize the charging efficiency.
> >
> > Co-developed-by: Alina Yu <alina_yu@richtek.com>
> > Signed-off-by: Alina Yu <alina_yu@richtek.com>
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
>
> > +
> > +static const struct linear_range rt9471_chg_ranges[RT9471_MAX_RANGES] =
=3D {
> > +       [RT9471_RANGE_AICR] =3D { 50000, 1, 63, 50000 },
> > +       [RT9471_RANGE_MIVR] =3D { 3900000, 0, 15, 100000 },
> > +       [RT9471_RANGE_IPRE] =3D { 50000, 0, 15, 50000 },
> > +       [RT9471_RANGE_VCHG] =3D { 3900000, 0, 80, 10000 },
> > +       [RT9471_RANGE_ICHG] =3D { 0, 0, 63, 50000 },
> > +       [RT9471_RANGE_IEOC] =3D { 50000, 0, 15, 50000 },
> > +};
>
> I just jumped in to ask if that could you please use the field names? Eg.
>  { .min =3D 50000, .min_sel =3D 1, .max_sel =3D 63, .step =3D 50000 },
>
> This would make it less error prone in case someone changes the
> members in struct linear_range.
>
Yes, sure, if something changed for this structure, this could be a problem=
.
Thanks for the comment.
> > +
> > +static int rt9471_set_value_by_field_range(struct rt9471_chip *chip,
> > +                                          enum rt9471_fields field,
> > +                                          enum rt9471_ranges range, in=
t val)
> > +{
> > +       unsigned int sel;
> > +
> > +       if (val < 0)
> > +               return -EINVAL;
> > +
> > +       linear_range_get_selector_within(rt9471_chg_ranges + range, val=
, &sel);
> > +
> > +       return regmap_field_write(chip->rm_fields[field], sel);
> > +}
> > +
> > +
> > +static int rt9471_get_value_by_field_range(struct rt9471_chip *chip,
> > +                                          enum rt9471_fields field,
> > +                                          enum rt9471_ranges range, in=
t *val)
> > +{
> > +       unsigned int sel, rvalue;
> > +       int ret;
> > +
> > +       ret =3D regmap_field_read(chip->rm_fields[field], &sel);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret =3D linear_range_get_value(rt9471_chg_ranges + range, sel, =
&rvalue);
> > +       if (ret)
> > +               return ret;
> > +
> > +       *val =3D rvalue;
> > +       return 0;
> > +}
> > +
> > +static inline int rt9471_set_hiz(struct rt9471_chip *chip, int enable)
> > +{
> > +       return regmap_field_write(chip->rm_fields[F_HZ], enable);
> > +}
> > +
> > +static inline int rt9471_set_ichg(struct rt9471_chip *chip, int microa=
mp)
> > +{
> > +       return rt9471_set_value_by_field_range(chip, F_ICHG_REG,
> > +                                              RT9471_RANGE_ICHG, micro=
amp);
> > +}
> > +
> > +static inline int rt9471_get_ichg(struct rt9471_chip *chip, int *micro=
amp)
> > +{
> > +       return rt9471_get_value_by_field_range(chip, F_ICHG_REG,
> > +                                              RT9471_RANGE_ICHG, micro=
amp);
> > +}
> > +
> > +static inline int rt9471_set_cv(struct rt9471_chip *chip, int microvol=
t)
> > +{
> > +       return rt9471_set_value_by_field_range(chip, F_VBAT_REG,
> > +                                              RT9471_RANGE_VCHG, micro=
volt);
> > +}
> > +
> > +static inline int rt9471_get_cv(struct rt9471_chip *chip, int *microam=
p)
> > +{
> > +       return rt9471_get_value_by_field_range(chip, F_VBAT_REG,
> > +                                              RT9471_RANGE_VCHG, micro=
amp);
> > +}
> > +
> > +static inline int rt9471_set_mivr(struct rt9471_chip *chip, int microv=
olt)
> > +{
> > +       return rt9471_set_value_by_field_range(chip, F_MIVR,
> > +                                              RT9471_RANGE_MIVR, micro=
volt);
> > +}
> > +
> > +static inline int rt9471_get_mivr(struct rt9471_chip *chip, int *micro=
volt)
> > +{
> > +       return rt9471_get_value_by_field_range(chip, F_MIVR,
> > +                                              RT9471_RANGE_MIVR, micro=
volt);
> > +}
> > +
> > +static inline int rt9471_set_aicr(struct rt9471_chip *chip, int microa=
mp)
> > +{
> > +       return rt9471_set_value_by_field_range(chip, F_AICR, RT9471_RAN=
GE_AICR,
> > +                                              microamp);
> > +}
> > +
> > +static inline int rt9471_get_aicr(struct rt9471_chip *chip, int *micro=
amp)
> > +{
> > +       return rt9471_get_value_by_field_range(chip, F_AICR, RT9471_RAN=
GE_AICR,
> > +                                              microamp);
> > +}
> > +
> > +static inline int rt9471_set_iprechg(struct rt9471_chip *chip, int mic=
roamp)
> > +{
> > +       return rt9471_set_value_by_field_range(chip, F_IPRE_CHG,
> > +                                              RT9471_RANGE_IPRE, micro=
amp);
> > +}
> > +
> > +static inline int rt9471_get_iprechg(struct rt9471_chip *chip, int *mi=
croamp)
> > +{
> > +       return rt9471_get_value_by_field_range(chip, F_IPRE_CHG,
> > +                                              RT9471_RANGE_IPRE, micro=
amp);
> > +}
> > +
> > +static inline int rt9471_set_ieoc(struct rt9471_chip *chip, int microa=
mp)
> > +{
> > +       return rt9471_set_value_by_field_range(chip, F_IEOC_CHG,
> > +                                              RT9471_RANGE_IEOC, micro=
amp);
> > +}
> > +
> > +static inline int rt9471_get_ieoc(struct rt9471_chip *chip, int *micro=
amp)
> > +{
> > +       return rt9471_get_value_by_field_range(chip, F_IEOC_CHG,
> > +                                              RT9471_RANGE_IEOC, micro=
amp);
> > +}
> > +
> > +static inline int rt9471_set_chg_enable(struct rt9471_chip *chip, int =
enable)
> > +{
> > +       return regmap_field_write(chip->rm_fields[F_CHG_EN], !!enable);
> > +}
> > +
>
> //snip
>
> > +
> > +static inline struct rt9471_chip * psy_device_to_chip(struct device *d=
ev)
> > +{
> > +       return power_supply_get_drvdata(to_power_supply(dev));
> > +}
>
> While skimming through the rest of the patch... This may just be my
> personal preference but wrapper functions with just one line are
> rarely beneficial. In the worst case they just add more lines AND hide
> the details of what actually is done without any clear benefits. Well,
> this is just my view so please ignore this comment if wrappers like
> this are a "subsystem standard"
>
I'm not sure what the 'subsystem standard' is.
I declare it as 'inline' function and the  function name to tell the
user what I'm doing.
This may be silly. But from my aspect, it makes each property set/get
more clear.
> Other than that the patch looks good to me.
>
> --
>
> Matti Vaittinen
> Linux kernel developer at ROHM Semiconductors
> Oulu Finland
>
> ~~ When things go utterly wrong vim users can always type :help! ~~
>
> Discuss - Estimate - Plan - Report and finally accomplish this:
> void do_work(int time) __attribute__ ((const));

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DCB513784
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 16:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348661AbiD1PAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348593AbiD1PAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:00:31 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D824968D;
        Thu, 28 Apr 2022 07:57:15 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bq30so9136525lfb.3;
        Thu, 28 Apr 2022 07:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=edaPhOqJ6sNMjVlH4NUtpjaeXKOnbtBwCPOsuCBJZKU=;
        b=YfTcS3mTCtPbXgS8Mwgqg8cvzUAYE7YiXXqaZMlJMg6VhBO0FpM4yubZ5zDlAEJeuj
         Opn7DtAg0Lyfl7G6/w/ZoaDy6IqOeHkqdmHFm7+L/6y8wXYDN3zzf49jG856cDtCkdoj
         VM0y4iuzePK/m9x6gD1bW5WejAuEXrFHWlfWumymOhIsWoorhrvFSANFrJo7ra2oSRTj
         3H+wdUUR8J+cJ8UQ6Z22bhnfGtTTGpsiDNLu4CvozwQfPtN/5RyI2I4o5gUnQ9yd0ltR
         3/76dovmgnl4nZBok+n2ZmwSYaN7oprqbMTMMQboH4149gdOLG22zYmLhfpENXufD7fu
         U+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=edaPhOqJ6sNMjVlH4NUtpjaeXKOnbtBwCPOsuCBJZKU=;
        b=VNQOE4+0luLKqwcXdYNKvSEzJXN0B0uvmGq9AOc5zvo2q273jlrBggqADONLkAguNa
         l5nX4+sPj9aIevG5FbjedBPj/VHTkRiYengJ+uy4sAqDejnYdWNtn2Ba30cePRs5Xt6J
         Lx4rkACdST1AngKWqU7O6hiLSKzUUcV9E43AOTUDhzk2oIWBX3pevUp60BKEA8O+zifl
         qrmh7VCgz9qHVarcF7rE2RegyTg/7C1X6ESoPaIZ3BM2fFrRCq6oaJF/7zU0WQKQog2H
         IpwpHFqYmOTGXWFLAcRBia3r9PzJmSxqcGPM3HyAMlF2l8IMakVDQ9jbw5wm8Jo6TecS
         PyHw==
X-Gm-Message-State: AOAM5307HNajJg7N0MWuXrs0PUOC1TL9dnDH8Gn13X+WH/EFh+TguQ87
        /EGm6ow+gxdNM6x7KrURr1syWQn+zDTBIBun8a0=
X-Google-Smtp-Source: ABdhPJwkh8xMJd2euFGqJq9Hf7/7jfpX7aEFfs+lWsLvXi1VgE0Dv6VL3djM8Zbk5sBL4KDSrsXefOB4aMTVp46BlNA=
X-Received: by 2002:a19:fc0e:0:b0:471:ff7d:ab35 with SMTP id
 a14-20020a19fc0e000000b00471ff7dab35mr17334833lfi.345.1651157833665; Thu, 28
 Apr 2022 07:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <1651138365-17362-1-git-send-email-u0084500@gmail.com>
 <1651138365-17362-5-git-send-email-u0084500@gmail.com> <CANhJrGN8avK7mehqVDHVCjBzoG3RU4CykHEaFdQqt40_LjSh1A@mail.gmail.com>
In-Reply-To: <CANhJrGN8avK7mehqVDHVCjBzoG3RU4CykHEaFdQqt40_LjSh1A@mail.gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Thu, 28 Apr 2022 22:57:01 +0800
Message-ID: <CADiBU39sgh-6=KmXgbuhNmL4QAQhdHpPz5nEDwffev8x+MQKpA@mail.gmail.com>
Subject: Re: [PATCH 4/4] leds: flash: mt6360: Add mt6360 isnk channel hardwre
 breath mode support
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Gene Chen <gene_chen@richtek.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Matti Vaittinen <mazziesaccount@gmail.com> =E6=96=BC 2022=E5=B9=B44=E6=9C=
=8828=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=887:51=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Hi ChiYuan!
>
> On Thu, Apr 28, 2022 at 1:03 PM cy_huang <u0084500@gmail.com> wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Add mt6360 isnk channel hardware breath mode support.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> >
> > +static int mt6360_gen_breath_reg_config(struct led_pattern *pattern, u=
32 len,
> > +                                       u8 *vals, int val_len)
> > +{
> > +       static const struct linear_range tranges[MT6360_ILED_RANGE_MAX]=
 =3D {
> > +               { 125, 0, 15, 250 }, /* tr/f12 and ton, unit: milliseco=
nd */
> > +               { 250, 0, 15, 500 }, /* toff, unit: millisecond */
> > +       };
>
> It's nice to see you are using the linear_ranges helpers here! Just a
> minor remark - do you think you could use field names in linear_ranges
> initializations? That would make it less likely the driver breaks if
> someone changes the struct linear_range definition. Eg, use something
> like:
>
> static const struct linear_range tranges[MT6360_ILED_RANGE_MAX] =3D {
>         /* tr/f12 and ton, unit: millisecond */
>         { .min =3D 125, .min_sel =3D 0, .max_sel =3D 15, .step =3D 250 },
>         /* toff, unit: millisecond */
>         { .min =3D 250, .min_sel =3D 0, .max_sel =3D 15, .step =3D 500 },
> };
>
> Do you think that would work?
Sure, it works.
To specify the field name can be compatible if the struct changes in the fu=
ture.
Thanks.
>
> Best Regards
> -- Matti
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

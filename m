Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DB0552980
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 04:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbiFUCnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 22:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbiFUCnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 22:43:06 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE121C10C;
        Mon, 20 Jun 2022 19:43:04 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id p69so12958258iod.0;
        Mon, 20 Jun 2022 19:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XBEE2W3FjydD0/XD0h/jv8cpLUWQxzRJ40zan6MUb+E=;
        b=oWfVzxZxhoE4HCZZdM8AG2g15e+tsDablb3uv6NkJNr1Kh3zVrgyKtEPApzczQpRms
         bD8RZbDm7aMtscYJEN8XXGOlsTqkZf1dtxoWPDORJ7urpKFNz5I0ZAkz1Y6lu2L3VKxk
         jsgOC3+8UD4PmI07mrFKGYJUB4K2+cCuGgR1lLkTssDUPma6usi742emzjDomnez/fO7
         gkncrR62Ovc5cM/k3mTqd9wRYOhJWE1fAYa4f47f2OUNxvJeF/xsemZbX25KUkPaIWm8
         FPCUCW3ESzi7b+Cjy8YYs3GbGU2ami25BYtYRPOZWh4ANtHkZtNS3Ocb5DmSnpwpiC2t
         VZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XBEE2W3FjydD0/XD0h/jv8cpLUWQxzRJ40zan6MUb+E=;
        b=SFsINAcKpo0JqvLZoIiAnlSWTDwO3lvN5Q8VeVFXxVlvuJjimD+NqZVyJiuJnQzv6R
         ZbkDwgWT+sZax3pIhI0V95jNOm2d7nzAAIoAxhN9FqWOlMzoRzpHDBh/TjXTJ4lkiuny
         I1xJbKalFidpctUA+w4CQtQqpUGCK61Lh2vMIRNSfEzvzXdq/4DlxGz9Zj1vmLgJb+hV
         MLhbTDCeHJBGBeEF6WEEoHlpN/hFuIQMLS5iAthEqHT3COWEmOR3wxrwdlYEYdutoNTm
         JKySTWwPiEZmw8gtHJfUCVfhIUbQalTqh74uD1zHiGbb2kblaqW1u+1gKr345lR5P+O9
         8eeA==
X-Gm-Message-State: AJIora8QGpEsIBkVHrnxkeg4mZIjs1bCXwJj+a2Dz3ZT7bjeLFI/NgL2
        qt1D5l7DvKntNPUKrog7UZdF1d4g+ixJkq+mvfY=
X-Google-Smtp-Source: AGRyM1vpQzgV0zlZHowqIGzYAAvxpyakFnm6y9bItBulj3V4Z+ncRS7AdAAHY3Rk9Fm+0HC+g4QHLAUy8HRH6yxI77s=
X-Received: by 2002:a02:6d61:0:b0:338:398c:1be8 with SMTP id
 e33-20020a026d61000000b00338398c1be8mr10684754jaf.271.1655779384400; Mon, 20
 Jun 2022 19:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220613111146.25221-1-peterwu.pub@gmail.com> <20220613111146.25221-8-peterwu.pub@gmail.com>
 <20220618164820.2eeb8ae8@jic23-huawei> <CABtFH5+R761Tyd4yaWg-foSC4K=_aeYiVaTf37KvVH1Z4z9Jhw@mail.gmail.com>
 <20220620193500.145f05b9@jic23-huawei>
In-Reply-To: <20220620193500.145f05b9@jic23-huawei>
From:   ChiaEn Wu <peterwu.pub@gmail.com>
Date:   Tue, 21 Jun 2022 10:42:53 +0800
Message-ID: <CABtFH5KsiDchvshPEEs2hejCWW3z+7RFUXuUBkpR-uiWqOMKyQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/15] Documentation: ABI: testing: mt6370: Add ADC
 sysfs guideline
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     lars@metafoo.de, matthias.bgg@gmail.com,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        jingoohan1@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com, ChiaEn Wu <chiaen_wu@richtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

Thanks for your reply!

Jonathan Cameron <jic23@kernel.org> =E6=96=BC 2022=E5=B9=B46=E6=9C=8821=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E5=87=8C=E6=99=A82:35=E5=AF=AB=E9=81=93=EF=BC=9A

>
> On Mon, 20 Jun 2022 14:00:43 +0800
> ChiaEn Wu <peterwu.pub@gmail.com> wrote:
>
> > Hi Jonathan,
> >
> > Thanks for your helpful comments, and I have some questions want to
> > ask you below.
> >
> > Jonathan Cameron <jic23@kernel.org> =E6=96=BC 2022=E5=B9=B46=E6=9C=8818=
=E6=97=A5 =E9=80=B1=E5=85=AD =E6=99=9A=E4=B8=8A11:39=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > >
> > > On Mon, 13 Jun 2022 19:11:38 +0800
> > > ChiaEn Wu <peterwu.pub@gmail.com> wrote:
> > >
> > > > From: ChiaEn Wu <chiaen_wu@richtek.com>
> > > >
> > > > Add ABI documentation for mt6370 non-standard ADC sysfs interfaces.
> > > >
> > > > Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> > > > ---
> > > >  .../ABI/testing/sysfs-bus-iio-adc-mt6370      | 36 +++++++++++++++=
++++
> > > >  1 file changed, 36 insertions(+)
> > > >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-mt6=
370
> > > >
> > > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-mt6370 b/D=
ocumentation/ABI/testing/sysfs-bus-iio-adc-mt6370
> > > > new file mode 100644
> > > > index 000000000000..039b3381176a
> > > > --- /dev/null
> > > > +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-mt6370
> > > > @@ -0,0 +1,36 @@
> > > > +What:                /sys/bus/iio/devices/iio:deviceX/in_voltage0_=
raw
> > >
> > > Unfortunately the kernel documentation build scripts do no support du=
plicating
> > > standard ABI for particular devices so as to provide more information=
.
> > > Hence you can't have anything in this file.
> > >
> >
> > I want to confirm with you again,
> > because my ABI file duplicates with standard sysfs-bus-iio (voltage,
> > current, and temperature channels),
> > Should I just remove this ABI file and modify the code of mt6370-adc
> > to meet your expectations??
>
> yes.

OK! I got it! I will refine the code in the next patch!

>
> >
> > >
> > > > +KernelVersion:       5.18
> > > > +Contact:     chiaen_wu@richtek.com
> > > > +Description:
> > > > +             Indicated MT6370 VBUS ADC with lower accuracy(+-75mA)
> > > Curious though, voltage with a mA accuracy range?
> >
> > Yes, this description is based on the data sheet.
>
> Weird :)

First, I want to apologize to you because I rechecked the datasheet
and asked the hardware engineer,
the conclusion is I wrote the wrong unit...
The correction is that the accuracy of vbusdiv5 is +-75"mV", not "mA",
and another one, vbusdiv2, is +-30mV.
I sincerely apologize for this mistake and for any inconvenience...

>
> >
> > > This scale should be presented directly to userspace anyway so no nee=
d
> > > for this doc.
> > >
> > > > +             higher measure range(1~22V)
> > > > +             Calculating with scale returns voltage in uV
> > >
> > > No. All channels return in mV. That's the ABI requirement as
> > > in sysfs-bus-iio and we cannot vary if for particular drivers.  If we=
 did
> > > no generic tooling would work.
> >
> > Ok, I got it!
> >
> > >
> > > > +
> > > > +What:                /sys/bus/iio/devices/iio:deviceX/in_voltage1_=
raw
> > > > +KernelVersion:       5.18
> > > > +Contact:     chiaen_wu@richtek.com
> > > > +Description:
> > > > +             Indicated MT6370 VBUS ADC with higher accuracy(+-30mA=
)
> > > > +             lower measure range(1~9.76V)
> > > > +             Calculating with scale offset returns voltage in uV
> > > > +
> > > > +What:                /sys/bus/iio/devices/iio:deviceX/in_voltage4_=
raw
> > > > +KernelVersion:       5.18
> > > > +Contact:     chiaen_wu@richtek.com
> > > > +Description:
> > > > +             Indicated MT6370 TS_BAT ADC
> > > > +             Calculating with scale returns voltage in uV
> > > > +
> > > > +What:                /sys/bus/iio/devices/iio:deviceX/in_voltage7_=
raw
> > > > +KernelVersion:       5.18
> > > > +Contact:     chiaen_wu@richtek.com
> > > > +Description:
> > > > +             Indicated MT6370 CHG_VDDP ADC
> > > > +             Calculating with scale returns voltage in mV
> > > > +
> > > > +What:                /sys/bus/iio/devices/iio:deviceX/in_temp8_raw
> > > > +KernelVersion:       5.18
> > > > +Contact:     chiaen_wu@richtek.com
> > > > +Description:
> > > > +             Indicated MT6370 IC junction temperature
> > > > +             Calculating with scale and offset returns temperature=
 in degree
> >
> > Shall I modify the scale of temperature to milli degrees in
> > mt6370-adc.c and remove this item??
>
> yes.
>
> Thanks,
>
> Jonathan
>
> >
> > >
> >
> > Best regards,
> > ChiaEn Wu
>

Best regards,
ChiaEn Wu

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BF45509BD
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 12:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbiFSKi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 06:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiFSKi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 06:38:56 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C22101DF;
        Sun, 19 Jun 2022 03:38:55 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z11so5297711edp.9;
        Sun, 19 Jun 2022 03:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Iz6jHYMoS6HvBou6Ank4WdyYv7rCxOnAp99ym/26Ctc=;
        b=JRFFibUTmHEAklZ7mVmGSE8YwHbxVNzfgozrUuHD3iXiddsS+EYng0C2hZ6AoTMEVK
         Ao/bWQs1sDA3otDsuKz6FM8jL13CuK35u6vEA477vf68p/R1IZtejqoxBeyQ6vZkfzz/
         Vb2qCSnz2bc66VO6M32icbFzl8bB0gvOeFzT8bte3m4UgO70HDSb0zdPOJlPq3RC/hHj
         l4D0wSoO9B5S/iKxbBsQAZl9/5/n1t2ZT1ANAkIyTBtr0kw9dQDTp/C8iwHbyweG120P
         cj0+apI/fONHlq8iI8VTTcAwe9ITQFgf0DEFg3+cW5TCJmCgps5Pqo6laH4/UssFUjjI
         SLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Iz6jHYMoS6HvBou6Ank4WdyYv7rCxOnAp99ym/26Ctc=;
        b=gdB81Z9JE5tSFgB964BolNcY846vPmFLw4VDsIntwTVx/7M9oHgsYybwz0wvhZPWwJ
         GFfBZBLQti4xXWAq3PSfutcQrVLAci7nfo/6URjbnUxPgdStCW03E20TG02OWusJHqHi
         8ENjepg7o0GkszcXhIuGdibPA5V7ui9kAcjFOIN/LVNWzUYG9nNMHQcZAORESWU8uBRd
         fzRqCDOENtdItHjP1cCzqBI6VZQK7mwbToWFI2u27II0WeTxNnPUT3eTvMERbYMsw6w9
         ZObSC3uWnBJocs++ktlULPXNBQvFtoefF7cyFz92XyHlNm9iBuyqxiWs2VkUB1YTZBRZ
         td6g==
X-Gm-Message-State: AJIora/L+M4csSScfZEGc3NDszIbcBLGz8BtD4cjJv2gmDSopkgiYsSv
        xS1VxTdlt8bKLm7vaw2EyOI//WtInAczsZdMRsc=
X-Google-Smtp-Source: AGRyM1to9YBUfhbInjOrJgnYWN1fIsrZBJlye6LbmZ5oiQZy8LF7p/fln889Xe+4p3TmOvEoO5jt4q3pcaPmajHuvZY=
X-Received: by 2002:a05:6402:11d2:b0:42d:e68a:eae0 with SMTP id
 j18-20020a05640211d200b0042de68aeae0mr23021080edw.111.1655635134082; Sun, 19
 Jun 2022 03:38:54 -0700 (PDT)
MIME-Version: 1.0
References: <1655458375-30478-1-git-send-email-u0084500@gmail.com>
 <1655458375-30478-3-git-send-email-u0084500@gmail.com> <CAHp75VfEQ6tu4-NQKwA+63Ae5busUwV+ZRqD6BtbUA+EkCZnWw@mail.gmail.com>
 <CADiBU3-wO0-0c9y-GpE15ra2AqkAG-ftqTh+hCvYEY-TojZ-pg@mail.gmail.com>
In-Reply-To: <CADiBU3-wO0-0c9y-GpE15ra2AqkAG-ftqTh+hCvYEY-TojZ-pg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 19 Jun 2022 12:38:17 +0200
Message-ID: <CAHp75VeBdgbyDQXEYb9ZZdi3AU=vPw6aKGWbNLnuA_QoN4LE4A@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: Add rtq6056 support
To:     ChiYuan Huang <u0084500@gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 18, 2022 at 5:16 PM ChiYuan Huang <u0084500@gmail.com> wrote:
> Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2022=E5=B9=B46=E6=
=9C=8818=E6=97=A5 =E9=80=B1=E5=85=AD =E5=87=8C=E6=99=A81:08=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > On Fri, Jun 17, 2022 at 11:37 AM cy_huang <u0084500@gmail.com> wrote:

...

> > > +KernelVersion: 5.18.2
> >
> > Wrong version, this won't be part of a stable kernel.
> >
> From kernel.org, currently the stable kernel version is 5.18.5.
> Change to 5.18.5?

Nope. You need to use realistic kernel version, and as I said it can't
be a stable one.

...

> > But for sure you missed

> >   types.h
> >
> Ack in next. But for types.h, i2c.h already include device.h.
> And device.h already include types.h.
> Is it still needed to declare explicitly for types.h??

Yes. You have to include all headers you are a direct user of, except
the ones that are guaranteed to be included by others. The types.h is
not guaranteed to be included by listed above.

...

> > > +       struct device *dev;
> > > +       struct regmap *regmap;
> >
> > Swapping these two might give less code in the generated binary. Have
> > you run bloat-o-meter?
> >
> I never know about this tool.
> I'll check it before I submit the next revision.
> Thanks for the reminding.
>
> But from Jonathan's reply, I may remove 'struct regmap *regmap'.
> If all function need the 'regmap', a local variable 'regmap' need to
> be declared.
> To use struct regmap *regmap =3D dev_get_regmap(dev, NULL) is more effect=
ive.

It's fine, but you may experiment with bloat-o-meter even in that case
out of curiosity.

--=20
With Best Regards,
Andy Shevchenko

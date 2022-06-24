Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2284F558F31
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 05:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbiFXDjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 23:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiFXDjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 23:39:19 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4D26382;
        Thu, 23 Jun 2022 20:39:18 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id j15so658737vkp.5;
        Thu, 23 Jun 2022 20:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1YM6At45nsxzP3H92QjFXsLn4kYFXKkIt+32oCz0R3Q=;
        b=Yz57J1I9Hc/qEFi7MqNq+W3QBun/g5+K6qIlvKniW4xvveiBXYy3I/gL45kwNgBs4t
         0yzp/EAnWtlt8ehnmEBDGFXmRPAkGJYtGqflCYi/ZIf0F+jXou6ijRUpnR0ooCtXN/tL
         nWejgz80BmEGFOtofaQvgtl+4IGdaZfnTOd/81lZVtH0X2n5Uo1+Oh9HUo+R0mXbXPPI
         37fLSi5PhCEKz5IhqHUfhpARPmGnzmQXB3wM7c0GOCmDxMWyaWz4jBziHr28eznoZKKy
         U8fzg8N9Zy0Jbz8FTksT74YQyqwpZDwBUlY30Da3tr01HVsl66TgQi7DdiKkV0cNjEIJ
         x1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1YM6At45nsxzP3H92QjFXsLn4kYFXKkIt+32oCz0R3Q=;
        b=utNucYsN4isS8w4II/v7KXxHwdUc3jLYZgWpo3LJBZHEBJLtMSkEvAUulN+qc+kwTZ
         j0pJGENeONkVL4REbJ6jTREsvNCr24o7y5SGE5RjVjRpBSwRHddxqoQe7sbQ13xZs1Sx
         VEnoV6BufkmO65fdguYc45GBlSI41YnasRpn9R842Hvs2+d9mzu5H0tLGvNPAt6h/q3Q
         X7uc8No/qYXsQEk9NoAU28cbgLBwqDDZsuCKP/+aCo7lJ38hdHLGz3ZU3mnfaWjxJK6Z
         GqDLypyKQoeIVe1e+I5p9Cs65yDmqDJmUN3JGdBOmJkq6WSHOAl0eA2Icy6xwKh9660z
         OwKw==
X-Gm-Message-State: AJIora/RAiYJEncoC/4Pm/xIqONCyxuRIwKOwICBy/jNQqhHhziawLgv
        Z/XtK1bjgsRnnl3trg8zXRLLSOHuJllJ21hPE+I=
X-Google-Smtp-Source: AGRyM1vEm8ISHtFwwJrzu6NGlZajnuGMiYLI+V6TR4IxyGImHB3OZOSO5J/tFHXQDFjACX2+upR6suqbjNzHYrsGUsc=
X-Received: by 2002:a1f:d4c5:0:b0:368:a100:4b9a with SMTP id
 l188-20020a1fd4c5000000b00368a1004b9amr19725345vkg.27.1656041957272; Thu, 23
 Jun 2022 20:39:17 -0700 (PDT)
MIME-Version: 1.0
References: <1655458375-30478-1-git-send-email-u0084500@gmail.com>
 <1655458375-30478-3-git-send-email-u0084500@gmail.com> <CAHp75VfEQ6tu4-NQKwA+63Ae5busUwV+ZRqD6BtbUA+EkCZnWw@mail.gmail.com>
 <CADiBU3-wO0-0c9y-GpE15ra2AqkAG-ftqTh+hCvYEY-TojZ-pg@mail.gmail.com> <CAHp75VeBdgbyDQXEYb9ZZdi3AU=vPw6aKGWbNLnuA_QoN4LE4A@mail.gmail.com>
In-Reply-To: <CAHp75VeBdgbyDQXEYb9ZZdi3AU=vPw6aKGWbNLnuA_QoN4LE4A@mail.gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Fri, 24 Jun 2022 11:39:06 +0800
Message-ID: <CADiBU3_jgoc9ZuVuVH_cvSeQkghOeUDxzLE_VZFtZ9eaTWeqgA@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: Add rtq6056 support
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

Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2022=E5=B9=B46=E6=9C=
=8819=E6=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8B=E5=8D=886:38=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Sat, Jun 18, 2022 at 5:16 PM ChiYuan Huang <u0084500@gmail.com> wrote:
> > Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2022=E5=B9=B46=E6=
=9C=8818=E6=97=A5 =E9=80=B1=E5=85=AD =E5=87=8C=E6=99=A81:08=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > > On Fri, Jun 17, 2022 at 11:37 AM cy_huang <u0084500@gmail.com> wrote:
>
> ...
>
> > > > +KernelVersion: 5.18.2
> > >
> > > Wrong version, this won't be part of a stable kernel.
> > >
> > From kernel.org, currently the stable kernel version is 5.18.5.
> > Change to 5.18.5?
>
> Nope. You need to use realistic kernel version, and as I said it can't
> be a stable one.
>
> ...
>
> > > But for sure you missed
>
> > >   types.h
> > >
> > Ack in next. But for types.h, i2c.h already include device.h.
> > And device.h already include types.h.
> > Is it still needed to declare explicitly for types.h??
>
> Yes. You have to include all headers you are a direct user of, except
> the ones that are guaranteed to be included by others. The types.h is
> not guaranteed to be included by listed above.
>
> ...
>
> > > > +       struct device *dev;
> > > > +       struct regmap *regmap;
> > >
> > > Swapping these two might give less code in the generated binary. Have
> > > you run bloat-o-meter?
> > >
> > I never know about this tool.
> > I'll check it before I submit the next revision.
> > Thanks for the reminding.
> >
> > But from Jonathan's reply, I may remove 'struct regmap *regmap'.
> > If all function need the 'regmap', a local variable 'regmap' need to
> > be declared.
> > To use struct regmap *regmap =3D dev_get_regmap(dev, NULL) is more effe=
ctive.
>
> It's fine, but you may experiment with bloat-o-meter even in that case
> out of curiosity.
>
I tred to only swap these two line for *dev and *regmap.
Check the below two cases
1. bloat-o-meter with rtq6056 as the builtin
add/remove: 0/0 grow/shrink: 0/0 up/down: 0/0 (0)
Function                                     old     new   delta
Total: Before=3D24428680, After=3D24428680, chg +0.00%
2. size tool with rtq6056 as the kernel build
   text    data     bss     dec     hex filename
   5261    1155       0    6416    1910 drivers/iio/adc/rtq6056-adc.ko.old
   text    data     bss     dec     hex filename
   5261    1155       0    6416    1910 drivers/iio/adc/rtq6056-adc.ko

It's weird that there's no difference.

Do I misunderstand something?

> --
> With Best Regards,
> Andy Shevchenko

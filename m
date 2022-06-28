Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6817155DE00
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344692AbiF1LsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344482AbiF1Lrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:47:53 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC310B0F;
        Tue, 28 Jun 2022 04:47:52 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-31780ad7535so113920627b3.8;
        Tue, 28 Jun 2022 04:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bBnFmZjZIoNFqqriC+iwFPBKJU61baPmyAFFIDagDFE=;
        b=S5ySAPM3rocgZ/Ugszd1CJjXHRh/k51KEH6B+k1RaIub/lWTQSBPNs58VeCF0R88K1
         tYGbwPBeKSKFou3r31LBzjOr3wFpuCiggyWWhCwjRvdX1zA9uSKSLMLVEtsdah3CUMCw
         V3qB56dC/4DTnToVxBehqbA/CYk/XiuI7E//GHJlFiaGTWwhkLaUePbr8AbbM5WRhPmk
         UJettY4vD6qoFbFMxlVATsEKXF55MR/u/bfsaAGQfl8zDJpE3ntCAk/t4NfdCamsUT1z
         1IUj/p3F6T1awGq9UIJrZMhJW9JEDZ72Tpue7pLvnxGjWoJJ+/rFoFuFlByJrMK2kWVZ
         0/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bBnFmZjZIoNFqqriC+iwFPBKJU61baPmyAFFIDagDFE=;
        b=kXl3wB7VtGpc69cgCcjx4Kev6L0Cm0SQzH8BnzV+PzuWV0qp5DHlZiNgmF+nzivBqN
         Su50n/VBp3UHPjxMaI9tj+1OuP0ln9zv/M+g+3YHtO5EE/i7Mz/E7tcLV2vs1L4v8+2c
         WEDsVuk9pbt6ynZOCsiYzo+odA4TfXMlQDonOM8n1SXr+0Mjwvidu5J+4Dlxu30YFhxh
         cKNAchnlDKn6bZgZCqwkYOHbzM4OHa9lGuLRq2LWWQ4XCck/KPHFRDxS2niSduFJSUFL
         Gu+WY8Nt3JmUG9lczvkEdRNV2bmf1B3jbAYfR2LBfZw1gs6mOP1TpYzqtcVWlYymUc8I
         4rqQ==
X-Gm-Message-State: AJIora/a1V54jHEVZqoQHcl+ZQmQqrNHF8FqUgK4WnJmWY9bZSrvcgPN
        yCyiqR2O6ak/K/jha/K/aEnrLhfMcv/BIi3Xzx+UEJdX8PiCjg==
X-Google-Smtp-Source: AGRyM1sI77zIPf/cv6+E7ghaqhb46auVskCT8U9VnPQcDZuNWFZhpI/LTOpehqZbUIHMZAMPVhomR3UMPvaQ7nGOgFg=
X-Received: by 2002:a81:2386:0:b0:317:6586:8901 with SMTP id
 j128-20020a812386000000b0031765868901mr20837201ywj.195.1656416872035; Tue, 28
 Jun 2022 04:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <1655458375-30478-1-git-send-email-u0084500@gmail.com>
 <1655458375-30478-3-git-send-email-u0084500@gmail.com> <CAHp75VfEQ6tu4-NQKwA+63Ae5busUwV+ZRqD6BtbUA+EkCZnWw@mail.gmail.com>
 <CADiBU3-wO0-0c9y-GpE15ra2AqkAG-ftqTh+hCvYEY-TojZ-pg@mail.gmail.com>
 <CAHp75VeBdgbyDQXEYb9ZZdi3AU=vPw6aKGWbNLnuA_QoN4LE4A@mail.gmail.com> <CADiBU3_jgoc9ZuVuVH_cvSeQkghOeUDxzLE_VZFtZ9eaTWeqgA@mail.gmail.com>
In-Reply-To: <CADiBU3_jgoc9ZuVuVH_cvSeQkghOeUDxzLE_VZFtZ9eaTWeqgA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Jun 2022 13:47:15 +0200
Message-ID: <CAHp75VejsNhgee0exMGzo3dqFxi8udO2GUbCTz9iNFJ7wZGvRw@mail.gmail.com>
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

On Fri, Jun 24, 2022 at 5:39 AM ChiYuan Huang <u0084500@gmail.com> wrote:
> Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2022=E5=B9=B46=E6=
=9C=8819=E6=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8B=E5=8D=886:38=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > On Sat, Jun 18, 2022 at 5:16 PM ChiYuan Huang <u0084500@gmail.com> wrot=
e:
> > > Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2022=E5=B9=B46=
=E6=9C=8818=E6=97=A5 =E9=80=B1=E5=85=AD =E5=87=8C=E6=99=A81:08=E5=AF=AB=E9=
=81=93=EF=BC=9A
> > > > On Fri, Jun 17, 2022 at 11:37 AM cy_huang <u0084500@gmail.com> wrot=
e:

...

> > > > > +       struct device *dev;
> > > > > +       struct regmap *regmap;
> > > >
> > > > Swapping these two might give less code in the generated binary. Ha=
ve
> > > > you run bloat-o-meter?
> > > >
> > > I never know about this tool.
> > > I'll check it before I submit the next revision.
> > > Thanks for the reminding.
> > >
> > > But from Jonathan's reply, I may remove 'struct regmap *regmap'.
> > > If all function need the 'regmap', a local variable 'regmap' need to
> > > be declared.
> > > To use struct regmap *regmap =3D dev_get_regmap(dev, NULL) is more ef=
fective.
> >
> > It's fine, but you may experiment with bloat-o-meter even in that case
> > out of curiosity.
> >
> I tred to only swap these two line for *dev and *regmap.
> Check the below two cases
> 1. bloat-o-meter with rtq6056 as the builtin
> add/remove: 0/0 grow/shrink: 0/0 up/down: 0/0 (0)
> Function                                     old     new   delta
> Total: Before=3D24428680, After=3D24428680, chg +0.00%
> 2. size tool with rtq6056 as the kernel build
>    text    data     bss     dec     hex filename
>    5261    1155       0    6416    1910 drivers/iio/adc/rtq6056-adc.ko.ol=
d
>    text    data     bss     dec     hex filename
>    5261    1155       0    6416    1910 drivers/iio/adc/rtq6056-adc.ko
>
> It's weird that there's no difference.
>
> Do I misunderstand something?

Nope, it means that in _current_ code this makes no change. Feel free
to go with your variant if you prefer.

--=20
With Best Regards,
Andy Shevchenko

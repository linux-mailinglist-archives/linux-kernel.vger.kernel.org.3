Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D614754F40B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 11:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbiFQJPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 05:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiFQJPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 05:15:42 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56DF49B43;
        Fri, 17 Jun 2022 02:15:40 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id m16so1083854ilf.6;
        Fri, 17 Jun 2022 02:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Rwjg/1YINzqxKrc7KAD/i4G4OnLWc8a5sJgC2L1EvV8=;
        b=T7RlZkRmUrk1uPWymyVaIYEm2USnc/kiRpW1DN7Cx2fgKOPadbLJ9hDWp330pVll0b
         nVbSUAeOw0ind5aX2DvD+qJ8edzVQwQd3vVZJpL8lsPgf97MamIi1jYUacpEmf4yt4Nv
         8RRQrqnZlA+v/EIUq3IJoumZPhS6kWTzFZg2DF9GNU3fnbSMCbrE+BajwsAUMooWjcpt
         9mPv6dhXPsyKfQqvI+pMgreCD1G0ZEiRwMHTufp3vlcXKkuxk6+kqTFh4zOAP+G5b4Na
         EpWtKBRqGJyZrmKT1ZeI3lx3hOwvQwReCYUJPQvQLh44wdub2G8emdWusMIolDoHXPjN
         eScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Rwjg/1YINzqxKrc7KAD/i4G4OnLWc8a5sJgC2L1EvV8=;
        b=DFHz0V+njVCqn++GopoXSIjoI4VxbsFEh5/4qwEMCZEjBVNJ3Lhb5v+URmiwVFpBma
         vemd/YAALBb9kpSqZkEwYlX7hvPtRUtbBftO7csKdaA3RyJ0/KaY2+Cxq6UMfMhw2OxZ
         A95a0trAzOOmnlbWLoSfmb7WYdcECw4XUwSGsDsUpQlP8P11cmYBYu5O9DFgAY//IHAu
         HZ2hgNQAf2TALwCldHR4gmotfZuyYkkXNCwUdsPQJzW6Q8LB8YZI3buD7qr+4FD4D/2E
         yAJOwAqpXvIh3cBM0S9r4OEzs/bozxHNBfqo9dxll8YNQB5V4NQaT9ILHDgCTstI5Qdb
         2rng==
X-Gm-Message-State: AJIora8h7SYXV93x2WHwrMmf0EHB+j+Pofg9wYBD61Fq7WtsKoka7why
        nzqUJCiC6hzMdTqVF3B3ZT03yu6Ah7zcmrExi9A=
X-Google-Smtp-Source: AGRyM1ulXgBKYwRX4sDQBTJgY1sJ1HQy/qNt3KPa2+zyrl3Y4yDe7BzlO+x/VaU+eUVa36+znFzZdfjPq6R82D89JK0=
X-Received: by 2002:a05:6e02:144f:b0:2d1:90c9:9047 with SMTP id
 p15-20020a056e02144f00b002d190c99047mr5212028ilo.211.1655457340207; Fri, 17
 Jun 2022 02:15:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220613111146.25221-1-peterwu.pub@gmail.com> <20220613111146.25221-12-peterwu.pub@gmail.com>
 <915871e4-b156-ab19-043f-b719e03a5711@infradead.org>
In-Reply-To: <915871e4-b156-ab19-043f-b719e03a5711@infradead.org>
From:   ChiaEn Wu <peterwu.pub@gmail.com>
Date:   Fri, 17 Jun 2022 17:15:29 +0800
Message-ID: <CABtFH5JyESUuMkDuRSKdc7pf5M4Zah2eZ_LG1RMbMVYxYkcBxA@mail.gmail.com>
Subject: Re: [PATCH v2 11/15] iio: adc: mt6370: Add Mediatek MT6370 support
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     jic23@kernel.org, lars@metafoo.de, matthias.bgg@gmail.com,
        lee.jones@linaro.org, Daniel Thompson <daniel.thompson@linaro.org>,
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

Hi Randy,

Thanks for your comment!
I apologize for any inconvenience caused when you decoded this help text.
I will refine this in the next patch, thanks!

Randy Dunlap <rdunlap@infradead.org> =E6=96=BC 2022=E5=B9=B46=E6=9C=8814=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E5=87=8C=E6=99=A84:17=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi,
>
> On 6/13/22 04:11, ChiaEn Wu wrote:
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index 71ab0a06aa82..09576fb478ad 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -737,6 +737,15 @@ config MEDIATEK_MT6360_ADC
> >         is used in smartphones and tablets and supports a 11 channel
> >         general purpose ADC.
> >
> > +config MEDIATEK_MT6370_ADC
> > +     tristate "Mediatek MT6370 ADC driver"
> > +     depends on MFD_MT6370
> > +     help
> > +       Say Y here to enable MT6370 ADC support.
> > +
> > +       Integrated for System Monitoring includes is used in smartphone=
s
>
> Please try again on the help text. I can't decode that.
>
> > +       and tablets and supports a 9 channel general purpose ADC.
>
> --
> ~Randy

Best Regards,
ChiaEn Wu

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BE2559411
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 09:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbiFXHUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 03:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiFXHUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 03:20:38 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5A8699A2;
        Fri, 24 Jun 2022 00:20:36 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id p128so1882527iof.1;
        Fri, 24 Jun 2022 00:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T3cWuiVsBA+DxTai60AWhDn/fRpeEo8zydPZYQwQBPs=;
        b=INkRDWkgz7QnDYd6PfjGcOd+HtbGBuFAFVtHSry5oK+uSexxmKolSWc9+ahE6Bsyiy
         zARECUtXVj9Yxu3ivS1I4Ikbz9sEucWs/6ZUfMDlGUc1ip2twYgPIYULdbUypI86mIzl
         mgKyYU2J5DhoBlb4HK7R3TEsu+SHK4XuGA+Sy+iylrc+8UWz0NCSlrofWvh89/4vykAo
         bPzchCxSebnIj7stqgMYl19bvM4RMlQ20oNFDZeXuyIbbF87V3BWpZnr0GOf16WkU7KM
         cHqCSrIR2+2R/9pWLaP9povhX5tYXh1/3O3+jKfQ8vWGEl2U54uG0vtizyP5hjPfZERr
         EwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T3cWuiVsBA+DxTai60AWhDn/fRpeEo8zydPZYQwQBPs=;
        b=PUQPnzoab6PVDrgc+lUwRF7nzj12ZsET4o4HNxJ4aoHLlFXTJa8bUc4GmjDGeMh06w
         asVaN2SVLitQFZfW8ercp7M1C5wUdnk7Hn3kM0eb2gna64/n/c+KvxBfT494rUjmTLRa
         mAiO+iJ6A2T+xcXeTvw0HJbFfs+z3cMLAIDVPLvmsb2uaKcJEY7gYNrXsMEOkq5lPoeM
         gZdmSo2S6DByXItlV/faW4kF75PcpWAnw1/UJxmmFV7AVLwTsk5XaFifwvD+Kjzhz+6X
         gGzVxw8EH/gh4infM8tk7K2zsHh1aEZFRKCAnYbJbnU0HzRTPjGk1/RhqgR2qVDf/b2J
         bl/g==
X-Gm-Message-State: AJIora9LVvhhECElQwaQQXuq9Eo+Y7t4BK1mnes85pTxvGNnLE7LnrJK
        aHo+mL5N4Jr9mjNaKd3L1G7CRZ8OjwNuEFyaA4I=
X-Google-Smtp-Source: AGRyM1v7K77xAmtUTEcEzoILdxRbEp2wv1joH1sI9ISqx+ur3eoSMLzrP7D8toJkzHB0bsYtmy7vVz+n8Z+nifA3RX0=
X-Received: by 2002:a05:6638:430e:b0:332:586:5182 with SMTP id
 bt14-20020a056638430e00b0033205865182mr7357424jab.225.1656055236048; Fri, 24
 Jun 2022 00:20:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220623115631.22209-1-peterwu.pub@gmail.com> <20220623115631.22209-13-peterwu.pub@gmail.com>
 <CACRpkdZatfOFmeGXepTrjAk1or4W6KNUEaXnP+srRebfM=52AA@mail.gmail.com> <CACRpkdbzZqerE_2PeGMUWRbtjK=9P8V763cj83ZqjP4n6AVHAg@mail.gmail.com>
In-Reply-To: <CACRpkdbzZqerE_2PeGMUWRbtjK=9P8V763cj83ZqjP4n6AVHAg@mail.gmail.com>
From:   szuni chen <szunichen@gmail.com>
Date:   Fri, 24 Jun 2022 15:20:24 +0800
Message-ID: <CA+hk2fZEG0TxMGhGJY21w=MmXgKsH5mYCYynQV1jbhpOCyf3qg@mail.gmail.com>
Subject: Re: [PATCH v3 12/14] leds: mt6370: Add Mediatek MT6370 current sink
 type LED Indicator support
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     ChiaEn Wu <peterwu.pub@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Helge Deller <deller@gmx.de>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        alice_chen@richtek.com, Linux PM <linux-pm@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        ChiYuan Huang <cy_huang@richtek.com>, chiaen_wu@richtek.com,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
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

Hi Linus,

Thank you for the comment.

Linus Walleij <linus.walleij@linaro.org> =E6=96=BC 2022=E5=B9=B46=E6=9C=882=
4=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=882:25=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On Fri, Jun 24, 2022 at 8:23 AM Linus Walleij <linus.walleij@linaro.org> =
wrote:
> > Thanks for your patch!
> >
> > On Thu, Jun 23, 2022 at 1:58 PM ChiaEn Wu <peterwu.pub@gmail.com> wrote=
:
> >
> > > From: ChiYuan Huang <cy_huang@richtek.com>
> > >
> > > Add Mediatek MT6370 current sink type LED Indicator driver.
> > >
> > > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > (...)
> > >  drivers/leds/Kconfig       |  11 +
> > >  drivers/leds/Makefile      |   1 +
> > >  drivers/leds/leds-mt6370.c | 989 +++++++++++++++++++++++++++++++++++=
++++++++++
> >
> > There is a drivers/leds/flash subdirectory these days, put the driver
> > in that directory instead.
>
> Sorry I'm commenting on the wrong patch.
>
> I meant this one. Move that into drivers/leds/flash
>  drivers/leds/flash/leds-mt6370-flash.c             |  657 ++++++++++++

In next version, I'll use "leds: flash: ......" instead of "leds:
flashlight: ......" in subject.
May I confirm that the driver has already in the drivers/leds/flash,
so I don=E2=80=99t have to move it in next version?


Sincerely,
Alice Chen

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E75957FBF7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbiGYJHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbiGYJHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:07:01 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F4CFD38;
        Mon, 25 Jul 2022 02:06:57 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id r21so7748394qtn.11;
        Mon, 25 Jul 2022 02:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IY0j+H2edk5UsmI6A7sNzAv0qZHfigoVGkZeFtNqZD0=;
        b=OAft5TUYAXK6FHwdudrZ3/ylDTgyd7ApXgH3mCQQrEy/AppLvKLTFrPAuRaeFgFtA7
         It8xo2DsjfOuep3j9cWzIbiJND3QEGySnwIZHLW7+dtLSlt+35HbGtRezBb37b4ET1YA
         T08HOavE/cN4KrCVfDqvDb9AfqV938ASpM6+DesVsCpK+wJIO8i1UyBgvsftmWjtDjOG
         FhD3Z5NBfgipr391g2noPdoBVxJJl+Zl02FqMF/RSg8CvI8FVka2TxagkUfxCYyIA8lN
         BEkxNh5JboG7/J/TGmZM68ALnFQGOS8vaYU/EgWzrbg9AQ2GE7pMqCpLXdsGFwSSNDLe
         gkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IY0j+H2edk5UsmI6A7sNzAv0qZHfigoVGkZeFtNqZD0=;
        b=CuO4WS9fHj7VN8m6j+pML9Pkk2VxzX1EGGfV5AocQGxASyIkm+oDI6cGGjpxYQS1wj
         MgoBaBcr9TVQTlvZ6+rCGOCqHFR0n+lJvCkF6QZ7Dft8q5jdkNB8CTBKj/ZPEbam45uH
         yVnWSetf2SQ0/YsgTbZXXGoJfz7UsravSecdNGpgTW3CGWiOHp6wkz1Qss92rSrZxDgu
         uUUZ3MOUicf/gytf6qRqm0ysv2WysQ0iPlDd+r7VxU6jMjd5cLHPiNXs4+sVtVr7+nwl
         7L3DfNLmI+M93bhCzR9cVq49SiMCCZNieYFIgdiw/bKTeBBCxg50E33kATDcfqNKS4Dm
         bckw==
X-Gm-Message-State: AJIora8XD7u4mPqVqKVejm2eiq4pZClJi5Nkh22yITWTxd7QCmXwsBcY
        FMBc65rlcVCecyHA7xj6lcOa+fOSthViakHrjQw=
X-Google-Smtp-Source: AGRyM1tJSXMumghoATC65twYRnzaQxdiBNYaldY1M9f4DosemyPp1f+IvX7cbVFcEYtBJ2DRVha2cAhiDgReWJ+n9ic=
X-Received: by 2002:ac8:5d49:0:b0:31f:aa:e632 with SMTP id g9-20020ac85d49000000b0031f00aae632mr9318617qtx.427.1658740016501;
 Mon, 25 Jul 2022 02:06:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220722102407.2205-1-peterwu.pub@gmail.com> <20220722102407.2205-8-peterwu.pub@gmail.com>
 <CAHp75VfiKMROzxeEaCH6qCthK9qanJPqbjADLMVH-V0upKf+9Q@mail.gmail.com>
 <CABtFH5++4N1mECJ0vN-79WsJJWcBTVxLFgvkiouPf1qev7LHHQ@mail.gmail.com> <CAHp75VfKihBLjUFqe_Sj5dqTO7-wjLehAF+9_8-sbUeyJ-ZAmg@mail.gmail.com>
In-Reply-To: <CAHp75VfKihBLjUFqe_Sj5dqTO7-wjLehAF+9_8-sbUeyJ-ZAmg@mail.gmail.com>
From:   ChiaEn Wu <peterwu.pub@gmail.com>
Date:   Mon, 25 Jul 2022 17:06:20 +0800
Message-ID: <CABtFH5+LvvcVscRotyRYXhXs1pPkCahbVe0NcSFxC4k_WMMsuQ@mail.gmail.com>
Subject: Re: [PATCH v6 07/13] mfd: mt6370: Add MediaTek MT6370 support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
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
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Alice Chen <alice_chen@richtek.com>,
        cy_huang <cy_huang@richtek.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        szuni chen <szunichen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 4:43 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> ...
>
> > > > +#define MT6370_REG_DEV_INFO    0x100
> > > > +#define MT6370_REG_CHG_IRQ1    0x1C0
> > > > +#define MT6370_REG_CHG_MASK1   0x1E0
> > > > +
> > > > +#define MT6370_VENID_MASK      GENMASK(7, 4)
> > > > +
> > > > +#define MT6370_NUM_IRQREGS     16
> > > > +#define MT6370_USBC_I2CADDR    0x4E
> > >
> > > > +#define MT6370_REG_ADDRLEN     2
> > > > +#define MT6370_REG_MAXADDR     0x1FF
> > >
> > > These two more logically to have near to other _REG_* definitions above.
> >

...

>
> You lost me. Namespace has a meaning, i.e. grouping items of a kind.
> In your proposal I don't see that. If REG_MAXADDR and REG_ADDRLEN are
> _not_ of the _REG_ kind as per above, why do they have this namespace
> in the first place?

oh... Sorry, I just got the wrong meaning
maybe it should be revised like this, right??
-------------------------------------------------------------------
#define MT6370_REG_DEV_INFO    0x100
#define MT6370_REG_CHG_IRQ1    0x1C0
#define MT6370_REG_CHG_MASK1   0x1E0
#define MT6370_REG_MAXADDR     0x1FF // Move it to here

#define MT6370_VENID_MASK      GENMASK(7, 4)

#define MT6370_NUM_IRQREGS     16
#define MT6370_USBC_I2CADDR    0x4E

#define MT6370_MAX_ADDRLEN     2    // Rename
-------------------------------------------------------------------

Thanks!

-- 
Best Regards,
ChiaEn Wu

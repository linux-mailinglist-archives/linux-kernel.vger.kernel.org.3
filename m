Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5F657FB9E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbiGYInq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233337AbiGYInn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:43:43 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EFD140C4;
        Mon, 25 Jul 2022 01:43:42 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z18so620205edb.10;
        Mon, 25 Jul 2022 01:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gBUjOXPSyxIp/ssA5bMpYCLKWAJ3HGf2reVDfO9yM3o=;
        b=ZcloaGBXNWKgwFGhN0tBCVgGN7mKJ0l57wi/gxiOCcQ3btK6lq9SuR+ZDWopqPFJwr
         QtH+fUQor4bu6z6i3Onr2HRzeQyO9JOs9GcWZvML3s9jvPJQnd/sk2l56CU4eOkmNXQj
         LqLK8afv+vA1SA6f+pxw6kwJwYDOpRk9RKfUzqG3YfKkkTmnHl6JN0Bgs4bLgrYJH4/G
         DwVst0E8Wq+wDqCv4Rf6WiAWX6k8ZbwXfY2/046oEtgbBla5lc4gNBqV8JGbD5c944lY
         EL1jChoaIjqEM9Bwbv2uv0Do0n4Vre3jmkyldcj0zTNhXTJcj/3JcVpHUBK+rQNRfl5E
         JX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gBUjOXPSyxIp/ssA5bMpYCLKWAJ3HGf2reVDfO9yM3o=;
        b=WF8HjDlbWM9SQ/1RTZrtsH6LlgLJGTGksTCYgNwJ2ITU7nO38Iszi4G6Bs1tv6Bpak
         1O1pyZuKXoovZKbMMVE87o9UpCNjtR0SN1pAQXM2uobFqaa6cV3RcfuNSHNElH7Bt1J5
         fRpp2yFuJ3jWc0uQQceptnG55IsC7lhLBytAk6Y3uT3NGMeF+4Trty1rNtyUcu+6KsSj
         Oc1klU/bJ3GZ2kZsWgS2K+QKpyJrwaDGDHW8NO300wnOk0x7Evb3i4lOKZacgSrgRXoX
         RHbS5f/4uDBkgUK2IrqlbLnisADIIgCvrVtkDE6Eel2zrqAsz/INaga/ec6reAisSGPw
         xpHw==
X-Gm-Message-State: AJIora8EWIaOeFopPOZFhx62Gi75ilx8OK2jLyURKPffWc8Qeuyn5lap
        MslqwBOIWchlALV5FwUUgmO+MbKmQudHFw4YPsM=
X-Google-Smtp-Source: AGRyM1soQCq75MmbI4ONQXkzNoXoyDLrEe84HYxRimv6nF0nPZqyoEzx4IbLZDEZCEsYL6EGcqoDhOkMKbKf9dD+JE4=
X-Received: by 2002:a05:6402:254b:b0:43b:d6c3:dd96 with SMTP id
 l11-20020a056402254b00b0043bd6c3dd96mr11626028edb.406.1658738620885; Mon, 25
 Jul 2022 01:43:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220722102407.2205-1-peterwu.pub@gmail.com> <20220722102407.2205-8-peterwu.pub@gmail.com>
 <CAHp75VfiKMROzxeEaCH6qCthK9qanJPqbjADLMVH-V0upKf+9Q@mail.gmail.com> <CABtFH5++4N1mECJ0vN-79WsJJWcBTVxLFgvkiouPf1qev7LHHQ@mail.gmail.com>
In-Reply-To: <CABtFH5++4N1mECJ0vN-79WsJJWcBTVxLFgvkiouPf1qev7LHHQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Jul 2022 10:43:04 +0200
Message-ID: <CAHp75VfKihBLjUFqe_Sj5dqTO7-wjLehAF+9_8-sbUeyJ-ZAmg@mail.gmail.com>
Subject: Re: [PATCH v6 07/13] mfd: mt6370: Add MediaTek MT6370 support
To:     ChiaEn Wu <peterwu.pub@gmail.com>
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

On Mon, Jul 25, 2022 at 10:30 AM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
> On Mon, Jul 25, 2022 at 4:00 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:

...

> > > +#define MT6370_REG_DEV_INFO    0x100
> > > +#define MT6370_REG_CHG_IRQ1    0x1C0
> > > +#define MT6370_REG_CHG_MASK1   0x1E0
> > > +
> > > +#define MT6370_VENID_MASK      GENMASK(7, 4)
> > > +
> > > +#define MT6370_NUM_IRQREGS     16
> > > +#define MT6370_USBC_I2CADDR    0x4E
> >
> > > +#define MT6370_REG_ADDRLEN     2
> > > +#define MT6370_REG_MAXADDR     0x1FF
> >
> > These two more logically to have near to other _REG_* definitions above.
>
> Hi Andy,
> Thanks for your review.
> Do you mean that we should move '#define MT6370_USBC_I2CADDR' and
> '#define MT6370_REG_MAXADDR' after the line '#define
> MT6370_REG_CHG_MASK1'?
> -------------------------------------------------------------------
> #define MT6370_REG_DEV_INFO    0x100
> #define MT6370_REG_CHG_IRQ1    0x1C0
> #define MT6370_REG_CHG_MASK1   0x1E0
> #define MT6370_USBC_I2CADDR    0x4E
> #define MT6370_REG_MAXADDR     0x1FF
>
> #define MT6370_VENID_MASK      GENMASK(7, 4)
>
> #define MT6370_NUM_IRQREGS     16
> #define MT6370_REG_ADDRLEN     2
> -------------------------------------------------------------------
> Like this?

You lost me. Namespace has a meaning, i.e. grouping items of a kind.
In your proposal I don't see that. If REG_MAXADDR and REG_ADDRLEN are
_not_ of the _REG_ kind as per above, why do they have this namespace
in the first place?

-- 
With Best Regards,
Andy Shevchenko

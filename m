Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C207E57FB68
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbiGYIbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbiGYIau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:30:50 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A6A6556;
        Mon, 25 Jul 2022 01:30:20 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id n2so8081171qkk.8;
        Mon, 25 Jul 2022 01:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eGTl5W3lU5EPUSxceW+3YfZM8YTmZNPLhO3+yi0Lxxo=;
        b=SchD1OSJhqZUbaDH3npCvBVhvgdsTgcai4JGkAeNGwKszMwOXVv1jP2YUfdpVF00gi
         M7W+LOBWkm3fvR7QR5Oi7Rr243ZKrwIRGyjvM4fEdp3ybWcWAtUz3ifU5jDZ2eCRBBLb
         hVRD5fVGR5o7NHR3kRn8qM+u20mgIRdugneUsK0DRfgczIFrKpOhBB+f9+/lUqaYKRv+
         zCqM+TkCzfpywtt7PK8+F+XO4TuRbG4FDiDPWiwIK0+yYxleqIJNXSwBHMHq6a6DI1r4
         IHORJbjxNq0t+3W70uo7ZSMhJhotvD3N/NslNtJkOTvO+ulZgz6/dODRy4NI0YAEC0V6
         1QjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eGTl5W3lU5EPUSxceW+3YfZM8YTmZNPLhO3+yi0Lxxo=;
        b=DOwl29MfcAr7pGLDLeY/CXUd9wHq14dJzb6ZC3QEzBvAMZYanQyJ40IkjdbZxbgo3u
         TfjapNLDmOhbyRk9hQB1V/Bzg0RMyiJJAvqfkVRKHlEXFMnywTtNZx6IkkAN2hx9kTkA
         7jinPHvENmkw2uMaZG6tLZtHGmgyDHi3PCqOtHm2cg4wPZfY+V/1skHtMJNkRTBi77Nq
         h+m2mN0PhsQ4/7AnPkB4dJ7XIs9E0WC+z87kRppObiWNG3mUEE+9uSjGQyeW82ncWaNb
         Ijq3QCWFf13/96DwvTKRavkeH9zWnNpuSf1CQ/jG1azEfvpBJGpAyOEjpINangIWFazH
         NXkg==
X-Gm-Message-State: AJIora9aI99Ljjb9e5EkFol/ChC8WbCXGp2VPVf/Z5pHpunSby3hOO8A
        pRFQvgkmu/wjFMamGUPLfl4H7EEqtU4Lcl2Sanc=
X-Google-Smtp-Source: AGRyM1tT9zd1NbQQxCDwlfF4CX1SIOVXegpCvtscSaJImwYFwZu4GtSNklBiffb6QTC6/u0h5ukzMhHUITILaRb40TA=
X-Received: by 2002:a05:620a:2942:b0:6b5:e33a:1771 with SMTP id
 n2-20020a05620a294200b006b5e33a1771mr8042028qkp.665.1658737820011; Mon, 25
 Jul 2022 01:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220722102407.2205-1-peterwu.pub@gmail.com> <20220722102407.2205-8-peterwu.pub@gmail.com>
 <CAHp75VfiKMROzxeEaCH6qCthK9qanJPqbjADLMVH-V0upKf+9Q@mail.gmail.com>
In-Reply-To: <CAHp75VfiKMROzxeEaCH6qCthK9qanJPqbjADLMVH-V0upKf+9Q@mail.gmail.com>
From:   ChiaEn Wu <peterwu.pub@gmail.com>
Date:   Mon, 25 Jul 2022 16:29:43 +0800
Message-ID: <CABtFH5++4N1mECJ0vN-79WsJJWcBTVxLFgvkiouPf1qev7LHHQ@mail.gmail.com>
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

On Mon, Jul 25, 2022 at 4:00 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>

...

>
> > +#define MT6370_REG_DEV_INFO    0x100
> > +#define MT6370_REG_CHG_IRQ1    0x1C0
> > +#define MT6370_REG_CHG_MASK1   0x1E0
> > +
> > +#define MT6370_VENID_MASK      GENMASK(7, 4)
> > +
> > +#define MT6370_NUM_IRQREGS     16
> > +#define MT6370_USBC_I2CADDR    0x4E
>
> > +#define MT6370_REG_ADDRLEN     2
> > +#define MT6370_REG_MAXADDR     0x1FF
>
> These two more logically to have near to other _REG_* definitions above.

Hi Andy,
Thanks for your review.
Do you mean that we should move '#define MT6370_USBC_I2CADDR' and
'#define MT6370_REG_MAXADDR' after the line '#define
MT6370_REG_CHG_MASK1'?
-------------------------------------------------------------------
#define MT6370_REG_DEV_INFO    0x100
#define MT6370_REG_CHG_IRQ1    0x1C0
#define MT6370_REG_CHG_MASK1   0x1E0
#define MT6370_USBC_I2CADDR    0x4E
#define MT6370_REG_MAXADDR     0x1FF

#define MT6370_VENID_MASK      GENMASK(7, 4)

#define MT6370_NUM_IRQREGS     16
#define MT6370_REG_ADDRLEN     2
-------------------------------------------------------------------
Like this?

>
> --
> With Best Regards,
> Andy Shevchenko

-- 
Best Regards,
ChiaEn Wu

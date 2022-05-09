Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198E552054F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 21:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240592AbiEITa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 15:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240567AbiEITaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 15:30:24 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4B0CC4;
        Mon,  9 May 2022 12:26:29 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2f7b815ac06so156333137b3.3;
        Mon, 09 May 2022 12:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cwT8TRwwzgeB1cCXJc6QViy1iG1+RNFet3Yocv4TFEE=;
        b=F3/Td3pGGIimKtAVPNXBwC109dTcvYtqE1fTsRdyd+2qp+6+ecgYzaDmb+avXzJgSl
         CRg994ex340NoIq4vBGKOtrKl4WJ2U5BbS0dwx5Mk2VcqQE9iizZ7oeNT/x48oTlwJbT
         4mwwoWr1bgdoHqSsUAav6EbjdLm/pMOhGarUbdmxb6tHSzETMXmR29JpVu2oRrwNH2ou
         UuutntjcfBEji2KxMnk6eW8Olx1yfQFPvHr13zx8YOucMnG3mjgC5sP67f8PgtpkF7op
         vnPMUOgoY3+XvBA7XinwoHuHTJq9K4upFI/qYVvLjw2F6VTJnrsDPXIJLYhy9kBHMV9l
         YruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cwT8TRwwzgeB1cCXJc6QViy1iG1+RNFet3Yocv4TFEE=;
        b=BUMWr7IIm2cQ7CXgkWSAlYmdJI4SIbPyye4lxK5kDiQmpFVJjygOwXMeQgrq63vf2g
         BCNY/+Y2Gv0WVdWAy4EqG6iMUjfLawPx+YkZjl0VEv36/Ec3lfs3KuVkEYbHEZJtOcaH
         ckcipHyreaA64Mt6sC1cmR9FUa2qoJZZQmX6kqYJu2ldcoOpoYMJPw+ugjJKls6QfUT3
         vMkjP6xsGfZmTj8fzS2zViUb8iVDAIKHKzaynzFhgCjuXXePtp7xTekb24lWzjCS2mbu
         cKpkPImzyjYQdaAQPFQOdT1lxwg0wPxMV/oRAeSPhyNLBlXMim0E8BJKa9cAJM+ToJgC
         YzRw==
X-Gm-Message-State: AOAM531PYjNcJy/McwIv8KgQz/OlssmhakW3qMucgaWIKGcJHEsMoKzH
        A4faW/fAsHgiw4XHn3ClfoAdwDngawtoDqR/yeU=
X-Google-Smtp-Source: ABdhPJwxE3KV0SiZFumxrvBU0FNmwjoLKE6kPa3NaQiLUdRZLafHYGC7kaJ7AhPuZ5xb9a/k7NPmgkmkqnP7Gw2Ikhs=
X-Received: by 2002:a0d:dd16:0:b0:2f4:dc1e:e0d8 with SMTP id
 g22-20020a0ddd16000000b002f4dc1ee0d8mr16180775ywe.413.1652124388856; Mon, 09
 May 2022 12:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220509050953.11005-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220509050953.11005-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB59228AE4AF4EE53C382E8BA986C69@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8syBvN7czRA7tq0TJSmUcBzmgjLrFmizHD6Ycp5kLXJWw@mail.gmail.com> <OS0PR01MB5922AFCAFF0F2BAA57E7A88486C69@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922AFCAFF0F2BAA57E7A88486C69@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 9 May 2022 20:26:02 +0100
Message-ID: <CA+V-a8sHOsXkCA59S-HNruSNRwivSG7rcKbPkmQgBtMYgF_Wzw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain to
 handle GPIO interrupt
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Biju,

On Mon, May 9, 2022 at 9:01 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
>
> Hi Prabhakar,
>
> > Subject: Re: [PATCH v2 5/5] pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain
> > to handle GPIO interrupt
> >
> > Hi Biju,
> >
> > Thank you for the review.
> >
> > On Mon, May 9, 2022 at 7:49 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > >
> > > Hi Prabhakar,
> > >
> > > Thanks for the patch.
> > >
> > > > Subject: [PATCH v2 5/5] pinctrl: renesas: pinctrl-rzg2l: Add IRQ
> > > > domain to handle GPIO interrupt
> > > >
> > > > Add IRQ domian to RZ/G2L pinctrl driver to handle GPIO interrupt.
> > > >
> > > > GPIO0-GPIO122 pins can be used as IRQ lines but only 32 pins can be
> > > > used as IRQ lines at given time. Selection of pins as IRQ lines is
> > > > handled by IA55 (which is the IRQC block) which sits in between the
> > GPIO and GIC.
> > > >
> > > > Signed-off-by: Lad Prabhakar
> > > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > ---
> > > >  drivers/pinctrl/renesas/pinctrl-rzg2l.c | 205
> > > > ++++++++++++++++++++++++
> > > >  1 file changed, 205 insertions(+)
> > > >
> > > > diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > > > b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > > > index a48cac55152c..275dfec74329 100644
> > > > --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > > > +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > > > @@ -9,8 +9,10 @@
> > > >  #include <linux/clk.h>
> > > >  #include <linux/gpio/driver.h>
> > > >  #include <linux/io.h>
> > > > +#include <linux/interrupt.h>
> > > >  #include <linux/module.h>
> > > >  #include <linux/of_device.h>
> > > > +#include <linux/of_irq.h>
> > > >  #include <linux/pinctrl/pinconf-generic.h>  #include
> > > > <linux/pinctrl/pinconf.h>  #include <linux/pinctrl/pinctrl.h> @@
> > > > -89,6
> > > > +91,7 @@
> > > >  #define PIN(n)                       (0x0800 + 0x10 + (n))
> > > >  #define IOLH(n)                      (0x1000 + (n) * 8)
> > > >  #define IEN(n)                       (0x1800 + (n) * 8)
> > > > +#define ISEL(n)                      (0x2c80 + (n) * 8)
> > > >  #define PWPR                 (0x3014)
> > > >  #define SD_CH(n)             (0x3000 + (n) * 4)
> > > >  #define QSPI                 (0x3008)
> > > > @@ -112,6 +115,10 @@
> > > >  #define RZG2L_PIN_ID_TO_PORT_OFFSET(id)      (RZG2L_PIN_ID_TO_PORT(id)
> > +
> > > > 0x10)
> > > >  #define RZG2L_PIN_ID_TO_PIN(id)              ((id) %
> > RZG2L_PINS_PER_PORT)
> > > >
> > > > +#define RZG2L_TINT_MAX_INTERRUPT     32
> > > > +#define RZG2L_TINT_IRQ_START_INDEX   9
> > > > +#define RZG2L_PACK_HWIRQ(t, i)               (((t) << 16) | (i))
> > > > +
> > > >  struct rzg2l_dedicated_configs {
> > > >       const char *name;
> > > >       u32 config;
> > > > @@ -137,6 +144,9 @@ struct rzg2l_pinctrl {
> > > >
> > > >       struct gpio_chip                gpio_chip;
> > > >       struct pinctrl_gpio_range       gpio_range;
> > > > +     DECLARE_BITMAP(tint_slot, RZG2L_TINT_MAX_INTERRUPT);
> > > > +     spinlock_t                      bitmap_lock;
> > > > +     unsigned int                    hwirq[RZG2L_TINT_MAX_INTERRUPT];
> > > >
> > > >       spinlock_t                      lock;
> > > >  };
> > > > @@ -883,6 +893,8 @@ static int rzg2l_gpio_get(struct gpio_chip
> > > > *chip, unsigned int offset)
> > > >
> > > >  static void rzg2l_gpio_free(struct gpio_chip *chip, unsigned int
> > > > offset) {
> > > > +     unsigned int virq;
> > > > +
> > > >       pinctrl_gpio_free(chip->base + offset);
> > > >
> > > >       /*
> > > > @@ -890,6 +902,10 @@ static void rzg2l_gpio_free(struct gpio_chip
> > > > *chip, unsigned int offset)
> > > >        * drive the GPIO pin as an output.
> > > >        */
> > > >       rzg2l_gpio_direction_input(chip, offset);
> > > > +
> > > > +     virq = irq_find_mapping(chip->irq.domain, offset);
> > > > +     if (virq)
> > > > +             irq_dispose_mapping(virq);
> > > >  }
> > > >
> > > >  static const char * const rzg2l_gpio_names[] = { @@ -1104,14
> > > > +1120,193 @@ static struct {
> > > >       }
> > > >  };
> > > >
> > > > +static int rzg2l_gpio_get_gpioint(unsigned int virq) {
> > > > +     unsigned int gpioint = 0;
> > > > +     unsigned int i = 0;
> > > > +     u32 port, bit;
> > > > +
> > > > +     port = virq / 8;
> > > > +     bit = virq % 8;
> > > > +
> > > > +     if (port >= ARRAY_SIZE(rzg2l_gpio_configs))
> > > > +             return -EINVAL;
> > > > +
> > > > +     for (i = 0; i < port; i++)
> > > > +             gpioint +=
> > > > + RZG2L_GPIO_PORT_GET_PINCNT(rzg2l_gpio_configs[i]);
> > > > +
> > > > +     if (bit >= RZG2L_GPIO_PORT_GET_PINCNT(rzg2l_gpio_configs[i]))
> > > > +             return -EINVAL;
> > >
> > > May be combine this statement to above with
> > >
> > > || (bit >= RZG2L_GPIO_PORT_GET_PINCNT(rzg2l_gpio_configs[port]))
> > >                 return -EINVAL;
> > >
> > The reason I have kept it outside the loop is that I'll have to check it
> > only once at the end of the loop instead of repeating the check every time
> > in the loop.
>
> I meant above for loop, so that validation happens before the for loop??
>
> if (port >= ARRAY_SIZE(rzg2l_gpio_configs)) || (bit >= RZG2L_GPIO_PORT_GET_PINCNT(rzg2l_gpio_configs[port]))
>         return -EINVAL;
>
Got that, will update in v3.

Cheers,
Prabhakar

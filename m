Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DABD56BC85
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 17:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238205AbiGHOkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 10:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237057AbiGHOkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 10:40:39 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52D613F0D;
        Fri,  8 Jul 2022 07:40:38 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 136so6347626ybl.5;
        Fri, 08 Jul 2022 07:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xsV11z/G+fL0V6fSs38XlBwYHjiU1oSzp5lHs2Ldqjo=;
        b=Pt56/UPozo/zrgsYm6aWQv6y7Hkf7x9iv2pUXEN+6p216AJCBTv2hmLlBEBFXUzPV+
         DsrVBfx0+eU7bfKcydFMDxzZw8dOYhaQ+DUEQXlJ++S2/vM7Too8Gr0xTfapBk/GHQlc
         JD0Qy/zIGYR2rda347KprW6bJ6CvE+afP+308qehOIwZhaVw+BKDAXNSFndZpTPH/UM/
         XzsYx70CQR35/JkzqvGR7GW3QY228Lq7bZ549rlevgHlmrk6HXcA8TswNr46ngYKLEi4
         i0jX6FK4oPnulGxjdSZkCaZsMK0goqTw1Nyc9eauogNwYFA+q8ErlLAQQ7MXyrWQrRUo
         mg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xsV11z/G+fL0V6fSs38XlBwYHjiU1oSzp5lHs2Ldqjo=;
        b=0Omm/Cfd8/PGQmV7VT0pwM4BogoXNPqFtS251mZC/bimskaHA225EfvZyrxoGZdJJp
         ccUUT+lIl9Ws4NhvheuuqazyfMShmvZq8BXBujeZKaSQdyYXMV9fT3fqRmg0UANkqSVG
         tyCHPMkm/sSrB8WOi/j/KkmDXBHaiVropSz+t4L+uZzPFzTBaOF5wFj+H1iuWe4t7kK3
         1slHgMsFkQqaH7vgO9TXCFs2E2BJdquXoOLocVdX1l4Fr3bzK/D/bVMGS87sWBI7Vjp/
         Yzvy5D3RietKJ6daJhbyhJKkRoiOjDGIMF5Ms4Tv1Gdq7oERSW4rmkKMg9uLufw7X8DM
         kF9A==
X-Gm-Message-State: AJIora89kl1Xs0a08aNlFYbuN9aK6hW96VUZOMWR0WlAlc3zlZc0kXO9
        FE99k3+7jjspMj3oS0IZrcWnTIJf0iJGpNzS6CYkibCsTjA=
X-Google-Smtp-Source: AGRyM1v7ghrVjpvaImxqYSihfNFTM/7K7eIvaG5YQKRkL1WONftHGyD9AqgHPPjJkbVZbbSlivMBMI0gvsGEiFXHDAc=
X-Received: by 2002:a05:6902:c4:b0:64b:4677:331b with SMTP id
 i4-20020a05690200c400b0064b4677331bmr3871251ybs.93.1657291238058; Fri, 08 Jul
 2022 07:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1657216200.git.william.gray@linaro.org> <6be749842a4ad629c8697101f170dc7e425ae082.1657216200.git.william.gray@linaro.org>
In-Reply-To: <6be749842a4ad629c8697101f170dc7e425ae082.1657216200.git.william.gray@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 8 Jul 2022 16:40:01 +0200
Message-ID: <CAHp75VdM7QoBfcsQ-S4OEn2ZLnFH+0HfLY44FcRQC+_cw+UXzg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] gpio: i8255: Introduce the i8255 module
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fred Eckert <Frede@cmslaser.com>,
        John Hentges <jhentges@accesio.com>,
        Jay Dolan <jay.dolan@accesio.com>
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

On Fri, Jul 8, 2022 at 1:16 AM William Breathitt Gray
<william.gray@linaro.org> wrote:
>
> Exposes consumer functions providing support for Intel 8255 Programmable
> Peripheral Interface devices. A CONFIG_GPIO_I8255 Kconfig option is
> introduced; modules wanting access to these functions should select this
> Kconfig option.

Spent much time with these chips in my teenage times :-)

Very good written library, see my comments below.

...

> +#include <linux/compiler_types.h>

Should be simple types.h as you are using u8, etc.

> +#include <linux/err.h>
> +#include <linux/export.h>

> +#include <linux/gpio/i8255.h>

gpio/driver.h ?

And since it belongs to GPIO, I would group them and move after all
other include/* to emphasize the relationship.

Also, why is it in the global header folder? Do you expect some
drivers outside of drivers/gpio/? Maybe we can move after when the
user comes?

> +#include <linux/io.h>
> +#include <linux/module.h>

...

> +#define I8255_CONTROL_PORTCLOWER_DIRECTION BIT(0)
> +#define I8255_CONTROL_PORTCUPPER_DIRECTION BIT(3)

Missed underscore.

...

> +static u8 i8255_direction_mask(const unsigned long offset)
> +{
> +       const unsigned long io_port = offset / 8;
> +       const unsigned long ppi_port = io_port % 3;
> +
> +       switch (ppi_port) {
> +       case I8255_PORTA:
> +               return I8255_CONTROL_PORTA_DIRECTION;
> +       case I8255_PORTB:
> +               return I8255_CONTROL_PORTB_DIRECTION;
> +       case I8255_PORTC:
> +               /* Port C can be configured by nibble */

> +               if (offset % 8 > 3)

I would move it to the local definition block close to offset/8. On
some architectures this may give one assembly instruction for two
variables.

> +                       return I8255_CONTROL_PORTCUPPER_DIRECTION;
> +               return I8255_CONTROL_PORTCLOWER_DIRECTION;
> +       default:
> +               /* Should never reach this path */
> +               return 0;
> +       }
> +}

> +void i8255_direction_input(struct i8255 __iomem *const ppi,
> +                          u8 *const control_state, const unsigned long offset)
> +{
> +       const unsigned long io_port = offset / 8;
> +       const unsigned long group = io_port / 3;
> +
> +       control_state[group] |= I8255_CONTROL_MODE_SET;
> +       control_state[group] |= i8255_direction_mask(offset);
> +
> +       iowrite8(control_state[group], &ppi[group].control);

No I/O serialization? Can this be accessed during interrupt? (It may
be that the code is correct, but please go through it and check with a
question "can this register be accessed during IRQ and if yes, will
the user get the correct / meaningful data?")

> +}
> +EXPORT_SYMBOL_GPL(i8255_direction_input);

Make it with a namespace. Ditto for the rest.

-- 
With Best Regards,
Andy Shevchenko

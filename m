Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC9D5509E1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 12:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbiFSKwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 06:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbiFSKwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 06:52:04 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C805710575;
        Sun, 19 Jun 2022 03:52:03 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id o7so16153686eja.1;
        Sun, 19 Jun 2022 03:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ebd6qW1bmr9UXQKliJw9JMCXnaRgcpZYnpj8vzueGKs=;
        b=XDbkHZRn044zzJnQOw/jpQIuTiBqWAsb7n6Bk0FYupham0OnCZ89dhObPmdRWwEWxd
         FtAmz4TYfqDr36tP/dE2fNcDBqAEij2JVPDLxG8dVkm7gAsqTbM/xzmifxG1KTt8sDuy
         OINMBX4xqBZPpjnjeTK+iVu/Xg9Bn7UvkUhDdWPDgbh5k/q4EXDTDbM8/l4RWc/ULx/1
         bqvlfUtAZ1nih/ZmFgjsKe9NjlheTKtnVymRFlejuivzvOBRBhwVzN0yt3kikL8SYaIh
         Go3c0K5KvKGEz6Bb7xkOqqhdhYBjDxkJHXXNsst8qA5+yt1lImgBMhOnGH05v3H/LpOM
         9eAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ebd6qW1bmr9UXQKliJw9JMCXnaRgcpZYnpj8vzueGKs=;
        b=wBO9+D9Nd2eYreT/wmzaArnIRWBUY2MicSQy2DCyqY4eQcO3CikH69zmnQ5lnvkvub
         W+XuS2bWpaYF4uczF7S9/6r0EqNYW4sxJe2Sbv8mCAEkAOQylA0y4ZnNopFFY8B/kXfN
         fzTCG8WZ8dU1BpjJYohPsNJJy+Vl/dejtwg+8ZnEfOxz7guEz+PSMBjVTw/9wgvT/Cn3
         oUdJOxHNDU/GmUbVQ8Uio3Wd7jpzzumVZ/OKFD0wcJq8xUiMQ4oPXf5vTqz98yt1g/ji
         itlpYaSSHcS5CmU+YhV4z2tKvOMFQHcQPmAitaz026X0kS5BqVxDVNSUQRpL+QtaYBch
         uxgQ==
X-Gm-Message-State: AJIora8RvL+87faGkr3hgCd7DCZt2hm8EgAR3GkAvC4ILnkIuhgdaA9u
        Cxqw30wihxo8Vuf5SbP4CRTSBo4jS6BiKSDDs0s=
X-Google-Smtp-Source: AGRyM1uNsTXG8QbLjgaH2Otr2hEazBEbSS6akba0cYFAJ6VMblAbmj1H7bX0ZGOcPh7DPTHCaO7E0ia/Kz/pISCfI0U=
X-Received: by 2002:a17:906:434f:b0:711:eb76:c320 with SMTP id
 z15-20020a170906434f00b00711eb76c320mr16565501ejm.636.1655635922377; Sun, 19
 Jun 2022 03:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com> <20220618214009.2178567-11-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220618214009.2178567-11-aidanmacdonald.0x0@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 19 Jun 2022 12:51:26 +0200
Message-ID: <CAHp75Vdfc=V8uBBF4m3pDtpjsrhqq06q=5fEBPCOiUmYQdSkGA@mail.gmail.com>
Subject: Re: [PATCH v3 10/16] iio: adc: axp20x_adc: Minor code cleanups
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>, quic_gurus@quicinc.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Michael Walle <michael@walle.cc>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
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

On Sat, Jun 18, 2022 at 11:40 PM Aidan MacDonald
<aidanmacdonald.0x0@gmail.com> wrote:
>
> The code may be clearer if parameters are not re-purposed to hold
> temporary results like register values, so introduce local variables
> as necessary to avoid that. Also, use the common FIELD_PREP macro

FIELD_PREP()

> instead of a hand-rolled version.

...

>  #include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/thermal.h>
> +#include <linux/bitfield.h>

Keep it sorted?

...

> -       val = val ? 1 : 0;
> +       regval = val ? 1 : 0;
>

I think you may drop these two lines (including blank line) and...

>         switch (chan->channel) {
>         case AXP20X_GPIO0_V:
> -               reg = AXP20X_GPIO10_IN_RANGE_GPIO0;
> -               regval = AXP20X_GPIO10_IN_RANGE_GPIO0_VAL(val);
> +               regmask = AXP20X_GPIO10_IN_RANGE_GPIO0;
> +               regval = FIELD_PREP(AXP20X_GPIO10_IN_RANGE_GPIO0, regval);

...use !!val as an argument here...

>                 break;
>
>         case AXP20X_GPIO1_V:
> -               reg = AXP20X_GPIO10_IN_RANGE_GPIO1;
> -               regval = AXP20X_GPIO10_IN_RANGE_GPIO1_VAL(val);
> +               regmask = AXP20X_GPIO10_IN_RANGE_GPIO1;
> +               regval = FIELD_PREP(AXP20X_GPIO10_IN_RANGE_GPIO1, regval);

...and here.

>                 break;
>
>         default:
>                 return -EINVAL;
>         }

-- 
With Best Regards,
Andy Shevchenko

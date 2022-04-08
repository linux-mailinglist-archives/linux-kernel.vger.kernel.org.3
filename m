Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187C34F937F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 13:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbiDHLKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 07:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiDHLKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 07:10:46 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E045D2409F;
        Fri,  8 Apr 2022 04:08:39 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id qh7so16522018ejb.11;
        Fri, 08 Apr 2022 04:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yFWqNjmVQi0EHxqS7hsStGRxXNcYNF67yXJTTekIJwA=;
        b=BWXVsDJA8sM1HrB/8IUJBEVQy0Pd669Y0k24RRlwmwuRaJvm4ggxzr9QmUuU2tEkRP
         MzLV5uSujwRJ7wurZ5MOfO86ikXC23tCew0gikrMnTXXDPLx0j5p5e0hA5+HvfqPxmN1
         Ld9Z9XeqKDEA48uSDdvA1e9fwG+erOUNYOXaEweVl3+PJEU/t714P3oi5MAPauOiJeLi
         BTVKC7J5Bm28ETJR5OdWs+rrbDQNlUEt7Ti7KLMupGtB84EwdWKk/kRtkDidMhEngS+5
         pf0d0g++vqGKfz9xRFv7DrdT36TAWbxVHA6XbIz5hKNfQQD121A75K4DPnpRx65C9IU7
         HI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yFWqNjmVQi0EHxqS7hsStGRxXNcYNF67yXJTTekIJwA=;
        b=t5n4IBz6kspfuMpBwjYceqPinJbFhvt8YDIVIa8q3NzFQg0RdmpwAMj9pz3evLPgRZ
         aGvV2FqM5qcRnJe826pMfX6GkjA7JBdOjRFWVVOmrx1Rx4a3pum1E3wfbjo8EN1f099Y
         RpKS2oCdU8ZUkKQ9kr177gBtZF5Uc614uC8PqQZNUZ4D9DAmoDBNl8f+PutplQRhP50o
         hAc1rWF7BAMkDP7zPLvCHidfpGiRUS9qrSBOyzDKrZWBrAHSgPWOPy0E0dFqcTzB00Cf
         jNvSCwgvc75QOcgaKvLPiAjFJ7Rh3DqwXGZ47H5/7Nov3/SCRKKV7SV7saafsA+UBS6D
         yT7g==
X-Gm-Message-State: AOAM530c6y6Olvb99pfEW6ytkfAAVOhD0/BUpQR1eDZY3TBT1ikEPVSe
        5ZuTkm8fvdAbSO/O0ENm9DSqRcs2sT59TzhfHP8=
X-Google-Smtp-Source: ABdhPJxIt65hCMMjnDby0MKivBZfXYPjvdvfkdTrmTuS0oA+7NgrR4wxLrPS6SZy/qgI6AOFDDmAbf0aZlmntY4aMmQ=
X-Received: by 2002:a17:907:a411:b0:6e1:2084:99d2 with SMTP id
 sg17-20020a170907a41100b006e1208499d2mr926429ejc.639.1649416118227; Fri, 08
 Apr 2022 04:08:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220407101034.13122-1-markuss.broks@gmail.com> <20220407101034.13122-3-markuss.broks@gmail.com>
In-Reply-To: <20220407101034.13122-3-markuss.broks@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 8 Apr 2022 14:04:23 +0300
Message-ID: <CAHp75VeMWLXCz_xf=Px-jRw2Fez1Kma2V80cqmu-Ta-67TWaRA@mail.gmail.com>
Subject: Re: [PATCH 2/2] leds: ktd2692: Make aux-gpios optional
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        phone-devel@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy
        Shevchenko <andy.shevchenko@gmail.com>," 
        <~postmarketos/upstreaming@lists.sr.ht>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
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

On Thu, Apr 7, 2022 at 1:33 PM Markuss Broks <markuss.broks@gmail.com> wrote:
>
> Make the AUX pin optional, since it isn't a core part of functionality,
> and the device is designed to be operational with only one CTRL pin.
>
> Also pick up maintainership for the LED driver and the yaml bindings.

maintenance?

...

> -               gpiod_direction_output(led->aux_gpio, KTD2692_LOW);
> +               if (led->aux_gpio)
> +                       gpiod_direction_output(led->aux_gpio, KTD2692_LOW);

Redundant change.

...

> -               gpiod_direction_output(led->aux_gpio, KTD2692_HIGH);
> +               if (led->aux_gpio)
> +                       gpiod_direction_output(led->aux_gpio, KTD2692_HIGH);

Ditto.

...

> -               gpiod_direction_output(led->aux_gpio, KTD2692_LOW);
> +               if (led->aux_gpio)
> +                       gpiod_direction_output(led->aux_gpio, KTD2692_LOW);

Ditto.

...

> -       gpiod_direction_output(led->aux_gpio, KTD2692_LOW);
> +       if (led->aux_gpio)
> +               gpiod_direction_output(led->aux_gpio, KTD2692_LOW);

Ditto.

...

>         ret = PTR_ERR_OR_ZERO(led->aux_gpio);
> -       if (ret) {
> -               dev_err(dev, "cannot get aux-gpios %d\n", ret);
> -               return ret;
> -       }
> +       if (ret)
> +               dev_info(dev, "aux-gpios not available, flash mode current might be reduced\n");

dev_warn()?

After this change the use of PTR_ERR_OR_ZERO() becomes unjustified, what about
        if (IS_ERR(led->aux_gpio))
?

But the problem here is the ignorance of important error codes, such a
deferred probe.

What you need is to switch to devm_gpiod_get_optional().

-- 
With Best Regards,
Andy Shevchenko

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB5F57FBDC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbiGYIzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbiGYIzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:55:39 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E211582A;
        Mon, 25 Jul 2022 01:55:37 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id t3so13025556edd.0;
        Mon, 25 Jul 2022 01:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3INTKFVzGpgdLiO6cm/tt/F3n1FdE/J8Gtrvuuomg/U=;
        b=KGUkTvmsrFj/i/g2Txcus2neVCIeH7fS7RYDzgarpCQjAlV25rYmvRqFk4rEW2Xu6H
         dVkCJgHWlrXopXOfsXa7jLI7QUV58LjpMPEGgOlQAaOnihMKMqUORjOGJ0SyGVX6oPmr
         AMrcGRzTVPctXdbs6Q2EfqiY6PKD5GpzJSWGECpaDGigxvdYX+uHjA92klNsnuWiXkR8
         KK3MgVH2qSoijeYpB69tibPEs3jLzlYrbqnbLehlkcag6TPz7QYuNOe0ls9ksOj0BiPk
         SOG0zIupDCmFrghFibZg1nOn4XrHoUYCdTW2Pwb7i2+PJ+hXVio5/EJxBh6mFV3wBtpH
         A4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3INTKFVzGpgdLiO6cm/tt/F3n1FdE/J8Gtrvuuomg/U=;
        b=dxPHoDmRgC9rpOQw/kF0dORG9HPgQXMrNb5ia19fDY/ujBHsUuEz0hYogxJtfGlxG6
         /eojK5Ixf0WSISXA18Fgmxa13gAw+VnADFiGo9YTwZu9BgJ4H8XShs6A8YMXfnxQzxp0
         AfkmxXd02aoHimGBZwxt5yHj3o2qeGlAvAkNyRhO10oq9KJZuWahas1GeJSqUdAMVspE
         MDjVtJkN0P+YKUe+ci+xpr6/vSPx8ayPH6zP3yapsJcdMzsQ9xI+eghOsAlMFLl2feOr
         9C44e0MvKsQbzlkmjDsKavrMJ+nohNdH6x47ehi+36HMI+P+0hZaEsJ2y4+ypVNJ4hL3
         8I4A==
X-Gm-Message-State: AJIora8tTq0iBWP3JTuOMng+a9RmiL+HCn7qyylEMaN1Z02H029l8pU+
        vcJ2x16a5O8tP6LPXeWQwVIRQCHSFK4f6s9pXqw=
X-Google-Smtp-Source: AGRyM1v8y+nmZhsplbXoHzO4Ve+2H3JYkbB6esC4VwvluxmYvgNwKHcXWiOtO8fBnhCqb3I9/pY7SCo8PriYmFxn6lE=
X-Received: by 2002:a05:6402:34c5:b0:43a:8f90:e643 with SMTP id
 w5-20020a05640234c500b0043a8f90e643mr11947835edc.88.1658739336148; Mon, 25
 Jul 2022 01:55:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220722102407.2205-1-peterwu.pub@gmail.com> <20220722102407.2205-13-peterwu.pub@gmail.com>
In-Reply-To: <20220722102407.2205-13-peterwu.pub@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Jul 2022 10:55:00 +0200
Message-ID: <CAHp75VfgiK87VwWu2bTJ_mR0=g0sa0LPJ+H16OGcUdARmzFRSA@mail.gmail.com>
Subject: Re: [PATCH v6 12/13] leds: flash: mt6370: Add MediaTek MT6370
 flashlight support
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

On Fri, Jul 22, 2022 at 12:25 PM ChiaEn Wu <peterwu.pub@gmail.com> wrote:

Forgot to add a couple of things...

...

> +#define MT6370_ITORCH_MIN_UA           25000
> +#define MT6370_ITORCH_STEP_UA          12500
> +#define MT6370_ITORCH_MAX_UA           400000
> +#define MT6370_ITORCH_DOUBLE_MAX_UA    800000
> +#define MT6370_ISTRB_MIN_UA            50000
> +#define MT6370_ISTRB_STEP_UA           12500
> +#define MT6370_ISTRB_MAX_UA            1500000
> +#define MT6370_ISTRB_DOUBLE_MAX_UA     3000000

Perhaps _uA would be better and consistent across your series
regarding current units.

...

> +       /*
> +        * For the flash to turn on/off, need to wait HW ramping up/down time

we need

> +        * 5ms/500us to prevent the unexpected problem.
> +        */
> +       if (!prev && curr)
> +               usleep_range(5000, 6000);
> +       else if (prev && !curr)
> +               udelay(500);

This still remains unanswered, why in the first place we allow
switching, and a busy loop in the other place?

-- 
With Best Regards,
Andy Shevchenko

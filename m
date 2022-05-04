Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FA351B186
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 23:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358370AbiEDWDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 18:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357853AbiEDWDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:03:21 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F77950B05
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 14:59:43 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id e12so4682638ybc.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 14:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rmJxiEP7m5MkHAr9riUqfx3uT8FiWx1lLvenswbOwJo=;
        b=QoiC7QZe2hJyujp1ZRg0nlXjXopykN2j/DeYH65TBWATXUktJf0x/kyffuuacsI/Xo
         3U/WGyV+fixlajIQ09GKt1DZZYpxMas0dWaDYCL8jonCJtMRr4CSZtyBZVh8caz3Zhfm
         KLVYZqsNmH6MjXnLA95998XCfsQEg4LoRnNmHuqp/sQ2AApgVFWMqqZBdroSiC1gbSmN
         F4COMU/J9YGu52LHRSSP9wDA3f+g3bnizNxpCHxuTE9h/gJ7KhKhsdH72IujMMikVg4I
         fP3vyeXEvVrVnkAX/oRVPo4TmV6M5W4ptTtqSYXWLDxsKe5hoIl7+BOBmDpgqE7s/ubD
         8xlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rmJxiEP7m5MkHAr9riUqfx3uT8FiWx1lLvenswbOwJo=;
        b=6aVJErBzrd0LFagv5QOiJO1EkaCZ+68mNkz/RNTw25HgYyfV8XvoMvT8ejIR3ZThHA
         KHAQdR/zvaThqmeKSzd3rXjS1oFVCk3QjowAltaZcf5KrNQVitYbstwTQCQSbf3FFq6+
         wX1ELo3VzD0X0/paBuuRoJVtIgtrPRpBT5wRYEaJuRnf6TxYYyvFVY3Gv0J+9YXSqPw6
         GWXIT2nlgzivbijFBKc33VU8/GgvJo7bbbW/6Cdjfpq3iuI8xpg+q4DM1Lw33BTWahqI
         v3FNHBc6iOg77T4HZrtUHIVs9UY9vWz7fkytZagrH0lk4XmMZRwNBl2cPK1quG8Fw48E
         bz3Q==
X-Gm-Message-State: AOAM532joBarBgJ4Vnonu3bFhKDt8lpZ+DF37+5cV7ePdHdcsk8xpOyn
        coBBsNG7uujtZhfep4VZv/HxITVgkZExpzy7BNuXmQ==
X-Google-Smtp-Source: ABdhPJws0kFu4uk8m+EBRW3/56Ag/4uZ6hdskWay/lA/R4RBYkLUb5oUPb5cyXOdcEWwAD5EvFRWUXI3Mh6lxHFGeY0=
X-Received: by 2002:a25:bcc7:0:b0:648:d728:d39 with SMTP id
 l7-20020a25bcc7000000b00648d7280d39mr19634791ybm.514.1651701582183; Wed, 04
 May 2022 14:59:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220419163810.2118169-1-arnd@kernel.org> <20220419163810.2118169-19-arnd@kernel.org>
 <CACRpkdac8dGKSEmc-HpgooJefrDtiKK+_A1Mv7AJM8yQV9UY-w@mail.gmail.com> <CAK8P3a0w3gFzZoBzyRsi1Ta4prESf8Fp0=quAPSKMnaXvbXNTQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0w3gFzZoBzyRsi1Ta4prESf8Fp0=quAPSKMnaXvbXNTQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 4 May 2022 23:59:30 +0200
Message-ID: <CACRpkdZNryYkidvdKuT57RM3fz6_X+3oOzF5xaOZd+TyScfUsw@mail.gmail.com>
Subject: Re: [PATCH 18/48] ARM: pxa: hx4700: use gpio descriptors for audio
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Paul Parsons <lost.distance@yahoo.com>,
        Tomas Cech <sleep_walker@suse.com>,
        Sergey Lapin <slapin@ossfans.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Helge Deller <deller@gmx.de>, Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        IDE-ML <linux-ide@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        patches@opensource.cirrus.com, linux-leds@vger.kernel.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-rtc@vger.kernel.org, USB list <linux-usb@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 2, 2022 at 9:08 AM Arnd Bergmann <arnd@kernel.org> wrote:
> On Sun, May 1, 2022 at 11:41 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > (...)
> > > +static struct gpiod_lookup_table hx4700_audio_gpio_table = {
> > > +       .dev_id = "hx4700-audio",
> > > +       .table = {
> > > +               GPIO_LOOKUP("gpio-pxa", GPIO75_HX4700_EARPHONE_nDET,
> > > +                           "earphone-ndet", GPIO_ACTIVE_HIGH),
> >
> > This looks wrong. The n in nDET in the end of the name of the GPIO line
> > means active low does it not?
> >
> > What I usually do when I see this is to properly set it to
> > GPIO_ACTIVE_LOW in the descriptor table, then invert the logic
> > where it's getting used.
> >
> > Also rename to earphone-det instead of -ndet
>
> Thanks for taking a look! I changed it now, but I don't know if
> I got the correct number of inversions in the end. How does this look?

Looks wrong, you can just invert the argument to any statement of set_value()
after tagging respective line as active low. Then gpilob will do a second
inversion.

> +               GPIO_LOOKUP("gpio-pxa", GPIO75_HX4700_EARPHONE_nDET,
> +                           "earphone-det", GPIO_ACTIVE_LOW),
> +               GPIO_LOOKUP("gpio-pxa", GPIO107_HX4700_SPK_nSD,
> +                           "spk-sd", GPIO_ACTIVE_LOW),

So those two have switched polarity.

> @@ -81,14 +79,14 @@ static const struct snd_soc_ops hx4700_ops = {
>  static int hx4700_spk_power(struct snd_soc_dapm_widget *w,
>                             struct snd_kcontrol *k, int event)
>  {
> -       gpio_set_value(GPIO107_HX4700_SPK_nSD, !!SND_SOC_DAPM_EVENT_ON(event));
> +       gpiod_set_value(gpiod_spk_sd, !!SND_SOC_DAPM_EVENT_ON(event));

Thus drop one ! in front of the expression, just !SND_SOC_DAPM_EVENT_ON(event)

> -       gpio_set_value(GPIO92_HX4700_HP_DRIVER, !!SND_SOC_DAPM_EVENT_ON(event));
> +       gpiod_set_value(gpiod_hp_driver, !!SND_SOC_DAPM_EVENT_ON(event));

But not this.

> +       gpiod_spk_sd = devm_gpiod_get(&pdev->dev, "spk-sd", GPIOD_OUT_LOW);

These initial values don't seem to be set in the old code you could
just use GPIOD_ASIS as flag to make sure the new code behaves
the same.

Yours,
Linus Walleij

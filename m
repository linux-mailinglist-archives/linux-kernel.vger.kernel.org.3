Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481354FB6E1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344080AbiDKJGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344070AbiDKJG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:06:26 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF2013D46;
        Mon, 11 Apr 2022 02:04:13 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id t207so8685296qke.2;
        Mon, 11 Apr 2022 02:04:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9TRi0bNPoJj9i+0TdWcYotMzzdlJV8VxAkudB/T4n5g=;
        b=RecfqrvAO5i82vM6HhQECzvgKmhIMr/jiKkGFRhT9lnN+u742mAL7D96PXK5qS840n
         gOOPws5XJeUcituCVCdnaa1sYxmDgQLRWNxeSXHcObl/FrMlTCtRyjhcKP5eCu3pm3Xn
         ONBzIpw9cfeRSupT8LP/eta76PfEP8FQu7tYTxhi76AwqA9VkW10esbHhyI7gT7Gtpsi
         KouBIAtFshLJQi+o03VZU/skEoo88+iUvfadSHiYuDG0KNOApBOG1IbvmfVRW9Hwhiks
         tkOmCFZ35EJcgTNf+0UsoakCcA2SexVOY2JgN4i+CVCvonyl51PIlkjDT9h63j9Xkp7O
         YhoA==
X-Gm-Message-State: AOAM5306NEtkVWrREkdrUre3SuaY5HNsW0EfaJwEM/+M7G/DqzEMh16O
        KWg8wsud6Yw8Aca/lVRZ9ABv6+dasLSevA==
X-Google-Smtp-Source: ABdhPJw92TnKqmEK7ZGcPKpGIraYJ0Hs1eXfW4oHleGd3bCX1+k4rLnRv8QiUkRuNSclWNkBN3faZQ==
X-Received: by 2002:a05:620a:2408:b0:699:d310:dbfb with SMTP id d8-20020a05620a240800b00699d310dbfbmr20973812qkn.326.1649667852207;
        Mon, 11 Apr 2022 02:04:12 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id u11-20020a05622a14cb00b002e1fd9dce3dsm24476060qtx.60.2022.04.11.02.04.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 02:04:11 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2ec04a2ebadso37504147b3.12;
        Mon, 11 Apr 2022 02:04:11 -0700 (PDT)
X-Received: by 2002:a0d:e743:0:b0:2eb:3106:9b32 with SMTP id
 q64-20020a0de743000000b002eb31069b32mr25689449ywe.512.1649667851285; Mon, 11
 Apr 2022 02:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220401103604.8705-1-andriy.shevchenko@linux.intel.com> <20220401103604.8705-10-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220401103604.8705-10-andriy.shevchenko@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Apr 2022 11:04:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX8zWA-3_=Je7sB_72G8Ky7-syqCH-RXGxNMazUipW-2g@mail.gmail.com>
Message-ID: <CAMuHMdX8zWA-3_=Je7sB_72G8Ky7-syqCH-RXGxNMazUipW-2g@mail.gmail.com>
Subject: Re: [PATCH v4 09/13] pinctrl: meson: Rename REG_* to MESON_REG_*
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Qianggui Song <qianggui.song@amlogic.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        openbmc@lists.ozlabs.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Fri, Apr 1, 2022 at 12:36 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Currently compilation test fails on x86 due to name collision. The usual
> way to fix that is to move both conflicting parts to their own namespaces.
>
> Rename REG_* to MESON_REG_* as a prerequisite for enabling COMPILE_TEST.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks for your patch!

> --- a/drivers/pinctrl/meson/pinctrl-meson.h
> +++ b/drivers/pinctrl/meson/pinctrl-meson.h
> @@ -63,12 +63,12 @@ struct meson_reg_desc {
>   * enum meson_reg_type - type of registers encoded in @meson_reg_desc
>   */
>  enum meson_reg_type {
> -       REG_PULLEN,
> -       REG_PULL,
> -       REG_DIR,
> -       REG_OUT,
> -       REG_IN,
> -       REG_DS,
> +       MESON_REG_PULLEN,
> +       MESON_REG_PULL,
> +       MESON_REG_DIR,
> +       MESON_REG_OUT,
> +       MESON_REG_IN,
> +       MESON_REG_DS,
>         NUM_REG,

MESON_NUM_REG?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

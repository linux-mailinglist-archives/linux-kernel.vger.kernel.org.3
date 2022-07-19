Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41B957A73E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 21:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239377AbiGSTb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 15:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbiGSTb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 15:31:56 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FBD545E3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 12:31:53 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ez10so29059040ejc.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 12:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RAU//37IhkSd2RP/wWuWqS7ZhbqNjkZqDAj9Jtyjxa4=;
        b=ji9VZB/X3hbNV8q9nSl61V1uJbsSlXFiowQ+IgcJlPoy7x/ZkgYfb24lVXvXmhy9yu
         5NzaaEZUdK8B80C6oxUSxlLue9eLNWCy9txZe6eUf1wyUOBLnjijcNC0Bxbyvmnm4Vqf
         s4V6mmibLy2x7kolQ94j/XKL1vPbjJ7+ynTcHPseK48L+mKg6/H3OcYxjEaNv4LYMtGS
         GfbGskI3pF42oqw6TgclVpSYFNfDw6zhIIZiYuwbK2IFGrcUSoHnpj8b+J9Q63/cbdA8
         vimIP/SXYRNFF4Kgox9hrLIRi8OnC0iJjAqS6MD6sVlrApmyKxo/UFSzI6QJH+G8RCDr
         K44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RAU//37IhkSd2RP/wWuWqS7ZhbqNjkZqDAj9Jtyjxa4=;
        b=0Xn1AeB905HOjAPL8HPl1jcVxNZg+FLHE/l/RQhHjUvte4WQCttahLpm9PVuE9SjwC
         wfQBLKWYHfHioMu0nxUY3xe/de1WPTz7N8zNrOSOLOhIRhZELGtDjgnGs4ZN6bcJebTy
         GrbW5eRBhCxD/A5e5xZ/xte1m4pAajx+5g2iw4Tytda3+vO/xhnG+2mRl9raNbxDcKwf
         DwK4yOuQZQLXQdBAfbcChaJYMCMpb/cWjwAfvkrvJ1uhWu+RwlQDJOChTKnsCBbI6w33
         +ZddzDKXbRCINIe+jmCPVoVQZaU+CZEIheycOCZ235yFM3d549yGSeH7nsZhVZ8/IStt
         igiA==
X-Gm-Message-State: AJIora/IYX3OJw4LmGgq7LZlRiL4jfyPJnlIn1o6Yy7RbwYLQ/CoFO1V
        GGNIv7x6Oo8hJEMsFCru7so59oG0L/UzZ7odu7Ko+w==
X-Google-Smtp-Source: AGRyM1uCskMut1g6IC9zHvM6uNkhvM+7YlQDg4xUxNPflA1/5PGzdLDxXoPK7pQiiaYChUzJQrkwam1AHGbhPdCH6uE=
X-Received: by 2002:a17:907:a06f:b0:72b:564c:465b with SMTP id
 ia15-20020a170907a06f00b0072b564c465bmr31572545ejc.344.1658259111567; Tue, 19
 Jul 2022 12:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220718105047.2356542-1-tzungbi@kernel.org> <CABXOdTdKpqsqajhQzQ1aEp6bsa96ONN6nz9EWZv6jGSuN0_LTA@mail.gmail.com>
 <YtY460lI465ne00L@google.com>
In-Reply-To: <YtY460lI465ne00L@google.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 19 Jul 2022 12:31:40 -0700
Message-ID: <CABXOdTe_FMXGhuX_u8QQ=uDxiPwZ=Oo1Ehw4FqjH9m-N6M=GhQ@mail.gmail.com>
Subject: Re: [PATCH v2] platform/chrome: cros_kbd_led_backlight: fix build warning
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:CHROME HARDWARE PLATFORM SUPPORT" 
        <chrome-platform@lists.linux.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 9:54 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> On Mon, Jul 18, 2022 at 06:28:22AM -0700, Guenter Roeck wrote:
> > On Mon, Jul 18, 2022 at 3:51 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> > >
> > > drivers/platform/chrome/cros_kbd_led_backlight.c got a new build warning
> > > when using the randconfig in [1]:
> > > >>> warning: unused variable 'keyboard_led_drvdata_ec_pwm'
> > >
> > > The warning happens when CONFIG_CROS_EC is set but CONFIG_OF is not set.
> > > Reproduce:
> > > - mkdir build_dir
> > > - wget [1] -O build_dir/.config
> > > - COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 \
> > >   O=build_dir ARCH=s390 SHELL=/bin/bash drivers/platform/chrome/
> > >
> > > Fix the warning by using __maybe_unused.  Also use IS_ENABLED() because
> > > CROS_EC is a tristate.
> >
> > Is that sufficient ? What happens if CROS_KBD_LED_BACKLIGHT=y and
> > CROS_EC=m ? I suspect you might need IS_REACHABLE() instead of
> > IS_ENABLED().
>
> For current code, it's impossible to set CROS_KBD_LED_BACKLIGHT=y and
> CROS_EC=m without setting ACPI=y.  Given that the dependencies:
> CHROME_PLATFORMS [=y] && LEDS_CLASS [=y] && (ACPI [=n] || CROS_EC [=m]).
>
> $ ./scripts/kconfig/merge_config.sh -n <(cat <<EOF
> CONFIG_MODULES=y
>
> CONFIG_NEW_LEDS=y
> CONFIG_LEDS_CLASS=y
>
> CONFIG_CHROME_PLATFORMS=y
> CONFIG_CROS_EC=m
> CONFIG_CROS_KBD_LED_BACKLIGHT=y
> EOF
> )
> [...]
> Value requested for CONFIG_CROS_KBD_LED_BACKLIGHT not in final .config
> Requested value:  CONFIG_CROS_KBD_LED_BACKLIGHT=y
> Actual value:     CONFIG_CROS_KBD_LED_BACKLIGHT=m
>

It is actually possible to configure CONFIG_CROS_KBD_LED_BACKLIGHT=y
with CONFIG_CROS_EC=m, by also setting CONFIG_LEDS_CLASS=y. However,
that doesn't seem to matter since the critical symbol is CROS_EC_PROTO
which is boolean.
Given that, IS_ENABLED should be fine.

Reviewed-by: Guenter Roeck <groeck@chromium.org>

Thanks,
Guenter

> However, when ACPI=y, `keyboard_led_drvdata_ec_pwm` is unused.  Instead, it
> uses `keyboard_led_drvdata_acpi` for current code.
>
> I guess IS_ENABLED() is sufficient.  Does it make sense?

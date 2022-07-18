Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCBB5783B5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbiGRN2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbiGRN2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:28:36 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB44D15FEC
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:28:35 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id mf4so21242957ejc.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C/n/n5N3kD+VrsmUyuuzjShv2vcVv2gHHyO/+4lHckk=;
        b=jnitDELvhIQNn98ip0Y5Hp8pRAMeVz86v70GtsvJlURkXTKJLUjHBTFfh4s4IcRMB/
         jjq88+7eKqYZ4iOOmu/EelFQQ331JG3pz3+3qQpyKA4b2xJEgPoxe/UN0nciOQ5qt30P
         Ykn9KnDorE0PabMG1So+VUu8gAYLM8ZFR9Wqzot3Vt5LDR/u6xf6bnj1uc9Ojn1qADrq
         dzwMSwjMFSgFECjxLZGVBSjwojkuLNG6b+AC+rjJb/aVItbcm654vO0YZypDbYLlL2QR
         EVMlcxMwo0pj2RjhKqQa4i7hNAIWItKTN3f+y4zX98gwKGYUCWor9riEDHjYwGYrj/Fe
         nOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C/n/n5N3kD+VrsmUyuuzjShv2vcVv2gHHyO/+4lHckk=;
        b=mcD51IAD6oxEuy5CdQLv+QZ2c8g8w9QxAJxY/0yWu042Z2595LbyNg6+7w5TSgu9Yq
         BD52JCmFnftajPWf91M3MrG7Tpn2+4QGTWaC9TJDzrvj0UJuMk99CVtO18ibXD5vzhEG
         RA2fmSNkp3QcIxdwqSPX3CknCOrw5zCzMIRqL06K8mBUy1ybO9ORKiKNkoWtdjNIRgUA
         JwnMNZnZ2I/KkRYi4WFgyl0WvqEYmsWYT035c7XHPLO35ybr8h0uVkV7C4EuX8eonyZK
         OL6VciIarwI5xdL0RkG5a6f7vZzxBOwlgzoZ/ac87YnDvRqzTqwb75VX1Y6IkJTTLU2L
         +f1w==
X-Gm-Message-State: AJIora8yRuSjDDNTbHfAOPK5zNqk5F9acxN0sKQBkmStLPOoYg044do1
        JoMoD2jxBUMYvq4+urldgeAhOpunYiMFtgGsYQiojQ==
X-Google-Smtp-Source: AGRyM1uIs/IIF7M4Uz/hB54B2qQo3bgDyGR6Ptlf4NxZdXvCR9vs0zvBuOwzrpGC7PGZxl4E2ege5QOU2vKs6yh2dtw=
X-Received: by 2002:a17:907:2ce9:b0:72b:30e5:f1bc with SMTP id
 hz9-20020a1709072ce900b0072b30e5f1bcmr25093951ejc.127.1658150914271; Mon, 18
 Jul 2022 06:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220718105047.2356542-1-tzungbi@kernel.org>
In-Reply-To: <20220718105047.2356542-1-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 18 Jul 2022 06:28:22 -0700
Message-ID: <CABXOdTdKpqsqajhQzQ1aEp6bsa96ONN6nz9EWZv6jGSuN0_LTA@mail.gmail.com>
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

On Mon, Jul 18, 2022 at 3:51 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> drivers/platform/chrome/cros_kbd_led_backlight.c got a new build warning
> when using the randconfig in [1]:
> >>> warning: unused variable 'keyboard_led_drvdata_ec_pwm'
>
> The warning happens when CONFIG_CROS_EC is set but CONFIG_OF is not set.
> Reproduce:
> - mkdir build_dir
> - wget [1] -O build_dir/.config
> - COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 \
>   O=build_dir ARCH=s390 SHELL=/bin/bash drivers/platform/chrome/
>
> Fix the warning by using __maybe_unused.  Also use IS_ENABLED() because
> CROS_EC is a tristate.

Is that sufficient ? What happens if CROS_KBD_LED_BACKLIGHT=y and
CROS_EC=m ? I suspect you might need IS_REACHABLE() instead of
IS_ENABLED().

Thanks,
Guenter

>
> [1]: https://download.01.org/0day-ci/archive/20220717/202207170538.MR39dw8m-lkp@intel.com/config
>
> Fixes: 40f58143745e ("platform/chrome: cros_kbd_led_backlight: support EC PWM backend")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
> Changes from v1 (https://patchwork.kernel.org/project/chrome-platform/patch/20220718061608.2303425-1-tzungbi@kernel.org/):
> - Use __maybe_unused.
>
>  drivers/platform/chrome/cros_kbd_led_backlight.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_kbd_led_backlight.c b/drivers/platform/chrome/cros_kbd_led_backlight.c
> index 5ad41c10412d..793fd3f1015d 100644
> --- a/drivers/platform/chrome/cros_kbd_led_backlight.c
> +++ b/drivers/platform/chrome/cros_kbd_led_backlight.c
> @@ -119,7 +119,7 @@ static const struct keyboard_led_drvdata keyboard_led_drvdata_acpi = {
>
>  #endif /* CONFIG_ACPI */
>
> -#ifdef CONFIG_CROS_EC
> +#if IS_ENABLED(CONFIG_CROS_EC)
>
>  static int
>  keyboard_led_set_brightness_ec_pwm(struct led_classdev *cdev,
> @@ -180,18 +180,18 @@ static int keyboard_led_init_ec_pwm(struct platform_device *pdev)
>         return 0;
>  }
>
> -static const struct keyboard_led_drvdata keyboard_led_drvdata_ec_pwm = {
> +static const __maybe_unused struct keyboard_led_drvdata keyboard_led_drvdata_ec_pwm = {
>         .init = keyboard_led_init_ec_pwm,
>         .brightness_set_blocking = keyboard_led_set_brightness_ec_pwm,
>         .brightness_get = keyboard_led_get_brightness_ec_pwm,
>         .max_brightness = KEYBOARD_BACKLIGHT_MAX,
>  };
>
> -#else /* CONFIG_CROS_EC */
> +#else /* IS_ENABLED(CONFIG_CROS_EC) */
>
> -static const struct keyboard_led_drvdata keyboard_led_drvdata_ec_pwm = {};
> +static const __maybe_unused struct keyboard_led_drvdata keyboard_led_drvdata_ec_pwm = {};
>
> -#endif /* CONFIG_CROS_EC */
> +#endif /* IS_ENABLED(CONFIG_CROS_EC) */
>
>  static int keyboard_led_probe(struct platform_device *pdev)
>  {
> --
> 2.37.0.170.g444d1eabd0-goog
>

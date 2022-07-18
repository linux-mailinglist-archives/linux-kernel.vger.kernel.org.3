Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC04577BED
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 08:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbiGRGys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 02:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbiGRGyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 02:54:45 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5245DE0D8
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 23:54:44 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id oy13so19486888ejb.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 23:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Wf3nz0D32YPk/y25pAQGhDQ1uTDwJ1vjvWzFxFZHho=;
        b=Ih+9aNjIeLTpADvaHAVyzE/9Uv2qM+Aey4UGoF+VMVge3MFhBt9ewvTNE+mU3yn44w
         A5+1FZasc2gPR68mlTe/uEt7GAJxFdaQFHktdNPRH6/CFPDR2gXztTpIRPYObF4gitXd
         TZ1lgSK2X37oA0Z4uZBTiAvU0ArMCukhL9fdmZU6pmPXqi6/diRgxvG2E2VhEHRlxD8f
         JVzjCoUN12HTHGj9wlPhxSIjxTjitGtAbC2b8GmfcNbE8oFgR3wNCTPQXIDYk110+xt6
         qUpWOfYlEjgqeGQ4xrS6HZs2IKccJLEUaeG/XOLgKcXo+dM0nWCDyb7olQv49hqFFp2m
         Md+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Wf3nz0D32YPk/y25pAQGhDQ1uTDwJ1vjvWzFxFZHho=;
        b=n40b2w/DUMeSQTbZx6Qhc2syiqkZqcKxtS6HVLW/9JvJXKwe0f8xytV6OpJceAei2t
         VG3YF8n2/qxIT86zmtbGXVbakIhKZnViy+9XKwIj2P/smWJHhB6lvoVxGHePF3ugaZ5A
         vVMSG0RNDxqcOuCiQfyyUPQYSlFgRO4gzS/w3HDqAZb94PE+lO/SqzyLOMEKHRX/53UE
         0sOcQji3ss2o0GOQo2VJH+9RFm9mYfrQRKJg3XnWiN0WGzgoRCap4LqV0hxZ2WCMQwfQ
         ggNL+oPSLXcjaknoDHik/neX2iYXFsiwUwXa5ouLQSM/a/4i8Eu0o2R7q2LcOIoaQ52s
         W5HA==
X-Gm-Message-State: AJIora977sipe+4wnBkeuvbtHi3idAobG+pqZN/aA5SR10AYxgBZo9R7
        gPbeZbYGY3YQqOUKwJ9PsHMnqVJ2YFA+12wpELGllQ==
X-Google-Smtp-Source: AGRyM1vEW2fHt3QyClItms5lOeJKBbgwfyE4WQDULLAvCf0Qqtqg8io+RzvCaT1lotn0yOTNZGTQJE9IFkzFljFVot0=
X-Received: by 2002:a17:907:160c:b0:72f:1031:2184 with SMTP id
 hb12-20020a170907160c00b0072f10312184mr9807494ejc.355.1658127282713; Sun, 17
 Jul 2022 23:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220718061608.2303425-1-tzungbi@kernel.org>
In-Reply-To: <20220718061608.2303425-1-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Sun, 17 Jul 2022 23:54:31 -0700
Message-ID: <CABXOdTeH-q=17QBnCn5NGT5V0QA5SOaTnrWaK+g5F3j4mVp8cA@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_kbd_led_backlight: fix build warning
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

On Sun, Jul 17, 2022 at 11:16 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
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

Have you tried the following ?
    CONFIG_ACPI=y
    CONFIG_CROS_EC=n
    CONFIG_OF=y

That should be possible, but with your patch it should now result in a
build error because keyboard_led_drvdata_ec_pwm is no longer defined.

Also, with your patch, CONFIG_CROS_EC=y, CONFIG_ACPI=y, and
CONFIG_OF=n (ie Intel/AMD systems) would result in the code not being
compiled, which would be wrong.

Thanks,
Guenter

> Fix the warning by hardening the guard condition.  Also use IS_ENABLED()
> because CROS_EC is a tristate.
>
> [1]: https://download.01.org/0day-ci/archive/20220717/202207170538.MR39dw8m-lkp@intel.com/config
>
> Fixes: 40f58143745e ("platform/chrome: cros_kbd_led_backlight: support EC PWM backend")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
>  drivers/platform/chrome/cros_kbd_led_backlight.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_kbd_led_backlight.c b/drivers/platform/chrome/cros_kbd_led_backlight.c
> index 5ad41c10412d..4a0b2bd004d5 100644
> --- a/drivers/platform/chrome/cros_kbd_led_backlight.c
> +++ b/drivers/platform/chrome/cros_kbd_led_backlight.c
> @@ -119,7 +119,7 @@ static const struct keyboard_led_drvdata keyboard_led_drvdata_acpi = {
>
>  #endif /* CONFIG_ACPI */
>
> -#ifdef CONFIG_CROS_EC
> +#if IS_ENABLED(CONFIG_CROS_EC) && defined(CONFIG_OF)
>
>  static int
>  keyboard_led_set_brightness_ec_pwm(struct led_classdev *cdev,
> @@ -187,11 +187,7 @@ static const struct keyboard_led_drvdata keyboard_led_drvdata_ec_pwm = {
>         .max_brightness = KEYBOARD_BACKLIGHT_MAX,
>  };
>
> -#else /* CONFIG_CROS_EC */
> -
> -static const struct keyboard_led_drvdata keyboard_led_drvdata_ec_pwm = {};
> -
> -#endif /* CONFIG_CROS_EC */
> +#endif /* IS_ENABLED(CONFIG_CROS_EC) && defined(CONFIG_OF) */
>
>  static int keyboard_led_probe(struct platform_device *pdev)
>  {
> --
> 2.37.0.170.g444d1eabd0-goog
>

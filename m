Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC0F53B10C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 03:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbiFBAf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 20:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbiFBAfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 20:35:25 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CA929B2F6;
        Wed,  1 Jun 2022 17:35:22 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id k4so3239771vsp.3;
        Wed, 01 Jun 2022 17:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qGfyFYtQBkhs1bsnCGTcxZHUxBKDfuhR4+aet0HmgBo=;
        b=VeHJrgo/y8ZGDzRNHgPEjLU52Wlr0JxZdvtA61TLoXo+5gojdFkUd8Oz7UYSRhJ7He
         Fi4VybCUB9O1dDdFMKyGZ9FfBG2F2yiA8IYdLGMwB4xx31ZHyQOpT0TRI7VZ6DmmR8Oi
         MUC0CQLYeUjEp3do+v3NjwSqYfFIUUTCm3g9mFdmpt3jgfPNXsZfPztBpEH1HmvAmD3z
         QCfoUCek/rC1B2I72UJMRhsLRmOEJ2+Oy9Ysw/cRjvU6xykRbgNLbxj+IY2kupMWpRw0
         Qhxj06Y9sc1eVRCMFgKc56V+lOkaJq4h3kHXBTzcObalgQHEr65O4bzFtLCn4WJ841B8
         ye3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qGfyFYtQBkhs1bsnCGTcxZHUxBKDfuhR4+aet0HmgBo=;
        b=BJMe9IBtq0SZKUvi76P4TQYiZWFc6erGdJ3buCyv5yc9abssWIiJHdlr4fiERQ0K+H
         Q+p+XNCJCDhExw5uTiQdYgg19Jp7ph3EgjuchsbQAEwniLkTfcrpbtYbUqbVu2eykCB3
         fIjlgdKvcPOVX6bQY24ETcXqvB5Kiw2Mb6ra5SulEYkyYNqc5I5KVSvEMmJ1tN1x9fGP
         sqrDdsP+0PrKz4o1Ue2OnKAZOjAKEpoR6pVIHFrQMfq6bkUQ+NisaT5OyZuH6er8E8Vk
         ZOGsIjKAz8dn4rxKaRzAVr9LeiLODX8qFvEcDJSQ67LBmgYKxzB6OZZ8a2nvsdXl+O7c
         Lzew==
X-Gm-Message-State: AOAM531efdcodByRGiD3xYAwcQLcGRYPHpcZ5YviciZ8SkxWAgLuhOtM
        Vbpx3/l/5HZsLAwsTSbbdTnfagU11DaZ718c1F0=
X-Google-Smtp-Source: ABdhPJx7ugB77N42e49zz59DK4hKLKhfJfHd4OOlDtVR342UYRcyO5YwluDr7EkJDQZ36gDAAFqPcDiIMMhol1TpnsI=
X-Received: by 2002:a67:8cc8:0:b0:349:e357:c679 with SMTP id
 o191-20020a678cc8000000b00349e357c679mr980534vsd.61.1654130121601; Wed, 01
 Jun 2022 17:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220529180230.17e9a0f9@ultrarare.space> <20220529182036.10226-1-jose.exposito89@gmail.com>
 <20220530083752.1973a905@ultrarare.space> <20220530061812.GA10391@elementary>
 <20220531221102.7bd7da7d@ultrarare.space> <20220531223330.3d63e2fe@ultrarare.space>
 <20220531172053.GA10651@elementary> <CAPnXWxG8gbe1arQK9kBtwM1Xcta+wreTN742kgtBBr1v0ewKug@mail.gmail.com>
 <7f67ac07b8bd37d5817cd151674cc6b0@ultrarare.space> <20220601072651.242ce08a@ultrarare.space>
In-Reply-To: <20220601072651.242ce08a@ultrarare.space>
From:   Bryan Cain <bryancain3@gmail.com>
Date:   Wed, 1 Jun 2022 18:35:10 -0600
Message-ID: <CAPnXWxG0pqL06XgO0nuQWKcUTi5H67gOFEiB63xLqREgrjfLig@mail.gmail.com>
Subject: Re: [PATCH v3] HID: apple: Properly handle function keys on non-Apple keyboard
To:     Hilton Chain <hako@ultrarare.space>
Cc:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I can't reply to v4 since I wasn't cc'd on that one and I'm not subscribed to
the mailing list, but while I haven't tested it yet, it looks good.

The only feedback I have is that according to my searching[1][2][3], Varmilo
keyboards pretending to be Apple devices report themselves as "AONE Varmilo
Keyboard", so it might be a good idea to add "AONE" to the list of clone
vendors.

Regards,
Bryan

[1] https://geekhack.org/index.php?topic=110250.msg3013629#msg3013629
[2] https://www.mail-archive.com/debian-bugs-dist@lists.debian.org/msg1750654.html
[3] https://forums.servethehome.com/index.php?threads/varmilo-keyboard-fn-keys-under-linux.29041/

On Tue, May 31, 2022 at 5:27 PM Hilton Chain <hako@ultrarare.space> wrote:
>
> This commit extends fa33382c7f74 ("HID: apple: Properly handle function
> keys on Keychron keyboards") by adding an array of known non-Apple
> keyboards' device names, and the function apple_is_non_apple_keyboard()
> to identify and create exception for them.
>
> Signed-off-by: Hilton Chain <hako@ultrarare.space>
> ---
>  drivers/hid/hid-apple.c | 33 ++++++++++++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
> index 42a568902f49..7d56530d9e3a 100644
> --- a/drivers/hid/hid-apple.c
> +++ b/drivers/hid/hid-apple.c
> @@ -36,7 +36,7 @@
>  #define APPLE_NUMLOCK_EMULATION        BIT(8)
>  #define APPLE_RDESC_BATTERY    BIT(9)
>  #define APPLE_BACKLIGHT_CTL    BIT(10)
> -#define APPLE_IS_KEYCHRON      BIT(11)
> +#define APPLE_IS_NON_APPLE     BIT(11)
>
>  #define APPLE_FLAG_FKEY                0x01
>
> @@ -65,6 +65,10 @@ MODULE_PARM_DESC(swap_fn_leftctrl, "Swap the Fn and left Control keys. "
>                 "(For people who want to keep PC keyboard muscle memory. "
>                 "[0] = as-is, Mac layout, 1 = swapped, PC layout)");
>
> +struct apple_non_apple_keyboard {
> +       char *name;
> +};
> +
>  struct apple_sc_backlight {
>         struct led_classdev cdev;
>         struct hid_device *hdev;
> @@ -313,6 +317,25 @@ static const struct apple_key_translation swapped_fn_leftctrl_keys[] = {
>         { }
>  };
>
> +static const struct apple_non_apple_keyboard non_apple_keyboards[] = {
> +       { "SONiX USB DEVICE" },
> +       { "Keychron" },
> +};
> +
> +static bool apple_is_non_apple_keyboard(struct hid_device *hdev)
> +{
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(non_apple_keyboards); i++) {
> +               char *non_apple = non_apple_keyboards[i].name;
> +
> +               if (strlen(non_apple) && strncmp(hdev->name, non_apple, strlen(non_apple)) == 0)
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
>  static inline void apple_setup_key_translation(struct input_dev *input,
>                 const struct apple_key_translation *table)
>  {
> @@ -363,7 +386,7 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
>         }
>
>         if (fnmode == 3) {
> -               real_fnmode = (asc->quirks & APPLE_IS_KEYCHRON) ? 2 : 1;
> +               real_fnmode = (asc->quirks & APPLE_IS_NON_APPLE) ? 2 : 1;
>         } else {
>                 real_fnmode = fnmode;
>         }
> @@ -669,9 +692,9 @@ static int apple_input_configured(struct hid_device *hdev,
>                 asc->quirks &= ~APPLE_HAS_FN;
>         }
>
> -       if (strncmp(hdev->name, "Keychron", 8) == 0) {
> -               hid_info(hdev, "Keychron keyboard detected; function keys will default to fnmode=2 behavior\n");
> -               asc->quirks |= APPLE_IS_KEYCHRON;
> +       if (apple_is_non_apple_keyboard(hdev)) {
> +               hid_info(hdev, "Non-apple keyboard detected; function keys will default to fnmode=2 behavior\n");
> +               asc->quirks |= APPLE_IS_NON_APPLE;
>         }
>
>         return 0;
>
> base-commit: e1cbc3b96a9974746b2a80c3a6c8a0f7eff7b1b5
> --
> 2.36.1
>

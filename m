Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E2753C020
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 23:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239293AbiFBVBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 17:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239122AbiFBVBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 17:01:10 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A80D35253;
        Thu,  2 Jun 2022 14:01:09 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id d2so1524624vkg.5;
        Thu, 02 Jun 2022 14:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9i8J+1TRfUHTT6n1+iy4Jf0ZEo68Ab/3VZwzDrsx+KE=;
        b=gxkuprEx3BTkTbTPCppLwPDdhTjCBxj9T4g0tOX2AWuhyPugDfGKA/U6mcKQhYyiHm
         z/NuXz3Prh/ae2nDI4hzLrs7pnSLujtSmGFX64qeQkVUaorSExBe9NFbFJy3ouqS2+RX
         GZyj+rGA6Mv/6ZC/tTZuYr/USyKosF3DMHLYQeId6mtPS9LDzET+ApZ7UrUP0tStTOnh
         H/AZIDRPMtQFhav0eIGreJHSm9Hg7VMDCJd1S0I9RrjIPT/3p2Vtww5WuaC836tHIzmD
         GUGhGbWmbvUHxyQ5RTRssLRFNsf0MG9IqZE2VqdFtg1DZEVgTfFFn9Dl0f+z3JP+zbZw
         odOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9i8J+1TRfUHTT6n1+iy4Jf0ZEo68Ab/3VZwzDrsx+KE=;
        b=JR28r0aZ6xhBtxQiB0DQFFi+II2dNYOSRuioaKgzWvc0p7ainYqtGiZcRydWtNyTWg
         CiqdjFwnq5zNC5w6KVVelbIPqvPYmdoVPcH2h5area+t1ViblDjXPgS5uX9zLM6ByjSx
         2ywvmJKBboG+TTQD0i2RFdoHDSmDwCCMMMeHuYXNPXCF7U709JHbrvYV3FmdHWaBQ+mS
         an+gfrf9P2SmIEVGersz7U2aVBf68J01ft6dRoQEn4f1r6Z8GDxDJxaqb24DPoX8Bk11
         u6M1Bkwp5IiYKd1/Ourp2+5Kx2AZ/aVaK2mLUnJDO44ORH5VIrNFWnNB8D5BDQmwwjR3
         Hfbw==
X-Gm-Message-State: AOAM530UUkUPFXFm5t7JaMwEUAHXEuk1jy9RroP58Gwj6ZglqI4Lc330
        M3iQce6Ab34pCzSq/VFi6IpClS0wNcHPk/mTcGA=
X-Google-Smtp-Source: ABdhPJxh25EHE5pKS0sdBj8nqoTs6+xG5QKiYEncfV5Hy57QsH9ZmJju5ZQ8eajkYJ+e4UmbnwdykzjVJHPYkpdGqmM=
X-Received: by 2002:a1f:3806:0:b0:357:34f9:bfe0 with SMTP id
 f6-20020a1f3806000000b0035734f9bfe0mr2929307vka.21.1654203668382; Thu, 02 Jun
 2022 14:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220529182036.10226-1-jose.exposito89@gmail.com>
 <20220530083752.1973a905@ultrarare.space> <20220530061812.GA10391@elementary>
 <20220531221102.7bd7da7d@ultrarare.space> <20220531223330.3d63e2fe@ultrarare.space>
 <20220531172053.GA10651@elementary> <CAPnXWxG8gbe1arQK9kBtwM1Xcta+wreTN742kgtBBr1v0ewKug@mail.gmail.com>
 <7f67ac07b8bd37d5817cd151674cc6b0@ultrarare.space> <20220601072651.242ce08a@ultrarare.space>
 <20220601121737.1226ffea@ultrarare.space> <20220601174956.GA10418@elementary> <20220602161219.152be32d@ultrarare.space>
In-Reply-To: <20220602161219.152be32d@ultrarare.space>
From:   Bryan Cain <bryancain3@gmail.com>
Date:   Thu, 2 Jun 2022 15:00:57 -0600
Message-ID: <CAPnXWxFU1RfVJ1LRMxevPSH5Y0tggx-t7ZuwdXkrba9mmOLojw@mail.gmail.com>
Subject: Re: [PATCH v5] HID: apple: Properly handle function keys on non-Apple keyboard
To:     Hilton Chain <hako@ultrarare.space>
Cc:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
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

This version looks good, and works without issue on my Keychron C1.
Thanks for implementing it!

Reviewed-by: Bryan Cain <bryancain3@gmail.com>
Tested-by: Bryan Cain <bryancain3@gmail.com>

Regards,
Bryan

On Thu, Jun 2, 2022 at 2:12 AM Hilton Chain <hako@ultrarare.space> wrote:
>
> This commit extends fa33382c7f74 ("HID: apple: Properly handle function
> keys on Keychron keyboards") by adding an array of known non-Apple
> keyboards' device names, and the function apple_is_non_apple_keyboard()
> to identify and create exception for them.
>
> Signed-off-by: Hilton Chain <hako@ultrarare.space>
> ---
>
> V4 -> V5: Add Varmilo keyboards' name "AONE" to the exception list
> V3 -> V4: Remove unnecessary strlen()
>
>  drivers/hid/hid-apple.c | 34 +++++++++++++++++++++++++++++-----
>  1 file changed, 29 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
> index 42a568902f49..7fbde58e1219 100644
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
> @@ -313,6 +317,26 @@ static const struct apple_key_translation swapped_fn_leftctrl_keys[] = {
>         { }
>  };
>
> +static const struct apple_non_apple_keyboard non_apple_keyboards[] = {
> +       { "SONiX USB DEVICE" },
> +       { "Keychron" },
> +       { "AONE" }
> +};
> +
> +static bool apple_is_non_apple_keyboard(struct hid_device *hdev)
> +{
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(non_apple_keyboards); i++) {
> +               char *non_apple = non_apple_keyboards[i].name;
> +
> +               if (strncmp(hdev->name, non_apple, strlen(non_apple)) == 0)
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
>  static inline void apple_setup_key_translation(struct input_dev *input,
>                 const struct apple_key_translation *table)
>  {
> @@ -363,7 +387,7 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
>         }
>
>         if (fnmode == 3) {
> -               real_fnmode = (asc->quirks & APPLE_IS_KEYCHRON) ? 2 : 1;
> +               real_fnmode = (asc->quirks & APPLE_IS_NON_APPLE) ? 2 : 1;
>         } else {
>                 real_fnmode = fnmode;
>         }
> @@ -669,9 +693,9 @@ static int apple_input_configured(struct hid_device *hdev,
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
> base-commit: d1dc87763f406d4e67caf16dbe438a5647692395
> --
> 2.36.1
>

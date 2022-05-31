Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3088153955E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 19:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346496AbiEaRVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 13:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236667AbiEaRVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 13:21:02 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8383CFE7;
        Tue, 31 May 2022 10:21:00 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id d5-20020a05600c34c500b0039776acee62so1257834wmq.1;
        Tue, 31 May 2022 10:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jQ4GDBetYenwz6wuOfGu54n2JTdY9CBw0hORhkYyzLM=;
        b=aIjhlncpiNyGPSbvfXHNI/BrPnbGGn+YxRozw0Xdc3hPxJZpCSQy57hULzzdgule3G
         x2BHOg5CZinjLMWLyTbfNJLRTr4B+c5ZFrXUl20dAdeo8jRUiMa8Hkd0ocEZU+u26cxA
         PGtG7nrp+26ymTrn205UA2eMivLHb9ygF2fF2S9qTxTCJp2uZoWtZ8duVQNOjNMMcYty
         ANBoj6BNE73hOd6q/zC+dtk3TGv1U0rqBfqm8panfzZ1YrNR1kfer2JfAj5h2/FD6krY
         iN1Ixc8ceCGTnICc/VL5s52+/Lx1Q+aJSKhjrWrZmSDbKuutCUPtvw27zCNLQSiep9tI
         SAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jQ4GDBetYenwz6wuOfGu54n2JTdY9CBw0hORhkYyzLM=;
        b=QBdECTr8AQRnw2xtbGHbi8tCt6ZF6rSuU/YvuTUkQ7ZS79i0GT4lwrkyLdsIlmqSyX
         MgfmPlsrltA2NFzVeRFKIJStHXlqxUboZkd1BnjjYe/1Fb/FgZoKuKbPIifqDgq76p70
         pf9UexeNcH0mcR/ae4yg/3+x5plIKOCJDss4MePn708LJqJE8Oiu8FJPcIx73aqmdT9y
         8FknBXjneJL7ROPmWMGVOWkzr8r1zFCbLGz3rZ4q3xF8Coi7fyEpkUK6K03rZhz5EmQi
         C6S9OLXvBhp42n6u/zL3akcmJ4RqwodUAHqSZVKnRotP7hpFB1j8qtucDTbrnrGP2uAl
         w+iw==
X-Gm-Message-State: AOAM530KSKCUjCL9Aw5YIxkRExzIHeCjRq3p+ivjG/8ny8pajZzLm/pn
        CKIVVbzEZ1tOdkeAA96a880=
X-Google-Smtp-Source: ABdhPJxjLzi3GM2IVCU/1X9UbuhiVPWdYg0/65GWl4v924yzr0RPi8nJQEzmEhOgztEi4nGR3tdcvQ==
X-Received: by 2002:a05:600c:198f:b0:394:952d:9a72 with SMTP id t15-20020a05600c198f00b00394952d9a72mr24149133wmq.72.1654017659226;
        Tue, 31 May 2022 10:20:59 -0700 (PDT)
Received: from elementary ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id 12-20020a5d47ac000000b0020c6b78eb5asm13660146wrb.68.2022.05.31.10.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 10:20:58 -0700 (PDT)
Date:   Tue, 31 May 2022 19:20:53 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Hilton Chain <hako@ultrarare.space>
Cc:     bryancain3@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v2] HID: apple: Workaround for non-Apple keyboards
Message-ID: <20220531172053.GA10651@elementary>
References: <20220529180230.17e9a0f9@ultrarare.space>
 <20220529182036.10226-1-jose.exposito89@gmail.com>
 <20220530083752.1973a905@ultrarare.space>
 <20220530061812.GA10391@elementary>
 <20220531221102.7bd7da7d@ultrarare.space>
 <20220531223330.3d63e2fe@ultrarare.space>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220531223330.3d63e2fe@ultrarare.space>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hilton,

Thanks for sending v2 of this patch.
Please find a couple of minor comments inline:

On Tue, May 31, 2022 at 10:33:30PM +0800, Hilton Chain wrote:
> There's a bunch of non-Apple keyboard misuses Apple's vendor and product
> id, causing hid_apple to be served for them. However they can't handle the
> default fnmode.
> 
> This commit adds an array of non-Apple keyboards' device names, together
> with a function apple_is_non_apple_keyboard() to identify and create
> exception for them.
> 
> Signed-off-by: Hilton Chain <hako@ultrarare.space>
> ---
>  drivers/hid/hid-apple.c | 40 ++++++++++++++++++++++++++++++++++------
>  1 file changed, 34 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
> index 42a568902f49..4429b25ae3d8 100644
> --- a/drivers/hid/hid-apple.c
> +++ b/drivers/hid/hid-apple.c
> @@ -36,7 +36,7 @@
>  #define APPLE_NUMLOCK_EMULATION	BIT(8)
>  #define APPLE_RDESC_BATTERY	BIT(9)
>  #define APPLE_BACKLIGHT_CTL	BIT(10)
> -#define APPLE_IS_KEYCHRON	BIT(11)
> +#define APPLE_IS_NON_APPLE	BIT(11)
>  
>  #define APPLE_FLAG_FKEY		0x01
>  
> @@ -65,6 +65,10 @@ MODULE_PARM_DESC(swap_fn_leftctrl, "Swap the Fn and left Control keys. "
>  		"(For people who want to keep PC keyboard muscle memory. "
>  		"[0] = as-is, Mac layout, 1 = swapped, PC layout)");
>  
> +struct apple_non_apple_keyboard {
> +	char *name;
> +};
> +
>  struct apple_sc_backlight {
>  	struct led_classdev cdev;
>  	struct hid_device *hdev;
> @@ -313,6 +317,29 @@ static const struct apple_key_translation swapped_fn_leftctrl_keys[] = {
>  	{ }
>  };
>  
> +static const struct apple_non_apple_keyboard non_apple_keyboards[] = {
> +	{ "SONiX USB DEVICE" },
> +	{ "Keychron" },
> +	{ }

Could the "non_apple && strlen(non_apple)" check be avoided by removing
this empty item?

> +};
> +
> +static bool apple_is_non_apple_keyboard(struct hid_device *hdev)
> +{
> +	unsigned long i;
> +	unsigned long non_apple_total = sizeof(non_apple_keyboards) /
> +					sizeof(struct apple_non_apple_keyboard);

Here you coud take advantage of the "ARRAY_SIZE" macro:

https://kernelnewbies.org/MagicMacros

It'll also allow you to use an int. Something similar to:

	int i;

	for (i = 0; i < ARRAY_SIZE(non_apple_keyboards); i++) {
		[...]

> +
> +	for (i = 0; i < non_apple_total; i++) {
> +		char *non_apple = non_apple_keyboards[i].name;
> +
> +		if (non_apple && strlen(non_apple) &&

This is the check I meant in my first comment ^

> +				strncmp(hdev->name, non_apple, strlen(non_apple)) == 0)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  static inline void apple_setup_key_translation(struct input_dev *input,
>  		const struct apple_key_translation *table)
>  {
> @@ -363,7 +390,7 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
>  	}
>  
>  	if (fnmode == 3) {
> -		real_fnmode = (asc->quirks & APPLE_IS_KEYCHRON) ? 2 : 1;
> +		real_fnmode = (asc->quirks & APPLE_IS_NON_APPLE) ? 2 : 1;
>  	} else {
>  		real_fnmode = fnmode;
>  	}
> @@ -667,11 +694,12 @@ static int apple_input_configured(struct hid_device *hdev,
>  	if ((asc->quirks & APPLE_HAS_FN) && !asc->fn_found) {
>  		hid_info(hdev, "Fn key not found (Apple Wireless Keyboard clone?), disabling Fn key handling\n");
>  		asc->quirks &= ~APPLE_HAS_FN;
> -	}
>  
> -	if (strncmp(hdev->name, "Keychron", 8) == 0) {
> -		hid_info(hdev, "Keychron keyboard detected; function keys will default to fnmode=2 behavior\n");
> -		asc->quirks |= APPLE_IS_KEYCHRON;
> +		if (apple_is_non_apple_keyboard(hdev)) {
> +			hid_info(hdev,
> +				"Non-apple keyboard detected; function keys will default to fnmode=2 behavior\n");

Checkpatch nitpick:

	CHECK: Alignment should match open parenthesis
	FILE: drivers/hid/hid-apple.c:700:
	hid_info(hdev,
		"Non-apple keyboard detected; function keys will default to fnmode=2 behavior\n");

It suggest to add  an extra space before "Non-apple ...".

In case you don't know the tool, it helps to find style errors, I
usually run it like:

$ ./scripts/checkpatch.pl --strict --codespell --git HEAD-1


> +			asc->quirks |= APPLE_IS_NON_APPLE;
> +		}

This slightly changes the behaviour from the previous patch.
Previously, the APPLE_IS_NON_APPLE quirk was set even if APPLE_HAS_FN
was not present. Now the condition is nested.

I'm not saying it is wrong (I don't have the required hardware to test
it), I'm just pointing it out in case it was an accidental change.
Bryan, should be able to confirm if it works with his keyboard.

>  	}
>  
>  	return 0;
> 
> base-commit: 8ab2afa23bd197df47819a87f0265c0ac95c5b6a
> -- 
> 2.36.1
> 


Best wishes,
José Expósito

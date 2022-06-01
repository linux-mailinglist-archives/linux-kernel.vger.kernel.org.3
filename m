Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CB853AC36
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 19:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354329AbiFARuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 13:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbiFARuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 13:50:15 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380A86A40C;
        Wed,  1 Jun 2022 10:50:10 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id o9so1397653wmd.0;
        Wed, 01 Jun 2022 10:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=oFDSjGzOC7Yt8zXCvAzGpMV1fjzJ0kn1d0jbMghS1lM=;
        b=djqh0v1UQGMY/UBGjOP8mswUR9Z45h5eYv2KKlSCbt1XZUHIVOIttNvAMp8CKQh2wF
         kffz8AKxzZ8B3kPm5IcqnBI0t7eFgO+aDaFRlQ6O/C2SLZjvxmm4KuLntaKZ5rbbHDIh
         Dc5BNOj9SSitBCY/AaFyLaRoRiLwWprOnLWhXlF+EygID5XyYMO6/vCaIkOeOnndVxbF
         ZuQpOf3mVJ/NEwsQBtzzl9/+Q7L1RrVB75FlTCkGudDTIm663tod+Sn4H/BB0YfFKBT/
         RICTrsa/G39RI1daTMeg/pQwt9vHILbhUeC7WtILlsXo2wI6kJN0A97LQi/6N9JWgTRU
         VnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=oFDSjGzOC7Yt8zXCvAzGpMV1fjzJ0kn1d0jbMghS1lM=;
        b=j2LY7PuFCQ5d9v5sR3/bEfxRhXGrgca5yxdGsfNiOJedBmL8RAoIuC3dzQ32L5VXAW
         YfBX316F5c+UygW9G7w4oCeDhL2r0IiQWVavdmS8X9mcmm1OcBUUdL/i/hCgWmtSX93f
         /3TV40HbCLK5iZjrD09qM3etnDoVyprtKtK8r5jqsRne2Wr976vrCvpWdi80RXBJ1edX
         PZhqRFgCdF24ghvRrcvfod6MkgA6sbbAqtI9fiF7q9RWmkqvCJTFz955ymML13S39bVJ
         5Z3SJekD2wMnj64Wc3HSKZTlMVbI8mpkDQpqeBMrNFjEfpjKqJDItGK7kcNKMkUd3kJ0
         b3GQ==
X-Gm-Message-State: AOAM533E7v3LOkb04NsEtAeMLHnz76BnmKo1zCHtDfdGcuueHLCd6m4a
        W/wtSpeBr1U+wrYAzXPOICYeEWKlPcYRqg==
X-Google-Smtp-Source: ABdhPJw4Xda2+DQCadaUdvYOx3qdLmh+LURFRRYbmHPrRoVSGS4wqnpcdkm34fx+HA3IbforrDVWJw==
X-Received: by 2002:a7b:c241:0:b0:397:4925:6d62 with SMTP id b1-20020a7bc241000000b0039749256d62mr513811wmj.192.1654105808687;
        Wed, 01 Jun 2022 10:50:08 -0700 (PDT)
Received: from elementary ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id l13-20020a5d560d000000b0020fe35aec4bsm2247888wrv.70.2022.06.01.10.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 10:50:08 -0700 (PDT)
Date:   Wed, 1 Jun 2022 19:49:56 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Hilton Chain <hako@ultrarare.space>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v4] HID: apple: Properly handle function keys on
 non-Apple keyboard
Message-ID: <20220601174956.GA10418@elementary>
References: <20220529182036.10226-1-jose.exposito89@gmail.com>
 <20220530083752.1973a905@ultrarare.space>
 <20220530061812.GA10391@elementary>
 <20220531221102.7bd7da7d@ultrarare.space>
 <20220531223330.3d63e2fe@ultrarare.space>
 <20220531172053.GA10651@elementary>
 <CAPnXWxG8gbe1arQK9kBtwM1Xcta+wreTN742kgtBBr1v0ewKug@mail.gmail.com>
 <7f67ac07b8bd37d5817cd151674cc6b0@ultrarare.space>
 <20220601072651.242ce08a@ultrarare.space>
 <20220601121737.1226ffea@ultrarare.space>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220601121737.1226ffea@ultrarare.space>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 12:17:37PM +0800, Hilton Chain wrote:
> This commit extends fa33382c7f74 ("HID: apple: Properly handle function
> keys on Keychron keyboards") by adding an array of known non-Apple
> keyboards' device names, and the function apple_is_non_apple_keyboard()
> to identify and create exception for them.
> 
> Signed-off-by: Hilton Chain <hako@ultrarare.space>


v4 looks good to me, thanks for adding the suggested changes!

Reviewed-by: José Expósito <jose.exposito89@gmail.com>


> ---
> 
> V3 -> V4: Removed unnecessary strlen()
> 
>  drivers/hid/hid-apple.c | 33 ++++++++++++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
> index 42a568902f49..4ec39c5e762a 100644
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
> @@ -313,6 +317,25 @@ static const struct apple_key_translation swapped_fn_leftctrl_keys[] = {
>  	{ }
>  };
>  
> +static const struct apple_non_apple_keyboard non_apple_keyboards[] = {
> +	{ "SONiX USB DEVICE" },
> +	{ "Keychron" },
> +};
> +
> +static bool apple_is_non_apple_keyboard(struct hid_device *hdev)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(non_apple_keyboards); i++) {
> +		char *non_apple = non_apple_keyboards[i].name;
> +
> +		if (strncmp(hdev->name, non_apple, strlen(non_apple)) == 0)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  static inline void apple_setup_key_translation(struct input_dev *input,
>  		const struct apple_key_translation *table)
>  {
> @@ -363,7 +386,7 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
>  	}
>  
>  	if (fnmode == 3) {
> -		real_fnmode = (asc->quirks & APPLE_IS_KEYCHRON) ? 2 : 1;
> +		real_fnmode = (asc->quirks & APPLE_IS_NON_APPLE) ? 2 : 1;
>  	} else {
>  		real_fnmode = fnmode;
>  	}
> @@ -669,9 +692,9 @@ static int apple_input_configured(struct hid_device *hdev,
>  		asc->quirks &= ~APPLE_HAS_FN;
>  	}
>  
> -	if (strncmp(hdev->name, "Keychron", 8) == 0) {
> -		hid_info(hdev, "Keychron keyboard detected; function keys will default to fnmode=2 behavior\n");
> -		asc->quirks |= APPLE_IS_KEYCHRON;
> +	if (apple_is_non_apple_keyboard(hdev)) {
> +		hid_info(hdev, "Non-apple keyboard detected; function keys will default to fnmode=2 behavior\n");
> +		asc->quirks |= APPLE_IS_NON_APPLE;
>  	}
>  
>  	return 0;
> 
> base-commit: 700170bf6b4d773e328fa54ebb70ba444007c702
> -- 
> 2.36.1
> 

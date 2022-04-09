Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4DB4FA104
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 03:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240217AbiDIBYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 21:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237743AbiDIBYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 21:24:41 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8055FB1B;
        Fri,  8 Apr 2022 18:22:35 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-de3ca1efbaso11504256fac.9;
        Fri, 08 Apr 2022 18:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=o8fu92V8462s1fJQA0hYQ/TEBk9TpllnF6Rg4uae8yI=;
        b=Xih0AdUs314YDR1r7fRxuj+u4jAtvIEja75T0SWYBcnZ884luFH5GP2lsbmbxEnDzC
         43+hETZqDcDVv6B7NfoKbSiHE8SHXIKooT2polj2gR3hoItKHeGDUkhnLXJeUYOrHDdJ
         2/4uDcFnSgr7BKdaRDoVm0T/qlRkB4z3LuABmqkiB1NOtW0LmebyuWgMaQWMfAYKwJXw
         LB4Q1MOJxRjQwrGRkFOdrmuHwG/iclWa8M9jI0NAzLFWs10hYJdD9N8f3t7QXClQjLEn
         6L90HH/mvm50f0X9quGu3jQtLZlYuZqLK9Gh4uG9tL5/A2KAWx6HZMeqzPn5S5s8seUZ
         gk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=o8fu92V8462s1fJQA0hYQ/TEBk9TpllnF6Rg4uae8yI=;
        b=CpBITARD9Ef/64dNTlsWqqBTNS27j47KZw+/ZP7QCNLgb5b5hql/0l9fs2kA6bA5Cp
         wegCb/kSIqXurTce9qK3HsTRISB11aZwZYL8tpi1Ny8zC7Qe8suzU0oD0cKIimBgqAUP
         aGSPtphl77vbTLBojiFuqNfzhW+7aKXmCGbRH0Id7gIJeKhDL5E3lcUMh8rMWhLuVNKg
         N3IjZ/nXD/ywZ599THrSlyXmg/91TgIGLzkSDNm78AQsAN0MnuUujqjaqP4UkeoNuvUi
         oNp27vvhC4dQN50hb1KXsffKafE45vH9GXb87Z5tMiiy8UGOQkpEihN7pmKqYu/R1F5M
         oiTw==
X-Gm-Message-State: AOAM533RUl/3ATarPjVovbh1Rng/IgK5bZDHpV/46+E2nuRWP6I0S/nE
        yO4IKlYltrFlquDkhL+e31kdqiIarqKlxgomy0c=
X-Google-Smtp-Source: ABdhPJyZf9TZKqMzrqGT/RD9E7girUkn8gTqBwJfUc8LnI9ftLGZmrGBYPuQ9hRFpKVb8MAOuKOi+Q==
X-Received: by 2002:a05:6870:328f:b0:de:f16d:d187 with SMTP id q15-20020a056870328f00b000def16dd187mr10060541oac.132.1649467354603;
        Fri, 08 Apr 2022 18:22:34 -0700 (PDT)
Received: from ?IPV6:2600:1700:4830:3f7f:7aac:34da:1863:159e? ([2600:1700:4830:3f7f:7aac:34da:1863:159e])
        by smtp.gmail.com with ESMTPSA id z5-20020a056830128500b005cdc661ad98sm9648059otp.28.2022.04.08.18.22.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 18:22:34 -0700 (PDT)
Message-ID: <1e06a151-5e81-d0e6-d1c3-77f7e420f208@gmail.com>
Date:   Fri, 8 Apr 2022 20:22:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] HID: microsoft: Fix button/axis mapping for Xbox One S
 Controller
Content-Language: en-US
To:     Daniel Bomar <dbdaniel42@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220408140902.15966-1-dbdaniel42@gmail.com>
From:   Cameron Gutman <aicommander@gmail.com>
In-Reply-To: <20220408140902.15966-1-dbdaniel42@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/22 09:09, Daniel Bomar wrote:
> Remaps several buttons and axes to match how these are mapped in the
> xpad driver (same controller over USB).
> 
> This is also how they are documented to be mapped in
> Documentation/input/gamepad.rst
> ---

Hi Daniel,

I don't think this is a good idea. Remapping this is going to cause
problems for userspace applications and libraries that already have
mappings for this gamepad (such as SDL [0]).

At the very least, you should set a bit in the version like hid-sony.c
does so SDL can tell the new and old mappings apart. However, I still
don't think it's worth making this change at all. In the _best_ case,
you break a ton of existing games and applications that have support
for this gamepad already and achieve very little practical gain.

I believe this change will break Android's mapping too [1]. Using
GAS/BRAKE for triggers is fairly common for gamepads designed for
Android, so it's likely that Microsoft did it this way on purpose.
I don't think we should be overruling their conscious design decisions
without very compelling reasons.

It's definitely not ideal that the mappings between USB and BT differ,
but breaking existing applications by changing it is much worse.

[0]: https://github.com/libsdl-org/SDL/blob/505d6a4a052592b2676f87456c1f564daa8d2c50/src/joystick/SDL_gamecontrollerdb.h#L795
[1]: https://cs.android.com/android/platform/superproject/+/master:frameworks/base/data/keyboards/Vendor_045e_Product_02fd.kl

Regards,
Cameron

>  drivers/hid/hid-microsoft.c | 73 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 72 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
> index 071fd093a5f4..903e09a3d898 100644
> --- a/drivers/hid/hid-microsoft.c
> +++ b/drivers/hid/hid-microsoft.c
> @@ -27,6 +27,7 @@
>  #define MS_DUPLICATE_USAGES	BIT(5)
>  #define MS_SURFACE_DIAL		BIT(6)
>  #define MS_QUIRK_FF		BIT(7)
> +#define MS_XBOX			BIT(8)
>  
>  struct ms_data {
>  	unsigned long quirks;
> @@ -179,6 +180,70 @@ static int ms_surface_dial_quirk(struct hid_input *hi, struct hid_field *field,
>  	return 0;
>  }
>  
> +#define ms_map_abs_clear(c)	hid_map_usage_clear(hi, usage, bit, max, \
> +					EV_ABS, (c))
> +/*
> + * Remap buttons and axes on Xbox controllers over bluetooth so they match
> + * with the xpad driver (USB interface) and with mapping specified in
> + * Documentation/input/gamepad.rst
> +*/
> +static int ms_xbox_quirk(struct hid_input *hi, struct hid_usage *usage,
> +		unsigned long **bit, int *max)
> +{
> +	int code;
> +	switch (usage->hid & HID_USAGE_PAGE) {
> +		/*
> +		 * Remap "Xbox" and Select buttons from consumer page to gamepad buttons.
> +		 * This allows these buttons to show up on the /dev/input/js* interface.
> +		*/
> +		case HID_UP_CONSUMER:
> +			switch (usage->hid & HID_USAGE) {
> +				case 0x223:
> +					ms_map_key_clear(BTN_MODE);
> +					return 1;
> +				case 0x224:
> +					ms_map_key_clear(BTN_SELECT);
> +					return 1;
> +			}
> +			break;
> +		/* These buttons do not physically exist on the controller. Ignore them. */
> +		case HID_UP_BUTTON:
> +			code = ((usage->hid - 1) & HID_USAGE) + BTN_GAMEPAD;
> +			switch (code) {
> +				case BTN_C:
> +				case BTN_Z:
> +				case BTN_TL2:
> +				case BTN_TR2:
> +					return -1;
> +			}
> +			break;
> +		/* Remap right joystick to RX/RY */
> +		case HID_UP_GENDESK:
> +			switch (usage->hid) {
> +				case HID_GD_Z:
> +					ms_map_abs_clear(ABS_RX);
> +					return 1;
> +				case HID_GD_RZ:
> +					ms_map_abs_clear(ABS_RY);
> +					return 1;
> +			}
> +			break;
> +		/* Remap left and right triggers from "gas" and "break" to RZ/Z */
> +		case HID_UP_SIMULATION:
> +			switch (usage->hid & HID_USAGE) {
> +				case 0xc4:
> +					ms_map_abs_clear(ABS_RZ);
> +					return 1;
> +				case 0xc5:
> +					ms_map_abs_clear(ABS_Z);
> +					return 1;
> +			}
> +			break;
> +	}
> +
> +	return 0;
> +}
> +
>  static int ms_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>  		struct hid_field *field, struct hid_usage *usage,
>  		unsigned long **bit, int *max)
> @@ -203,6 +268,12 @@ static int ms_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>  			return ret;
>  	}
>  
> +	if (quirks & MS_XBOX) {
> +		int ret = ms_xbox_quirk(hi, usage, bit, max);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -447,7 +518,7 @@ static const struct hid_device_id ms_devices[] = {
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, 0x091B),
>  		.driver_data = MS_SURFACE_DIAL },
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_ONE_S_CONTROLLER),
> -		.driver_data = MS_QUIRK_FF },
> +		.driver_data = MS_QUIRK_FF | MS_XBOX },
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_8BITDO_SN30_PRO_PLUS),
>  		.driver_data = MS_QUIRK_FF },
>  	{ }
> 

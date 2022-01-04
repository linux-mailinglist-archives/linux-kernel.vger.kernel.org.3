Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84F1483BE6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 07:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbiADGWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 01:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbiADGWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 01:22:47 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59A6C061761;
        Mon,  3 Jan 2022 22:22:46 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id f5so2523020pgk.12;
        Mon, 03 Jan 2022 22:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=b3pYK+BInmnqYZZWk4LawmaFXBSOW3m+FQr02geDmQg=;
        b=DHP02ughMySkG2UP2UW2dPFng1HwZLTajCZPekmYJm39Brh+pz/uaPaBI052JMC4uf
         BBvc6wt6wziXlTwrURCAIJ846olk/V0i3Eu2mecP5lAFrkX6ZIrUq4tllrtsx/PBWDCY
         6gZnUXdx6pkqKYWYK++bgoEr0Zp1NgZZuT0pzteCd3WrlAl11zsHpsIj0yztE2V/q5HY
         hgX9F3xnqeW0m9KyfCtn9j548PYaRyQZ1ZAbslRr2hXsrs0pY4p7UjIOXPo9C/MLpZoO
         TKVQS6anCGjx1eC9D6Junx245gpzgN7EmXmPC7lC5olbCvHU7iqg+HEJs2axS1LKvJH/
         6+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=b3pYK+BInmnqYZZWk4LawmaFXBSOW3m+FQr02geDmQg=;
        b=OH2EjEi9fcWOA+2hlFztT0ybmUYt4mH+djk9dNw9oBD3tnoqSpYf2fIcn/YyBhVZhE
         mNvSoOtl6Wr1C+AdrzThaZRnEfNWXisEM5mHxcTWEPJk8nebXQP9ouIwkvr4039kYQ/H
         ojv6RcN+0OM7EV92zKQvPPWe4l09/MUGRulfndqqBmyoQDGjnCOwcUWkQpBwMu9UA3QQ
         HPMktw643MDXbAeIY7OAtlgwLWlZwFQ70Age9gmwQYcKxyXEFJQtiN9DtdgOPm1DFhEw
         jxFoF19/dE2Fvq1+PHHMAbWv+7M1Cnuagp9j75wppExfJwvtEG4/SECxI5Vs6qXJExie
         T/3A==
X-Gm-Message-State: AOAM5306cdQUHSZwOmzs2uCoStjkf/LHXpKC0nGgxaSWpjkg/izkvebw
        SQkq1X7WXyQ/8wxd5iTswBQ=
X-Google-Smtp-Source: ABdhPJy4Lfek1J2TlAKZlqPjwzZ/53SwZO+MDBb+gcg4yK+QK0aTdyRLM7XKsa2sa8+bplhbQNEtRA==
X-Received: by 2002:a63:824a:: with SMTP id w71mr43794769pgd.74.1641277366273;
        Mon, 03 Jan 2022 22:22:46 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a7d6:43d7:bbe3:3573])
        by smtp.gmail.com with ESMTPSA id g66sm39385189pfb.64.2022.01.03.22.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 22:22:45 -0800 (PST)
Date:   Mon, 3 Jan 2022 22:22:42 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        peter.hutterer@who-t.net, roderick.colenbrander@sony.com,
        pali@kernel.org, rydberg@bitmath.org, nick@shmanahar.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Input: add input_set_property()
Message-ID: <YdPnsiFTc2/7f83z@google.com>
References: <20211202110807.6783-1-jose.exposito89@gmail.com>
 <20211202110807.6783-2-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211202110807.6783-2-jose.exposito89@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi José,

On Thu, Dec 02, 2021 at 12:08:06PM +0100, José Expósito wrote:
> Buttonpads are expected to map the INPUT_PROP_BUTTONPAD property bit
> and the BTN_LEFT key bit.
> 
> As explained in the specification, where a device has a button type
> value of 0 (click-pad) or 1 (pressure-pad) there should not be
> discrete buttons:
> https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/touchpad-windows-precision-touchpad-collection#device-capabilities-feature-report
> 
> However, some drivers map the BTN_RIGHT and/or BTN_MIDDLE key bits even
> though the device is a buttonpad and therefore does not have those
> buttons.
> 
> This behavior has forced userspace applications like libinput to
> implement different workarounds and quirks to detect buttonpads and
> offer to the user the right set of features and configuration options.
> For more information:
> https://gitlab.freedesktop.org/libinput/libinput/-/merge_requests/726
> 
> In order to avoid this issue add a helper function for drivers to add
> device properties and make sure that the conditions associated with the
> INPUT_PROP_BUTTONPAD property are meet.
> 
> Notice that this change will not affect udev because it does not check
> for buttons. See systemd/src/udev/udev-builtin-input_id.c.
> 
> List of known affected hardware:
> 
>  - Chuwi AeroBook Plus
>  - Chuwi Gemibook
>  - Framework Laptop
>  - GPD Win Max
>  - Huawei MateBook 2020
>  - Prestigio Smartbook 141 C2
>  - Purism Librem 14v1
>  - StarLite Mk II   - AMI firmware
>  - StarLite Mk II   - Coreboot firmware
>  - StarLite Mk III  - AMI firmware
>  - StarLite Mk III  - Coreboot firmware
>  - StarLabTop Mk IV - AMI firmware
>  - StarLabTop Mk IV - Coreboot firmware
>  - StarBook Mk V
> 
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> ---
>  drivers/input/input.c | 35 +++++++++++++++++++++++++++++++++++
>  include/linux/input.h |  1 +
>  2 files changed, 36 insertions(+)
> 
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index ccaeb2426385..f7e23b3b6ae5 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -2125,6 +2125,41 @@ void input_set_capability(struct input_dev *dev, unsigned int type, unsigned int
>  }
>  EXPORT_SYMBOL(input_set_capability);
>  
> +/**
> + * input_set_property - add a property to the device
> + * @dev: device to add the property to
> + * @property: type of the property (INPUT_PROP_POINTER, INPUT_PROP_DIRECT...)
> + *
> + * In addition to setting up corresponding bit in dev->propbit the function
> + * might add or remove related capabilities.
> + */
> +void input_set_property(struct input_dev *dev, unsigned int property)
> +{
> +	switch (property) {
> +	case INPUT_PROP_POINTER:
> +	case INPUT_PROP_DIRECT:
> +	case INPUT_PROP_SEMI_MT:
> +	case INPUT_PROP_TOPBUTTONPAD:
> +	case INPUT_PROP_POINTING_STICK:
> +	case INPUT_PROP_ACCELEROMETER:
> +		break;
> +
> +	case INPUT_PROP_BUTTONPAD:
> +		input_set_capability(dev, EV_KEY, BTN_LEFT);
> +		__clear_bit(BTN_RIGHT, dev->keybit);
> +		__clear_bit(BTN_MIDDLE, dev->keybit);

I would prefer if we did this when registering input device, not when
setting this property.

> +		break;
> +
> +	default:
> +		pr_err("%s: unknown property %u\n", __func__, property);
> +		dump_stack();
> +		return;
> +	}
> +
> +	__set_bit(property, dev->propbit);
> +}
> +EXPORT_SYMBOL(input_set_property);
> +
>  static unsigned int input_estimate_events_per_packet(struct input_dev *dev)
>  {
>  	int mt_slots;
> diff --git a/include/linux/input.h b/include/linux/input.h
> index 0354b298d874..5f357687da42 100644
> --- a/include/linux/input.h
> +++ b/include/linux/input.h
> @@ -456,6 +456,7 @@ static inline void input_mt_sync(struct input_dev *dev)
>  }
>  
>  void input_set_capability(struct input_dev *dev, unsigned int type, unsigned int code);
> +void input_set_property(struct input_dev *dev, unsigned int property);
>  
>  /**
>   * input_set_events_per_packet - tell handlers about the driver event rate
> -- 
> 2.25.1
> 

Thanks.

-- 
Dmitry

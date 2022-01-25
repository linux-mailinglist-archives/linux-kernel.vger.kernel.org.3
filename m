Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00EEA49A884
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1319192AbiAYDIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3420425AbiAYCYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 21:24:18 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D94C067A7C;
        Mon, 24 Jan 2022 18:03:58 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id s185so11715860oie.3;
        Mon, 24 Jan 2022 18:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4d+4TLddh1iILo0iPjAzyUaE64ZZAAUgPh4mjdb7zyo=;
        b=Lc6oqAUSjft7lGStVs9/NSozsAJW50sCPctsh1WZEziI2d7idluVCBhxfWMtC4L+Xf
         tJs6hIdkf0JYxQns/LWb5BY0wbYYlW0mKkO5jTLB5Ws0bkdVsFvHP7loaqNJ4UImpAiP
         Wx2c+a7Lz5/KzDYHNuZYG3k3QZI4isAMvit2ZHbIJQPtc80o/3orwfySWrp2s5gwsHxF
         b2TR/BLTP3VB6A4t95aAv4T4tWQIK1a2bKqPBRqt6akvXFT80rHAODYKpqOp/XxX/6pf
         sOKzAV3aXcAZH/u6yTpvRxn+Qc4SbMhcK6NzBgEs16ukXtuaCPJIsQ06oak1Ldgieo6/
         kIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=4d+4TLddh1iILo0iPjAzyUaE64ZZAAUgPh4mjdb7zyo=;
        b=FifHe7NuResyxzRfa0v/LGdH61a3n7A0FbR+LuUy8jLUD64JP96Cfcv9on84+jSVGc
         jc0peTPbQEK657GBcQ7e7NGFsBpSHZ77DfLKejd3XsmePuk2x1nktWpxO0Bo3relHbkL
         pkRE9/D9HbEwa82vZFnelubOHdSovLt5ZDGUh9oD4XHlojNJbYE7jBuEVPt0RcwVTGLm
         YqMtiZCf9u8Y+FhTWXW+2O6HEmEEAxJCVQXpFDCrlY6Qu336F1koKUNCIYPdLCUPd6gX
         1B+MYTV3hr5eFJ/C/HfMKQo1kfYBYWy2i2SVCrl7Ms3l6FchauAmGT6LCoXZ/VRsSoNj
         R0Jw==
X-Gm-Message-State: AOAM530hP6fWNdQiYTqmwreVqPtJ6YDcSAg+d2ENmmn8gx4FffoCZq2b
        +MNHJCF2Maqzoc8ns0UrzeledMCXOBU=
X-Google-Smtp-Source: ABdhPJxdUJEVns1KUuKUlAhBTewdl4UDYa5y5d4AWRYG9z57CPRk+j1G9ysAd0X250DH74alCBHGcg==
X-Received: by 2002:aca:eb88:: with SMTP id j130mr3721074oih.75.1643076238238;
        Mon, 24 Jan 2022 18:03:58 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j4sm737292oon.8.2022.01.24.18.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 18:03:57 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 24 Jan 2022 18:03:55 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Luiz Sampaio <sampaio.ime@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 03/31] hwmon: pmbus: changing LED_* from enum
 led_brightness to actual value
Message-ID: <20220125020355.GA355320@roeck-us.net>
References: <20220121165436.30956-1-sampaio.ime@gmail.com>
 <20220121165436.30956-4-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121165436.30956-4-sampaio.ime@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 01:54:08PM -0300, Luiz Sampaio wrote:
> The enum led_brightness, which contains the declaration of LED_OFF,
> LED_ON, LED_HALF and LED_FULL is obsolete, as the led class now supports
> max_brightness.

There is no Signed-off-by:, so this is not not a valid/acceptable patch.

> ---
>  drivers/hwmon/pmbus/ibm-cffps.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
> index e3294a1a54bb..cc20a70c723b 100644
> --- a/drivers/hwmon/pmbus/ibm-cffps.c
> +++ b/drivers/hwmon/pmbus/ibm-cffps.c
> @@ -382,10 +382,10 @@ static int ibm_cffps_led_brightness_set(struct led_classdev *led_cdev,
>  	u8 next_led_state;
>  	struct ibm_cffps *psu = container_of(led_cdev, struct ibm_cffps, led);
>  
> -	if (brightness == LED_OFF) {
> +	if (brightness == 0) {
>  		next_led_state = CFFPS_LED_OFF;
>  	} else {
> -		brightness = LED_FULL;
> +		brightness = 255;

If the LED subsystem no longer likes defines, we should have local constants
instead and not just use magic numbers. At the same time, this LED only supports
two states, off or on. There will have to be an explanation why the full range of
0..255 is still used and not just 0/1.

>  
>  		if (psu->led_state != CFFPS_LED_BLINK)
>  			next_led_state = CFFPS_LED_ON;
> @@ -426,7 +426,7 @@ static int ibm_cffps_led_blink_set(struct led_classdev *led_cdev,
>  		return rc;
>  
>  	psu->led_state = CFFPS_LED_BLINK;
> -	led_cdev->brightness = LED_FULL;
> +	led_cdev->brightness = 255;
>  	*delay_on = CFFPS_BLINK_RATE_MS;
>  	*delay_off = CFFPS_BLINK_RATE_MS;
>  
> @@ -442,7 +442,7 @@ static void ibm_cffps_create_led_class(struct ibm_cffps *psu)
>  	snprintf(psu->led_name, sizeof(psu->led_name), "%s-%02x", client->name,
>  		 client->addr);
>  	psu->led.name = psu->led_name;
> -	psu->led.max_brightness = LED_FULL;
> +	psu->led.max_brightness = 255;
>  	psu->led.brightness_set_blocking = ibm_cffps_led_brightness_set;
>  	psu->led.blink_set = ibm_cffps_led_blink_set;
>  

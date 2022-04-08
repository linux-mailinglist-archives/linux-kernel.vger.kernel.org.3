Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969C84F8C84
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 05:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbiDHB0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 21:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbiDHB0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 21:26:00 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7741578E3;
        Thu,  7 Apr 2022 18:23:57 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id j17so5626871pfi.9;
        Thu, 07 Apr 2022 18:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=//YiwRfPFbdmGMV9eJAUrTVTbYdWfAr8lJcc63WDfhE=;
        b=DUcVtqLVp345L37JvjnRF21s79RCEuwKSHNVC6trYg3oh9Z0Mu8SY1tL75UvTk/t29
         ECPZLf+X1BXO1IPcBf/pNnlAKWpWjVz8y5Irp+Uwa61jTxz7x5eMS82FxzuHEzYTjP2N
         w7Syk04sEK6WTKXolzHjjchv2nw23J18XUjaGoSKpKcL8IPX6ZvT9NwavJEp2P5dBkoM
         m9dr08JN58u4a5YLs0Z0kIbsCJvO5wMibCbXPpebApDKTZFcTJ/GOkelaKpjkG7AQwaf
         S/CzIovkDWQc0dojC9DIzHXrLX+pj8Ij9zi6Y6xpVwYlUFZLBfAcJzKJtazfVQRdZmqP
         hJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=//YiwRfPFbdmGMV9eJAUrTVTbYdWfAr8lJcc63WDfhE=;
        b=360yprCRbA8usObunnQgtumzm8v8Lbw3o0Gk7GeXK61HjkOOsx9U8sPJhBCAqeZnxr
         QiBAUMIMad491hDJz0wnkamPhDuhazhdleYmK1/1rRnlC3ElwK5KxpScvyVr/HBSAj8P
         /5idwk6YHnMHRtLnuuj1oco5wYZUyHW6wiwytbRW1SJRyaXhghialI5DKpS75Qss8WXm
         Ba/RlR8hHXOe7IsfdE80AXEhksk49l2dz6BTCU0uAkHFCNuLGlIefwONxnJOQlRoasF1
         KiXRwxLdLx7o5S4g52Dga+zlnL3I9//hjdrekYTmZPG1TwLDOZMOzyN9DpZR2DSlJZGT
         k4rw==
X-Gm-Message-State: AOAM533g1Fe/xdjGSQlpWXQJ+d3r8r9uVlBWYawxMDqVSAG3TEfzA7EH
        GbzRtcih50b3rMX7sk1jgtU=
X-Google-Smtp-Source: ABdhPJyXtGdPLXOeJ8D0jlRi2/acdDxcAsGXNjK7PivTukqzqht156R6WCbZ0LUl1cOWCDEGMVNDwg==
X-Received: by 2002:a63:6d88:0:b0:39c:ec64:c5e4 with SMTP id i130-20020a636d88000000b0039cec64c5e4mr2345158pgc.72.1649381037427;
        Thu, 07 Apr 2022 18:23:57 -0700 (PDT)
Received: from [192.168.1.5] ([110.78.142.75])
        by smtp.googlemail.com with ESMTPSA id y16-20020aa79af0000000b00505653b3badsm3877711pfp.213.2022.04.07.18.23.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 18:23:57 -0700 (PDT)
Message-ID: <4848899e-2c88-f6aa-8901-bf28266f2954@gmail.com>
Date:   Fri, 8 Apr 2022 08:23:52 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1 1/2] net: usb: cdc_ether: Add Fibocom L610 modem
Content-Language: en-US
To:     sven@svenschwermer.de, linux-usb@vger.kernel.org
Cc:     Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        linux-kernel@vger.kernel.org, oliver@neukum.org
References: <20220407074745.74195-1-sven@svenschwermer.de>
From:   Lars Melin <larsm17@gmail.com>
In-Reply-To: <20220407074745.74195-1-sven@svenschwermer.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/2022 14:47, sven@svenschwermer.de wrote:
> From: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> 
> T:  Bus=03 Lev=01 Prnt=01 Port=06 Cnt=04 Dev#=122 Spd=480  MxCh= 0
> D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=1782 ProdID=4d11 Rev= 0.00
> S:  Manufacturer=FIBOCOM
> S:  Product=L610
> C:* #Ifs= 9 Cfg#= 1 Atr=e0 MxPwr=400mA
> A:  FirstIf#= 0 IfCount= 2 Cls=02(comm.) Sub=06 Prot=00
> I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=06 Prot=00 Driver=cdc_ether
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=32ms
> I:  If#= 1 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
> I:* If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 6 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 7 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=88(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 8 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=08(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> 
> Signed-off-by: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> ---
>   drivers/net/usb/cdc_ether.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/usb/cdc_ether.c b/drivers/net/usb/cdc_ether.c
> index 9b4dfa3001d6..b09b5567aea2 100644
> --- a/drivers/net/usb/cdc_ether.c
> +++ b/drivers/net/usb/cdc_ether.c
> @@ -999,6 +999,12 @@ static const struct usb_device_id	products[] = {
>   				      USB_CDC_SUBCLASS_ETHERNET,
>   				      USB_CDC_PROTO_NONE),
>   	.driver_info = (unsigned long)&wwan_info,
> +}, {
> +	/* Fibocom L610 (+GTUSBMODE=32) */
> +	USB_DEVICE_AND_INTERFACE_INFO(0x1782, 0x4d11, USB_CLASS_COMM,
> +				      USB_CDC_SUBCLASS_ETHERNET,
> +				      USB_CDC_PROTO_NONE),
> +	.driver_info = (unsigned long)&wwan_info,
>   }, {
>   	USB_INTERFACE_INFO(USB_CLASS_COMM, USB_CDC_SUBCLASS_ETHERNET,
>   			USB_CDC_PROTO_NONE),

The same question for this one, why added to the whitelist?

thanks
Lars

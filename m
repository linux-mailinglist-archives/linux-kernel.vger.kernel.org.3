Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E974F8C8D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 05:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbiDHBRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 21:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiDHBRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 21:17:07 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A3927147;
        Thu,  7 Apr 2022 18:15:06 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id a16-20020a17090a6d9000b001c7d6c1bb13so8162795pjk.4;
        Thu, 07 Apr 2022 18:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Idjn34kuNBBfLlmwcM6XkwnNJSjd6HgvJJshg4x6j34=;
        b=SiN06LPFjNlk0fqA/8xabk/HLDehtoLlkMWHLQZ4sGuFgvMH8Pr8eGl6cS0w3RVL1q
         7LHZBJ5UcWX0gil6p3MzSW31TLOepSndhqSGv654TqM8YEsQeLX9nvjfJogAepQ9DSlc
         +XtxjqzcZ6HeqYifVin5lBPuSXMa29v4OO1wsqIuBQjs8jFbdHUE69pAXK5w9gubegFL
         2Q+Kjcm9UrvbGbn0tiffkVUH3sO3TqukQ17SKwjMMNWIpb6N79CXMoTzZm0E0375tF4d
         FFHLKML5X+2xhyB0hS9KcthjKBzxMfc2FKSTKOTWRgagz6P+QzqPjD4AX++VqXQ/jwAZ
         L58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Idjn34kuNBBfLlmwcM6XkwnNJSjd6HgvJJshg4x6j34=;
        b=2Gypk81W6lPN3zgsQOMzFpPkz3Mn9MrWPfsWrdDLMlrtlUud1CdeLMQjS7QWYOCrmr
         OCmrccyeAFKDXd2WAehTS9i383rQxdkfzEHIn5eXkk8hha2W4vn+KrPmLsRLlb2/89fv
         Ee8uUsqMregZ8XmVNL7/BcDDEiU5JZMpEYN6d9NKttDFYITz5gsgI9Fe27nT1QluCuH7
         3iGFJpwDG02BU2RUJwbWBxEn40juza+H1zJ88lkcq5V1DVCcuhn11b7R9UAbvyDmp917
         VxVO2hO8bSZ1JutO45kZLQURZzuCvSrIhrc+nqhG47kCL0RMiPBsndUZMLNt2tDyv6E/
         TQGg==
X-Gm-Message-State: AOAM532N4pagUYdI9zi4JsZDxKjPkAxZedc46fY0iFyXP6RH/jK1lN3D
        yw3BCXeZGKsSI+ql3wbArx7SbQt7PleecZkX
X-Google-Smtp-Source: ABdhPJyCX3ztY5bfjruQrRVJxAW56nV269fJn/l3lQt8OkK1msBDS+Hq505xUIIgXdyRwAR2RGdKIA==
X-Received: by 2002:a17:90b:224f:b0:1c9:949e:2202 with SMTP id hk15-20020a17090b224f00b001c9949e2202mr18808604pjb.56.1649380505412;
        Thu, 07 Apr 2022 18:15:05 -0700 (PDT)
Received: from [192.168.1.5] ([110.78.142.75])
        by smtp.googlemail.com with ESMTPSA id m21-20020a17090a7f9500b001c97c6bcaf4sm10270319pjl.39.2022.04.07.18.15.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 18:15:05 -0700 (PDT)
Message-ID: <3b8a8497-df41-8bf4-6816-f4419cb7f950@gmail.com>
Date:   Fri, 8 Apr 2022 08:15:00 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1 2/2] net: usb: cdc_ether: Add Fibocom MA510 modem
Content-Language: en-US
To:     sven@svenschwermer.de, linux-usb@vger.kernel.org
Cc:     Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        linux-kernel@vger.kernel.org, oliver@neukum.org
References: <20220407074745.74195-1-sven@svenschwermer.de>
 <20220407074745.74195-2-sven@svenschwermer.de>
From:   Lars Melin <larsm17@gmail.com>
In-Reply-To: <20220407074745.74195-2-sven@svenschwermer.de>
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
> +GTUSBMODE: 31
> --------------
> T:  Bus=03 Lev=01 Prnt=01 Port=06 Cnt=04 Dev#= 99 Spd=480  MxCh= 0
> D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=2cb7 ProdID=0106 Rev= 0.00
> S:  Manufacturer=Fibocom MA510 Modem
> S:  Product=Fibocom MA510 Modem
> S:  SerialNumber=55e2695b
> C:* #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=500mA
> A:  FirstIf#= 3 IfCount= 2 Cls=02(comm.) Sub=00 Prot=00
> I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> E:  Ad=82(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
> E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=fe Prot=ff Driver=option
> E:  Ad=84(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
> E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 3 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=06 Prot=00 Driver=cdc_ether
> E:  Ad=86(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
> I:  If#= 4 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
> I:* If#= 4 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
> E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> 
> +GTUSBMODE: 32
> --------------
> T:  Bus=03 Lev=01 Prnt=01 Port=06 Cnt=04 Dev#=100 Spd=480  MxCh= 0
> D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=2cb7 ProdID=010a Rev= 0.00
> S:  Manufacturer=Fibocom MA510 Modem
> S:  Product=Fibocom MA510 Modem
> S:  SerialNumber=55e2695b
> C:* #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=500mA
> A:  FirstIf#= 2 IfCount= 2 Cls=02(comm.) Sub=00 Prot=00
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=fe Prot=ff Driver=option
> E:  Ad=83(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
> E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 2 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=06 Prot=00 Driver=cdc_ether
> E:  Ad=85(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
> I:  If#= 3 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
> I:* If#= 3 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
> E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> 
> Signed-off-by: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> ---
>   drivers/net/usb/cdc_ether.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/net/usb/cdc_ether.c b/drivers/net/usb/cdc_ether.c
> index b09b5567aea2..c9367587698e 100644
> --- a/drivers/net/usb/cdc_ether.c
> +++ b/drivers/net/usb/cdc_ether.c
> @@ -1005,6 +1005,18 @@ static const struct usb_device_id	products[] = {
>   				      USB_CDC_SUBCLASS_ETHERNET,
>   				      USB_CDC_PROTO_NONE),
>   	.driver_info = (unsigned long)&wwan_info,
> +}, {
> +	/* Fibocom MA510 (+GTUSBMODE=31) */
> +	USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x0106, USB_CLASS_COMM,
> +				      USB_CDC_SUBCLASS_ETHERNET,
> +				      USB_CDC_PROTO_NONE),
> +	.driver_info = (unsigned long)&wwan_info,
> +}, {
> +	/* Fibocom MA510 (+GTUSBMODE=32) */
> +	USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x010a, USB_CLASS_COMM,
> +				      USB_CDC_SUBCLASS_ETHERNET,
> +				      USB_CDC_PROTO_NONE),
> +	.driver_info = (unsigned long)&wwan_info,
>   }, {
>   	USB_INTERFACE_INFO(USB_CLASS_COMM, USB_CDC_SUBCLASS_ETHERNET,
>   			USB_CDC_PROTO_NONE),

Why do you add this modem to the whitelist?
The net interface has the correct cdc_ether attributes so the cdc_ether 
driver should bind automagically without any need for the modem to be in 
the whitelist.

thanks
Lars

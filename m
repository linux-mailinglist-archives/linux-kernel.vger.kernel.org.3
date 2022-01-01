Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB394482799
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 13:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbiAAMX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 07:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiAAMX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 07:23:26 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0C8C061574;
        Sat,  1 Jan 2022 04:23:26 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id g13so36280516ljj.10;
        Sat, 01 Jan 2022 04:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/JJSTBWNyDVAnOx6SUMAARmZkCZKH2wbNxZkpQ1FD2k=;
        b=fnj61BVfjWwJWiHVTvzJTCj3axLOwTYFDaeIXS6WMeR6tJl/Z8IBs2MC9QG6P19hS+
         KeLK8jQXPOZSC6klPOrfhEmdiLiu+XP0wd/FQ8Vsedx1bpaplLuvv6QIMLGNQELG5Pxq
         fjug7M15f+aaM9CqSKiU1bMZUrj7B/pqC7txBo9OHPMjxXCSwQqeihub9qISN5M1U0/n
         dXZhHG0/KZPJzSDyojT45DUUHp9YUxxh+wi9OMYvkiUR2MAdZN7344iMnSDcwtk4ZobS
         fHDNnDSyaOqoPOGAxfIwTlvuiwanITE9rVdZuxE9Cv1dL0/ugMVLrNBz8i5gCPY2V2wY
         cLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/JJSTBWNyDVAnOx6SUMAARmZkCZKH2wbNxZkpQ1FD2k=;
        b=DnihQpmQMFSrkDEFdPkeakKtj/0CchBVBs6uqezzV56RwiKz4h/GVaSmKzR1555Kbf
         kjCz1Hz0rNe0D0oDaZEw2FLZrzb8HqCqEu/2oK32MWvgFnNpbtMdqRlh0xAfQQ5WotVQ
         WQ1xgZHx0cmEl4CEKw1cKs8o1k+Q4YIe5p4cqXZxcFHbC3ODJ5TnYp+GMj4kMhzfnh3O
         4/u/1yIrORNfKup1imbhHFKmkMpt4SAIdkbD2fIjylmbHThOk9cSxxKbU7vuBsO5n49x
         NBwN87PUYbMFU7zoa3kr5CHElbGXIURuylS2upFp7rBWWZGgV+ceet6PP9JiEoifaazb
         i4Tw==
X-Gm-Message-State: AOAM530wwy0ZL/uIW39iXzaaaIdIJqEbRjq2djaZWUQxxzrs52+J5OpG
        4GMvUk0x9MYBAjYSmR3IMO+RlhEaz68=
X-Google-Smtp-Source: ABdhPJw+7aRJBUMLERhDR/yiFux8DTU98PEZNQgwWj6qPbX+MpDbb5nHG2CzmDkbb5hwjWDe7nyCGw==
X-Received: by 2002:a2e:a0cd:: with SMTP id f13mr26120445ljm.254.1641039804456;
        Sat, 01 Jan 2022 04:23:24 -0800 (PST)
Received: from [192.168.2.145] (46-138-43-24.dynamic.spd-mgts.ru. [46.138.43.24])
        by smtp.googlemail.com with ESMTPSA id p21sm2179616lfg.98.2022.01.01.04.23.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jan 2022 04:23:24 -0800 (PST)
Subject: Re: [PATCH v17 1/7] usb: misc: Add onboard_usb_hub driver
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Chen <peter.chen@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Roger Quadros <rogerq@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Bastien Nocera <hadess@hadess.net>
References: <20211116200739.924401-1-mka@chromium.org>
 <20211116120642.v17.1.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <07781322-3632-7d63-0da8-a651a438a3ff@gmail.com>
 <Yc4T1qSkcRF2iBVg@google.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1c37be43-4102-6afe-fb05-4cac21ac4d98@gmail.com>
Date:   Sat, 1 Jan 2022 15:23:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Yc4T1qSkcRF2iBVg@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

30.12.2021 23:17, Matthias Kaehlcke пишет:
> On Mon, Dec 20, 2021 at 11:05:28PM +0300, Dmitry Osipenko wrote:
>> 16.11.2021 23:07, Matthias Kaehlcke пишет:
>>> +static const struct usb_device_id onboard_hub_id_table[] = {
>>> +	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x0411) }, /* RTS0411 USB 3.0 */
>>> +	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x5411) }, /* RTS5411 USB 2.0 */
>>> +	{},
>>> +};
>>
>> RTS5411 two times in the comments?
> 
> One time, the other is RTS0511
> 
>> Internet suggests that RTS5411 is USB 3.0
> 
> Correct, however the chip internally has two hubs, one for USB2 and one for
> USB3:
> 
>   Bus 002 Device 002: ID 0bda:0411 Realtek Semiconductor Corp. 4-Port USB 3.1 Hub
>   Bus 001 Device 002: ID 0bda:5411 Realtek Semiconductor Corp. 4-Port USB 2.1 Hub

Alright, thanks.

>> Are these hubs expected to be powered-on only when upstream port is
>> enabled? Shouldn't runtime PM be used for that somehow?
> 
> In the general case I would expect that a onboard hub is connected to a port
> that is enabled. For now I think it's fine to power the hub always when the
> system is running (which is also the current situation with using always-on
> regulators). If someone has an actual use case where the upstream port can
> be disabled they can add support for that later.
> 

I see that you're handling the wakeup-capable devices during the
driver's suspend, perhaps it should work okay then.

BTW, shouldn't the "companion-hub" need to be turned into a generic USB
property? The onboard-usb-hub looks like a generic thing, but
"companion-hub" is specific to the RTS5411 binding.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E44247B423
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 20:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbhLTT7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 14:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbhLTT70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 14:59:26 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055A8C061574;
        Mon, 20 Dec 2021 11:59:26 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id x21so15965624lfa.5;
        Mon, 20 Dec 2021 11:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/c/cCfmIiz8eKJQdLJKnFVnoASRqFW42c9fWmmbu56Q=;
        b=gzWmyxfIjuFmZfUS66iyf1QU2AqUfwsy2R2KEoch30qAuRDtLV/ZP5P65KSbHQYANa
         OEa6JJm6P/JmQTSr0k/05x3HFWM16RjJoZNKFrmU9wOQu3z37S1HmJxVGb0VBXT73mMC
         oyvwjEJzQyi35QWurouaXUbLCC92mJc3m8uDjBeJG0EhTHjSHZ8hfMJPELafsjySnNjM
         JVdGjc//Q4npZh9GmIi3xoCkUiUiLURu65SbRhBgwkhmK2LhI3OnDflQEeLF6yG3oeSa
         YaBzywEtqyUeugu+miueCoIKqZH6WmIbLEJGPeAfy5u6JdAeIfAaduNMVDpOMhvid3fP
         GJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/c/cCfmIiz8eKJQdLJKnFVnoASRqFW42c9fWmmbu56Q=;
        b=ta7Imycpr8g+1JlX1QCu3TxaBgpM4VhpV1xObOECk0TFkCPQNu8ehcu/7m3hSIc57V
         4DUlMVZeRfQ5jkSva57cf8Chmad3aLFxuXKvpALSsHtB3TINJwGPwelfKrdtRQsh/5oN
         fyA7DKGcfBKsq0bKShXGqElmHxZLASbZSi7LbtKtzDhcKSPXHWPRguBIAeAx2IAXd0XL
         lLYWe6UqFUyFJ9UNOD4G1UevFxR1xfOb5K+K6iD1J8RdE8Gl94gUfAa5rAe7Uqdl5s7c
         gNP8a08SRIX/9Z2gYakf9cCjX203payXJyGfgLWQHUhQvne7YeByuCKhGsjFG/M7466P
         RG+A==
X-Gm-Message-State: AOAM532j3rzfWLl1aYoxIjTxv4jdS/6LMqgWCKkWoLyQkqmvyU1QX40v
        FonU6+hT9gDUN/7nOz3e/9CGINbfPLU=
X-Google-Smtp-Source: ABdhPJxrsS5UyUsIwql/oKbVrCA13lTnDKLbJxRls+Mx4JTxS9RqH4/UHQbrokvmG0bDQmjZs4Lbmg==
X-Received: by 2002:a05:6512:2289:: with SMTP id f9mr16859982lfu.619.1640030364055;
        Mon, 20 Dec 2021 11:59:24 -0800 (PST)
Received: from [192.168.2.145] (46-138-43-24.dynamic.spd-mgts.ru. [46.138.43.24])
        by smtp.googlemail.com with ESMTPSA id x11sm927290lfr.171.2021.12.20.11.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 11:59:23 -0800 (PST)
Subject: Re: [PATCH v17 7/7] usb: Specify dependencies on USB_XHCI_PLATFORM
 with 'depends on'
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
        Bastien Nocera <hadess@hadess.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Pawel Laszczak <pawell@cadence.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
References: <20211116200739.924401-1-mka@chromium.org>
 <20211116120642.v17.7.If248f05613bbb06a44eb0b0909be5d97218f417b@changeid>
 <YbvSNta4jCxizaTa@google.com>
 <b0b69294-e7fb-5e7a-80f3-466dd4bdc88a@gmail.com>
 <YcDPJ1POD5oAqyLj@google.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c38c0a7d-c835-27a6-aeb3-48430c57858a@gmail.com>
Date:   Mon, 20 Dec 2021 22:59:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YcDPJ1POD5oAqyLj@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

20.12.2021 21:44, Matthias Kaehlcke пишет:
> On Fri, Dec 17, 2021 at 03:47:24AM +0300, Dmitry Osipenko wrote:
>> 17.12.2021 02:56, Matthias Kaehlcke пишет:
>>> On Tue, Nov 16, 2021 at 12:07:39PM -0800, Matthias Kaehlcke wrote:
>>>> Some USB controller drivers that depend on the xhci-plat driver
>>>> specify this dependency using 'select' in Kconfig. This is not
>>>> recommended for symbols that have other dependencies as it may
>>>> lead to invalid configurations. Use 'depends on' to specify the
>>>> dependency instead of 'select'.
>>>>
>>>> For dwc3 specify the dependency on USB_XHCI_PLATFORM in
>>>> USB_DWC3_HOST and USB_DWC3_DUAL_ROLE. Also adjust the
>>>> dependencies of USB_DWC3_CORE to make sure that at least one
>>>> of USB_DWC3_HOST, USB_DWC3_GADGET or USB_DWC3_DUAL_ROLE can be
>>>> selected.
>>>>
>>>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>>>> Reviewed-by: Roger Quadros <rogerq@kernel.org>
>>>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>>>
>>> Note: This patch has been removed from the onboard_usb_hub series,
>>> together with "ARM: configs: Explicitly enable USB_XHCI_PLATFORM
>>> where needed" and "arm64: defconfig: Explicitly enable
>>> USB_XHCI_PLATFORM". These patches aren't any longer needed for the
>>> series. If maintainers think they are useful independently from
>>> the series please pick them or let me know what needs to be
>>> changed to get them landed.
>>>
>>
>> Hi,
>>
>> I don't know what this all is about, perhaps I'm CC'ed semi-randomly
>> because touched that Kconfig once.
> 
> Yes, it seems tools select you based on their heuristics because you
> made changes to that file.
> 
>> All I can say here is that the commit message tells us "This is not
>> recommended" and doesn't explain what's the actual problem is being
>> solved. If there is no real problem, why bother?
> 
> Earlier versions of the onboard_usb_hub series [1] which had a dependency
> involving USB_XHCI_PLATFORM had an issue with invalid (rand)configs
> that was related with the 'selects'.
> 
> The series doesn't depend on USB_XHCI_PLATFORM any longer, hence the
> original issue doesn't exist anymore, however it might re-surface in
> the future.
> 
> Personally I have no vested interest at this point in getting the
> config changes landed, I just wanted to make clear what the status
> is (split off from the series, no future versions unless someone
> requests them), rather than abandoning them silently.
> 
> [1]: https://patchwork.kernel.org/project/linux-usb/list/?series=531343
> 

My point is that you should always explain in a commit message what
problem is being solved and how it's solved. There is no explanation of
the problem in the commit of this patch. If there is no real problem and
patch is a minor improvement, then it also should be explained explicitly.

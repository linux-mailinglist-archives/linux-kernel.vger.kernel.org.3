Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D044482762
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 12:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbiAALDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 06:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbiAALDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 06:03:06 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADA8C061574;
        Sat,  1 Jan 2022 03:03:05 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id o30so16063785wms.4;
        Sat, 01 Jan 2022 03:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Z/+9nvmLB5oEXe4I6O3MJpdQ4O59Sk/tOuc5Q78ycSI=;
        b=iqfHPGieEbjoGyxVq0oJI2zlJ10bouhezyn4iemfIsQWm++l/17j4YBGg06GEoljEZ
         NM//csCTnqTgEdKVv773vuU5U1Q2N4ypQh9jbgjW2Fik8VBpLdAafYwWaIoHP8EREl83
         3Ewt1ykGKwT+1ECcKdY9fEKz6jmY0GflbOjTpUaUPeen0qlxtoVczESw5OU+Eb8wl8xA
         3yFTXtyUoU2HZETNCLrkO7jQAnggox5Z5Vm5mhfc6sqy/F+EsVQnJJFjkrGiMk+sGbwi
         mHGzOVb4+XAiUhZDIGJhdtVVxyG4yFwEa2IiSFD2TGnL6vwpJKF+lh/CtzCMhgOVfjNJ
         aMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Z/+9nvmLB5oEXe4I6O3MJpdQ4O59Sk/tOuc5Q78ycSI=;
        b=5DEQYJQgtBOwllD/AhD2RYxD75V0DCRzdJ20FwsBp7fTyb9iCqR2u70cUvIGH0bzJL
         wI1ZSNxYXLbcqekic5+FtDAwMMLj6oSeOIgw9A4DkHtfBEaZDQqPJC2zz/HUdXtpZdRo
         kh8QudjG+cCu1r0VE63ByotSxH1JJcDk8Gr3sXA6GEOYGK9AuhwmmQQ0W81W+EVTg2sy
         nyT+g9X50gQXX2skVi5LbpxI+tpvNeytBpsn2WoVJtarlptmblJXu3iwaxdPaFRvgJDB
         8K92qBGfD5CVPFlck++TVDjgtUJBNgMuhGJU3xczTiz2N1mi0+ghH0n3A8420cuw5vR4
         +uJg==
X-Gm-Message-State: AOAM533d0XuHgjSge2rSvN0BEyj2sU1s6IQHbwlsD/rgT6i3Q6y3LSbG
        jZGZraLST4N8TUIa5GFj9i4=
X-Google-Smtp-Source: ABdhPJz6q4+H7oaIwJTrdJubrwrWCH5bAR5Qx9uj3aTmlp5kCZMGazsTdNS8SFUNzc0gwtQipe1oFg==
X-Received: by 2002:a05:600c:4ed1:: with SMTP id g17mr23871140wmq.112.1641034984247;
        Sat, 01 Jan 2022 03:03:04 -0800 (PST)
Received: from [192.168.1.10] (4e691f2a.skybroadband.com. [78.105.31.42])
        by smtp.googlemail.com with ESMTPSA id h3sm29559366wrt.94.2022.01.01.03.03.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jan 2022 03:03:03 -0800 (PST)
Message-ID: <b4175a8e-a9a4-29e8-b433-6c0dd99c9673@googlemail.com>
Date:   Sat, 1 Jan 2022 11:03:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: 5.16.0-rc7+ Bluetooth error
Content-Language: en-GB
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Kiran K <kiran.k@intel.com>
References: <02077a37-46d6-c94f-fa08-9da7ee99e42c@googlemail.com>
 <50ea1b0e-28d7-6d04-9c03-4becc4db143b@googlemail.com>
 <CABBYNZLc9Pj=LYhL5MUUVkhenHb_xfT59aDDkdk14k7+ojeUzw@mail.gmail.com>
From:   Chris Clayton <chris2553@googlemail.com>
In-Reply-To: <CABBYNZLc9Pj=LYhL5MUUVkhenHb_xfT59aDDkdk14k7+ojeUzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/12/2021 19:53, Luiz Augusto von Dentz wrote:
> Hi Chris,
> 
> On Fri, Dec 31, 2021 at 2:35 AM Chris Clayton <chris2553@googlemail.com> wrote:
>>
>> On 30/12/2021 09:21, Chris Clayton wrote:
>>> Hi,
>>>
>>> I pulled the latest changes into my clone of Linus' tree and built and installed the kernel. (git describe gives
>>> v5.16-rc7-9-ge7c124bd0463). I'm seeing errors reported by the bluetooth subsystem that i don't see in 5.15.12 or 5.10.89
>>>
>>> The problem seems to occur twice during system startup and on each occasion I see a batch of identical error messages:
>>>
>>> [    3.980822] Bluetooth: hci0: Failed to read codec capabilities (-56)
>>> [    3.982812] Bluetooth: hci0: Failed to read codec capabilities (-56)
>>> [    3.984812] Bluetooth: hci0: Failed to read codec capabilities (-56)
>>> [    3.986608] Bluetooth: hci0: Failed to read codec capabilities (-56)
>>> [    3.987621] Bluetooth: hci0: Failed to read codec capabilities (-56)
>>> [    3.988606] Bluetooth: hci0: Failed to read codec capabilities (-56)
>>> [    3.989650] Bluetooth: hci0: Failed to read codec capabilities (-56)
>>>
>>
>> Sorry, I should have said that despite the above errors, my bluetooth devices still work fine.
> 
> Would be great to have the HCI trace (btmon).
> 

How would I go about capturing that, please? This all happens during boot, so I don't have access to the system to set
up a trace.


> @Kiran K Is this to be expected?
> 
>>
>>> A full dmesg log is attached. I've also attached Two files containing the output from "lsusb -v" run on 5.10.89 and
>>> 5.16-rc7.
>>>
>>> Please let me know if I can provide any other diagnostic information or test any patches. You'll need to cc me on
>>> replies because I'm not subscribed to LKML or linux-bluetooth.
>>>
>>> Thanks
> 
> 
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3EAF483174
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 14:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbiACNf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 08:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiACNf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 08:35:28 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE06C061761;
        Mon,  3 Jan 2022 05:35:27 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id v6so8238613wra.8;
        Mon, 03 Jan 2022 05:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VRK5HsxWtUBcHbxZyOm3gdgQYDUVk/y62Vk5hy/pEaU=;
        b=eyKZl1xnowuNvg7+HosjAbAnByb/eZLfnnsxMp6IFAm6HsUe4RoXQ/I5ZdhtJW3X2N
         ud2aKr68hafn4xuOqD4a/lc3TGpAZog+enKLGD7ftVz39Bal7XroHgrWBPGze0r40QDb
         Ltxw55nWOvD0klWr1ubZIxSz1Hg5O8xm0E09AGWXjohGnOxmv/8qHwjpqIP3bagLsZCX
         ORVGF2WDIhJwyJRIcS2vUsC7od83XShF4/zL1+0R6uU+oBGNaCPlXRtb5Ydxrr1lU/uc
         2D2ayA1HAXCBIUBUPvrLN9aS5uSJIDbOsPalorYbyCWToes+oCFn2m99orzMKWoBlwlA
         XOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VRK5HsxWtUBcHbxZyOm3gdgQYDUVk/y62Vk5hy/pEaU=;
        b=OGrjoAorLmXoOyUOIEb9m+Nt6ao4uo+nV0c1CZGGM9XPNpBu8yjkqQ6XlOMS2qboAv
         jHerLfwjj4DF89THQy8tQeI23U4eUwHAmbwehoFshhVfXTF8WwUCpBaYay8ANi9TCER+
         33Ixe5+5NANU0+G/aLPiXKenj9oagvJH9VC7TUpZVtN7wl8eP3XDbdG/mtap495PwvIq
         zDennXiuczzLtlKoobUGqvBtaSUFmcb+I355S+25fNgxS5IAFZFinN4MnZJhvPGmrDKu
         C4Er7AatI8Ro72xtBvQN3PxKwP3y3JaAsMyiLeDH/qOalRTLfja6N2rIIApkxwtW729N
         wBDw==
X-Gm-Message-State: AOAM531peGqsAxtOZ+UWxP8yRM6rzdP1yRERFwnmK0mFWg7AR526uUQS
        knF76HzvxC0aIfJE2SqkF98jvdwek+0NSQ==
X-Google-Smtp-Source: ABdhPJxJqfT+HfANXnaNQ/9KDj+8bSI9sQ/Bvqq4mY/RYpNPzJcmVnri8r/ZWrPCl6M8A49mXASl+g==
X-Received: by 2002:a5d:64c8:: with SMTP id f8mr41754938wri.158.1641216926122;
        Mon, 03 Jan 2022 05:35:26 -0800 (PST)
Received: from [192.168.1.10] (4e691f2a.skybroadband.com. [78.105.31.42])
        by smtp.googlemail.com with ESMTPSA id o3sm32930072wmr.15.2022.01.03.05.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jan 2022 05:35:25 -0800 (PST)
Message-ID: <b583dc48-a6b6-f6c7-4a5a-678d985ce358@googlemail.com>
Date:   Mon, 3 Jan 2022 13:35:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: 5.16.0-rc7+ Bluetooth error
Content-Language: en-GB
To:     "K, Kiran" <kiran.k@intel.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <02077a37-46d6-c94f-fa08-9da7ee99e42c@googlemail.com>
 <50ea1b0e-28d7-6d04-9c03-4becc4db143b@googlemail.com>
 <CABBYNZLc9Pj=LYhL5MUUVkhenHb_xfT59aDDkdk14k7+ojeUzw@mail.gmail.com>
 <DM8PR11MB55735DD3A1EA9132E1A71733F5499@DM8PR11MB5573.namprd11.prod.outlook.com>
From:   Chris Clayton <chris2553@googlemail.com>
In-Reply-To: <DM8PR11MB55735DD3A1EA9132E1A71733F5499@DM8PR11MB5573.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/01/2022 09:55, K, Kiran wrote:
> Hi Luiz, Chris,
> 
>> -----Original Message-----
>> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
>> Sent: Saturday, January 1, 2022 1:23 AM
>> To: Chris Clayton <chris2553@googlemail.com>
>> Cc: LKML <linux-kernel@vger.kernel.org>; linux-bluetooth@vger.kernel.org;
>> K, Kiran <kiran.k@intel.com>
>> Subject: Re: 5.16.0-rc7+ Bluetooth error
>>
>> Hi Chris,
>>
>> On Fri, Dec 31, 2021 at 2:35 AM Chris Clayton <chris2553@googlemail.com>
>> wrote:
>>>
>>> On 30/12/2021 09:21, Chris Clayton wrote:
>>>> Hi,
>>>>
>>>> I pulled the latest changes into my clone of Linus' tree and built
>>>> and installed the kernel. (git describe gives
>>>> v5.16-rc7-9-ge7c124bd0463). I'm seeing errors reported by the
>>>> bluetooth subsystem that i don't see in 5.15.12 or 5.10.89
>>>>
>>>> The problem seems to occur twice during system startup and on each
>> occasion I see a batch of identical error messages:
>>>>
>>>> [    3.980822] Bluetooth: hci0: Failed to read codec capabilities (-56)
>>>> [    3.982812] Bluetooth: hci0: Failed to read codec capabilities (-56)
>>>> [    3.984812] Bluetooth: hci0: Failed to read codec capabilities (-56)
>>>> [    3.986608] Bluetooth: hci0: Failed to read codec capabilities (-56)
>>>> [    3.987621] Bluetooth: hci0: Failed to read codec capabilities (-56)
>>>> [    3.988606] Bluetooth: hci0: Failed to read codec capabilities (-56)
>>>> [    3.989650] Bluetooth: hci0: Failed to read codec capabilities (-56)
>>>>
>>>
>>> Sorry, I should have said that despite the above errors, my bluetooth
>> devices still work fine.
>>
>> Would be great to have the HCI trace (btmon).
>>
>> @Kiran K Is this to be expected?
> 
> May be the BT controller here is not supporting HCI_READ_CODEC_CAPABILITIES command.
> 
> This has been fixed - https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=107fe0482b549a0e43a971e5fd104719c6e495ef
> 

I've applied the patch to 5.16.0-rc8 and the error messages are no longer produced. My bluetooth devices are stiil working.

Tested-By: Chris Clayton <chris2553@googlemail.com>

> A check has been added to read codec capabilities only if supported.
> 
> Thanks,
> Kiran
> 

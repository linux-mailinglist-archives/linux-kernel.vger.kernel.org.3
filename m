Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CE14A75B1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 17:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345810AbiBBQYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 11:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236409AbiBBQYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 11:24:15 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DA4C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 08:24:14 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id n32so19212150pfv.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 08:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4RU4nT0A8ScUi0XH1TGWZby5UrMX36vrOc8ZNPOHMnY=;
        b=BjMp2b4aJS29gAsExIeXJwymLti9bMZuWps/hQkbpCNpsSkjMKG09LT9KlGWO3iYiU
         yS7C3p5MsMsRtocfTWpx56BrKisYaNkfHVkltZyjSpuHvpkOYS2YYtuSdmHYwYpOWlkw
         3rnqE4y37W8fi0Qu04lzK5IPncZHF6JdALe3v3q/106EEJ5qvVLjWBi/Svm8JHK0L1vp
         k+9Ub5bgSE6ayDgYSCg7bmeTkGLS4b4bvJI3TbSdP1Ib3Eqe2hYjknPEsuGlwZ6ZwgB4
         2ZJHwHHShHV9OMe5dVX/bhSYQovPOz0pFqpSkl4bBzuKwAOWZ1McOZtuyTDx0xiGufRc
         zZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4RU4nT0A8ScUi0XH1TGWZby5UrMX36vrOc8ZNPOHMnY=;
        b=zs8FPhihEBcw+ockDqduCrTBvTe9UfgNfiSwTdL96URJ3BaiWs9j+TrPmRVq6Umz4F
         5ebtg45zd0X7uqFtjgyWS3OV/PqhVVnChP9ezbpTUeAbgBfAU7mDJGUsU5B5XTQH2b3T
         PvofxHkuTbuzK8D7CYKRdLeuCe2t5aSb+f7SvSAl6WK99sP9KhRXOt+WIufkoHy9cO9W
         q3qmUkZ4zlVZGkvZZw6puYgFvZxyWNS7lvgp1Y+QKLHaC6xiTjoktShs2oc9rVhtgQlf
         9J64EwMr5oeDxW2BuMwfoS6xPUyd1cKanMJtRBOEB0MtN7FZGzE3jRrAeSjWTHIe6HAc
         n5Xw==
X-Gm-Message-State: AOAM530uljqeR150hT6ERXH/iBS27JBJ5w0zgOHSZEG7B8DcM//e3RNy
        2PbdP2hcE57TOiAJ4D9Glq0=
X-Google-Smtp-Source: ABdhPJzKBckS0KU9uqHVFtKYVdrbjhsxdWHHuWUI+DUjuhAJZzFyyGTrixlAGa6YTa0wYc0A5+m80w==
X-Received: by 2002:a05:6a00:885:: with SMTP id q5mr17134700pfj.6.1643819054229;
        Wed, 02 Feb 2022 08:24:14 -0800 (PST)
Received: from [10.230.29.214] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id m38sm33846917pgl.64.2022.02.02.08.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 08:24:13 -0800 (PST)
Message-ID: <71178ae0-053d-d2f4-88cf-a41513432351@gmail.com>
Date:   Wed, 2 Feb 2022 08:24:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/3] phy: phy-brcm-usb: Fixes for phy-brcm-usb driver
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20211201180653.35097-1-alcooperx@gmail.com>
 <7cbb745e-8b95-1eed-0903-44070a112ec0@gmail.com> <Ye0/8MSBRVNuBr3L@matsya>
 <e801d672-bedf-b08b-d27b-2b0cdd476a6d@gmail.com> <YfoPIGfs5Q3IwrPm@matsya>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <YfoPIGfs5Q3IwrPm@matsya>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/1/2022 8:57 PM, Vinod Koul wrote:
> On 27-01-22, 17:01, Florian Fainelli wrote:
>>
>>
>> On 1/23/2022 3:45 AM, Vinod Koul wrote:
>>> On 19-01-22, 15:26, Florian Fainelli wrote:
>>>> Hi Vinod,
>>>>
>>>> On 12/1/21 10:06 AM, Al Cooper wrote:
>>>>> A few fixes for the phy-brcm-usb driver.
>>>>>
>>>>> Al Cooper (3):
>>>>>     phy: usb: Leave some clocks running during suspend
>>>>>     usb: Add "wake on" functionality for newer Synopsis XHCI controllers
>>>>>     phy: broadcom: Kconfig: Fix PHY_BRCM_USB config option
>>>>
>>>> Are you able to pick up those patches? Thank you
>>>
>>> Applied phy patches to phy-fixes, thanks
>>
>> Thanks! I can see patches 1 and 3 there but patch 2 is not in phy-fixes or
>> your next branch. Can you pick it up if it is satisfactory? Thanks!
> 
> That is usb patch right. I wont pick unless Greg acks it to go thru phy
> tree

This is an USB PHY patch, I suppose the subject including "usb: " did 
somewhat mislead you. Here is the diffstat just for that patch:

  .../phy/broadcom/phy-brcm-usb-init-synopsys.c | 46 +++++++++++++++----
  1 file changed, 38 insertions(+), 8 deletions(-)

definitively falling into the PHY subsystem.
-- 
Florian

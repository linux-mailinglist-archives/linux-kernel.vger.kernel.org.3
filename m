Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54FB746FDCD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 10:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239447AbhLJJgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 04:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbhLJJgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 04:36:50 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D332FC061746;
        Fri, 10 Dec 2021 01:33:15 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id t26so16938725lfk.9;
        Fri, 10 Dec 2021 01:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=1sKsqu13f1fJ8ZVjtTiFIs7M6/v2yiKCto4Y2goIhtY=;
        b=gegr37rT1wvk5/wIHoT3HG7CbFisDJJ4qe7XzDTdtRmUZejW6aDzDd79UpHl8InFNC
         Aav2ZhWN7fwu3X0v/aE89Aw3XSuHOBWjTUXuS08G6a53BhERGxk+ge/9uOOtbkqHNmgb
         MoJZlh7AwjhHDayjdbsuG/3Q0h1neeOtb+eNY+EgK6GT9rHBwt8YAyq6IvVCDr3pO26l
         HAnOi+dsKwsTag1DeO8AbaabSQ2CLSMuvxJeKT04xZCkvOu+Z3PXKa6G9dWDMSK8DId3
         4B3MJliyAYL16Dmvpz/AGxNLYDhl40rwyQIQcyt7MD1w5vB8GcKk1scbGe0WZI0ZOvzP
         XpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1sKsqu13f1fJ8ZVjtTiFIs7M6/v2yiKCto4Y2goIhtY=;
        b=NguCNx1zV30Hb5rtZ8kB48SsdTxBzENrytlAzS5ImUEuoXZBazVJldryo+bqzCh0gc
         MEbhsHwKumUR9OQNu8hfDf+eJgbxvkENYomjMGuhMnTPIt39Pdq3tqNNjY9XUczBJyBC
         l3ZJqI5Kbd5RzTrR2AJTJUnGDqD4C7G8r5QHhp4AGeg88FFTv01rIU6JbiCunzH7NCCB
         Ttr7N1nnB0bT23pAv8nrqZnxd6CKj+vKemJkxzoKpCO8n9DQYdZv9D/ovmQ7U1HC66Uc
         q/n4Jn48E+10X+rFlJ5B+910t5ex6rMbsyvycaLaJKFIWI8i9wX2pmhdPMZxLyPpOQeB
         geZg==
X-Gm-Message-State: AOAM532gKncsFVShysEiWrWgdMhT4kIQJjgVeBg6HWtGKTR13fovqdv7
        TmPp/wiGrdrsJ7rE8NqTXveurRpsAGRRqg==
X-Google-Smtp-Source: ABdhPJy0jBvkn2hW116jh/1FKkNOWkwWVSWrraWcHOTZPFv9s8mfwd+5sJqH2upmSWbUncVjhxEwpQ==
X-Received: by 2002:a05:6512:1047:: with SMTP id c7mr11615784lfb.26.1639128794039;
        Fri, 10 Dec 2021 01:33:14 -0800 (PST)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id c13sm254687lfv.293.2021.12.10.01.33.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 01:33:13 -0800 (PST)
Subject: Re: [PATCH V4 6/6] dt-bindings: xen: Clarify "reg" purpose
To:     Julien Grall <julien@xen.org>
Cc:     xen-devel@lists.xenproject.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>
References: <1639080336-26573-1-git-send-email-olekstysh@gmail.com>
 <1639080336-26573-7-git-send-email-olekstysh@gmail.com>
 <669d3f56-13b8-f159-2053-b39f1ba4222f@xen.org>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <35ee3534-9e24-5a11-0bf1-a5dd0b640186@gmail.com>
Date:   Fri, 10 Dec 2021 11:33:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <669d3f56-13b8-f159-2053-b39f1ba4222f@xen.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10.12.21 11:09, Julien Grall wrote:
> Hi Oleksandr,


Hi Julien


>
> On 09/12/2021 20:05, Oleksandr Tyshchenko wrote:
>> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>>
>> Xen on Arm has gained new support recently to calculate and report
>> extended regions (unused address space) safe to use for external
>> mappings. These regions are reported via "reg" property under
>> "hypervisor" node in the guest device-tree. As region 0 is reserved
>> for grant table space (always present), the indexes for extended
>> regions are 1...N.
>>
>> No device-tree bindings update is needed (except clarifying the text)
>> as guest infers the presence of extended regions from the number
>> of regions in "reg" property.
>>
>> While at it, remove the following sentence:
>> "This property is unnecessary when booting Dom0 using ACPI."
>> for "reg" and "interrupts" properties as the initialization is not
>> done via device-tree "hypervisor" node in that case anyway.
> You sent a similar patch for Xen and have already commented there [1] 
> . In short, the OS will be using the node to discover whether it is 
> running on Xen for both ACPI and DT. The hypervisor node also contain 
> the UEFI information for dom0.

I agree with your comments. The sentence should remain in this case. 
Thank you for pointing this out.


>
>
> Cheers,
>
> [1] 
> https://lore.kernel.org/xen-devel/9602b019-6c20-cdc7-23f3-9e4f8fd720f6@xen.org/T/#t
>
-- 
Regards,

Oleksandr Tyshchenko


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE75D489FB4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242704AbiAJS4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242676AbiAJS4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:56:45 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46482C061748
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 10:56:45 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id n16so13368948plc.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 10:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KOjF+aHOZfHctdvB0p5uPGtcS6K7oiTlWXcdyeCAUFs=;
        b=fSWPSuySrDuZj91txh2kM6ZvoCCDSYLQP05Sf0291TWF+04hEXFF6ML1bsiUaJyMTd
         gV2uo7Hrd0lkcvzQloeJPsiELWV2KWnjQVzR6LnUpw+qvPjiao+DQDwznd73D4A5qCxx
         pdVAw9cuNJJws4xrSOPrY5G7V32nRpW6mBwHUzFcmpoTu9xEZW1Jkb9KYX4w2yXCaYES
         lN9zRDjC9DsTlVpIKfuZKq+OJi53xPY09CowRY2fcdlskG61twmgOA6im1n1f5h6xoqf
         S7jHHyBIzELzYlBu4iceI+Cl+tgZQa5rxPiVsZIOAtGnavmmPgmhUZ8FaikFhOrv6L4Y
         9ZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KOjF+aHOZfHctdvB0p5uPGtcS6K7oiTlWXcdyeCAUFs=;
        b=pc2I36TKHUtRO1NSRhT6SglJBn4+HwM0KMLjW3SdMnCLup8Cj1ciXitVysJzCLEl9Z
         T7CWCMnxYTM4WqQIjxgk7LjnXXc+drxHzW7rg7y42ROD4/jla0EDObvsTTv7IbCjmjwX
         qLsl3I9hCMkjYycailx0dXyNt4N1bp7ooK6DgX7BtRdswCkdBjLK7G1IjJxejzJu4Odj
         b8G98cs8QKQ/q5zYJcVGf3hdnqAqKQ6lTcRuqZxd5BWNgvjyFuiI9FJip/IPGYv2eBLP
         lc4kqhvh/EjpKq/sZWfkmfRw0z27hfHv1TUcyNpxNDuMeTq1NVFmdh0ixvzivMubiXcC
         wP8A==
X-Gm-Message-State: AOAM531EQc4NPOpn5aweFEhP6BvM/Bqxr7Kc5mTwPhAhjge2HLNI2pSt
        vZ9jAG5BbyB7ZXxpDuPPVks=
X-Google-Smtp-Source: ABdhPJxwXo4TEhh1O9HLwE/gS4oLc/JwS2WiGmrhf6rQMa9kF7/C5oG9a9aY0ikBmThXKoVcQuu47g==
X-Received: by 2002:a17:902:e752:b0:14a:b35:2fbb with SMTP id p18-20020a170902e75200b0014a0b352fbbmr978313plf.142.1641841004788;
        Mon, 10 Jan 2022 10:56:44 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id h18sm7346899pfn.124.2022.01.10.10.56.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 10:56:44 -0800 (PST)
Subject: Re: [GIT PULL 0/5] SoC changes for 5.17
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <CAK8P3a0RDZpLtWjMEU1QVWSjOoqRAH6QxQ+ZQnJc8LwaV7m+JQ@mail.gmail.com>
 <7e480da8-0d54-2d62-0a8e-184901c974b6@gmail.com>
 <ee2c92da-030c-b92f-0f41-1fdbbeed47c7@gmail.com>
 <CAOesGMgx99GJ3gQmdgauSs3aF8xr4FgcgsELRz4HSVXmujHJnQ@mail.gmail.com>
 <CAK8P3a3sBADt4Cu=LGbjHQpQ32O-BtFk1aQFwhL8Ar=M_gj6Xw@mail.gmail.com>
 <CAOesGMjArmB1J7KasjHZRTNXoZvtUXkTOQAyg5yd29qC8PeS9g@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <3d57e988-68e7-a1e4-5ad5-697ed82b9b08@gmail.com>
Date:   Mon, 10 Jan 2022 10:56:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAOesGMjArmB1J7KasjHZRTNXoZvtUXkTOQAyg5yd29qC8PeS9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/22 10:32 AM, Olof Johansson wrote:
> On Tue, Jan 4, 2022 at 5:40 PM Arnd Bergmann <arnd@kernel.org> wrote:
>>
>> On Tue, Jan 4, 2022 at 7:40 PM Olof Johansson <olof@lixom.net> wrote:
>>> On Tue, Jan 4, 2022 at 1:58 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>>> On 12/24/21 9:11 AM, Florian Fainelli wrote:
>>>>>
>>>>> Should I resend or fix something in those? Thanks!
>>>>
>>>>
>>>> Arnd, Olof, do I need to resend the 3 pull requests mentioned above?
>>>> Thanks and happy new year.
>>>
>>> I'm about to make a pass of merges, likely tomorrow -- I had to get my
>>> Honeycomb working again since it hosts all the trees and mailboxes for
>>> me.
>>>
>>> No need to resend at this time.
>>
>> It's possible that I had accidentally merged them in the end but tagged
>> the branch without those merge commits, so have a look if it's in there.
> 
> Yeah, it looks like there were a few merges not part of the pull
> request (Linus just merged them, so these showed up in
> regen-contents). I'll fold them into arm/late.

Thanks!
-- 
Florian

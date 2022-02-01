Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F634A63AA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 19:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235661AbiBASXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 13:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiBASXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:23:52 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0F0C061714;
        Tue,  1 Feb 2022 10:23:52 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id a7so16816192qvl.1;
        Tue, 01 Feb 2022 10:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RE7G6HWBplku2+vK7AkTfekQdPqvsoGPNP8lPj8UG8A=;
        b=C4/bdY54tA7woecKdYjn/Fd4jSyJs6g6Rj9bPihHkJ8Gv8hCcx5NiiahNi3EkChPXb
         pMq7x7LbgtiUqqBnrSxggwyFnBLU74m6t1w8biFMTVNyaGsbymUFtr1Z5KVWw/g3sgC4
         Gc9kSzGMzvOOZV8adUEIs2l4mF0oHdRhEA9KkhCTkJTK3CMSbTr4FOVYMwHXtkERgsEW
         7drfa28HCkwpE9wDsjEte/vVxGiw9ulDcWJDbSckaozxZwnow2jq1DJGucNz1lxNurfy
         ERssRXDim9jWVxz6n4F6sg/gawIkkKHcUVGxE5m357K+WvdWDBq8rpO8iZJVsHkQjxg7
         IDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RE7G6HWBplku2+vK7AkTfekQdPqvsoGPNP8lPj8UG8A=;
        b=yS/PmoxO0VCjj+tSU3CfCSCpzIfgfg28aV4pVX9TWlCj4wczf8x1xL+YYxtr0qsPyr
         70S+wlL2ji2Zu1hB4wZ9ys175UMfHNxxDmIeX86IkvykoJJxqEK/yd/sqOkB2RV3pgaR
         kLQ6qhHGV47Nk9c83MZa7pY/r5HxXe8yDV/3QB2kQiizXodQw5s+yEnv+7eTI8D24duh
         Y7tZbjxSmjZqJlvRrhosKBnsOmwtGOlEdK0f8BtsBATJ65QbOjGPf6UXK8cPMslYYwDW
         Kmbp8azG1FrlZlpctssSry4bRSaDjhoo2UCoIyMylVDNSmpkIlF6OQJSF7bDDntAFOXX
         OXDg==
X-Gm-Message-State: AOAM533M9vokhyou9l5rYNVNgdiAZPPHCSKWluSPgHbJNDNYi1rj8r0E
        nTJMgFS0eJt21ON+6INDig8=
X-Google-Smtp-Source: ABdhPJyz24WaXYwJehVlFOjiOu5IYBKdLTOVrLVYVHU4x8xMIGuN+nse9AfCRG7QPpmo5Rou7bpUGg==
X-Received: by 2002:ad4:5dcf:: with SMTP id m15mr23680408qvh.26.1643739831787;
        Tue, 01 Feb 2022 10:23:51 -0800 (PST)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id u17sm4956827qkp.23.2022.02.01.10.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 10:23:51 -0800 (PST)
Subject: Re: [PATCH 1/1] of: unittest: update text of expected warnings
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220127192643.2534941-1-frowand.list@gmail.com>
 <CAL_JsqLSsHJMKqOcLYR6uegghy8acLmu7iOX40gp__XVaShBUg@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <fb292c87-ea49-3837-40e7-a5d9031cdeb7@gmail.com>
Date:   Tue, 1 Feb 2022 12:23:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLSsHJMKqOcLYR6uegghy8acLmu7iOX40gp__XVaShBUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/22 9:04 AM, Rob Herring wrote:
> On Thu, Jan 27, 2022 at 1:26 PM <frowand.list@gmail.com> wrote:
>>
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> The text of various warning messages triggered by unittest has
>> changed.  Update the text of expected warnings to match.
>>
>> The expected vs actual warnings are most easily seen by filtering
>> the boot console messages with the of_unittest_expect program at
>> https://github.com/frowand/dt_tools.git.  The filter prefixes
> 
> News to me there's such a tool. Normally, I just give up staring at
> the wall of text spewed out and check failures. Can we add this tool
> to the kernel tree? Then there might be some hope that I'll run it.

I cleaned it up and submitted a patch.

-Frank

> 
> Rob
> 


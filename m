Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C308489CD9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236784AbiAJPzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbiAJPzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:55:35 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E388C061748
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 07:55:35 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 18-20020a05600c22d200b00347d3a13c7cso5023045wmg.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 07:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7s3MOFZuNDY7toiO/Y3Rxx9iJkH7JdNecRXNZtv+XK4=;
        b=ppgC+n7R8bfoSNcjkhktE+DXfE7Oe7p46An7xDYHMOjpPkWMUOItqR7hDLS7oZcrH0
         zBEWT6SFYHKDuvW4EiErBaZujW++2y8YzENbLFRyXE2zIvgklf1pnjXzkcX9sk+B9AR6
         zKmrxVK7dF1Z3eikkvJBtCuUCA+IxvhaaVgrlVHoUqOAdidthaz6uaXCRwjpPB8vx2pA
         hWUlrq841AbOQ0ZTZnMoD7nYDdU3z6PoMzAJzYIllr9dsZcc1NDET9VNY74xAZgC7s63
         IEVxS5N+pn+oGzZ1L8ShkkFDHVsm2AI9eNrjH2VSaYxK5cDagcaYdl/EKLoXLSr2MWYO
         lsDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7s3MOFZuNDY7toiO/Y3Rxx9iJkH7JdNecRXNZtv+XK4=;
        b=C5aamWdE4OKJ6B9WN2TiAq7VJIte+WAaWrLnXMif2vRLW6g30g/LSkoyp5MpA6YZ5w
         xkeuJch86EJVb7izlvvjlllc5RVwqlBNyWvoORbOn9sepVAcRTDraU8r4BPT5WZHkzzk
         BUTf5J3TBxkr/90a+kM6uMhytHVPpDPtp8+8/PnNaUa6pmYd0TkebsD1QAXyGB7i56EL
         06rmbAYkinQP82YME5LQHrJpr6G+RB8HBMPsqOy1ifqgq09c1IjeGph63WjyQ5hwsZ5J
         5Pq603DXmpjLRMpHTdqKYuRixW4UMFPsWdZZh1wxJQsucndC8fEAb48L/CepOsh6GXGP
         SLGg==
X-Gm-Message-State: AOAM530JAt5J9AfvM6cU/Cnf0kGYwgVc0x0t4UK9yhVq4OXX4MUJCmkd
        TmhJ0ocCHAllACtfPfqxOvxBJw==
X-Google-Smtp-Source: ABdhPJz6952ZE93XlgA1Usg0LK+0UHUKyv0bNQKLSeR0fMDSl2H1RS4KpiMrPCx2wZP0KU/bt1/1EQ==
X-Received: by 2002:a7b:c305:: with SMTP id k5mr98169wmj.144.1641830133670;
        Mon, 10 Jan 2022 07:55:33 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:18f0:2692:14f:d8fd? ([2a01:e34:ed2f:f020:18f0:2692:14f:d8fd])
        by smtp.googlemail.com with ESMTPSA id j39sm7400619wms.0.2022.01.10.07.55.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 07:55:33 -0800 (PST)
Subject: Re: [PATCH v5 2/6] powercap/drivers/dtpm: Add hierarchy creation
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     rjw@rjwysocki.net, lukasz.luba@arm.com, robh@kernel.org,
        heiko@sntech.de, arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
References: <20211218130014.4037640-1-daniel.lezcano@linaro.org>
 <20211218130014.4037640-3-daniel.lezcano@linaro.org>
 <CAPDyKFrLTsUxG8JHdK33h2BT8pxeHk6kiU-4uGrvxUhcQKg3Sw@mail.gmail.com>
 <8fcc0ef8-b0c7-da73-434f-31c88896aed5@linaro.org>
 <CAPDyKFqzxnfh0kow5mzoApFMQpKOAv=e1b7Cy9H-iEh99Wmagw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <cbc70ea7-39b4-b5e8-b5c0-45fb436f53eb@linaro.org>
Date:   Mon, 10 Jan 2022 16:55:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqzxnfh0kow5mzoApFMQpKOAv=e1b7Cy9H-iEh99Wmagw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/2022 16:54, Ulf Hansson wrote:
> [...]
> 
>>>> +static int dtpm_for_each_child(const struct dtpm_node *hierarchy,
>>>> +                              const struct dtpm_node *it, struct dtpm *parent)
>>>> +{
>>>> +       struct dtpm *dtpm;
>>>> +       int i, ret;
>>>> +
>>>> +       for (i = 0; hierarchy[i].name; i++) {
>>>> +
>>>> +               if (hierarchy[i].parent != it)
>>>> +                       continue;
>>>> +
>>>> +               dtpm = dtpm_node_callback[hierarchy[i].type](&hierarchy[i], parent);
>>>> +               if (!dtpm || IS_ERR(dtpm))
>>>> +                       continue;
>>>> +
>>>> +               ret = dtpm_for_each_child(hierarchy, &hierarchy[i], dtpm);
>>>
>>> Why do you need to recursively call dtpm_for_each_child() here?
>>>
>>> Is there a restriction on how the dtpm core code manages adding
>>> children/parents?
>>
>> [ ... ]
>>
>> The recursive call is needed given the structure of the tree in an array
>> in order to connect with the parent.
> 
> Right, I believe I understand what you are trying to do here, but I am
> not sure if this is the best approach to do this. Maybe it is.
> 
> The problem is that we are also allocating memory for a dtpm and we
> call dtpm_register() on it in this execution path - and this memory
> doesn't get freed up nor unregistered, if any of the later recursive
> calls to dtpm_for_each_child() fails.
> 
> The point is, it looks like it can get rather messy with the recursive
> calls to cope with the error path. Maybe it's easier to store the
> allocated dtpms in a list somewhere and use this to also find a
> reference of a parent?

I think it is better to continue the construction with other nodes even
some of them failed to create, it should be a non critical issue. As an
analogy, if one thermal zone fails to create, the other thermal zones
are not removed.

In addition, that should allow multiple nodes description for different
DT setup for the same platform. That should fix the issue pointed by Bjorn.

> Later on, when we may decide to implement "dtpm_destroy_hierarchy()"
> (or whatever we would call such interface), you probably need a list
> of the allocated dtpms anyway, don't you think?

No it is not necessary, the dtpms list is the dtpm tree itself and it
can be destroyed recursively.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

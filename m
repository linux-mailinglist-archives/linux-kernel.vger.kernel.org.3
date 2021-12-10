Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF616470CB8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 22:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344397AbhLJVsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 16:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239438AbhLJVsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:48:37 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A26AC0617A2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 13:45:02 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id a11so9676429ilj.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 13:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=twSZcP3mfT9b/ZypuoNY+BMMl0lomCjpqlD3pIkCMVk=;
        b=bwTgLlu5ayICV2oRruJfhchWzCMSfHhBCodMQOwyhgYl/hTdov/P/dpEioeiZgwA8L
         XbXc2E4w2vHRlih0oxJVVva20CRtJmcCvC6Wy7kaDCYd4tB8v48PxJ++2l+Io5HaYPTX
         fLPrC7HgLWiGamqyyf6+itveeWSmVBqTOMT8ssWNc9c3es1+ntEDK6TleEXqaWJZP6hU
         OpginV9JT8Fll+zzaBDYh1BSmXWSzLJ5K9PrchWmDZkJoFbYJq63yHRHVfU5Gzgc6BWe
         xXtckl37/mUgpph2S8bAjCo9opUVovfuXHzyznvPSQ7AbRhISx2ars2msdiF5tqtbdLh
         yDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=twSZcP3mfT9b/ZypuoNY+BMMl0lomCjpqlD3pIkCMVk=;
        b=bvEJHA0699VbBmLM636VOhHhXHVxHZEgpyRAi986i9RtSJtijaY21fpYmGAlnIh0vj
         k/EYVDvT0eJPr371749aKb3bGqpbxEeNOUpHyGyADqpcn11evoc4nyecwzdn4r3PyoRS
         +YMjWEbnG0ZyjqgfFuV7kjFRFssgBfd4Zyw6cb7zQ4KcCBC+/XApu+VfBjhGjyLKfg3d
         xCVwk/jv0EXqUEy7rCEnskXxbRGhYHnbscrheMBr4LqUtKuoLouTwGO1WL7fg1O8P9Rc
         buXbHJ8C7B/+okpsZ2UlsLluJep7wfFiFuRfWftibV9IvsqaOQ7FM8QyoHew26oYUv/K
         Uxpw==
X-Gm-Message-State: AOAM530A740z1NQufAvkC0qgawfZT3HaEGha34rWJtVOBCIr8J5yOQGA
        2Q0IX9R4rSrusOnbHTWt/uGoWYXXvoGUXCgA
X-Google-Smtp-Source: ABdhPJyh4LXFMt7xtDpViOu223o6K21uy/0CVGrUz8kUYRG7TJ06//3d2q/c2WKdXgTwLXUoYRoWuQ==
X-Received: by 2002:a92:cda4:: with SMTP id g4mr20168487ild.159.1639172701177;
        Fri, 10 Dec 2021 13:45:01 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id t6sm2498690ios.13.2021.12.10.13.44.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 13:45:00 -0800 (PST)
Message-ID: <c206a619-a40c-8c2b-8dfe-484f2b0eba92@linaro.org>
Date:   Fri, 10 Dec 2021 15:44:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 2/3] firmware: qcom: scm: Add function to set the maximum
 IOMMU pool size
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Elliot Berman <eberman@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211208083423.22037-1-marijn.suijten@somainline.org>
 <20211208083423.22037-3-marijn.suijten@somainline.org>
 <b21686fc-3662-1ed4-8ba3-8ed5ca6eda13@linaro.org>
 <20211208234436.ktagmcfj6jl5jct5@SoMainline.org>
 <fb1005b6-e610-407f-39bb-7cd6a198f9d6@somainline.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <fb1005b6-e610-407f-39bb-7cd6a198f9d6@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/21 10:28 AM, AngeloGioacchino Del Regno wrote:
> Il 09/12/21 00:44, Marijn Suijten ha scritto:
>> On 2021-12-08 07:30:28, Alex Elder wrote:
>>> On 12/8/21 2:34 AM, Marijn Suijten wrote:
>>>> From: AngeloGioacchino Del Regno 
>>>> <angelogioacchino.delregno@somainline.org>
>>>>
>>>> This is not necessary for basic functionality of the IOMMU, but
>>>> it's an optimization that tells to the TZ what's the maximum
>>>> mappable size for the secure IOMMUs, so that it can optimize
>>>> the data structures in the TZ itself.
>>>
>>> Are there no users of this function?    -Alex
>>
>> I should have probably mentioned in the cover letter that this function
>> and the one introduced in patch 3/3 are going to be used in upcoming
>> patches for IOMMUs found in msm8976, msm8974 and related SoCs (with the
>> side-note that I don't see this particular set_cp_pool_size used in the
>> branch that this was submitted from, but it's most likely used elsewhere
>> or planned ahead to be used in the near future - I expect Angelo to be
>> able to comment on that more accurately).
>>
> 
> This function is used in the secured iommu pagetable setup, but not for
> all of the "SCM feature versions" (only for version >= 1.1.1, downstream
> reads it with a call to scm_feat_version()).
> 
> It's not strictly necessary for functionality, hence why Marijn isn't
> seeing any call to this in the branch that he was browsing: the spirit here
> is to first introduce code that does a minimal (but, of course, working)
> setup of the IOMMUs found in MSM8956/76 (which can be adapted with very
> minimal changes to other SoCs), and *only then* to add these performance
> enhancements to the mix.
> 
> ...and this is why this commit is here :))
> 
> By the way, if my memory isn't failing me, that SCM call should be usable
> on all AArch64 SoCs (so, 8956, 8994 and the rest).

Thanks for your responses.  I don't actually know what
you use as downstream for this.  If I did, I might
compare what I see there to what you do and confirm
it does the same thing...

So I'm not offering any review on this or patch 3.
But I'm glad to know the users of these functions
will be coming soon.

					-Alex

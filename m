Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD37A4BEB86
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 21:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbiBUUC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 15:02:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbiBUUCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 15:02:55 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56F7237C5;
        Mon, 21 Feb 2022 12:02:31 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id g39so20592820lfv.10;
        Mon, 21 Feb 2022 12:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fb+j2sk074uBhHwnP84qNW+Wlx2FB7d28dJPNkXMgrg=;
        b=gfZpsarTMe8zv8kNNuq658hFcX165O74Khr5ONbccSUuNk9HZplFmoclpWHVjrtTP1
         CjB0a7K9VEof0eheFxjkWmb1/BJ3TM3xpxUE8qpaHHfjK/lcJcWQL5+0e/YMOOi57TQO
         tOFQzm9J531Nfysi9H9SFHqFRDal61VkFMN/61bQ7LPvsbWiac7qjr47Wf39nzwi6rhC
         s8R5VqTz32sZJQlodkO5eG4h9VI/ZjdRqH7NP1+wSYeGx6QTtg4yzJheiIvIbKCFzm2v
         CWtpbzNUrZzSH+r8xrS+4iuIcDsucGpyTcRgV33dFhy7Kgyk2V5uOa6YjBXMKz03AvYb
         +6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fb+j2sk074uBhHwnP84qNW+Wlx2FB7d28dJPNkXMgrg=;
        b=wnMpB1oouaKWbO3ntK42M65Bf750HsWnHqWPAEwJHUygbGxbmb8k4CxlHxUkt+8x2J
         h8iJV3aT2CE9D1R2ld+4nZoAAKwV3XtmNxA8RhPv9WgaaQ29hEmdMLWNvbAAKOtN6nLK
         toVmClJvxAgS/Yq5X5UwVFguA5ECc1njFuBB8qJzb4SaMw/j8AN9XWF+aUuYju2CE740
         B949SJrXkUm8b7vzhUVdSqdDCXsjOYJUleDKQMC8kNrS8SkETvwa5TF8dFne0hoINiry
         dSddV0tJOHnlNHeO0FCUPIsknwmZR5QzdUOXjJPB3c8Nqb9bckpu5JmLkT0tN20JZEEW
         4AvQ==
X-Gm-Message-State: AOAM533pUeooNfWMur6gF2of+bzquIThIweQ/m5tu2f7nqwcuB6iv/tu
        t1ymwwJFR7CwtfSCDFo0t+0=
X-Google-Smtp-Source: ABdhPJy4/bripNm193lusUsi4gc6siiKT+oZ6eEPNsLASVQRtAyZf8khtnW/p16T4mOlUK/g6+a8vQ==
X-Received: by 2002:a05:6512:3310:b0:443:4c51:6b60 with SMTP id k16-20020a056512331000b004434c516b60mr14689786lfe.398.1645473750057;
        Mon, 21 Feb 2022 12:02:30 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id v6sm1451504ljd.86.2022.02.21.12.02.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 12:02:29 -0800 (PST)
Message-ID: <bb533634-6cde-3835-db11-7b6191385294@gmail.com>
Date:   Mon, 21 Feb 2022 23:02:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 9/9] drm/tegra: Support context isolation
Content-Language: en-US
To:     Mikko Perttunen <cyndis@kapsi.fi>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, joro@8bytes.org,
        will@kernel.org, robh+dt@kernel.org, robin.murphy@arm.com
Cc:     linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220218113952.3077606-1-mperttunen@nvidia.com>
 <20220218113952.3077606-10-mperttunen@nvidia.com>
 <2b4dd244-f918-4d26-2322-00a0bb226ccf@gmail.com>
 <ea65fcd6-9451-7f5b-f4a9-57b8575f09ff@kapsi.fi>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <ea65fcd6-9451-7f5b-f4a9-57b8575f09ff@kapsi.fi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

21.02.2022 15:06, Mikko Perttunen пишет:
> On 2/19/22 20:35, Dmitry Osipenko wrote:
>> 18.02.2022 14:39, Mikko Perttunen пишет:
>>> +    if (context->memory_context &&
>>> context->client->ops->get_streamid_offset) {
>>              ^^^
>>> +        int offset =
>>> context->client->ops->get_streamid_offset(context->client);
>>> +
>>> +        if (offset >= 0) {
>>> +            job->context = context->memory_context;
>>> +            job->engine_streamid_offset = offset;
>>> +            host1x_context_get(job->context);
>>> +        }
>>
>> You should bump refcount unconditionally or you'll get refcnt underflow
>> on put, when offset < 0.
> 
> This refcount is intended to be dropped from 'release_job', where it's
> dropped if job->context is set, which it is from this path.
> 
>>
>>> +    }
>>> +
>>>       /*
>>>        * job_data is now part of job reference counting, so don't
>>> release
>>>        * it from here.
>>> diff --git a/drivers/gpu/drm/tegra/uapi.c b/drivers/gpu/drm/tegra/uapi.c
>>> index 9ab9179d2026..be33da54d12c 100644
>>> --- a/drivers/gpu/drm/tegra/uapi.c
>>> +++ b/drivers/gpu/drm/tegra/uapi.c
>>> @@ -33,6 +33,9 @@ static void tegra_drm_channel_context_close(struct
>>> tegra_drm_context *context)
>>>       struct tegra_drm_mapping *mapping;
>>>       unsigned long id;
>>>   +    if (context->memory_context)
>>> +        host1x_context_put(context->memory_context);
>>
>> The "if (context->memory_context &&
>> context->client->ops->get_streamid_offset)" above doesn't match the "if
>> (context->memory_context)". You'll get refcount underflow.
> 
> And this drop is for the refcount implicitly added when allocating the
> memory context through host1x_context_alloc; so these two places should
> be independent.
> 
> Please elaborate if I missed something.

You named context as memory_context and then have
context=context->memory_context. Please try to improve the variable
names, like drm_ctx->host1x_ctx for example.

I'm also not a big fan of the "if (ref) put(ref)" pattern. Won't be
better to move all the "if (!NULL)" checks inside of get()/put() and
make the invocations unconditional?

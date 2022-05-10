Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D522520B8C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 04:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbiEJC7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 22:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiEJC7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 22:59:23 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D997285EFA
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 19:55:27 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id iq2-20020a17090afb4200b001d93cf33ae9so894786pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 19:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=B7DhpPw0OljxuhhwZSNtAYT/hHruNdjiKQXsCQg3OVI=;
        b=BQAj539DZtR1wE5Q3MISt/EowQJyBDbBpp2BPwl2Dn0/pzDF2sRwnHdWXyppJZ7hs9
         WdmGkAV+JsOuHWdPuVkG/kwaBPG1MT5yB0tI+xyUucj4d30+zizdO5KNYLF1+q4cSAiX
         umGt2jl9+fMcPSZTJpMQpopFuuIoXHJhK3UmaTPvaRmNpvpiZrHDmh7VdMHPzN8CR5V3
         BZc0NhYjbixwIJ3LFNafD3E3b1+2lHNM021nWf502zmMg0JatiH3njGVxP6ePJc+ODBY
         OZcUVL9ziasgmDwa9+Uqxt2LoW8K9UBqlFYX5SWQomhL6wdjSZAAS9OYY0tLT3oG2TN7
         WxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=B7DhpPw0OljxuhhwZSNtAYT/hHruNdjiKQXsCQg3OVI=;
        b=W8Tm52/3cJk8eSyWW4RUgcIgHHDpWxO83dBTDWMAcpNiRsjnV56YhWVKIG+RWa234d
         bLD1bWPrtkCG6PxglNtHVH+gHWgrzqNsTneZbTgWlsMPvzIq1smwHdM8oE9lCYniEeYq
         0YZ0qYf1MFwWfHC29Xbk+8NWXWSkaRtloNIcSr39hlylFHTKWZK94sQ9IYqKvSTVwGC2
         nApWcVmua5iPyZoZMQXjOo0Y1qWRyozyjnqxdZVDECHYC2qYGTcbS3MVjBrdwOiY3iml
         So7TJGQvhdRdxRgPmAQIZV0a4O2goWMPAMi3sDv3YqrzG77dMToHPeGbIKaPXsv0wiCY
         7d7g==
X-Gm-Message-State: AOAM531N/lwFafJfnbLIoGtqH2wSpO6GYkwbDXx/4DX00tM8/8Tw9NcR
        /ogneP2dz8+bxJoQNV2JvO+CHg==
X-Google-Smtp-Source: ABdhPJxdu6lNlc3c6CsznUzvEW/IZZ9AQxSGv6ndmynEODn9wRe1gwwY+FKAn+YCxQ8a+SGVmPc6zg==
X-Received: by 2002:a17:902:ee93:b0:15f:186a:6a13 with SMTP id a19-20020a170902ee9300b0015f186a6a13mr5463597pld.7.1652151327068;
        Mon, 09 May 2022 19:55:27 -0700 (PDT)
Received: from [10.254.93.206] ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id w25-20020a637b19000000b003c659b92b8fsm6615547pgc.32.2022.05.09.19.55.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 19:55:26 -0700 (PDT)
Message-ID: <5c076a57-74d8-9590-3ab7-badab3f91cd9@bytedance.com>
Date:   Tue, 10 May 2022 10:55:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v3] sched/fair: filter out overloaded cpus in SIS
Content-Language: en-US
To:     Chen Yu <yu.chen.surf@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220505122331.42696-1-wuyun.abel@bytedance.com>
 <CADjb_WTRYjSD8z0BCE=u322iJmQVuEq5cUMTZO6ij9V-=ViY-w@mail.gmail.com>
 <53fcde27-7dd2-5150-633b-4e2acc37bb6f@bytedance.com>
 <CADjb_WRmXh0tj7nZZR3QybhLxtoxZBy6OMKRNygtKOx-wUPxZA@mail.gmail.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <CADjb_WRmXh0tj7nZZR3QybhLxtoxZBy6OMKRNygtKOx-wUPxZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/9/22 11:21 PM, Chen Yu Wrote:
>> Yes, I have been already working on that for several days, and
>> along with some improvement on load balance (group_has_spare).
>> Ideally we can finally get rid out of the cache issues.
>>
> Ok, could you please also Cc me in the next version? I'd like to have
> a try.
> 

I will, thanks!

Abel

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1E4554043
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 03:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355839AbiFVBxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 21:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355818AbiFVBw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 21:52:58 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F10112D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 18:52:55 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id w19-20020a17090a8a1300b001ec79064d8dso12028013pjn.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 18:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8BeHII7j2RVL5an2X6ClS6MJ44OPIqlDCSKDBki0jmc=;
        b=g4hG9kGoLq+3irH9R5WvwKlQ1UTs4YU/rtZy5pOgAKIEfNvUCpb87PJ3vwqrTAgDSx
         wNkg3fSqnDrcpysjQmN0qcI9Uqi0sY3G9U9o782kxL01r6zdR1+1KbcWffbbTkGD60Yw
         v+BguyznyT+Jd5VBQaL1lbCl3QBXICIghqQA6DxNcwZ1HRA1/L8H/pjbU5oXvCkL+cxV
         bHtwjbr+a0DjKFISj8UoiVHmgV14wtImCCbmTJPz8XwPzWTEviekvs4NRhyDwyFNhmHO
         PZ5CPU/Zxxq4xg2gKQBS8AHBGrbI7+FMaxaXiSxhT5Y3UcVqTCjK4dkcL76P62GGfZnv
         4lLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8BeHII7j2RVL5an2X6ClS6MJ44OPIqlDCSKDBki0jmc=;
        b=oj7X8yaSpGS3SYZhwfXY4eJifPRZS2lA20TU5vIxuQH//+XT+zZ6FJEXLQeG1Ft1zu
         xjJMb4zs8a+qipYE5CfSvlMLHThvhUXPh0evW3fT66rzgoO7d2sDLvu/uFCdAgNKwXjs
         AQllRKwsdBofQnMKvDvodTNaFlfSERaEmFs1cVFIkSLwc+WaGpJaxQBVZK82dbcP5w02
         VZa0UzyPAbp0qw7xjgY1I+/U7n5kmeBHDaZkdnWCUUNGoy/7nmoF6uoXOXp54fkvT1Zi
         YugpUyVZVTQCUVSruonqzn1njBx3mk9Vute1K1ow0Te2x2bo6SubeIfBk45/OIwKGLtO
         tKag==
X-Gm-Message-State: AJIora9uJemM6z8tKeEjB16+nTofD6n3emnPXsFytqa4hcI2GRIsaata
        qHbSF77EU4MSkivH2rwyN1GG8A==
X-Google-Smtp-Source: AGRyM1vHaHACef/0JKF5jzF9jweZG26XcxHqgoiGnvAgJ+N/XS/Utzwd9scJN+6vRUq49JuEJmCOlQ==
X-Received: by 2002:a17:902:ea07:b0:16a:2833:3207 with SMTP id s7-20020a170902ea0700b0016a28333207mr12461298plg.86.1655862774703;
        Tue, 21 Jun 2022 18:52:54 -0700 (PDT)
Received: from [10.70.253.98] ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id e23-20020aa78c57000000b0051c15bb876esm12320868pfd.174.2022.06.21.18.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 18:52:54 -0700 (PDT)
Message-ID: <d5d884c5-ed82-4ea9-4c08-e284d80239af@bytedance.com>
Date:   Wed, 22 Jun 2022 09:52:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [External] Re: [PATCH] sched: RT bandwidth interface for cgroup
 unified hierarchy
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, corbet@lwn.net
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220621123542.1444-1-zhouchengming@bytedance.com>
 <7933e208-cd4f-2234-58cb-2e5b40e795d8@infradead.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <7933e208-cd4f-2234-58cb-2e5b40e795d8@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/21 23:59, Randy Dunlap wrote:
> Hi--
> 
> On 6/21/22 05:35, Chengming Zhou wrote:
>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>> index 176298f2f4de..3d2949e16e04 100644
>> --- a/Documentation/admin-guide/cgroup-v2.rst
>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>> @@ -1055,6 +1055,19 @@ All time durations are in microseconds.
>>  
>>  	The burst in the range [0, $MAX].
>>  
>> +  cpu.max.rt
>> +	A read-write two value file which exists on all cgroups when
> 
> 	             two-value
> 
>> +	CONFIG_RT_GROUP_SCHED enabled, to control CPU bandwidth for
> 
> 	                      is enabled,
> 
>> +	RT threads in the task group.
>> +
>> +	The maximum bandwidth limit.  It's in the following format::
>> +
>> +	  $MAX $PERIOD
>> +
>> +	which indicates that RT threads in the group may consume upto
> 
> 	                                                         up to
> 
>> +	$MAX in each $PERIOD duration.  "max" for $MAX indicates no
>> +	limit.  If only one number is written, $MAX is updated.
> 

Thanks for review, I will send v2 later.

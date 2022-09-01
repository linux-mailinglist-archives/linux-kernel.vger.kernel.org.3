Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86EEE5A9F76
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 20:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbiIAS5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 14:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbiIAS5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 14:57:40 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F7A74374
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 11:57:39 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id t11so6969665ilf.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 11:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=nia9jI2O88KcphJGb5RxJpwde9w47ORDSNyakk4/vu4=;
        b=hg8tXGlRx/SHRdCMcUjwsB9CQwcZ1IenwElcgFvFC8TAzOIuj/aoS1YyRlxk5vauL0
         msx5OMOm8pzSFwsfukf2yerhoTmxXHpUiLcMFp8GjtPNwoOUdFUC9SKV01PcBc0fcMsC
         aB+G8hQSkYpnaA2IAd8P2pmZ3Z4wg5OPTmRwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nia9jI2O88KcphJGb5RxJpwde9w47ORDSNyakk4/vu4=;
        b=UYIYOxvYYSLbayLD5rBjtjENWammZiCqae0osRp9729mXIzn/7vBahOkO3+j96a1KF
         QoW1LUPp8Cmf98x80SyOBT6HbB0I+7bNzoAC+i3lYa7N5Plm01SCj+f5UGq8hUJ67qhe
         iBanYfCra8AXDumYQW4Mgy6c8i8aCVN9BE5cGoS+v32oZtEZjoG8y/hkXi15NVv4OM99
         9vG19US4mjKjm4+SMP23xY1V57bl/sbnXJIqDqUb6r06/h616uYttRvgtSN3nrdVo9ub
         APPoJHw9TktIFh8SlQc3xfOn7lwgkRLmGUFVpMmYsqfnPjyuHZw7Ytcp7NmEAykBBtRf
         hljQ==
X-Gm-Message-State: ACgBeo1e0kptxKspJktsKGaWxsz8Vfxr4eMDuynXT1u34clfzHf4cozR
        Tr4hlT3qVhhLWhC4rJDT1p25WA==
X-Google-Smtp-Source: AA6agR7dw1ZlZ/aQIVwXijEoBDwRoQ/vPMU/DT6/0bpcHuPPUyUq35r2u4ojDWcQq1/WRafGqsNBzA==
X-Received: by 2002:a05:6e02:1849:b0:2ee:6664:9301 with SMTP id b9-20020a056e02184900b002ee66649301mr385667ilv.266.1662058658824;
        Thu, 01 Sep 2022 11:57:38 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id i1-20020a056602134100b006887640a5edsm9345405iov.23.2022.09.01.11.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 11:57:38 -0700 (PDT)
Message-ID: <cb8b16a1-a7d6-1b04-c748-3f2d802b54e5@linuxfoundation.org>
Date:   Thu, 1 Sep 2022 12:57:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] tools: Add new "test" taint to kernel-chktaint
Content-Language: en-US
To:     David Gow <davidgow@google.com>,
        Joe Fradley <joefradley@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Jonathan Corbet <corbet@lwn.net>, kernel-team@android.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220824041933.822838-1-joefradley@google.com>
 <CABVgOSki72Yqb1DBSCgi-qk+FbNniL4GX+19MXwq=K9VEzAyoA@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CABVgOSki72Yqb1DBSCgi-qk+FbNniL4GX+19MXwq=K9VEzAyoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/22 22:41, David Gow wrote:
> On Wed, Aug 24, 2022 at 12:19 PM Joe Fradley <joefradley@google.com> wrote:
>>
>> Commit c272612cb4a2 ("kunit: Taint the kernel when KUnit tests are run")
>> added a new taint flag for when in-kernel tests run. This commit adds
>> recognition of this new flag in kernel-chktaint.
>>

What happens without this change? It isn't clear what this change is
fixing.

>> Reviewed-by: David Gow <davidgow@google.com>
>> Signed-off-by: Joe Fradley <joefradley@google.com>
>> ---
>> Changes in v2:
>> - based off of kselftest/kunit branch
>> - Added David's Reviewed-by tag
>>
> 
> This still looks good to me.
> 
> Unless anyone objects, I guess we'll take this through the KUnit
> branch (which, after all, is where the taint was originally added).
> I've added it to the list for 6.1, but it technically could be
> considered a fix for 6.0 as well.
> 

I can definitely take this for Linux 6.0 with additional information
on the problems seen without this change.

thanks,
-- Shuah


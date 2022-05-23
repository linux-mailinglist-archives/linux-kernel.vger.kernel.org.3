Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C6B530E1D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbiEWJ3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbiEWJ3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:29:46 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E62496A7
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 02:29:45 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id z17so1487350wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 02:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=Pnpr494hnLQiQgSniXG4dedtD9vAIlrv2YCFBq6/bJk=;
        b=RT0d0o+rGT9eb8OtGLbDP+vie/YBmOdJAGORMRmiTnzK739Xyadin/nUD6vaMhvk9o
         IsUks9JtWQvggrD1p6QMAGVACssRzUdHNUiyjHY/YY+jORUQjWrW9thr0UIIXpJ07U9C
         Ia43er3d5Bkq1EQ33yngwcoBal3e5KWHNw4paiSoQomLtU8xIjZ8COxgWDhuxu19j/v+
         Ymb7H06vcg8dF83QJhUt37Ex7EArAbHwKmpqZYZzaUjX/3BunO/I3gmiq22q9mtg53V+
         ingo0Wbjw8vJWqfhl+cMs01B9pr/zT4B4ACkIh8b+FR+VJV5lQefpFrStl2h+lKtS4DK
         0k8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Pnpr494hnLQiQgSniXG4dedtD9vAIlrv2YCFBq6/bJk=;
        b=ctcPMRHG5JcUPJAIHCpvAujNmDAS2tA+PaKzdMfhmiqqOpQ1uvmrwnO330Imuio4P2
         +zqFsFAyfLFg95MCwHJuX0w3mwzomkalEJQSQdCCF4Nmk8oRO2Ojl8nhgKOrsweJessE
         H/61pM+iTjGCnxxJZpTa3OiSeGq8enS1AOIHFc2V++lDsRc+5tJ1sFEIT1wC7yU0ojVf
         PfcCjWvNcIDp5/BaKtDlWCpLBQKJvzLrArwOzErZ1+LUvoGswkyLdfGYuWRxLRqwTfR8
         mjRN/LvUDP4tC8A8QtvwLWrDD1Y8FwpmSglsNpJ4DiTwd+qWz0drMBRLkmDutn1Jt23L
         Bk1w==
X-Gm-Message-State: AOAM533VClvW/iySF1oaB5EicpFmycFvY2CpwQITX+aul4XHZqDvWxjf
        61vbRKM9d7QCh5A9xxtrKgcweg==
X-Google-Smtp-Source: ABdhPJzu9lHDhyv33m/66/hyW0RNfwUhvW0Nk8KCnXzLmMGU7ILI6RCWM/GKo9PrhdNlG1HugBtDlQ==
X-Received: by 2002:a1c:a4c3:0:b0:397:3bf0:d14d with SMTP id n186-20020a1ca4c3000000b003973bf0d14dmr12783340wme.186.1653298183704;
        Mon, 23 May 2022 02:29:43 -0700 (PDT)
Received: from ?IPV6:2a00:1098:3142:14:3110:d736:2a7:6aff? ([2a00:1098:3142:14:3110:d736:2a7:6aff])
        by smtp.gmail.com with ESMTPSA id l16-20020a1c7910000000b003972dcfb614sm9260131wme.14.2022.05.23.02.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 02:29:43 -0700 (PDT)
Message-ID: <58cb7fbb-d317-83e6-0427-d3f3944b24b8@raspberrypi.com>
Date:   Mon, 23 May 2022 10:29:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: vchiq: Performance regression since 5.18-rc1
To:     Stefan Wahren <stefan.wahren@i2se.com>, paulmck@kernel.org
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Minchan Kim <minchan@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        regressions@lists.linux.dev, riel@surriel.com,
        viro@zeniv.linux.org.uk
References: <77d6d498-7dd9-03eb-60f2-d7e682bb1b20@i2se.com>
 <20220521234616.GO1790663@paulmck-ThinkPad-P17-Gen-1>
 <bfad3d08-3268-5528-17c1-c17ef3949d96@i2se.com>
 <20220523044818.GS1790663@paulmck-ThinkPad-P17-Gen-1>
 <e0503433-615d-3834-4392-d0868caf47cf@i2se.com>
From:   Phil Elwell <phil@raspberrypi.com>
In-Reply-To: <e0503433-615d-3834-4392-d0868caf47cf@i2se.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On 23/05/2022 07:19, Stefan Wahren wrote:
> Hi Paul,
> 
> Am 23.05.22 um 06:48 schrieb Paul E. McKenney:
>> On Sun, May 22, 2022 at 05:11:36PM +0200, Stefan Wahren wrote:
>>> Hi Paul,
>>>
>>> Am 22.05.22 um 01:46 schrieb Paul E. McKenney:
>>>> On Sun, May 22, 2022 at 01:22:00AM +0200, Stefan Wahren wrote:
>>>>> Hi,
>>>>>
>>>>> while testing the staging/vc04_services/interface/vchiq_arm driver with my
>>>>> Raspberry Pi 3 B+ (multi_v7_defconfig) i noticed a huge performance
>>>>> regression since [ff042f4a9b050895a42cae893cc01fa2ca81b95c] mm:
>>>>> lru_cache_disable: replace work queue synchronization with synchronize_rcu
>>>>>
>>>>> Usually i run "vchiq_test -f 1" to see the driver is still working [1].
>>>>>
>>>>> Before commit:
>>>>>
>>>>> real    0m1,500s
>>>>> user    0m0,068s
>>>>> sys    0m0,846s
>>>>>
>>>>> After commit:
>>>>>
>>>>> real    7m11,449s
>>>>> user    0m2,049s
>>>>> sys    0m0,023s
>>>>>
>>>>> Best regards
>>>>>
>>>>> [1] - https://github.com/raspberrypi/userland
>>>> Please feel free to try the patch shown below.  Or the pair of patches
>>>> from Rik here:
>>>>
>>>> https://lore.kernel.org/lkml/20220218183114.2867528-2-riel@surriel.com/
>>>> https://lore.kernel.org/lkml/20220218183114.2867528-3-riel@surriel.com/
>>> I tried your patch and Rik's patches but in both cases vchiq_test runs 7
>>> minutes instead of ~ 1 second.
>> That is surprising.  Do you boot with rcupdate.rcu_normal=1?
> No, not explicit.
>>    That would
>> nullify my patch, but I would expect that Rik's patch would still provide
>> increased performance even in that case.
> I will retest with a fresh SD card image.
>>
>> Could you please characterize where the slowdown is occurring?
> 
> Unfortunately i don't have a deep insight into driver and vchiq_test tool. Just 
> a user view.
> 
> Do you think an strace would be a good starting point?
> 
> @Phil Any advices to analyse this issue?

Sending many small control packets:

    vchiq_test -c 1 10000

essentially tests interrupt latency. Using a small number of large bulk transfers:

    vchiq_test -b 10000 1

becomes a test of how long it takes to lock down pages. It also tests DMA 
transfer speeds, but since the DMA is run by the firmware (which you aren't 
changing), I think you can rule that.

You may also find it helpful to include "force_turbo=1" in config.txt for more 
predictable results.

By the way, running our 5.18-rc7-based branch on a 3B+ I'm not seeing any 
performance problems:

pi@raspberrypi:~$ time vchiq_test -f 1
Functional test - iters:1
======== iteration 1 ========
Testing bulk transfer for alignment.
Testing bulk transfer at PAGE_SIZE.

real    0m0.512s
user    0m0.042s
sys     0m0.165s

Phil

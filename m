Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA09153A97B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 16:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353902AbiFAO7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 10:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350763AbiFAO7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 10:59:15 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8FA6C56D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 07:59:14 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e2so2761097wrc.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 07:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TzKfq7E9CEicVwu+G42Kc4ZGKMTepsQz/3pjzCviq18=;
        b=GYMZVPH3V0zPbXe23xeBJb6wFtWFRdinGznt4a6IGiXz6RwQgxYKuIC67JvhTGZVjp
         I3m2ltOSjhogcVBY+BTxxpeIW+jQJkV3OtLcHK4VoPs3O7aCXkmSZ/Qeea7ab7k9qJjw
         IG4QDUjb2/8orbBfYJ7YE6msnLv3XEeYRM04/N/6pSUV9rAUJaB6+39sjTfid8nXCFhH
         s/h7TPP1ULnoN7POx4rLhvG/Jp7gvG32+fN24aVA5wJf0No41d2RZBG3RAOXo2P1fHkO
         zHKgvFz0fCmOeaJVQqBEuTQEBotegZdO6BTa2Y0PgfFP2ERIngu2LKXBlBvd6lE4rVFw
         VXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TzKfq7E9CEicVwu+G42Kc4ZGKMTepsQz/3pjzCviq18=;
        b=d6+2qnXv5O+anTVjF4ChitYOA6iU2oLk2z8GXIf1d+Hqy+12+pIQ26dD2zGMdTJ3K2
         STLOHsj5YehjfMG/7Rgisgk6A5patiN67/DfkknSGoazUPdZaja29LxzkN7G2ijYh/QB
         bbwnZOM47Vj+ta5dYHYUyiqOreL+in8QkrQ/3uAEC1kRBAPlUhq3QjLBgBpMtiV3xQHC
         jSD+pKcFbuVuBvr4bwx6TaI3tsn2AEm/iD4hr9hqantRBAPFclfB3M/hR3qvYNhcv/pN
         utDBqcrH9piRwhFcX4gO3AtmnjPOnvnK+uZFFrAREpcPVXNwaJNaIfRtGLeFCoY/ZKCa
         +K+Q==
X-Gm-Message-State: AOAM5330efWLIWO3CSNvib/9HAvjy6biX7Hy8mNE4XtWN+ib/hg9gkDG
        CukHYlq1UlQBX3OJv4u56D8=
X-Google-Smtp-Source: ABdhPJzLEM3ct34cP2eWbQF/nurpWxFFA6JmpyVqmxe+oBMnLutmGpf9Is7iheaNssWAvf3apmIWAg==
X-Received: by 2002:a05:6000:1887:b0:20f:de1d:9fc3 with SMTP id a7-20020a056000188700b0020fde1d9fc3mr162259wri.111.1654095552721;
        Wed, 01 Jun 2022 07:59:12 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:d1fb:e1e4:e193:e55f? ([2a02:908:1256:79a0:d1fb:e1e4:e193:e55f])
        by smtp.gmail.com with ESMTPSA id j22-20020a5d4536000000b0021108003596sm1481517wra.10.2022.06.01.07.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 07:59:12 -0700 (PDT)
Message-ID: <d11df4fa-a0bd-63f0-9ae7-ead007868989@gmail.com>
Date:   Wed, 1 Jun 2022 16:59:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: (REGRESSION bisected) Re: amdgpu errors (VM fault / GPU fault
 detected) with 5.19 merge window snapshots
Content-Language: en-US
To:     Alex Deucher <alexdeucher@gmail.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        "Yang, Philip" <Philip.Yang@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220527090039.pdrazo5e6mwgo3d3@lion.mk-sys.cz>
 <20220527124459.mfo4tjdsjohamsvy@lion.mk-sys.cz>
 <CADnq5_PHR3NMhMAWDLy3SGyzn4bHedWDerXVmaFANbooYhZE0w@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_PHR3NMhMAWDLy3SGyzn4bHedWDerXVmaFANbooYhZE0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 01.06.22 um 16:55 schrieb Alex Deucher:
> On Fri, May 27, 2022 at 8:58 AM Michal Kubecek <mkubecek@suse.cz> wrote:
>> On Fri, May 27, 2022 at 11:00:39AM +0200, Michal Kubecek wrote:
>>> Hello,
>>>
>>> while testing 5.19 merge window snapshots (commits babf0bb978e3 and
>>> 7e284070abe5), I keep getting errors like below. I have not seen them
>>> with 5.18 final or older.
>>>
>>> ------------------------------------------------------------------------
>>> [  247.150333] gmc_v8_0_process_interrupt: 46 callbacks suppressed
>>> [  247.150336] amdgpu 0000:0c:00.0: amdgpu: GPU fault detected: 147 0x00020802 for process firefox pid 6101 thread firefox:cs0 pid 6116
>>> [  247.150339] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00107800
>>> [  247.150340] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0D008002
>>> [  247.150341] amdgpu 0000:0c:00.0: amdgpu: VM fault (0x02, vmid 6, pasid 32780) at page 1079296, write from 'TC2' (0x54433200) (8)
>> [...]
>>> [  249.925909] amdgpu 0000:0c:00.0: amdgpu: IH ring buffer overflow (0x000844C0, 0x00004A00, 0x000044D0)
>>> [  250.434986] [drm] Fence fallback timer expired on ring sdma0
>>> [  466.621568] gmc_v8_0_process_interrupt: 122 callbacks suppressed
>> [...]
>>> ------------------------------------------------------------------------
>>>
>>> There does not seem to be any apparent immediate problem with graphics
>>> but when running commit babf0bb978e3, there seemed to be a noticeable
>>> lag in some operations, e.g. when moving a window or repainting large
>>> part of the terminal window in konsole (no idea if it's related).
>>>
>>> My GPU is Radeon Pro WX 2100 (1002:6995). What other information should
>>> I collect to help debugging the issue?
>> Bisected to commit 5255e146c99a ("drm/amdgpu: rework TLB flushing").
>> There seem to be later commits depending on it so I did not test
>> a revert on top of current mainline.
>>
> @Christian Koenig, @Yang, Philip Any ideas?  I think there were some
> fix ups for this.  Maybe those just haven't hit the tree yet?

I need to double check, but as far as I know we have fixed all the fallout.

Could be that something didn't went upstream because it came to late for 
the merge window.

Christian.

>
> Alex
>
>
>> I should also mention that most commits tested as "bad" during the
>> bisect did behave much worse than current mainline (errors starting as
>> early as with sddm, visibly damaged screen content, sometimes even
>> crashes). But all of them issued messages similar to those above into
>> kernel log.
>>
>> Michal Kubecek


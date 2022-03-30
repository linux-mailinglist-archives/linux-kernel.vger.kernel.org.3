Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11ECA4EC589
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 15:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344413AbiC3NYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 09:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344304AbiC3NYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 09:24:33 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58164992B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 06:22:40 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bq8so27543141ejb.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 06:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jrmiuTtGmZ4dpdCeuJ811vflkUzFE8FbD11Q0Jlb02k=;
        b=pVo3pISBmfs+7qwWHwNm9MYH5v9rQlZzszV/r72uwFHQKQlIoIZORr+FS/FbEABoLq
         QqY0pmKG14PnsemFNv855594p/Qd1EpMKRv4TtLAba/owDHZAHNhtFSHXhVR3Ql7Bk32
         uVfLaSnrVDtyKbsOOUJnppSh3EI+OonrXq3H30K91IBnvbhAVnTlNtIKBaBBvn3R2Oac
         KPnuI+Ct79UlyFiqGTwq2DaP7lUg0HuztT9AWEYarGE0bb2FdrLeXPPoC3aXXW3qkG5y
         m4kQ905uW7M/4xw6wV2SE5CzCwPHdSPUQTllwuaBtC4bK9GTJMWV7lAv10n6uSPaI3ma
         IieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jrmiuTtGmZ4dpdCeuJ811vflkUzFE8FbD11Q0Jlb02k=;
        b=zx/l5hXnL4msdwT/ud53dyZIsGUkCVDtfQXdm4hP0acX2us68A7MQKQaFQ3bmK4IFn
         C7vyz1d26mMwuzX1hxaYi0rv9aCWEErSyuU9Rpe1wY/Zg9jjWMUlntI9BydD7QeFBQJ2
         C00TGI7GcKN48C7wMxnUqgxa8H0YwOR+CUY7teE1m3v7Kkptmf+RrUyqULyT6OyAifFA
         YvLqqqJyVNx5AmA7AUUPhPoQJIHtEoJCLmdfk9HVV2xsTuOlNWTXp4pG0cvzN13L3vhX
         GyGGCxBllzGDooDYXwsJuWLiieB6YaOqs3MoBX9fdaQcbFOXJfZxbFY0i8IDIJeqcjGY
         4w6g==
X-Gm-Message-State: AOAM533hIhJtMvByN0rU0CGS2uwEN5PhNutxMsp4tUa0yQ17iL+LOEP8
        fTl0qNmqpjq2qDB0b60pG14xSQ==
X-Google-Smtp-Source: ABdhPJxzAXRit4FdPYIT+K3BFM5nPYC0VIXWfUVSvpvUJDuNkIotsV8vuYuO6K6CANRGT4efJV00sg==
X-Received: by 2002:a17:906:f956:b0:6df:d816:264b with SMTP id ld22-20020a170906f95600b006dfd816264bmr40605526ejb.354.1648646559008;
        Wed, 30 Mar 2022 06:22:39 -0700 (PDT)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id gb3-20020a170907960300b006dfafbb4ba4sm8457701ejc.83.2022.03.30.06.22.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 06:22:38 -0700 (PDT)
Message-ID: <3a72702f-6cf9-2b6e-0f9c-bf6857ab7ed2@tessares.net>
Date:   Wed, 30 Mar 2022 15:22:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] perf tools: Stop depending on .git files for building
 PERF-VERSION-FILE
Content-Language: en-GB
To:     John Garry <john.garry@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1648635774-14581-1-git-send-email-john.garry@huawei.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <1648635774-14581-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 30/03/2022 12:22, John Garry wrote:
> This essentially reverts commit c72e3f04b45fb2e50cdd81a50c3778c6a57251d8
> and commit 4e666cdb06eede2069a7b1a96a1359d1c441a3eb.
> 
> In commit c72e3f04b45f ("tools/perf/build: Speed up git-version test on
> re-make"), a makefile dependency on .git/HEAD was added. The background is
> that running PERF-VERSION-FILE is relatively slow, and commands like
> "git describe" are particularly slow.
> 
> In commit 4e666cdb06ee ("perf tools: Fix dependency for version file
> creation"), an additional dependency on .git/ORIG_HEAD was added, as
> .git/HEAD may not change for "git reset --hard HEAD^" command. However,
> depending on whether we're on a branch or not, a "git cherry-pick" may
> not lead to the version being updated.
> 
> As discussed with the git community in [0], using git internal files for
> dependencies is not reliable. Commit 4e666cdb06ee also breaks some build
> scenarios [1].
> 
> As mentioned, c72e3f04b45f was added to speed up the build. However in
> commit 7572733b8499 ("perf tools: Fix version kernel tag") we removed the
> call to "git describe", so just revert Makefile.perf back to same as pre
> c72e3f04b45f and the build should not be so slow, as below:
> 
> Pre 7572733b8499:
> $> time util/PERF-VERSION-GEN
>   PERF_VERSION = 5.17.rc8.g4e666cdb06ee
> 
> real    0m0.110s
> user    0m0.091s
> sys     0m0.019s
> 
> Post 7572733b8499:
> $> time util/PERF-VERSION-GEN
>   PERF_VERSION = 5.17.rc8.g7572733b8499
> 
> real    0m0.039s
> user    0m0.036s
> sys     0m0.007s
> 
> [0] https://lore.kernel.org/git/87wngkpddp.fsf@igel.home/T/#m4a4dd6de52fdbe21179306cd57b3761eb07f45f8
> [1] https://lore.kernel.org/linux-perf-users/20220329093120.4173283-1-matthieu.baerts@tessares.net/T/#u
> 
> Fixes: 4e666cdb06ee ("perf tools: Fix dependency for version file creation")
> Reported-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: John Garry <john.garry@huawei.com>

Thank you for your patch, I just tested it and it also fixes the issue I
reported!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

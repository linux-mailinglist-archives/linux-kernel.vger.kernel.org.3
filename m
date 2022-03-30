Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5A84EC66B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346769AbiC3OYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346778AbiC3OY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:24:29 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87DC206EF1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 07:22:39 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id lr4so33424575ejb.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 07:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lqQd8DOJ48CVojNKjiKgvQ0Jvy8m0O0FfXmyz3Zfnxc=;
        b=59TwkFTlgjH3K1vQCveg8eX2zqYEJT4ie7uTL9mP3sX91c0O8YBaGAowj5xbu1sWNi
         rD4y6d5gWKVgc0sAW4cs1eNqeI6sce1xBtm6ow4dC7J8TleX+uE4qYhUiucwalN+r+Qo
         Tiis6qfWpX6v41XE+H5mYydo0YtuHHw4ntMuNFb9XE4oW/LsjPH2lwZeGn176KMkXYk3
         hp7atZxMLPOAm7EDoNU1d91Ohpw01sxkLfatKmKUX5ohTAalgfTyFVQ3NXF1XAml8wf1
         CC7v1hyKy8uhGMrErL0TMR9oyuZFNV9FQVmzY1/lnsSdaaakL/vpJKBf3QNxqPtnNvHw
         /reg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lqQd8DOJ48CVojNKjiKgvQ0Jvy8m0O0FfXmyz3Zfnxc=;
        b=lL3kffr+T56cQzDDBx35fJlIiGGKQDlC6KuUp732nkNtTAHJPkbkJ0cYvX9ESYTGt7
         botwci3UTQIFqYRdM1RRxoqOYfSLWNhI7dSkpMrKE6xxlWMyHsTw9NDZ6aC7jZAJzaFR
         nsiFBHYWhpsB3JKzkhkoJffMXSZNeEgIXbZFu1m9hirDwKGXMe2hLhI8wrYGsRaeyoLd
         1r+owEzYbrvQAwcltyDd0msFRXtJaADqI5cGnNP9bcajEhHXyhpNfFFw/drmRAOl46Vf
         c24XW8zCqct2K/ajtzzByhK99iFiLO6z/aW2coyB+jJUo+r+TshL6kDXg+e0YyHioQUj
         PJEQ==
X-Gm-Message-State: AOAM5339YTwahrrK4WWIpNZuOFZnfBg7+6tW553nRfX0OW5xJgPm7+rK
        E+TTKibtIpW+F3R5BlK/rGCwsgQV2q3DHQ==
X-Google-Smtp-Source: ABdhPJxN5TEtsHRQzq3eyOyKNu9bxB/INVQnZPY/VcvdkzULVFqFkeYUVNT6z8Ug6ErUP433gZ7FHg==
X-Received: by 2002:a17:906:2ac9:b0:6ce:dc0f:9139 with SMTP id m9-20020a1709062ac900b006cedc0f9139mr40540346eje.206.1648650157981;
        Wed, 30 Mar 2022 07:22:37 -0700 (PDT)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id gb29-20020a170907961d00b006e00c7b0f5asm8360022ejc.0.2022.03.30.07.22.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 07:22:37 -0700 (PDT)
Message-ID: <634d9682-dc78-e09a-865c-9eed28aee667@tessares.net>
Date:   Wed, 30 Mar 2022 16:22:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] perf tools: Stop depending on .git files for building
 PERF-VERSION-FILE
Content-Language: en-GB
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     John Garry <john.garry@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1648635774-14581-1-git-send-email-john.garry@huawei.com>
 <3a72702f-6cf9-2b6e-0f9c-bf6857ab7ed2@tessares.net>
 <YkRlZhaEgmJ5Q4k/@kernel.org>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <YkRlZhaEgmJ5Q4k/@kernel.org>
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

Hi Arnaldo,

On 30/03/2022 16:12, Arnaldo Carvalho de Melo wrote:
> Em Wed, Mar 30, 2022 at 03:22:37PM +0200, Matthieu Baerts escreveu:
>> Hi John,
>>
>> On 30/03/2022 12:22, John Garry wrote:
>>> This essentially reverts commit c72e3f04b45fb2e50cdd81a50c3778c6a57251d8
>>> and commit 4e666cdb06eede2069a7b1a96a1359d1c441a3eb.
>>>
>>> In commit c72e3f04b45f ("tools/perf/build: Speed up git-version test on
>>> re-make"), a makefile dependency on .git/HEAD was added. The background is
>>> that running PERF-VERSION-FILE is relatively slow, and commands like
>>> "git describe" are particularly slow.
>>>
>>> In commit 4e666cdb06ee ("perf tools: Fix dependency for version file
>>> creation"), an additional dependency on .git/ORIG_HEAD was added, as
>>> .git/HEAD may not change for "git reset --hard HEAD^" command. However,
>>> depending on whether we're on a branch or not, a "git cherry-pick" may
>>> not lead to the version being updated.
>>>
>>> As discussed with the git community in [0], using git internal files for
>>> dependencies is not reliable. Commit 4e666cdb06ee also breaks some build
>>> scenarios [1].
>>>
>>> As mentioned, c72e3f04b45f was added to speed up the build. However in
>>> commit 7572733b8499 ("perf tools: Fix version kernel tag") we removed the
>>> call to "git describe", so just revert Makefile.perf back to same as pre
>>> c72e3f04b45f and the build should not be so slow, as below:
>>>
>>> Pre 7572733b8499:
>>> $> time util/PERF-VERSION-GEN
>>>   PERF_VERSION = 5.17.rc8.g4e666cdb06ee
>>>
>>> real    0m0.110s
>>> user    0m0.091s
>>> sys     0m0.019s
>>>
>>> Post 7572733b8499:
>>> $> time util/PERF-VERSION-GEN
>>>   PERF_VERSION = 5.17.rc8.g7572733b8499
>>>
>>> real    0m0.039s
>>> user    0m0.036s
>>> sys     0m0.007s
>>>
>>> [0] https://lore.kernel.org/git/87wngkpddp.fsf@igel.home/T/#m4a4dd6de52fdbe21179306cd57b3761eb07f45f8
>>> [1] https://lore.kernel.org/linux-perf-users/20220329093120.4173283-1-matthieu.baerts@tessares.net/T/#u
>>>
>>> Fixes: 4e666cdb06ee ("perf tools: Fix dependency for version file creation")
>>> Reported-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>
>> Thank you for your patch, I just tested it and it also fixes the issue I
>> reported!
> 
> I'm taking this as a:
> 
> Tested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> 
> Ok?

Yes, OK for me, thank you!

I never know what maintainers prefer when there is already a
"Reported-by" tag so I didn't specify it but I will do next time.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

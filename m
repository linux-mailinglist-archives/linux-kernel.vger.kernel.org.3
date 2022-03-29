Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBC54EB006
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 17:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238360AbiC2POC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 11:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235294AbiC2POA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:14:00 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64DD22C6D8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 08:12:15 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id a17so21078106edm.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 08:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AxdIJYFQ2HFyaWkSd6aH3B9KrL7/ps4UvmhKce2/pf4=;
        b=g9siOZ1wQAd1DjJJBP0MTLpMqGR/555P38tKZJY0BVNM/BpJizrUnN5mAB7H5fNM+L
         vnPkOsZ9BQ+6z0uEHi19RU5MbZG1E8e1CBpgSh9duinJB2AgBE56EjCVwSEyXyJWBurF
         /P244D1UL9c+KzHdTU8Ttec2Tv2xQ6kENL0R+GZkbmAdyw/KjDZgzRN3Dc4p5C1eXy5v
         YEgwiV4UZEESj25E5+zlEVygkTDjDeL0l4Ezl+NxQZEFidS1rmnFexjFMnXw9DHfeKax
         eSXvo625Y4JoO6853tTDFftrxFQHjNVFYZSA1wuLIx0DA85416MfAVOZvQYtsVrrsqN+
         2tsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AxdIJYFQ2HFyaWkSd6aH3B9KrL7/ps4UvmhKce2/pf4=;
        b=a0dZbj4Tpl7J+hg+d4I7OWMF/edLkXNQeo3TJYPpX7HW1gwUYQWPpHI4mBzsg9X+pj
         C2HyrmHkvXcjVVCyQs/iYparY8/W3wVh+3WOIFqkF9wSlE8qgLOb4DVXxPKDbSyCDlJ2
         xx92jH6M1s9Hm3CsofIHpyt6r0O9tVuTWWHlpoDzgvtFv84wb3qRBVDAQS6YfON/dbfo
         H4Sc/aU5bbz0osf6GO+4128iP/ezwpDrvfN4RnCDDoCsEDPwuNRuyktWBiJbi0y/vwPi
         Rubef2fU8TRVtp1ohbMgCetxRK5EV+Bp1ceKdBkXck8uuuWmdhoDKi0VmFkjGz4vYkZM
         5KuQ==
X-Gm-Message-State: AOAM531KtjTP3niqO4uM+NYAJxaT+96DIr1TY5/J2aHMu83DpsxI/BAA
        sMI/hQLhkFgPqsAUexszM6PReg==
X-Google-Smtp-Source: ABdhPJzeoiD4DWuA6XaK8Uj1ZpZ/FJGBZx6c64C3I7nEU56ECpuZhFAB7WG5VRNkFUOZ/WREWm2cJw==
X-Received: by 2002:a05:6402:17dc:b0:418:efa5:f445 with SMTP id s28-20020a05640217dc00b00418efa5f445mr5082928edy.125.1648566733974;
        Tue, 29 Mar 2022 08:12:13 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:505b:327f:c6b6:495c? ([2a02:578:8593:1200:505b:327f:c6b6:495c])
        by smtp.gmail.com with ESMTPSA id dm8-20020a170907948800b006dfe5b317d3sm7486123ejc.75.2022.03.29.08.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 08:12:13 -0700 (PDT)
Message-ID: <4675337e-d71d-2045-1cab-b81ba9fa2c25@tessares.net>
Date:   Tue, 29 Mar 2022 17:12:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH perf] perf tools: .git/ORIG_HEAD might not exist
Content-Language: en-GB
To:     John Garry <john.garry@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     mptcp@lists.linux.dev, Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220329093120.4173283-1-matthieu.baerts@tessares.net>
 <e9969b97-3998-d7b2-9fd2-77ddd27969ef@huawei.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <e9969b97-3998-d7b2-9fd2-77ddd27969ef@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 29/03/2022 12:32, John Garry wrote:
> On 29/03/2022 10:31, Matthieu Baerts wrote:
> 
> Hi Matthieu,
> 
> Sorry for the breakage.

That's alright, it happens.

(...)

> Could you please try this:
> 
> ---->8------
> 
> 
> From 694964709a7fc2b46c995bb7b1967cc6b129def8 Mon Sep 17 00:00:00 2001
> From: John Garry <john.garry@huawei.com>
> Date: Tue, 29 Mar 2022 11:06:46 +0100
> Subject: [PATCH] perf: Stop depending on .git internal files for
> building PERF-VERSION-FILE
> 
> This essentially reverts commit c72e3f04b45fb2e50cdd81a50c3778c6a57251d8
> and commit 4e666cdb06eede2069a7b1a96a1359d1c441a3eb.
> 
> In commit c72e3f04b45f ("tools/perf/build: Speed up git-version test on
> re-make"), a makefile dependency on .git/HEAD was added. The background
> is that running PERF-VERSION-FILE is relatively slow, and commands like
> "git describe" are particularly slow.
> 
> In commit 4e666cdb06ee ("perf tools: Fix dependency for version file
> creation"), an additional dependency on .git/ORIG_HEAD was added, as
> .git/HEAD may not change for "git reset --hard HEAD^" command.
> 
> However, as discussed with the git community in [0], using git internal
> files for dependencies is not reliable. Commit 4e666cdb06ee also breaks
> some build scenarios [1].
> 
> As mentioned, c72e3f04b45f was added to speed up the build. However in
> commit 7572733b8499 ("perf tools: Fix version kernel tag") we removed
> the call to "git describe", so just revert Makefile.perf back to same as
> pre c72e3f04b45f and the build should not be so slow, as below:
> 
> Pre 7572733b8499:
> $> time util/PERF-VERSION-GEN
>   PERF_VERSION = 5.17.rc8.g4e666cdb06ee
> 
> real    0m0.110s
> user    0m0.091s
> sys     0m0.019s
> 
> Post 7572733b8499:
> $> time util/PERF-VERSION-GEN
>   PERF_VERSION = 5.17.rc8.g7572733b8499
> 
> real    0m0.039s
> user    0m0.036s
> sys     0m0.007s

Probably the optimisation to avoid calling this script is indeed no
longer needed but it is not me to judge.

What I know is that indeed, 'git describe' can be slow while just
returning the current SHA is supposed to be always quick.

(...)

> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 9c935f86d172..ddd03b21bda2 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -691,9 +691,8 @@ $(OUTPUT)common-cmds.h: $(wildcard
> Documentation/perf-*.txt)
>  $(SCRIPTS) : % : %.sh
>      $(QUIET_GEN)$(INSTALL) '$@.sh' '$(OUTPUT)$@'
> 
> -$(OUTPUT)PERF-VERSION-FILE: ../../.git/HEAD ../../.git/ORIG_HEAD
> +$(OUTPUT)PERF-VERSION-FILE: .FORCE-PERF-VERSION-FILE

Regarding my issue, removing the dependence to .git/ORIG_HEAD file fixes
the issue. So I'm fine to drop my patch and revert the two commits you
mentioned.

If you send this patch, please do not forget to add a Fixes tag:

  Fixes: 4e666cdb06ee ("perf tools: Fix dependency for version file
creation")

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

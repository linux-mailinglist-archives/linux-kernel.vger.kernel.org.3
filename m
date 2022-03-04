Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388944CDBD6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241454AbiCDSL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbiCDSL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:11:56 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03961D0841
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 10:11:07 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id b5so13879584wrr.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 10:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8CUqH+T1NmoB2pHeRsnvR7yakP1UyT5ff8t46TR/rkc=;
        b=G7ewdwVut2kvJmFgsHWKWHMkmynih5Ppxf5Mu8vwM6fISeGtJxMYptxidSYrnNYxuY
         RacHzhXM76CnOJ77AHmSc2U7yxRtiz/SVf0LhY0oAptpg0aO8J+BW6jsgFwEDQQCah6L
         NModnuANoy/eBShpON7ajYzkJX+snOxdHRBiriKUckU5tmEmuSxaN7O0uMcMcNARlcRN
         8V6CWEjjas55XCkkHQRzRQanaImeBOHD81GUcxXmKcm502t4C2y/P6/RpOHE3zhHRwSM
         BOzdp8PwkVPhVsHAyAEC+IC01VKjcUyhRWtHpmC4I5MQ31f59n6QTX+loO8HNXY2bct9
         GgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8CUqH+T1NmoB2pHeRsnvR7yakP1UyT5ff8t46TR/rkc=;
        b=oOQGscjTu2RspANMzO+lIJqK/A6y/w7zcPZ9Pr9UeCQYbBCC+M7eWu0FW0BTZmkk1+
         KTAajPJ1GPEWcaIVRsAqI2Z/bhPbu5TviLAObd1xS7ipVlJIg8F+YqXXzidAMz5Arw/9
         rOmoXP+wF6NEKs2C7M73E4fmVaqfDN/i47Rwgl0fWpbqqPJcPXmzJIdemfZZcXo4eneP
         3KaPgVyNS5a/hsz0f8IaIfH0mQq3ZtcVq51aC/fmSA5+TBJn3v2Hvm9s7G/7WSO4a1Gl
         L1UmPQz5tWAZ25lZFp7Gv4q4mYuOXFEqENfJxauPe5roOYJFC3d9dFRrnIIZ0hhSlvl7
         o9hQ==
X-Gm-Message-State: AOAM532vc5uWJLFvADm3aq+0AuDNQCJ/ucPixnESIFcEOOzKceU+uvQ7
        WkW6hToXz3v00nHBfj/VEnKfrKXXRkP/f2oqJ0n6rg==
X-Google-Smtp-Source: ABdhPJwhhTp45VvNeE8w3E/5H2BYG+MzLn3g1CCaPntlfvjWV4Qr6sCVwgfDysj6yqXzcjZhcJ2OTTSfDSuYH0iislk=
X-Received: by 2002:a5d:5687:0:b0:1f0:9663:c80e with SMTP id
 f7-20020a5d5687000000b001f09663c80emr2823843wrv.343.1646417466283; Fri, 04
 Mar 2022 10:11:06 -0800 (PST)
MIME-Version: 1.0
References: <20220304083329.GC20556@xsang-OptiPlex-9020>
In-Reply-To: <20220304083329.GC20556@xsang-OptiPlex-9020>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 4 Mar 2022 10:10:53 -0800
Message-ID: <CAP-5=fVz=arWo19PQR_4UKY_PyywyXoyp+MUnfAJxCFZy5rhWg@mail.gmail.com>
Subject: Re: [perf vendor events] 3f5f0df7bf: perf-sanity-tests.perf_all_metrics_test.fail
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Clark <james.clark@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 4, 2022 at 12:33 AM kernel test robot <oliver.sang@intel.com> wrote:
>
>
>
> Greeting,
>
> FYI, we noticed the following commit (built with gcc-9):
>
> commit: 3f5f0df7bf0f8c48d33d43454fc0b7d0f3ab9537 ("perf vendor events: Update metrics for Skylake")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
> in testcase: perf-sanity-tests
> version: perf-x86_64-fb184c4af9b9-1_20220302
> with following parameters:
>
>         perf_compiler: clang
>         ucode: 0xec
>
>
>
> on test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz with 32G memory
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):

Hi,

Thanks for the report! There is no information in the test output that
I can diagnose the issue with, could you add the -v option to perf
test so that I can see what the cause is, rather than just pass/fail.
At the time of filing the update I didn't have access to a Skylake
machine (just SkylakeX) but this test was ran as detailed in the
commit message:
https://lore.kernel.org/lkml/20220201015858.1226914-21-irogers@google.com/
Knowing the test, I suspect there may be a bad event on Skylake, but
can't confirm this because I lack the hardware and/or the test output.
The issue may also be how the test was run, such as not as root, not
in a container. There is a further issue with this test that metrics
(e.g. number of vector ops) that measure things that a simple
benchmark doesn't cause counts for can fail the test, as the test is
checking if the metric is reported - for example, there may be no
vector ops within the simple benchmark.

Thanks,
Ian

> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>
>
>
> 2022-03-02 19:01:56 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-3f5f0df7bf0f8c48d33d43454fc0b7d0f3ab9537/tools/perf/perf test 89
>  89: perf all metricgroups test                                      : Ok
> 2022-03-02 19:02:05 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-3f5f0df7bf0f8c48d33d43454fc0b7d0f3ab9537/tools/perf/perf test 90
>  90: perf all metrics test                                           : FAILED!
> 2022-03-02 19:07:00 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-3f5f0df7bf0f8c48d33d43454fc0b7d0f3ab9537/tools/perf/perf test 91
>  91: perf all PMU test                                               : Ok
>
>
>
> To reproduce:
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached in this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>         sudo bin/lkp run generated-yaml-file
>
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
>
>
>
> ---
> 0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
> https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation
>
> Thanks,
> Oliver Sang
>

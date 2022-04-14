Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B43501ECB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 00:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347399AbiDNXBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 19:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345432AbiDNXBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 19:01:31 -0400
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5249399E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 15:59:05 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id q14so7771712ljc.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 15:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EzeM7BAsGDvC8RGxh6KP5UkbdJMIo4Bz6Mv+RzgiilI=;
        b=OQNFW/Ibro2GDmLGv1CqQ+9E+ONlWwm1ctri+zwIrO0J/dRg5lBMQsh7fzdtngixJg
         ZFNX9gQiXxi73iBw8PVgZX4DOuAeApBTKAUNX7kaLfB91K/M3za2wq6sWZCM8sQgy2Jr
         7O8IP0DglY51X9p7i+e6Es4PtjGDPi3Im3uUQoNyMg7b9x/H+KYbKJeyqz4uvpFV9uNz
         HFLnoqmkN5xWf9yASv6G2fcIqt2z/pFxePg1HLXclfbpB/KU4Thrq5us0x6nchRbk/Zh
         8frw+tjUgrH8Tu+4gSaLUJ4uHI81HH//fI8Z+vBRjZUiyO7R7cA6GeHG7I8+8Lf3RB7A
         2NjA==
X-Gm-Message-State: AOAM5319e76vBbKg/+LK+1d2L7+WZQq9KyJiqRfeyGhJcm8cYAN1G6Ke
        1mRd8Ti1Brc1p7YFNSkDvnjLR+Bs+jAo9KDGwig=
X-Google-Smtp-Source: ABdhPJx6Xdpu15bviN7b/0aQHWOhzbU4fd0nliCy26M7JFa7gVDlAqvyCI0wM7rsq1uAPvzGXlsBlr9nW6tPmruC2qs=
X-Received: by 2002:a05:651c:1544:b0:24c:8644:4046 with SMTP id
 y4-20020a05651c154400b0024c86444046mr2790615ljp.366.1649977143666; Thu, 14
 Apr 2022 15:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220304083329.GC20556@xsang-OptiPlex-9020> <CAP-5=fVz=arWo19PQR_4UKY_PyywyXoyp+MUnfAJxCFZy5rhWg@mail.gmail.com>
 <20220413070529.GA1320@linux.intel.com> <CAP-5=fXGqODZYGu781qjEEVtGFpCQJ=dCXi5shYOAbBSt5wQkw@mail.gmail.com>
 <85eed89f-e4a8-2887-a0b3-579704304357@linux.intel.com> <CAP-5=fXj+WT3ExNo-fL4d9b_Wm5swnKaCWd67rU85Q=QFg5KUw@mail.gmail.com>
 <74d36e66-5b16-ee10-bcae-171e2b681845@linux.intel.com> <CAP-5=fX+Hqf5xYTCqBXNCz5-ZPaZ7ChNUgoRyH1+JhiAqj79nQ@mail.gmail.com>
 <f020f05e-0e54-cc59-0666-810cf3a4fd14@linux.intel.com>
In-Reply-To: <f020f05e-0e54-cc59-0666-810cf3a4fd14@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 14 Apr 2022 15:58:52 -0700
Message-ID: <CAM9d7cic6AhJGrNF7wmyowUBpp0mPu8TdiVebL4XXcotFtLUuQ@mail.gmail.com>
Subject: Re: [LKP] Re: [perf vendor events] 3f5f0df7bf: perf-sanity-tests.perf_all_metrics_test.fail
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Ian Rogers <irogers@google.com>, Carel Si <beibei.si@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        alexandre.torgue@foss.st.com, Andi Kleen <ak@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Clark <james.clark@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>, mcoquelin.stm32@gmail.com,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        lkp@lists.01.org, kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kan,

On Thu, Apr 14, 2022 at 12:06 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>
>
>
> On 4/14/2022 12:09 PM, Ian Rogers wrote:
> > ```
> > $ perf stat -e '{BR_INST_RETIRED.NEAR_CALL,BR_INST_RETIRED.NEAR_TAKEN,BR_INST_RETIRED.NOT_TAKEN,cycles,cycles}:W'
> > -a sleep 1
> >   Performance counter stats for 'system wide':
> >
> >       <not counted>      BR_INST_RETIRED.NEAR_CALL
> >                 (0.00%)
> >       <not counted>      BR_INST_RETIRED.NEAR_TAKEN
> >                  (0.00%)
> >       <not counted>      BR_INST_RETIRED.NOT_TAKEN
> >                 (0.00%)
> >       <not counted>      cycles
> >                 (0.00%)
> >       <not counted>      cycles
> >                 (0.00%)
> >
> >         1.005599088 seconds time elapsed
> >
> > Some events weren't counted. Try disabling the NMI watchdog:
> >          echo 0 > /proc/sys/kernel/nmi_watchdog
> >          perf stat ...
> >          echo 1 > /proc/sys/kernel/nmi_watchdog
> > The events in group usually have to be from the same PMU. Try
> > reorganizing the group.
> > ```
> >
> > If we add two extra cycles or the original group is smaller then it is "fixed":
> > ```
> > $ perf stat -e '{BR_INST_RETIRED.NEAR_CALL,BR_INST_RETIRED.NEAR_TAKEN,BR_INST_RETIRED.NOT_TAKEN,cycles}:W'
> > -a sleep 1
> >
> >   Performance counter stats for 'system wide':
> >
> >          20,378,789      BR_INST_RETIRED.NEAR_CALL
> >         168,420,963      BR_INST_RETIRED.NEAR_TAKEN
> >          96,330,608      BR_INST_RETIRED.NOT_TAKEN
> >       1,652,230,042      cycles
> >
> >         1.008757590 seconds time elapsed
> >
> > $ perf stat -e '{BR_INST_RETIRED.NEAR_CALL,BR_INST_RETIRED.NEAR_TAKEN,BR_INST_RETIRED.NOT_TAKEN,cycles,cycles,cycles}:W'
> > -a sleep 1
> >
> >   Performance counter stats for 'system wide':
> >
> >          37,696,638      BR_INST_RETIRED.NEAR_CALL
> >                 (66.62%)
> >         298,535,151      BR_INST_RETIRED.NEAR_TAKEN
> >                  (66.63%)
> >         297,011,663      BR_INST_RETIRED.NOT_TAKEN
> >                 (66.63%)
> >       3,155,711,474      cycles
> >                 (66.65%)
> >       3,194,919,959      cycles
> >                 (66.74%)
> >       3,126,664,102      cycles
> >                 (66.72%)
> >
> >         1.006237962 seconds time elapsed
> > ```
> >
> > So the extra cycles is needed to fix weak groups when the nmi watchdog
> > is enabled and the group is an architecture dependent size.
>
> Yes, the size of the group depends on the architecture, but perf tool
> doesn't need to know the HW details. For this case, perf tool just sends
> the request with an extra cycles event in the group and lets kernel decide.

I prefer doing this in the kernel even if it'd be incomplete.
For the NMI watchdog, is it possible to check if it's enabled
at the moment, and set the fake_cpuc->idxmsk to prevent
scheduling events in validate_group()?

Thanks,
Namhyung

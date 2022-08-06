Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7CC58B4C6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 11:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241733AbiHFJhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 05:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiHFJhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 05:37:20 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D2F15808;
        Sat,  6 Aug 2022 02:37:19 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M0HNg0gYhzlVsH;
        Sat,  6 Aug 2022 17:34:27 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 6 Aug 2022 17:37:14 +0800
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 6 Aug 2022 17:37:13 +0800
Subject: Re: [PATCH v2 0/7] perf kwork: A couple of fixes according to review
 comments
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <colin.i.king@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>
CC:     <pc@us.ibm.com>, <yhs@fb.com>, <andrii.nakryiko@gmail.com>,
        <songliubraving@fb.com>
References: <20220730030335.78203-1-yangjihong1@huawei.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <417639ef-5c98-35a6-0ec7-501c1a33475a@huawei.com>
Date:   Sat, 6 Aug 2022 17:37:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20220730030335.78203-1-yangjihong1@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

PING.

Regards,
Jihong
.

On 2022/7/30 11:03, Yang Jihong wrote:
> Some issues are fixed based on the comments of several reviewers:
> 1. Add '--synth task' option for record (note from Namhyung)
> 2. Replace hard-coded initialization of nr_tracepoints with ARRAY_SIZE macro (note from Namhyung)
> 3. Fix spelling mistake: "PRINT_TIME_UNIT_MESC_WIDTH" -> "PRINT_TIME_UNIT_MSEC_WIDTH" (note from Namhyung)
> 4. Fix spelling mistake: "Captuer" -> "Capture" (note from Colin)
> 5. Add some {} for multiline for/if blocks (note from Arnaldo)
> 
> Modifying based on the latest commit (9a0b36266f7a) at acme/perf/core:
> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/core
> 
> Yang Jihong (7):
>    perf kwork: Add '--synth task' option for record
>    perf kwork: Replace hard-coded initialization of nr_tracepoints with
>      ARRAY_SIZE macro
>    perf kwork: Fix spelling mistake: "Captuer" -> "Capture"
>    perf kwork: Fix spelling mistake: "PRINT_TIME_UNIT_MESC_WIDTH" ->
>      "PRINT_TIME_UNIT_MSEC_WIDTH"
>    perf kwork: Strdup function name in workqueue_work_init
>    perf kwork: Expand capacity of bpf entries
>    perf kwork: Add some {} for multiline for/if blocks
> 
>   tools/perf/builtin-kwork.c                 | 67 +++++++++++++---------
>   tools/perf/util/bpf_skel/kwork_trace.bpf.c |  2 +-
>   2 files changed, 40 insertions(+), 29 deletions(-)
> 

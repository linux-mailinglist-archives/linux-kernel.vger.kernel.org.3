Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B99346D2BC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 12:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbhLHLzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 06:55:39 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4229 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhLHLzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 06:55:38 -0500
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J8Fpd2RrCz67gtT;
        Wed,  8 Dec 2021 19:50:17 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 8 Dec 2021 12:52:04 +0100
Received: from [10.47.91.245] (10.47.91.245) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 8 Dec
 2021 11:52:02 +0000
Subject: Re: [PATCH v2 3/3] perf tools: Support register names from all archs
To:     German Gomez <german.gomez@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <acme@kernel.org>
CC:     Alexandre Truong <alexandre.truong@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-csky@vger.kernel.org>, <linux-riscv@lists.infradead.org>
References: <20211207180653.1147374-1-german.gomez@arm.com>
 <20211207180653.1147374-4-german.gomez@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <90bcce69-9585-3fb4-de89-bbf2bd6def05@huawei.com>
Date:   Wed, 8 Dec 2021 11:51:43 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20211207180653.1147374-4-german.gomez@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.91.245]
X-ClientProxiedBy: lhreml724-chm.china.huawei.com (10.201.108.75) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2021 18:06, German Gomez wrote:
>   tools/perf/arch/arm/include/perf_regs.h       |  42 --
>   tools/perf/arch/arm64/include/perf_regs.h     |  76 --
>   tools/perf/arch/csky/include/perf_regs.h      |  82 ---
>   tools/perf/arch/mips/include/perf_regs.h      |  69 --
>   tools/perf/arch/powerpc/include/perf_regs.h   |  66 --
>   tools/perf/arch/riscv/include/perf_regs.h     |  74 --
>   tools/perf/arch/s390/include/perf_regs.h      |  78 --
>   tools/perf/arch/x86/include/perf_regs.h       |  82 ---
>   tools/perf/builtin-script.c                   |  18 +-
>   tools/perf/util/perf_regs.c                   | 666 ++++++++++++++++++
>   tools/perf/util/perf_regs.h                   |  10 +-
>   .../scripting-engines/trace-event-python.c    |  10 +-
>   tools/perf/util/session.c                     |  25 +-
>   13 files changed, 697 insertions(+), 601 deletions(-)

Did you consider leaving the register structures where they are while
renaming to include the arch name and then having as externs or similar? 
I see an example of that idea for arm64_unwind_libunwind_ops.

Cheers,
John

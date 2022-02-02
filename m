Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BB54A6EC6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343537AbiBBKdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 05:33:31 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4616 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiBBKd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:33:29 -0500
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JpdRV45Q6z67y8Y;
        Wed,  2 Feb 2022 18:32:54 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Feb 2022 11:33:27 +0100
Received: from [10.47.27.42] (10.47.27.42) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 2 Feb
 2022 10:33:20 +0000
Message-ID: <ecbca50c-775b-e460-a6dd-488069c3f390@huawei.com>
Date:   Wed, 2 Feb 2022 10:33:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v9] libperf: Add arm64 support to perf_mmap__read_self()
To:     Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
CC:     Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220201214056.702854-1-robh@kernel.org>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220201214056.702854-1-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.27.42]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2022 21:40, Rob Herring wrote:
> Add the arm64 variants for read_perf_counter() and read_timestamp().
> Unfortunately the counter number is encoded into the instruction, so the
> code is a bit verbose to enumerate all possible counters.
> 
> Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Ha, I was just looking at this same topic yesterday from an old patchset 
[0] and wasn't aware of this separate change.

Tested-by: John Garry <john.garry@huawei.com>

[0] https://lore.kernel.org/all/20210311000837.3630499-1-robh@kernel.org/

BTW, Documentation/arm64/perf.rst has a reference to a file which does 
not seem to exit:

.. _tools/perf/arch/arm64/tests/user-events.c:
 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/arch/arm64/tests/user-events.c

Thanks,
john

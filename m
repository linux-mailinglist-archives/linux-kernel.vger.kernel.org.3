Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066654B6A7D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 12:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237015AbiBOLQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 06:16:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbiBOLQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 06:16:28 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EAC108184;
        Tue, 15 Feb 2022 03:16:18 -0800 (PST)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jydn63pb7z6873Q;
        Tue, 15 Feb 2022 19:15:54 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Feb 2022 12:16:16 +0100
Received: from [10.47.81.62] (10.47.81.62) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Tue, 15 Feb
 2022 11:16:14 +0000
Message-ID: <06412caf-42e4-5c4b-c9b3-9691075405bd@huawei.com>
Date:   Tue, 15 Feb 2022 11:16:16 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: Test 73 Sig_trap fails on arm64 (was Re: [PATCH] perf test: Test
 73 Sig_trap fails on s390)
From:   John Garry <john.garry@huawei.com>
To:     Leo Yan <leo.yan@linaro.org>, Marco Elver <elver@google.com>,
        Will Deacon <will@kernel.org>
CC:     Thomas Richter <tmricht@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <acme@kernel.org>, <svens@linux.ibm.com>, <gor@linux.ibm.com>,
        <sumanthk@linux.ibm.com>, <hca@linux.ibm.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, <dvyukov@google.com>
References: <20211216151454.752066-1-tmricht@linux.ibm.com>
 <CANpmjNNMWtjcKa961SjEvRbbPXyw5M5SkrXbb3tnyL3_XyniCw@mail.gmail.com>
 <90efb5a9-612a-919e-cf2f-c528692d61e2@huawei.com>
 <20220118091827.GA98966@leoy-ThinkPad-X240s>
 <CANpmjNMPoU+1b1fKFuYDYwisW2YfjQHxGt5hgLp1tioG7C2jmg@mail.gmail.com>
 <20220118124343.GC98966@leoy-ThinkPad-X240s>
 <bfa0af18-04ac-857d-d3d8-ad9290f912c8@huawei.com>
In-Reply-To: <bfa0af18-04ac-857d-d3d8-ad9290f912c8@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.81.62]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/2022 09:19, John Garry wrote:

Hi Will,

Have you had a chance to check this or the mail from Dmitry?

https://lore.kernel.org/linux-perf-users/CACT4Y+YVyJcqbR5j2fsSQ+C5hy78X+aobrUHaZKghFf0_NMv=A@mail.gmail.com/

If we can't make progress then we just need to skip the test on arm64 
for now.

Thanks,
John

> 
>> On Tue, Jan 18, 2022 at 12:40:04PM +0100, Marco Elver wrote:
>>
>> [...]
>>
>>>> Both Arm and Arm64 platforms cannot support signal handler with
>>>> breakpoint, please see the details in [1].  So I think we need
>>>> something like below:
>>>>
>>>> static int test__sigtrap(struct test_suite *test __maybe_unused, int 
>>>> subtest __maybe_unused)
>>>> {
>>>>          ...
>>>>
>>>>          if (!BP_SIGNAL_IS_SUPPORTED) {
>>>>                  pr_debug("Test not supported on this architecture");
>>>>                  return TEST_SKIP;
>>>>          }
>>>>
>>>>          ...
>>>> }
>>>>
>>>> Since we have defined BP_SIGNAL_IS_SUPPORTED, I think we can reuse 
>>>> it at
>>>> here.
>>>>
>>>> [1]https://lore.kernel.org/lkml/157169993406.29376.12473771029179755767.tip-bot2@tip-bot2/ 
>>>>
>>> Does this limitation also exist for address watchpoints? The sigtrap
>>> test does not make use of instruction breakpoints, but instead just
>>> sets up a watchpoint on access to a data address.
>> Yes, after reading the code, the flow for either instrution breakpoint
>> or watchpoint both use the single step [1], thus the signal handler will
>> take the single step execution and lead to the infinite loop.
>>
>> I am not the best person to answer this question; @Will, could you
>> confirm for this?  Thanks!
>>
>> Leo
>>
>> [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/kernel/hw_breakpoint.c 
>>
> 
> .


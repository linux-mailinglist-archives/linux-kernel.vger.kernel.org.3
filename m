Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758AC52D45E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 15:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238898AbiESNnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 09:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiESNmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 09:42:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01B913ED3D;
        Thu, 19 May 2022 06:42:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FBBB15DB;
        Thu, 19 May 2022 06:42:33 -0700 (PDT)
Received: from [10.57.3.56] (unknown [10.57.3.56])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04D473F66F;
        Thu, 19 May 2022 06:42:30 -0700 (PDT)
Message-ID: <4031d3a2-9f37-4399-f4b0-8a60d0d8193b@arm.com>
Date:   Thu, 19 May 2022 14:42:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH 00/20] perf vendors events arm64: Multiple Arm CPUs
To:     John Garry <john.garry@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>
References: <20220510104758.64677-1-nick.forrington@arm.com>
 <f523b0fe-1262-c1e5-c587-15842ccf0fcf@arm.com>
 <28509191-3a45-de6d-f5bc-a8e7331c0a9e@huawei.com>
From:   Nick Forrington <nick.forrington@arm.com>
In-Reply-To: <28509191-3a45-de6d-f5bc-a8e7331c0a9e@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18/05/2022 09:15, John Garry wrote:
> On 17/05/2022 15:32, Robin Murphy wrote:
>>
>> On 2022-05-10 11:47, Nick Forrington wrote:
>>> Add Performance Monitoring Unit event data for the Arm CPUs listed
>>> below.
>>>
>>> Changesets are dependent due to incremental updates to the common 
>>> events
>>> file and mapfile.csv.
>>>
>>> Data is sourced from https://github.com/ARM-software/data
>>>
>>> Nick Forrington (20):
>>>    perf vendors events arm64: Arm Cortex-A5
>>>    perf vendors events arm64: Arm Cortex-A7
>>>    perf vendors events arm64: Arm Cortex-A8
>>>    perf vendors events arm64: Arm Cortex-A9
>>>    perf vendors events arm64: Arm Cortex-A15
>>>    perf vendors events arm64: Arm Cortex-A17
>>>    perf vendors events arm64: Arm Cortex-A32
>>
>> Obligatory question over anything relating to the above CPUs being in 
>> an "arch/arm64" directory... ;)
>
> If we were to add to arm32/arm then the common event numbers and maybe 
> other JSONs in future would need to be duplicated.
>
> Would there be any reason to add to arm32/arm apart to from being 
> strictly proper? Maybe if lots of other 32b support for other vendors 
> came along then it could make sense (to separate them out).

Not that I'm aware of, although I don't have these available to test.

I'm happy to re-submit without these CPUs if it simplifies things.

Thanks,
Nick


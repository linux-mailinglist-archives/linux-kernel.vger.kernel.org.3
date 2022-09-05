Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15615AD17D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 13:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237713AbiIELTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 07:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235821AbiIELT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 07:19:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F6FB1FD;
        Mon,  5 Sep 2022 04:19:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B689ED1;
        Mon,  5 Sep 2022 04:19:26 -0700 (PDT)
Received: from [10.57.16.136] (unknown [10.57.16.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7311E3F7B4;
        Mon,  5 Sep 2022 04:19:18 -0700 (PDT)
Message-ID: <8800c180-ed40-1de2-82c6-b6077fbf0bfc@arm.com>
Date:   Mon, 5 Sep 2022 12:19:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH] perf vendor events: Add missing Neoverse V1 events
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     John Garry <john.garry@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20220901151804.294823-1-nick.forrington@arm.com>
 <c17d8229-6029-3fd6-1ce5-f406962eae8f@huawei.com>
 <6813a737-736d-7e15-a44f-d800ed9248be@arm.com> <YxJYv0IfvmL1BTrX@kernel.org>
From:   Nick Forrington <nick.forrington@arm.com>
In-Reply-To: <YxJYv0IfvmL1BTrX@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/09/2022 20:25, Arnaldo Carvalho de Melo wrote:
> Em Fri, Sep 02, 2022 at 03:12:49PM +0100, Nick Forrington escreveu:
>> On 02/09/2022 09:04, John Garry wrote:
>>> On 01/09/2022 16:18, Nick Forrington wrote:
>>>> Based on updated data from:
>>>> https://github.com/ARM-software/data/blob/master/pmu/neoverse-v1.json
>>>>
>>>> which is based on PMU event descriptions from the Arm Neoverse V1
>>>> Technical Reference Manual.
>>>>
>>>> This adds the following missing events:
>>>> ASE_INST_SPEC
>>>> SVE_INST_SPEC
>>>> SVE_PRED_SPEC
>>>> SVE_PRED_EMPTY_SPEC
>>>> SVE_PRED_FULL_SPEC
>>>> SVE_PRED_PARTIAL_SPEC
>>>> SVE_LDFF_SPEC
>>>> SVE_LDFF_FAULT_SPEC
>>>> FP_SCALE_OPS_SPEC
>>>> FP_FIXED_OPS_SPEC
>>>>
>>>> It also moves REMOTE_ACCESS from other.json to memory.json.
>>> Any specific reason why? I see that neoverse n2 and a76-n1 still use
>>> "other" json for REMOTE_ACCESS. Nicer to be consistent.
>> Thanks John, I agree on consistency.
>>
>> I think memory is a better categorisation (for all CPUs), and this is
>> consistent with what I submitted for various Cortex CPUs a while back.
> Were those patches processed or is some still outstanding?

Those were processed.

(REMOTE_ACCESS appears in memory.json for the Cortex JSON files)

>   
>> I'd be happy to remove the REMOTE_ACCESS change here and update (or not)
>> REMOTE_ACCESS for Neoverse separately.
>>
>>>> Signed-off-by: Nick Forrington<nick.forrington@arm.com>
>>>> ---
>>> Apart from above:
>>> Reviewed-by: John Garry <john.garry@huawei.com>
>> Thanks, Nick
> So, how should we proceed?
>
> - Arnaldo

I'll update this patch to remove the REMOTE_ACCESS change, and submit a 
separate patch to make REMOTE_ACCESS categorisation consistent across 
all CPUs.


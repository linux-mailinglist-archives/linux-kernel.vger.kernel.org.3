Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7188522A85
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 05:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239575AbiEKDsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 23:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiEKDsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 23:48:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0217816ABC5;
        Tue, 10 May 2022 20:48:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71BB9106F;
        Tue, 10 May 2022 20:48:07 -0700 (PDT)
Received: from [192.168.0.8] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2029B3F5A1;
        Tue, 10 May 2022 20:48:00 -0700 (PDT)
Message-ID: <6322e2d1-eaa0-e5ee-84b1-5c4a5ce522f3@arm.com>
Date:   Wed, 11 May 2022 09:19:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V5 0/8] perf: Expand perf_branch_entry
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, Robin Murphy <robin.murphy@arm.com>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20220404045046.634522-1-anshuman.khandual@arm.com>
 <f469f253-9ccc-d55b-731d-3ecc8d685104@arm.com>
 <a304d9e4-2632-1ba9-249f-1d87c90f82de@arm.com> <YmqagfywsvGXaIVl@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <YmqagfywsvGXaIVl@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/28/22 19:15, Arnaldo Carvalho de Melo wrote:
> Em Mon, Apr 18, 2022 at 12:17:53PM +0530, Anshuman Khandual escreveu:
>> On 4/11/22 11:16, Anshuman Khandual wrote:
>>> On 4/4/22 10:20, Anshuman Khandual wrote:
>>>> - Rebased series on v5.18-rc1
>>>
>>> Gentle ping, any updates on this series ?
>>
>> Gentle ping, any updates on this series ?
>>
>> I have posted BRBE RFC V2 accommodating all these new perf ABI changes being
>> proposed here. I would really appreciate reviews and/or suggestions on this
>> series, which is essential and also prerequisite for the BRBE driver itself.
>>
>> https://lore.kernel.org/all/20220412115455.293119-1-anshuman.khandual@arm.com/
> 
> Has the kernel bits been merged? When that happens I'll cherry pick the
No, this series is still waiting for reviews for the kernel changes.

> tools/ ones.

Sure.

> 
> In future series, please, on the final patch submission, please send two
> series, one for the kernel and another for tooling.

Sure, will do.

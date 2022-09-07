Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98F55AFC49
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiIGGWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiIGGWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:22:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0E109CCF1;
        Tue,  6 Sep 2022 23:22:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFA881042;
        Tue,  6 Sep 2022 23:22:06 -0700 (PDT)
Received: from [10.162.40.15] (unknown [10.162.40.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDD963F534;
        Tue,  6 Sep 2022 23:22:26 -0700 (PDT)
Message-ID: <808b31ab-f4d7-ede4-abaf-def639455c36@arm.com>
Date:   Wed, 7 Sep 2022 11:51:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] perf: Consolidate branch sample filter helpers
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20220906084414.396220-1-anshuman.khandual@arm.com>
 <YxccSZOGAwdiYrsj@hirez.programming.kicks-ass.net>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <YxccSZOGAwdiYrsj@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/6/22 15:39, Peter Zijlstra wrote:
> On Tue, Sep 06, 2022 at 02:14:14PM +0530, Anshuman Khandual wrote:
>> Besides the branch type filtering requests, 'event.attr.branch_sample_type'
>> also contains various flags indicating which additional information should
>> be captured, along with the base branch record. These flags help configure
>> the underlying hardware, and capture the branch records appropriately when
>> required e.g after PMU interrupt. But first, this moves an existing helper
>> perf_sample_save_hw_index() into the header before adding some more helpers
>> for other branch sample filter flags.
>>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>> Cc: linux-perf-users@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> Hello Peter,
>>
>> Could you please consider taking this patch along with others on the perf
>> ABI series. This patch has been part of the original BRBE driver series,
>> which will have one less patch to include going forward. Thank you.
>>
>> - Anshuman
>>
>> This applies on v6.0-rc4 but after applying the following patch series
>>
>> https://lore.kernel.org/all/20220824044822.70230-1-anshuman.khandual@arm.com/
>>
> 
> Yeah, but it doesn't cleanly apply to tip/perf/core....
> 
> The conflict looks trivial, let me stomp on it to make it fit :-)

Thank you.

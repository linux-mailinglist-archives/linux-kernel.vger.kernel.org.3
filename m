Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FAE592AAA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 10:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240380AbiHOIAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 04:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240812AbiHOIAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 04:00:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4818AB7E7;
        Mon, 15 Aug 2022 01:00:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C9F3113E;
        Mon, 15 Aug 2022 01:00:37 -0700 (PDT)
Received: from [192.168.99.12] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BC9F3F67D;
        Mon, 15 Aug 2022 01:00:35 -0700 (PDT)
Message-ID: <b679a0a9-938b-5039-8bce-b2cb1b45cb78@foss.arm.com>
Date:   Mon, 15 Aug 2022 09:00:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 00/14] perf: test: Add trace data quality tests for
 CoreSight
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org,
        linux-perf-users@vger.kernel.org
References: <20220812121641.336465-1-carsten.haitzler@foss.arm.com>
 <YvahJcUNAZ0WC8fj@kernel.org> <YvahnOSyts95F8xm@kernel.org>
 <YvaiE4w/Fb0XAmmM@kernel.org> <YvajWfaMUDjmrFoY@kernel.org>
From:   Carsten Haitzler <carsten.haitzler@foss.arm.com>
Organization: Arm Ltd.
In-Reply-To: <YvajWfaMUDjmrFoY@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/12/22 20:00, Arnaldo Carvalho de Melo wrote:
> Em Fri, Aug 12, 2022 at 03:55:15PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Fri, Aug 12, 2022 at 03:53:16PM -0300, Arnaldo Carvalho de Melo escreveu:
>>> Em Fri, Aug 12, 2022 at 03:51:17PM -0300, Arnaldo Carvalho de Melo escreveu:
>>>> Em Fri, Aug 12, 2022 at 01:16:27PM +0100, carsten.haitzler@foss.arm.com escreveu:
>>>>> previous older versions of test scripts that are editor backup files
>>>>> as well as skipping perf.data files that may appear and so on.
> 
>>>>> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
> 
>>>> On the next series, please add to the cover letter a summary of what
>>>> changed on each repost.
> 
>>> I also saw that several of your patches got reviewed and given
>>> "Reviewed-by" tags, so if some of the patches in the previous versions
>>> didn't change and received Reviewed-by tags, please collect them on the
>>> current version.
> 
>> I tried getting v5 to see if b4 would find v6 and v7 and go on figuring
>> this out for us, but somehow it can't match v5 to v6 and v7:
> 
> It seems you changed the subject on the cover letter, and AFAIK that is
> what makes b4 find a previous version :-\

I was asked to change the subject... so I did. :)

> - Arnaldo
>   
>> ⬢[acme@toolbox perf]$ b4 am -ctsl --cc-trailers 20220728145256.2985298-1-carsten.haitzler@foss.arm.com
>> Grabbing thread from lore.kernel.org/all/20220728145256.2985298-1-carsten.haitzler%40foss.arm.com/t.mbox.gz
>> Checking for newer revisions on https://lore.kernel.org/all/
>> Analyzing 36 messages in the thread
>> ('Reviewed-by', 'Leo Yan <leo.yan@linaro.org>', None)
>> Checking attestation on all messages, may take a moment...
>> ---
>>    [PATCH v5 1/14] perf test: Refactor shell tests allowing subdirs
>>      + Reviewed-by: Leo Yan <leo.yan@linaro.org> (✓ DKIM/linaro.org)
>>    [PATCH v5 2/14] perf test: Add CoreSight shell lib shared code for future tests
>>      + Reviewed-by: Leo Yan <leo.yan@linaro.org> (✓ DKIM/linaro.org)
>>    [PATCH v5 3/14] perf test: Add build infra for perf test tools for CoreSight tests
>>    [PATCH v5 4/14] perf test: Add asm pureloop test tool
>>      + Reviewed-by: Leo Yan <leo.yan@linaro.org> (✓ DKIM/linaro.org)
>>    [PATCH v5 5/14] perf test: Add asm pureloop test shell script
>>      + Reviewed-by: Leo Yan <leo.yan@linaro.org> (✓ DKIM/linaro.org)
>>    [PATCH v5 6/14] perf test: Add git ignore for perf data generated by the CoreSight tests
>>      + Reviewed-by: Leo Yan <leo.yan@linaro.org> (✓ DKIM/linaro.org)
>>    [PATCH v5 7/14] perf test: Add memcpy thread test tool
>>      + Reviewed-by: Leo Yan <leo.yan@linaro.org> (✓ DKIM/linaro.org)
>>    [PATCH v5 8/14] perf test: Add memcpy thread test shell script
>>      + Reviewed-by: Leo Yan <leo.yan@linaro.org> (✓ DKIM/linaro.org)
>>    [PATCH v5 9/14] perf test: Add thread loop test tool
>>      + Reviewed-by: Leo Yan <leo.yan@linaro.org> (✓ DKIM/linaro.org)
>>    [PATCH v5 10/14] perf test: Add thread loop test shell scripts
>>      + Reviewed-by: Leo Yan <leo.yan@linaro.org> (✓ DKIM/linaro.org)
>>    [PATCH v5 11/14] perf test: Add unroll thread test tool
>>      + Reviewed-by: Leo Yan <leo.yan@linaro.org> (✓ DKIM/linaro.org)
>>    [PATCH v5 12/14] perf test: Add unroll thread test shell script
>>      + Reviewed-by: Leo Yan <leo.yan@linaro.org> (✓ DKIM/linaro.org)
>>    [PATCH v5 13/14] perf test: Add git ignore for tmp and output files of CoreSight tests
>>      + Reviewed-by: Leo Yan <leo.yan@linaro.org> (✓ DKIM/linaro.org)
>>    [PATCH v5 14/14] perf test: Add relevant documentation about CoreSight testing
>>      + Reviewed-by: Mike Leach <mike.leach@linaro.org> (✓ DKIM/linaro.org)
>>      + Reviewed-by: Leo Yan <leo.yan@linaro.org> (✓ DKIM/linaro.org)
>> ---
>> Total patches: 14
>> ---
>> Cover: ./v5_20220728_carsten_haitzler_a_patch_series_improving_data_quality_of_perf_test_for_coresight.cover
>>   Link: https://lore.kernel.org/r/20220728145256.2985298-1-carsten.haitzler@foss.arm.com
>>   Base: not specified
>>         git am ./v5_20220728_carsten_haitzler_a_patch_series_improving_data_quality_of_perf_test_for_coresight.mbx
>> ⬢[acme@toolbox perf]$

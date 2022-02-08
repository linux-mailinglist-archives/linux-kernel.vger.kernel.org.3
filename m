Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760C04ADDCE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 17:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382505AbiBHP72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381811AbiBHP7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:59:23 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62362C061576;
        Tue,  8 Feb 2022 07:59:22 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2862C1FB;
        Tue,  8 Feb 2022 07:59:22 -0800 (PST)
Received: from [10.57.36.220] (unknown [10.57.36.220])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8899D3F70D;
        Tue,  8 Feb 2022 07:59:20 -0800 (PST)
Message-ID: <2d52edc4-c6e6-b641-b291-d1726cc20b30@arm.com>
Date:   Tue, 8 Feb 2022 15:58:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [RFC PATCH v2 0/5] topdown with metrics
Content-Language: en-US
From:   Andrew Kilroy <andrew.kilroy@arm.com>
To:     John Garry <john.garry@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org,
        irogers@google.com, ak@linux.intel.com
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
References: <4fefb1bc-49b2-bc5b-23cd-cd8fabe8c588@huawei.com>
 <20220111150749.13365-1-andrew.kilroy@arm.com>
 <7cd7bd11-4900-81c4-de84-6e5fc63ec87c@huawei.com>
 <1fa70669-146c-7ec6-cee9-4f59751eb334@arm.com>
In-Reply-To: <1fa70669-146c-7ec6-cee9-4f59751eb334@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/01/2022 11:42, Andrew Kilroy wrote:
> 
> 
> On 20/01/2022 09:26, John Garry wrote:
>> On 11/01/2022 15:07, Andrew Kilroy wrote:
>>> This patch series adds the ability for the --topdown option to use
>>> metrics (defined in json files in the pmu-events directory) to describe
>>> how to calculate and determine the output columns for topdown level 1.
>>>
>>> For this to work, a number of metrics have to be defined for the
>>> relevant processor with the MetricGroup name "TopDownL1".  perf will
>>> arrange for the events defined in each metric to be collected, and each
>>> metric will be displayed in the output, as if
>>>
>>>    perf stat -M 'TopDownL1' --metric-only -- exampleapp
>>>
>>> had been used.
>>>
>>> Topdown was already implemented where certain kernel events are defined.
>>> If these kernel events are defined, the new json metrics behaviour is
>>> not used.  The json metrics approach is only used if the kernel events
>>> are absent.
>>>
>>> The last patch in the series disables the json metrics behaviour on x86.
>>> This is because of concerns that due to SMT it's not straightforward to
>>> express the various formulas as json for certain x86 cpus.  See
>>
>> I suppose this solution is ok.
>>
> 
> Thanks, would you mind giving it a Reviewed-By?
> 
>> A concern is that today we only have 1x arm64 platform which actually 
>> supports this in mainline.
>>
>> Do you have any more which you plan to support?
>>
> 
> The Neoverse cores, mainly.
> 

Thanks for the feedback on this RFC, I think we'll resubmit these 
patches at a later time, when we've got a json metrics file or two.

Thanks,
Andrew

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F63524DAB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354061AbiELNBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354067AbiELNBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:01:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 57B0662214;
        Thu, 12 May 2022 06:01:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1001723A;
        Thu, 12 May 2022 06:01:22 -0700 (PDT)
Received: from [10.57.2.11] (unknown [10.57.2.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B5623F66F;
        Thu, 12 May 2022 06:01:19 -0700 (PDT)
Message-ID: <eec03f0d-d491-511c-d9b0-694c6d527b38@arm.com>
Date:   Thu, 12 May 2022 14:01:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH 00/20] perf vendors events arm64: Multiple Arm CPUs
To:     John Garry <john.garry@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Will Deacon <will@kernel.org>,
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
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20220510104758.64677-1-nick.forrington@arm.com>
 <YnqJwMfi/bcDmN4H@kernel.org>
 <b1081013-2cd9-f223-8125-d7e51d784f90@huawei.com>
From:   Nick Forrington <nick.forrington@arm.com>
In-Reply-To: <b1081013-2cd9-f223-8125-d7e51d784f90@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2022 16:55, John Garry wrote:
> On 10/05/2022 16:50, Arnaldo Carvalho de Melo wrote:
>> Em Tue, May 10, 2022 at 11:47:38AM +0100, Nick Forrington escreveu:
>>> Add Performance Monitoring Unit event data for the Arm CPUs listed
>>> below.
>>>
>>> Changesets are dependent due to incremental updates to the common 
>>> events
>>> file and mapfile.csv.
>>>
>>> Data is sourced fromhttps://github.com/ARM-software/data
>> Waiting for reviews to merge this.
>>
>
> I'll have a closer look this week.
>
> @Nick, Just curious, do you have some tool/script to convert from the 
> JSON format @ https://github.com/ARM-software/data/blob/master/pmu/ to 
> the "linux" format?

Thanks John.

We do have a conversion script, although it isn't publically available 
anywhere at the moment.

Thanks,
Nick


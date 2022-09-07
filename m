Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B056B5B08B5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 17:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiIGPjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 11:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiIGPjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 11:39:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A68A045045;
        Wed,  7 Sep 2022 08:39:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95B84106F;
        Wed,  7 Sep 2022 08:39:11 -0700 (PDT)
Received: from [10.57.15.206] (unknown [10.57.15.206])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68A6C3F71A;
        Wed,  7 Sep 2022 08:39:03 -0700 (PDT)
Message-ID: <fd9097a8-589c-90cb-4848-10386f5f664f@arm.com>
Date:   Wed, 7 Sep 2022 16:39:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH] perf vendor events: Update events for Neoverse E1
To:     John Garry <john.garry@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20220905153020.1792-1-nick.forrington@arm.com>
 <YxdGFAYHeO/j5uJF@kernel.org>
 <496f98ce-a0c4-9587-853c-9ba05323523a@huawei.com>
 <caaf43aa-6c36-b263-30ba-7a4d3edd4e20@arm.com>
 <0f73ba23-b892-035a-10f0-384e77b71040@huawei.com>
From:   Nick Forrington <nick.forrington@arm.com>
In-Reply-To: <0f73ba23-b892-035a-10f0-384e77b71040@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2022 15:47, John Garry wrote:
> On 06/09/2022 15:36, Robin Murphy wrote:
>>>
>>> This looks the same as an a65 event. And more similar cases below, 
>>> at a glance.
>>
>> According to Anandtech, E1 is to A65 what N1 is to A76, and if they 
>> say so then it must be true :)
>
> That would make life easier :)
>
> And even if only the events are the same, then they are the same core 
> from pmu-events PoV.

I'll submit a v2 that de-dups A65 and E1 event files. (A65 data is 
already correct, so need for the E1 fixes)

Thanks, Nick


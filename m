Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAEE584409
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 18:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbiG1QR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 12:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbiG1QRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 12:17:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E74396F7EC;
        Thu, 28 Jul 2022 09:17:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5348D106F;
        Thu, 28 Jul 2022 09:17:12 -0700 (PDT)
Received: from [10.57.11.98] (unknown [10.57.11.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9482E3F70D;
        Thu, 28 Jul 2022 09:17:09 -0700 (PDT)
Message-ID: <3379eac1-d398-60be-b606-10098702d7aa@arm.com>
Date:   Thu, 28 Jul 2022 17:17:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH] perf vendor events arm64: Arm Cortex-A78C and X1C
To:     John Garry <john.garry@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org
Cc:     Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20220610174459.615995-1-nick.forrington@arm.com>
 <2955958b-4982-42bc-7c68-82cd23462b35@huawei.com>
From:   Nick Forrington <nick.forrington@arm.com>
In-Reply-To: <2955958b-4982-42bc-7c68-82cd23462b35@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2022 11:09, John Garry wrote:
> On 10/06/2022 18:44, Nick Forrington wrote:
>> Add PMU events for the Arm Cortex-A78C and Arm Cortex-X1C CPUs.
>>
>> Events for Arm Cortex-A78C match those for Arm Cortex-A78.
>> Events for Arm Cortex-X1C match those for Arm Cortex- X1.
>>
>> As such, this is just a mapfile change.
>>
>> Main ID Register (MIDR) and event data is sourced from the corresponding
>> Arm Technical Reference Manuals:
>>
>> Arm Cortex-A78C
>> https://developer.arm.com/documentation/102226/
>>
>> Arm Cortex-X1C
>> https://developer.arm.com/documentation/101968/
>>
>> Signed-off-by: Nick Forrington<nick.forrington@arm.com>
>
> Reviewed-by: John Garry <john.garry@huawei.com>

Could this be applied please?

Thanks,
Nick



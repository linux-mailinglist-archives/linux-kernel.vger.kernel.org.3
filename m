Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E138254C2DD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 09:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241944AbiFOHr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 03:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241113AbiFOHrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 03:47:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC8D5E004;
        Wed, 15 Jun 2022 00:47:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74B81153B;
        Wed, 15 Jun 2022 00:47:48 -0700 (PDT)
Received: from [10.57.38.196] (unknown [10.57.38.196])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CB3A3F66F;
        Wed, 15 Jun 2022 00:47:46 -0700 (PDT)
Message-ID: <21eb45a4-de6c-58f4-6649-4491c00cc464@arm.com>
Date:   Wed, 15 Jun 2022 08:47:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 0/4] Thermal cpufreq & devfreq cooling minor clean-ups
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     amitk@kernel.org, rui.zhang@intel.com, viresh.kumar@linaro.org,
        rafael@kernel.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
        mingo@redhat.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220613124327.30766-1-lukasz.luba@arm.com>
 <92f56aed-e6cd-c65b-f42f-5bd1e07b90c5@arm.com>
 <80516a8d-80b2-9c96-3ac8-4f2e6e6e851d@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <80516a8d-80b2-9c96-3ac8-4f2e6e6e851d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/14/22 19:26, Daniel Lezcano wrote:
> On 14/06/2022 14:51, Lukasz Luba wrote:
>> Hi Daniel,
>>
>>
>> On 6/13/22 13:43, Lukasz Luba wrote:
>>> Hi all,
>>>
>>> This is v2 of some minor clean-ups for the thermal cpufreq and devfreq
>>> cooling code.
>>>
>>> Changes:
>>> v2:
>>> - extened the cpufreq_cooling_device with private ops field, to not 
>>> waste
>>>    memory and simplify allocation/free code (Viresh)
>>> - added devfreq_cooling clean-up to align with cpufreq cooling code
>>> - added ACKs from Viresh for patch 2/4 and path 3/4
>>> - added missing maintainers of tracing to CC list
>>>
>>> Regards,
>>> Lukasz
>>>
>>> Lukasz Luba (4):
>>>    thermal: cpufreq_cooling: Use private callback ops for each cooling
>>>      device
>>>    thermal: cpufreq_cooling : Refactor thermal_power_cpu_get_power
>>>      tracing
>>>    thermal: cpufreq_cooling: Update outdated comments
>>>    thermal: devfreq_cooling: Extend the devfreq_cooling_device with ops
>>>
>>>   drivers/thermal/cpufreq_cooling.c | 77 ++++++++++---------------------
>>>   drivers/thermal/devfreq_cooling.c | 27 ++++-------
>>>   include/trace/events/thermal.h    | 28 ++++-------
>>>   3 files changed, 42 insertions(+), 90 deletions(-)
>>>
>>
>> Could you have a look and take the patches into your tree, please?
>> The 3 of 4 patches got ACKs, the last one is devfreq cooling, which
>> is pretty minor change.
> 
> Applied, thanks
> 
> 

Thanks Daniel!

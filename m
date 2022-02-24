Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CB94C2800
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbiBXJZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbiBXJZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:25:50 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA91627990C;
        Thu, 24 Feb 2022 01:25:20 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 770831476;
        Thu, 24 Feb 2022 01:25:20 -0800 (PST)
Received: from [10.57.8.211] (unknown [10.57.8.211])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 803A03F70D;
        Thu, 24 Feb 2022 01:25:18 -0800 (PST)
Message-ID: <02d16fbe-d4d6-a7f1-d81f-39f05dff76fc@arm.com>
Date:   Thu, 24 Feb 2022 09:25:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 4/4] Documentation: EM: Describe new registration
 method using DT
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, nm@ti.com,
        sboyd@kernel.org, mka@chromium.org, dianders@chromium.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20220224081131.27282-1-lukasz.luba@arm.com>
 <20220224081131.27282-5-lukasz.luba@arm.com>
 <20220224091508.fp7emu2zyhavkfkt@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220224091508.fp7emu2zyhavkfkt@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/24/22 09:15, Viresh Kumar wrote:
> On 24-02-22, 08:11, Lukasz Luba wrote:
>> The new registration method allows to get power values from the DT OPP
>> definition. The new OPP entry property "opp-microwatt" contains total
>> power expressed in micro-Watts. Align the EM documentation with this
>> new possible registration method of 'advanced' EM.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   Documentation/power/energy-model.rst | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/Documentation/power/energy-model.rst b/Documentation/power/energy-model.rst
>> index 5ac62a7b4b7c..719253fd5215 100644
>> --- a/Documentation/power/energy-model.rst
>> +++ b/Documentation/power/energy-model.rst
>> @@ -113,6 +113,16 @@ to: return warning/error, stop working or panic.
>>   See Section 3. for an example of driver implementing this
>>   callback, or Section 2.4 for further documentation on this API
>>   
>> +Registration of 'advanced' EM using DT
> 
> I am not really sure if this should be called *Advanced*. Just call it
> registration of EM using DT.

Our partners had a lot of issues with EM+EAS, because they were not
aware of the internals of EM and limitations.

We've started to name two types of EM: 'advanced' and 'simple'.
The 'simple' is the one which causes issues. Now when we contact with
partners we ask if they use 'simple' EM and see some issues in EAS.
This is a needed clarification and naming convention that we use.

Here the paragraph name is stressing the fact explicitly that
from today we have the option to provide real power measurements using
DT and it will be the 'advanced' EM.


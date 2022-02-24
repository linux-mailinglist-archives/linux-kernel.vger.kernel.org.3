Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456B24C284E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbiBXJk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbiBXJkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:40:25 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E28BA27B9A2;
        Thu, 24 Feb 2022 01:39:55 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC847ED1;
        Thu, 24 Feb 2022 01:39:55 -0800 (PST)
Received: from [10.57.8.211] (unknown [10.57.8.211])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC60C3F70D;
        Thu, 24 Feb 2022 01:39:53 -0800 (PST)
Message-ID: <927bb145-abf8-a15a-506f-0f060384d096@arm.com>
Date:   Thu, 24 Feb 2022 09:39:52 +0000
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
 <02d16fbe-d4d6-a7f1-d81f-39f05dff76fc@arm.com>
 <20220224093717.3vsi4t26zcmoh2ra@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220224093717.3vsi4t26zcmoh2ra@vireshk-i7>
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



On 2/24/22 09:37, Viresh Kumar wrote:
> On 24-02-22, 09:25, Lukasz Luba wrote:
>> Our partners had a lot of issues with EM+EAS, because they were not
>> aware of the internals of EM and limitations.
>>
>> We've started to name two types of EM: 'advanced' and 'simple'.
>> The 'simple' is the one which causes issues. Now when we contact with
>> partners we ask if they use 'simple' EM and see some issues in EAS.
>> This is a needed clarification and naming convention that we use.
>>
>> Here the paragraph name is stressing the fact explicitly that
>> from today we have the option to provide real power measurements using
>> DT and it will be the 'advanced' EM.
> 
> I understand the background now, and since I am part of the same
> community I can appreciate that. But being a maintainer, I have to say
> that when we look at something from Upstream's point of view, we may
> have to neglect/ignore the terminology used in downstream.

I understand your upstream point of view.

> 
>  From what I can see, there is no advancement here, as of now. This is
> a very small change where we are getting pre-evaluated power values
> from DT, instead of calculating them at runtime. The data may be more
> correct, but the EM doesn't get advanced because of that. And so using
> such terminology is only going to harm further. If EM gets a
> "advanced" algorithm later on, which can improve things, then yes we
> can call it advanced, but for now there is nothing.
> 

Fair enough, I'll drop this word from the paragraph name.

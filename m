Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156BE55FD1A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 12:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbiF2KYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 06:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiF2KYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 06:24:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1477427B0E;
        Wed, 29 Jun 2022 03:24:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11C8A152B;
        Wed, 29 Jun 2022 03:24:05 -0700 (PDT)
Received: from [10.57.9.39] (unknown [10.57.9.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6441E3F792;
        Wed, 29 Jun 2022 03:24:02 -0700 (PDT)
Message-ID: <a5455086-a62c-d00a-95b4-d441c0d4d2e9@arm.com>
Date:   Wed, 29 Jun 2022 11:24:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 0/4] Energy Model power in micro-Watts and SCMI v3.1
 alignment
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        rafael@kernel.org, dietmar.eggemann@arm.com, nm@ti.com,
        sboyd@kernel.org, sudeep.holla@arm.com, cristian.marussi@arm.com,
        matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>
References: <20220622145802.13032-1-lukasz.luba@arm.com>
 <be793e51-0d89-7afd-e122-ec929a1130e9@arm.com>
 <20220629095302.bi3xx6yicsnjeff7@vireshk-i7>
 <1072cb84-4097-0cbd-f980-a864ea851b0c@arm.com>
 <20220629100148.67kevfelqq7d23n5@vireshk-i7>
 <7d3fdfb5-ed03-671b-59d8-918cc0d60612@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <7d3fdfb5-ed03-671b-59d8-918cc0d60612@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 6/29/22 11:21, Daniel Lezcano wrote:
> 
> Hi Lukasz,
> 
> On 29/06/2022 12:01, Viresh Kumar wrote:
>> On 29-06-22, 11:00, Lukasz Luba wrote:
>>> Thanks for fast response. It would be great.
>>>
>>> I have 2 ACKs from Sudeep for the SCMI part,
>>> but I don't know the status e.g. of DTPM
>>> current work which is using the EM milli-Watts
>>> and does conversion to uW internally.
>>> I hope, I won't make issues to Daniel's work with this
>>> change.
>>
>> Daniel, do you have any objections to this ?
> 
> Sorry I had no time to review the series yet, give me a couple of days, 
> may be a bit more if possible
> 
> 

OK, take your time. I hope this could land as a material
for v5.20, we still have some time.

Regards,
Lukasz

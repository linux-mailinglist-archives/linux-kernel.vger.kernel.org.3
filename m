Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08A54C2821
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbiBXJe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbiBXJee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:34:34 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0117927C214;
        Thu, 24 Feb 2022 01:33:41 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3BFFED1;
        Thu, 24 Feb 2022 01:33:40 -0800 (PST)
Received: from [10.57.8.211] (unknown [10.57.8.211])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFAEE3F70D;
        Thu, 24 Feb 2022 01:33:38 -0800 (PST)
Message-ID: <93a0fb41-7b10-7461-8461-fbe2866ac42a@arm.com>
Date:   Thu, 24 Feb 2022 09:33:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/4] OPP: Add "opp-microwatt" supporting code
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, nm@ti.com,
        sboyd@kernel.org, mka@chromium.org, dianders@chromium.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20220224081131.27282-1-lukasz.luba@arm.com>
 <20220224081131.27282-3-lukasz.luba@arm.com>
 <20220224091418.wodurdfhzyrtqepg@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220224091418.wodurdfhzyrtqepg@vireshk-i7>
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



On 2/24/22 09:14, Viresh Kumar wrote:
> On 24-02-22, 08:11, Lukasz Luba wrote:
>> Add new property to the OPP: power value. The OPP entry in the DT can have
>> "opp-microwatt". Add the needed code to handle this new property in the
>> existing infrastructure.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   drivers/opp/core.c     | 20 ++++++++++++++++++
>>   drivers/opp/of.c       | 47 ++++++++++++++++++++++++++++++++++++++++--
>>   include/linux/pm_opp.h | 12 ++++++++++-
>>   3 files changed, 76 insertions(+), 3 deletions(-)
> 
> Also update drivers/opp/debugfs.c please.
> 

OK

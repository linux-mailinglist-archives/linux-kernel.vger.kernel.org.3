Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295DC568307
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbiGFJKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbiGFJJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:09:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A23E12717B;
        Wed,  6 Jul 2022 02:06:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A0FE15A1;
        Wed,  6 Jul 2022 02:06:35 -0700 (PDT)
Received: from [10.57.9.19] (unknown [10.57.9.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6EFA43F66F;
        Wed,  6 Jul 2022 02:06:31 -0700 (PDT)
Message-ID: <51b98350-0278-8e5d-90f9-3996e378a4a9@arm.com>
Date:   Wed, 6 Jul 2022 10:06:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/4] Documentation: EM: Switch to micro-Watts scale
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     amitk@kernel.org, rui.zhang@intel.com, viresh.kumar@linaro.org,
        rafael@kernel.org, dietmar.eggemann@arm.com, nm@ti.com,
        sboyd@kernel.org, sudeep.holla@arm.com, cristian.marussi@arm.com,
        matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20220622145802.13032-1-lukasz.luba@arm.com>
 <20220622145802.13032-3-lukasz.luba@arm.com>
 <be1e6e75-45e0-2c73-bace-4499b7b1af68@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <be1e6e75-45e0-2c73-bace-4499b7b1af68@linaro.org>
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



On 7/5/22 10:10, Daniel Lezcano wrote:
> On 22/06/2022 16:58, Lukasz Luba wrote:
>> The EM now uses the micro-Watts scale for the power values. Update
>> related documentation to reflect that fact.
>>
>> Fix also a problematic sentence in the doc "to:" which triggers test
>> scripts complaining about wrong email address.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> 
> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 

Thanks for the reviews!

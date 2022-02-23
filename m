Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F85C4C0EE9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 10:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239214AbiBWJNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 04:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbiBWJNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 04:13:42 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 953508093C;
        Wed, 23 Feb 2022 01:13:14 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FA781042;
        Wed, 23 Feb 2022 01:13:14 -0800 (PST)
Received: from [10.57.9.184] (unknown [10.57.9.184])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 668213F5A1;
        Wed, 23 Feb 2022 01:13:12 -0800 (PST)
Message-ID: <f6b2f524-6355-5f18-0358-6b6f96142b04@arm.com>
Date:   Wed, 23 Feb 2022 09:13:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [[PATCH v2 2/2] OPP: Add 'opp-microwatt' parsing for advanced EM
 registration
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, nm@ti.com,
        sboyd@kernel.org, mka@chromium.org, dianders@chromium.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20220222140746.12293-1-lukasz.luba@arm.com>
 <20220222140746.12293-3-lukasz.luba@arm.com>
 <20220223055357.t3wulpla64vt3xus@vireshk-i7>
 <b6682d6f-a6ae-8a82-68c3-13840c02d178@arm.com>
 <20220223091012.w3flzpye6z55jnwd@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220223091012.w3flzpye6z55jnwd@vireshk-i7>
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



On 2/23/22 09:10, Viresh Kumar wrote:
> On 23-02-22, 08:59, Lukasz Luba wrote:
>> OK, so you want to have this available for the whole system. I can do
>> that. I would go for one value of power
> 
> One value per supply, right ?

yes, only the u_watt, no _min, _max variants.

> 
>> and try to fit into the
>> opp_parse_supplies() code.
> 
> Correct.
> 
>> As far as I can see in the
>> dev_pm_opp_get_voltage() the simple solution: supplier[0] and u_volt
>> is used. I would go for similar solution for u_watt.
>> There is even a single u_amp and no _max, _min variants, so should be
>> good..
> 
> Yes, I don't think we need min/max/target kind of naming here. Just a single
> value per supply is enough.
> 

Good, thanks for comments. Let me craft the v3 then.

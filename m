Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1836E4C112E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 12:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239818AbiBWLXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 06:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbiBWLXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 06:23:00 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B64448AE4C;
        Wed, 23 Feb 2022 03:22:32 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49987106F;
        Wed, 23 Feb 2022 03:22:32 -0800 (PST)
Received: from [10.57.9.184] (unknown [10.57.9.184])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59D7C3F70D;
        Wed, 23 Feb 2022 03:22:30 -0800 (PST)
Message-ID: <94d3f2a3-4145-afdc-d810-61f2120df579@arm.com>
Date:   Wed, 23 Feb 2022 11:22:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 0/2] Introduce 'advanced' Energy Model in DT
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, nm@ti.com, sboyd@kernel.org, mka@chromium.org,
        dianders@chromium.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
References: <20220222140746.12293-1-lukasz.luba@arm.com>
 <467a7de4-df84-8e9e-a26a-80449ca55950@linaro.org>
 <20220223104341.jh5hjcv6ugaexgoa@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220223104341.jh5hjcv6ugaexgoa@vireshk-i7>
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



On 2/23/22 10:43, Viresh Kumar wrote:
> On 23-02-22, 10:52, Daniel Lezcano wrote:
>> why not extend the energy model to any kind of devices?
> 
> FWIW, the OPP core supports a wide range of devices now, not just CPUs.
> 

Is that the "opp-level" thing which would allow that?
I can see some DT files with regulators(?) using it e.g. [1].
It looks flexible, the opp-hz is not hard requirement,
the opp-level can be used instead IIUC.

It might be a next step which might meet Daniel's needs.
If that 'level' can be any number and frequency is not available
then EM must have 'level' filed in the struct em_perf_state
for this kind of new devices. I'm open for such change.
We can discuss this as a next step. We would need to find some examples
how this new thing would be used.

[1] 
https://elixir.bootlin.com/linux/v5.17-rc5/source/arch/arm/boot/dts/tegra20-peripherals-opp.dtsi#L4

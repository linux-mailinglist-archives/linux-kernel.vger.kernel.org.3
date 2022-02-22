Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2494C0157
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbiBVSc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234810AbiBVSc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:32:26 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE9D53465D;
        Tue, 22 Feb 2022 10:31:59 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C847106F;
        Tue, 22 Feb 2022 10:31:59 -0800 (PST)
Received: from [10.57.9.152] (unknown [10.57.9.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BFED3F66F;
        Tue, 22 Feb 2022 10:31:56 -0800 (PST)
Message-ID: <27df4e4f-b6d7-9a58-f2dd-d6afa748e217@arm.com>
Date:   Tue, 22 Feb 2022 18:31:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] thermal: cooling: Check Energy Model type in
 cpufreq_cooling and devfreq_cooling
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     amit.kachhap@gmail.com, viresh.kumar@linaro.org, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, dietmar.eggemann@arm.com,
        Pierre.Gondois@arm.com, Matthias Kaehlcke <mka@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220207073036.14901-1-lukasz.luba@arm.com>
 <20220207073036.14901-2-lukasz.luba@arm.com>
 <4e090ffe-c19b-8e2c-0396-72dc33361f35@arm.com>
 <211a3606-2f4c-227b-33aa-177ef68a49a3@arm.com>
 <3d1719ca-d4a4-f904-e284-b857414669ba@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <3d1719ca-d4a4-f904-e284-b857414669ba@linaro.org>
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



On 2/22/22 18:12, Daniel Lezcano wrote:
> 
> Hi Lukasz,
> 
> I don't think it makes sense to remove the support of the energy model 
> if the units are abstracts.
> 
> IIUC, regarding your previous answer, we don't really know what will do 
> the SoC vendor with these numbers and likely they will provide 
> consistent abstract values which won't prevent a correct behavior.
> 
> What would be the benefit of giving inconsistent abstract values which 
> will be unusable except of giving a broken energy model?

The power values in the EM which has abstract scale, would make sense to 
EAS, but not for IPA or DTPM. Those platforms which want to enable EAS,
but don't need IPA, would register such '<a_good_name_here>' EM.

> 
> Your proposed changes would be acceptable if the energy model has a 
> broken flag IMO

That is doable. I can add that flag, so we can call it 'artificial' EM
(when this new flag is set).

Let me craft the RFC patch with this new flag proposal then.
Do you agree? Can I also add you as 'Suggested-by'?

Thank you for coming back to me with the comments.

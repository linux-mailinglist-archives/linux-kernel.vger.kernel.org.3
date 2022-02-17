Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137D34BA7FE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244159AbiBQSSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:18:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235092AbiBQSSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:18:48 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5784817187A;
        Thu, 17 Feb 2022 10:18:33 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2255D113E;
        Thu, 17 Feb 2022 10:18:33 -0800 (PST)
Received: from [10.57.17.240] (unknown [10.57.17.240])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20E2F3F718;
        Thu, 17 Feb 2022 10:18:30 -0800 (PST)
Subject: Re: [PATCH 1/2] thermal: cooling: Check Energy Model type in
 cpufreq_cooling and devfreq_cooling
To:     daniel.lezcano@linaro.org
Cc:     amit.kachhap@gmail.com, viresh.kumar@linaro.org, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, dietmar.eggemann@arm.com,
        Pierre.Gondois@arm.com, Matthias Kaehlcke <mka@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220207073036.14901-1-lukasz.luba@arm.com>
 <20220207073036.14901-2-lukasz.luba@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <4e090ffe-c19b-8e2c-0396-72dc33361f35@arm.com>
Date:   Thu, 17 Feb 2022 18:18:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220207073036.14901-2-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,


On 2/7/22 7:30 AM, Lukasz Luba wrote:
> The Energy Model supports power values either in Watts or in some abstract
> scale. When the 2nd option is in use, the thermal governor IPA should not
> be allowed to operate, since the relation between cooling devices is not
> properly defined. Thus, it might be possible that big GPU has lower power
> values in abstract scale than a Little CPU. To mitigate a misbehaviour
> of the thermal control algorithm, simply not register a cooling device
> capable of working with IPA.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>   drivers/thermal/cpufreq_cooling.c |  2 +-
>   drivers/thermal/devfreq_cooling.c | 16 +++++++++++++---
>   2 files changed, 14 insertions(+), 4 deletions(-)

The discussion in below this patch went slightly off-topic but it was
valuable. It clarified also there are no broken platforms with this
change.

Could you take the patch into the thermal tree, please?

Regards,
Lukasz

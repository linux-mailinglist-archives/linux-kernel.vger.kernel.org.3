Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7862557478
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 09:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiFWHuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 03:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiFWHuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:50:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0D15BDD;
        Thu, 23 Jun 2022 00:50:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FAD612FC;
        Thu, 23 Jun 2022 00:50:15 -0700 (PDT)
Received: from [192.168.33.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0FFB3F792;
        Thu, 23 Jun 2022 00:50:12 -0700 (PDT)
Message-ID: <e9dc0752-269f-bdfc-1036-17f5bfd95680@arm.com>
Date:   Thu, 23 Jun 2022 08:50:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/4] firmware: arm_scmi: Get detailed power scale from
 perf
Content-Language: en-US
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        viresh.kumar@linaro.org, rafael@kernel.org,
        dietmar.eggemann@arm.com, nm@ti.com, sboyd@kernel.org,
        cristian.marussi@arm.com, matthias.bgg@gmail.com,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20220622145802.13032-1-lukasz.luba@arm.com>
 <20220622145802.13032-4-lukasz.luba@arm.com>
 <20220622155322.g2idz2623nxi6mu3@bogus>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220622155322.g2idz2623nxi6mu3@bogus>
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



On 6/22/22 16:53, Sudeep Holla wrote:
> On Wed, Jun 22, 2022 at 03:58:01PM +0100, Lukasz Luba wrote:
>> In SCMI v3.1 the power scale can be in micro-Watts. The upper layers, e.g.
>> cpufreq and EM should handle received power values properly (upscale when
>> needed). Thus, provide an interface which allows to check what is the
>> scale for power values. The old interface allowed to distinguish between
>> bogo-Watts and milli-Watts only (which was good for older SCMI spec).
>>
> 
> Assuming you will take this as a series,
> 
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> 

Thanks Sudeep for the ACKs!

Regards,
Lukasz

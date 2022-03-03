Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38534CBAED
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 11:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbiCCKDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 05:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiCCKDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 05:03:31 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 795511B785;
        Thu,  3 Mar 2022 02:02:45 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E5AD1424;
        Thu,  3 Mar 2022 02:02:44 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 380833F73D;
        Thu,  3 Mar 2022 02:02:43 -0800 (PST)
Date:   Thu, 3 Mar 2022 10:02:40 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Edwin Chiu =?utf-8?B?6YKx5Z6C5bOw?= <edwin.chiu@sunplus.com>,
        Edwin Chiu <edwinchiu0505tw@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v5] cpuidle: sunplus: Create cpuidle driver for sunplus
 sp7021
Message-ID: <YiCSQCG4NkepeZKs@bogus>
References: <cover.1645427180.git.edwinchiu0505tw@gmail.com>
 <1628e048220f066204b8ac27f3cedf7f3cc02963.1645427180.git.edwinchiu0505tw@gmail.com>
 <394261d1-f1df-e80d-3591-10f2d649e731@kernel.org>
 <bcc7a0b58aad4f0989d7d86eaee2c746@sphcmbx02.sunplus.com.tw>
 <748eb0e1-684c-a772-bccd-64b80780192f@kernel.org>
 <fda1e55e576b4cdf9ab412529a3dfc7b@sphcmbx02.sunplus.com.tw>
 <fd39f73e-8317-38c4-6002-8defd784caec@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd39f73e-8317-38c4-6002-8defd784caec@kernel.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 10:34:31AM +0100, Krzysztof Kozlowski wrote:
> On 03/03/2022 10:01, Edwin Chiu 邱垂峰 wrote:
> >
> >
> >> -----Original Message-----
> >> From: Krzysztof Kozlowski <krzk@kernel.org>
> >> Sent: Tuesday, March 1, 2022 7:34 PM
> >> To: Edwin Chiu 邱垂峰 <edwin.chiu@sunplus.com>; Edwin Chiu <edwinchiu0505tw@gmail.com>;
> >> robh+dt@kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; rafael@kernel.org;
> >> daniel.lezcano@linaro.org; linux-pm@vger.kernel.org
> >> Subject: Re: [PATCH v5] cpuidle: sunplus: Create cpuidle driver for sunplus sp7021
> >>
> >> On 01/03/2022 10:30, Edwin Chiu 邱垂峰 wrote:
> >>>
> >>>
> >>>> -----Original Message-----
> >>>> From: Krzysztof Kozlowski <krzk@kernel.org>
> >>>> Sent: Tuesday, February 22, 2022 12:48 AM
> >>>> To: Edwin Chiu <edwinchiu0505tw@gmail.com>; Edwin Chiu 邱垂峰
> >>>> <edwin.chiu@sunplus.com>;
> >>>> robh+dt@kernel.org; devicetree@vger.kernel.org;
> >>>> robh+linux-kernel@vger.kernel.org; rafael@kernel.org;
> >>>> daniel.lezcano@linaro.org; linux-pm@vger.kernel.org
> >>>> Subject: Re: [PATCH v5] cpuidle: sunplus: Create cpuidle driver for
> >>>> sunplus sp7021
> >>>>
> >>>> On 21/02/2022 08:26, Edwin Chiu wrote:
> >>>>> Create cpuidle driver for sunplus sp7021 chip
> >>>>>
> >>>>> Signed-off-by: Edwin Chiu <edwinchiu0505tw@gmail.com>
> >>>>> ---
> >>>>> Changes in v3
> >>>>>  - Rearrangement #include sequence
> >>>>>  - Change remark style to /*~*/
> >>>>>  - Align author email address to same as sob
> >>>>>  - Optimal code
> >>>>> Changes in v4
> >>>>>  - According Rob Herringrobh's comment
> >>>>>    There is no need for this binding.
> >>>>>    Just wanting a different driver is not a reason
> >>>>>    for a duplicate schema.
> >>>>>    So remove yaml file and submit driver again.
> >>>>> Changes in v5
> >>>>>  - According Krzysztof's comment
> >>>>>    You either use appropriate compatible in DT
> >>>>>    or add your compatible to cpuidle-arm.
> >>>>>    Even if this did not work, then the solution is to
> >>>>>    use common parts, not to duplicate entire driver.
> >>>>>    According Sudeep's comment
> >>>>>    In short NACK for any dedicated driver for this platform,
> >>>>>    use the generic cpuidle-arm driver with appropriate platform hooks
> >>>>>    Create cpuidle-sunplus.c in arch/arm/mach-sunplus/
> >>>>>    for hook generic cpuidle-arm driver
> >>>>>
> >>>>>  MAINTAINERS                                   |  6 ++
> >>>>>  arch/arm/mach-sunplus/cpuidle-sunplus.c       | 88 +++++++++++++++++
> >>>>>  include/linux/platform_data/cpuidle-sunplus.h | 12 ++++
> >>>>>  3 files changed, 106 insertions(+)
> >>>>>  create mode 100644 arch/arm/mach-sunplus/cpuidle-sunplus.c
> >>>>>  create mode 100644 include/linux/platform_data/cpuidle-sunplus.h
> >>>>>
> >>>>> diff --git a/MAINTAINERS b/MAINTAINERS index e0dca8f..5c96428 100644
> >>>>> --- a/MAINTAINERS
> >>>>> +++ b/MAINTAINERS
> >>>>> @@ -18252,6 +18252,12 @@ L:	netdev@vger.kernel.org
> >>>>>  S:	Maintained
> >>>>>  F:	drivers/net/ethernet/dlink/sundance.c
> >>>>>
> >>>>> +SUNPLUS CPUIDLE DRIVER
> >>>>> +M:	Edwin Chiu <edwinchiu0505tw@gmail.com>
> >>>>> +S:	Maintained
> >>>>> +F:	arch/arm/mach-sunplus/cpuidle-sunplus.c
> >>>>> +F:	include/linux/platform_data/cpuidle-sunplus.h
> >>>>> +
> >>>>>  SUPERH
> >>>>>  M:	Yoshinori Sato <ysato@users.sourceforge.jp>
> >>>>>  M:	Rich Felker <dalias@libc.org>
> >>>>> diff --git a/arch/arm/mach-sunplus/cpuidle-sunplus.c
> >>>>> b/arch/arm/mach-sunplus/cpuidle-sunplus.c
> >>>>> new file mode 100644
> >>>>> index 0000000..e9d9738
> >>>>> --- /dev/null
> >>>>> +++ b/arch/arm/mach-sunplus/cpuidle-sunplus.c
> >>>>> @@ -0,0 +1,88 @@
> >>>>> +// SPDX-License-Identifier: GPL-2.0-only
> >>>>> +/*
> >>>>> + * SP7021 cpu idle Driver.
> >>>>> + * Copyright (C) Sunplus Tech / Tibbo Tech.
> >>>>> + */
> >>>>> +#define pr_fmt(fmt) "CPUidle arm: " fmt
> >>>>> +
> >>>>> +#include <linux/cpuidle.h>
> >>>>> +#include <linux/of_device.h>
> >>>>> +#include <linux/platform_data/cpuidle-sunplus.h>
> >>>>> +
> >>>>> +#include <asm/cpuidle.h>
> >>>>> +
> >>>>> +typedef int (*idle_fn)(void);
> >>>>> +
> >>>>> +static DEFINE_PER_CPU(idle_fn*, sp7021_idle_ops);
> >>>>> +
> >>>>> +static int sp7021_cpuidle_enter(unsigned long index) {
> >>>>> +	return __this_cpu_read(sp7021_idle_ops)[index]();
> >>>>> +}
> >>>>> +static int sp7021_cpu_spc(void)
> >>>>> +{
> >>>>> +	cpu_v7_do_idle();   /* idle to WFI */
> >>>>> +	return 0;
> >>>>> +}
> >>>>> +static const struct of_device_id sp7021_idle_state_match[] = {
> >>>>> +	{ .compatible = "arm,idle-state", .data = sp7021_cpu_spc },
> >>>>> +	{ },
> >>>>> +};
> >>>>
> >>>> This is confusing. You want to have two drivers to bind to the same
> >>>> compatible? As I wrote in the previous messages, you should simply use arm,idle-state just like few
> >> other architectures.
> >>>>
> >>>>
> >>>> Best regards,
> >>>> Krzysztof
> >>>
> >>>
> >>> The patch v5 implemented according your comment.
> >>> Used common part of arm,idle-state.
> >>> Create new enable-method for cpuidle.ops function.
> >>> It only have arm cpuidle driver exist now, no two drivers to bind to the same compatible.
> >>>
> >>> What do you mean " simply use arm,idle-state just like few other architectures "?
> >>>
> >>
> >> I mean, do it similarly (by using arm,idle-state and other related
> >> properties) to for example ti,am4372/ti,am3352.
> >>
> >> Best regards,
> >> Krzysztof
> >
> >
> > The am3352 cpuidle code structure is very similar to ours.
> > Used enable-method = "ti,am3352" and compatible = "arm,idle-state" in am33xx.dtsi
> > Used CPUIDLE_METHOD_OF_DECLARE(pm33xx_idle, "ti,am3352", &amx3_cpuidle_ops) in pm33xx-core.c
> >
> > The difference are
> > am3352
> > amx3_idle_init(~) assign idle_states[i].wfi_flags = states[i].wfi_flags;
> > amx3_idle_enter(~) call idle_fn(idle_state->wfi_flags)
> >
> > sunplus-sp7021
> > sp7021_cpuidle_init(~) assign fns[i] = idle_fns[i];
> > sp7021_cpuidle_enter(~) call __this_cpu_read(sp7021_idle_ops)[index]();
> >
> > I don't think am3352 cpuidle code architecture simpler than ours.
> > The idle_fn function need more complex method to be assign.
> > How do you think?
>
> You duplicated a driver, entire pieces of code. This is not acceptable.
> Therefore it does not really make sense to discuss whether duplicated
> solution seems simpler or not... We won't accept duplicated code.
> Especially for WFI-only driver.
>

+1 for above comment.

In addition, the reference platform am33xx* doesn't seem to support hotplug
(may be I am missing to see but quick grep gave no results) and their idle
is definitely not just WFI. So what I asked is that please document the
chosen "sunplus,sc-smp" as bot cpu idle and hotplug methods and when you
support non WFI states, we can revisit this. Also you must stick to this
hotplug method whenever you decided to support it.


--
Regards,
Sudeep

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934A94A9ADC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 15:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359256AbiBDOWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 09:22:40 -0500
Received: from foss.arm.com ([217.140.110.172]:47676 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234877AbiBDOWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 09:22:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E65211D4;
        Fri,  4 Feb 2022 06:22:39 -0800 (PST)
Received: from bogus (unknown [10.57.41.150])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 943D03F40C;
        Fri,  4 Feb 2022 06:22:37 -0800 (PST)
Date:   Fri, 4 Feb 2022 14:21:50 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Wojciech Bartczak <wbartczak@marvell.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        Szymon Balcerak <sbalcerak@marvell.com>
Subject: Re: Mixing SCMI and ACPI?
Message-ID: <20220204142150.glsu6ujjtqpcktjp@bogus>
References: <SJ0PR18MB39807064D4DAA0A6E6F62F3DB9299@SJ0PR18MB3980.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SJ0PR18MB39807064D4DAA0A6E6F62F3DB9299@SJ0PR18MB3980.namprd18.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wojciech,

Please cc me too for anything SCMI related in the future.

On Fri, Feb 04, 2022 at 01:32:47PM +0000, Wojciech Bartczak wrote:
> Hi Folks,
> 
> I have been working with SCMI for some time now.

Good to know 😄

> Here at Marvell, we use very common software stack.

Excellent!

> Mostly ATF, U-Boot and Kernel. With this software stack, SCMI integration is
> just a matter of following the common sense.

Glad to hear that.

> Recently, the new requirement for supporting ACPI and UEFI has arrived.
> The main goal is to have ACPI and platform that works almost the same.
>

Sure.

> This is where the problem begins. SCMI is quite well-defined for DT-based
> environments.

Indeed and that is intentional. However, lots of concepts in SCMI already aligns
well with ACPI concepts just under different name most of the time.

> Unfortunately, there are not too many mentions for the UEFI/ACPI based
> platforms. This is probably caused by the fact that SCMI overlaps with ACPI
> in some points like sensors or performance management.

Correct.

> However, SCMI has one single advantage over the ACPI, namely it defines pretty
> nice framework for clocks management. ACPI is silent in this regard.

Yes but any reasons why that can't be part of standard power methods.

> It is just delegating clocks to OSPM. The kernel and OS should be unaware of
> the clocks management according to the ACPI spec. This surely does work for x86,
> but not so well for ARM.
>

While that could be true, why do you need to manage the clocks so much outside
the standard power methods in ACPI.

> Wonder, if you had chance discuss using SCMI in ACPI based environments?

We have discussed in the past, SCMI can be used in ACPI abstracted under the
existing well defined methods(I know you will be shouting not clocks but
we need to know why that can't be done with standards device power/state
methods.

> I am mostly interested in the description using ACPI tables and eventually
> the bindings for ACPI tables. I need something portable and
> in line with future development for SCMI.
>

I don't understand what you mean by that.

> Now the review of existing threads and forums returns almost nothing.
> The SCMI specification wasn't too helpful either.
> I did the code review too. But only thing I see are bindings for DT (v5.17-rc2).
> It will help greatly if you have any advice or pointer that I could try.
> Has anyone done this before?

Not sure if anyone has told so in the public ML. However if you want to
run same platform both in ACPI and DT with same firmware, you can write
ASL to manage clocks via SCMI command so that same firmware can be used.

I may be giving to generic info and may not be addressing your specific
issue, but I need specific info to address that. What have you tried with
ACPI so far, what are the issues you are seeing, ...etc ?

--
Regards,
Sudeep

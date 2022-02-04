Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82204A9ED0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 19:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377483AbiBDSRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 13:17:11 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:9884 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S243150AbiBDSRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 13:17:09 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 214EUPnS025427;
        Fri, 4 Feb 2022 10:16:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pfpt0220;
 bh=eCgLnIFjhDvyC5OEFtoDD3YaMzCHkIhKN4t86pGmmHY=;
 b=OVhiXPPwU9+8N3tKlOgdNBlPdFh8AwL9eXAsrGkyFk4t+pKz3G3+Y70oQJCvkKgPAG9g
 +Q7zm+EmGJKauYPxvnMqfJHhk6d3dwXbQ0GEcmD7ALqUJLoQkGqA5nB7Sdra32lsyyBt
 KIiDnn1Z7dJroNS+k9IJd9xEI5aNSOnsLde590JSIq2Him7p1onwes1UGJG0q3a3F182
 SB+Zm44sHIpvVMjOypSUH1QzrH52LobWKJ2FtpT3ZpWVE2hcHl6Wrw13X0Kj5WA54uaY
 5Sp3EDEqqgMpFkpGNQU8SJDUNXy+1Z/eOTNtjl4sqSQMSRaPxhcyEweBT72nuhFmJoEQ Mg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3e0tp1atu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 10:16:59 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 4 Feb
 2022 10:16:57 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Fri, 4 Feb 2022 10:16:57 -0800
Received: from localhost.localdomain (unknown [10.110.150.170])
        by maili.marvell.com (Postfix) with ESMTP id 73F4A3F706C;
        Fri,  4 Feb 2022 10:16:57 -0800 (PST)
From:   Wojciech Bartczak <wbartczak@marvell.com>
To:     <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <sbalcerak@marvell.com>,
        <wbartczak@marvell.com>
Subject: Re: Mixing SCMI and ACPI?
Date:   Fri, 4 Feb 2022 10:16:41 -0800
Message-ID: <20220204181641.28176-1-wbartczak@marvell.com>
X-Mailer: git-send-email 2.17.1
References: <20220204142150.glsu6ujjtqpcktjp@bogus>
MIME-Version: 1.0
In-Reply-To: <20220204142150.glsu6ujjtqpcktjp@bogus>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: lRDlt_gd-zaEnjwhdQ9E0naZ_MB1tm8M
X-Proofpoint-GUID: lRDlt_gd-zaEnjwhdQ9E0naZ_MB1tm8M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_07,2022-02-03_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 02:21:50PM +0000, Sudeep Holla wrote:
Hi Sudeep,

Firstly, thank you for blazing fast answer.

> Hi Wojciech,
> 
> Please cc me too for anything SCMI related in the future.
> 
> On Fri, Feb 04, 2022 at 01:32:47PM +0000, Wojciech Bartczak wrote:
> > Hi Folks,
> > 
> > I have been working with SCMI for some time now.
> 
> Good to know 😄
> 
> > Here at Marvell, we use very common software stack.
> 
> Excellent!
> 
> > Mostly ATF, U-Boot and Kernel. With this software stack, SCMI integration is
> > just a matter of following the common sense.
> 
> Glad to hear that.
> 
> > Recently, the new requirement for supporting ACPI and UEFI has arrived.
> > The main goal is to have ACPI and platform that works almost the same.
> >
> 
> Sure.
> 
> > This is where the problem begins. SCMI is quite well-defined for DT-based
> > environments.
> 
> Indeed and that is intentional. However, lots of concepts in SCMI already aligns
> well with ACPI concepts just under different name most of the time.
> 
> > Unfortunately, there are not too many mentions for the UEFI/ACPI based
> > platforms. This is probably caused by the fact that SCMI overlaps with ACPI
> > in some points like sensors or performance management.
> 
> Correct.
> 
> > However, SCMI has one single advantage over the ACPI, namely it defines pretty
> > nice framework for clocks management. ACPI is silent in this regard.
> 
> Yes but any reasons why that can't be part of standard power methods.
> 

I should've explained it slightly better. Of course SCMI does great work
when managing the clocks. However, what the intent here is the SCMI
clocks register itself nicely into common clk framework.
I don't intend to change the clock. SCP in my case is invariant source.
Hence, no need for ASL methods. I just want to read given clock and have it
registered in clk framework.
Reason for that is simple, there's a good code in SCMI. I don't
want to create own driver for that. I just have to be able to start SCMI
when only source of hardware information is ACPI/UEFI.

> > It is just delegating clocks to OSPM. The kernel and OS should be unaware of
> > the clocks management according to the ACPI spec. This surely does work for x86,
> > but not so well for ARM.
> >
> 
> While that could be true, why do you need to manage the clocks so much outside
> the standard power methods in ACPI.
> 
> > Wonder, if you had chance discuss using SCMI in ACPI based environments?
> 
> We have discussed in the past, SCMI can be used in ACPI abstracted under the
> existing well defined methods(I know you will be shouting not clocks but
> we need to know why that can't be done with standards device power/state
> methods.
> 
> > I am mostly interested in the description using ACPI tables and eventually
> > the bindings for ACPI tables. I need something portable and
> > in line with future development for SCMI.
> >
> 
> I don't understand what you mean by that.
> 
> > Now the review of existing threads and forums returns almost nothing.
> > The SCMI specification wasn't too helpful either.
> > I did the code review too. But only thing I see are bindings for DT (v5.17-rc2).
> > It will help greatly if you have any advice or pointer that I could try.
> > Has anyone done this before?
> 
> Not sure if anyone has told so in the public ML. However if you want to
> run same platform both in ACPI and DT with same firmware, you can write
> ASL to manage clocks via SCMI command so that same firmware can be used.
> 
> I may be giving to generic info and may not be addressing your specific
> issue, but I need specific info to address that. What have you tried with
> ACPI so far, what are the issues you are seeing, ...etc ?

This is still most specific thing I could have found on the internet.
So, to clear up the clouds about my idea.

I have platform with UEFI/ACPI only. I want my clocks to be registered.
So, I use SCMI. The framework needs bindings for proper registration.
Instead using DT approach:

firmware {
	scmi {
		compatible = "arm-scmi";
		/* ... */

		clks: protocol@14 {
			reg = <0x14>;
			#clock-cells = <1>;
		}
	}
}

I add ACPI match table to SCMI code and present it with matching ACPI
tables. It might look like this:

Scope (_SB) {
	Device (ARMSCMI) {
		Name (_HID, "ASCM0001")
		Name (_UID, 0)

		Method (_STA) {
			Return (0xF)
		}

		Device (CLKS) {
			Name (_ADR, 0x14)
			Name (_UID, 0)

			Method (_STA) {
				Return (0xF)
			}
		}
	}
}

Then SCMI registers the clocks protocol and does remaining magic.


Kind regards,
Wojciech.

> --
> Regards,
> Sudeep

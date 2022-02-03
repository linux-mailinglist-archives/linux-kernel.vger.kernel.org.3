Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FFA4A82FF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 12:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350143AbiBCLPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 06:15:24 -0500
Received: from foss.arm.com ([217.140.110.172]:39688 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232228AbiBCLPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 06:15:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 140F011D4;
        Thu,  3 Feb 2022 03:15:23 -0800 (PST)
Received: from bogus (unknown [10.57.41.150])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7DCE63F774;
        Thu,  3 Feb 2022 03:15:21 -0800 (PST)
Date:   Thu, 3 Feb 2022 11:14:35 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] Broadcom STB PM PSCI extensions
Message-ID: <20220203111435.e3eblv47ljkwkvwf@bogus>
References: <20220122035421.4086618-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220122035421.4086618-1-f.fainelli@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 07:54:17PM -0800, Florian Fainelli wrote:
> Hi all,
> 
> This patch series contains the Broadcom STB PSCI extensions which adds
> some additional functions on top of the existing standard PSCI interface
> which is the reason for having the driver implement a custom
> suspend_ops.
> 
> These platforms have traditionally supported a mode that is akin to
> ACPI's S2 with the CPU in WFI and all of the chip being clock gated
> which is entered with "echo standby > /sys/power/state". Additional a
> true suspend to DRAM as defined in ACPI by S3 is implemented with "echo
> mem > /sys/power/state".

How different is the above "standby" state compare to the standard "idle"
(a.k.a suspend-to-idle which is different from system-to-ram/S3) ?
Suspend to idle takes all the CPUs to lowest possible power state instead
of cpu-hotplug in S2R. Also I assume some userspace has to identify when
to enter "standby" vs "mem" right ? I am trying to see how addition of
"idle" changes that(if it does). Sorry for too many questions.

-- 
Regards,
Sudeep

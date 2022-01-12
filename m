Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F2348C310
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 12:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352848AbiALL0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 06:26:12 -0500
Received: from foss.arm.com ([217.140.110.172]:58668 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238954AbiALL0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 06:26:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D20BE1FB;
        Wed, 12 Jan 2022 03:26:08 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.1.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A4653F774;
        Wed, 12 Jan 2022 03:26:07 -0800 (PST)
Date:   Wed, 12 Jan 2022 11:26:03 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: errata: Update
 ARM64_ERRATUM_[2119858|2224489] with Cortex-X2 ranges
Message-ID: <Yd66y1OvDmkFT5wJ@FVFF77S0Q05N>
References: <1641980099-20315-1-git-send-email-anshuman.khandual@arm.com>
 <1641980099-20315-3-git-send-email-anshuman.khandual@arm.com>
 <Yd6uTCwjzDdBrtGI@FVFF77S0Q05N>
 <73b5cc05-4318-8eb8-bc3a-84af1ad6145c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73b5cc05-4318-8eb8-bc3a-84af1ad6145c@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 04:36:07PM +0530, Anshuman Khandual wrote:
> 
> 
> On 1/12/22 4:02 PM, Mark Rutland wrote:
> > Hi Anshuman,
> > 
> > On Wed, Jan 12, 2022 at 03:04:59PM +0530, Anshuman Khandual wrote:
> >> Errata ARM64_ERRATUM_[2119858|2224489] also affect some Cortex-X2 ranges as
> >> well. Lets update these errata definition and detection to accommodate all
> >> new Cortex-X2 based cpu MIDR ranges.
> >>
> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> Cc: Will Deacon <will@kernel.org>
> >> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> >> Cc: Suzuki Poulose <suzuki.poulose@arm.com>
> >> Cc: coresight@lists.linaro.org
> >> Cc: linux-arm-kernel@lists.infradead.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> >> ---
> >>  arch/arm64/Kconfig             | 12 ++++++------
> >>  arch/arm64/kernel/cpu_errata.c |  2 ++
> >>  2 files changed, 8 insertions(+), 6 deletions(-)
> > 
> > I think you've misssed Documentation/arm64/silicon-errata.rst -- for other
> > common errata we add lines for each affected part, e.g. as we do for
> > ARM64_ERRATUM_1418040.
> 
> Sure, will do. I guess Cortex-X2 lines will come just after Cortex-A710
> but before Neoverse-N1.
> 
> +----------------+-----------------+-----------------+-----------------------------+
> | ARM            | Cortex-A710     | #2224489        | ARM64_ERRATUM_2224489       |
> +----------------+-----------------+-----------------+-----------------------------+
> >
> >
> +----------------+-----------------+-----------------+-----------------------------+
> | ARM            | Neoverse-N1     | #1188873,1418040| ARM64_ERRATUM_1418040       |
> +----------------+-----------------+-----------------+-----------------------------+

That sounds right to me, yes.

Thanks,
Mark.

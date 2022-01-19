Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D57493750
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352934AbiASJaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:30:01 -0500
Received: from foss.arm.com ([217.140.110.172]:51446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234544AbiASJaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:30:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 434F311D4;
        Wed, 19 Jan 2022 01:30:00 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.38.123])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 560623F766;
        Wed, 19 Jan 2022 01:29:58 -0800 (PST)
Date:   Wed, 19 Jan 2022 09:29:50 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] arm64: Add Cortex-X2 CPU part definition
Message-ID: <20220119092950.GA42546@C02TD0UTHF1T.local>
References: <1641980099-20315-1-git-send-email-anshuman.khandual@arm.com>
 <1641980099-20315-2-git-send-email-anshuman.khandual@arm.com>
 <CAK8P3a1cDF=jEVGchU8LNBdjdtROmHHHpebOASreR=WOuZ4Z1A@mail.gmail.com>
 <00e28671-8d3a-f789-91c4-109814792a07@arm.com>
 <CAK8P3a2Q+iN1O6FEdUJRt=0bQu=6fkWAD3RCECfdhu4DKHq0pg@mail.gmail.com>
 <519f3b4e-e790-c051-3cb1-3fd229a3e498@arm.com>
 <CAK8P3a1t5N_vW3rcMD_e+UMy5EQDrTrE4QqPDo7nM_s1-Bf0XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1t5N_vW3rcMD_e+UMy5EQDrTrE4QqPDo7nM_s1-Bf0XQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Wed, Jan 19, 2022 at 08:44:54AM +0100, Arnd Bergmann wrote:
> On Wed, Jan 19, 2022 at 7:44 AM Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
> > On 1/13/22 5:17 PM, Arnd Bergmann wrote:
> > >
> > > It also helps me personally to have a known place to look up the names
> > > by value rather than chasing through reference manuals.
> >
> > IIUC the purpose here would be a quick CPU ID documentation reference check ?
> > I will wait for other opinions here and add the remaining in a separate patch
> > probably.
> 
> The purpose would be to do what is obviously the right thing, and to avoid
> more patches getting sent the next time someone needs to add a workaround
> for another core that is already known.

The general policy we've taken is to only add part definitions as and
when they're required (e.g. alongside an errata workaround that needs to
identify the part), since the kernel doesn't otherwise need to know, and
it keeps the errata workaround patches self-contained (and ensures the
MIDR definitions get tested as they're added).

So per usual policy I don't think we should add the other part
definitions here. If and when errata appear that requires us to identify
those parts we can add corresponding MIDR definitions.

> If you can't do this without more discussion, then just use your
> current version and let the next person do it.

As above, for now I think we should leave this as-is, and only add the
Cortex-X2 part definition.

Thanks,
Mark.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A3C49F79C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 11:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347912AbiA1Kvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 05:51:52 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51802 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244101AbiA1Kvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 05:51:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3001B824E4;
        Fri, 28 Jan 2022 10:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D251C340E0;
        Fri, 28 Jan 2022 10:51:45 +0000 (UTC)
Date:   Fri, 28 Jan 2022 10:51:42 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 RESEND 0/7] coresight: trbe: Workaround Cortex-A510
 erratas
Message-ID: <YfPKvsw+fOsJvSm7@arm.com>
References: <1643120437-14352-1-git-send-email-anshuman.khandual@arm.com>
 <20220127202220.GA2191206@p14s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127202220.GA2191206@p14s>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On Thu, Jan 27, 2022 at 01:22:20PM -0700, Mathieu Poirier wrote:
> On Tue, Jan 25, 2022 at 07:50:30PM +0530, Anshuman Khandual wrote:
> > Anshuman Khandual (7):
> >   arm64: Add Cortex-A510 CPU part definition
> >   arm64: errata: Add detection for TRBE ignored system register writes
> >   arm64: errata: Add detection for TRBE invalid prohibited states
> >   arm64: errata: Add detection for TRBE trace data corruption
> >   coresight: trbe: Work around the ignored system register writes
> >   coresight: trbe: Work around the invalid prohibited states
> >   coresight: trbe: Work around the trace data corruption
> > 
> >  Documentation/arm64/silicon-errata.rst       |   6 +
> >  arch/arm64/Kconfig                           |  59 ++++++++++
> >  arch/arm64/include/asm/cputype.h             |   2 +
> >  arch/arm64/kernel/cpu_errata.c               |  27 +++++
> >  arch/arm64/tools/cpucaps                     |   3 +
> >  drivers/hwtracing/coresight/coresight-trbe.c | 114 ++++++++++++++-----
> >  drivers/hwtracing/coresight/coresight-trbe.h |   8 --
> >  7 files changed, 183 insertions(+), 36 deletions(-)
> 
> I have applied this set and sent a pull request to Catalin for the arm64
> portion.

Well, I'm happy for the whole series to go in via Greg's tree or however
the coresight patches go in (that's why I acked them). The last three
patches depend on the first four, so you might as well send them all
together. I'd split the series only if there's a conflict with the arm64
tree (I haven't checked).

-- 
Catalin

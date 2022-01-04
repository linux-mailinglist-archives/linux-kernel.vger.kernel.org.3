Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90E4484202
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 14:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbiADNCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 08:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiADNCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 08:02:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F662C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 05:02:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 397D8B815A5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 13:02:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D3BC36AE9;
        Tue,  4 Jan 2022 13:02:31 +0000 (UTC)
Date:   Tue, 4 Jan 2022 13:02:27 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kees Cook <keescook@chromium.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     Joe Perches <joe@perches.com>, Will Deacon <will@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        James Morse <james.morse@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Fuad Tabba <tabba@google.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: Drop outdated links in comments
Message-ID: <YdRFY5P+gutrtSzr@arm.com>
References: <20211215191835.1420010-1-keescook@chromium.org>
 <YbsZkr4gfhcQGON6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbsZkr4gfhcQGON6@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 10:48:50AM +0000, Catalin Marinas wrote:
> On Wed, Dec 15, 2021 at 11:18:35AM -0800, Kees Cook wrote:
> > As started by commit 05a5f51ca566 ("Documentation: Replace lkml.org links
> > with lore"), an effort was made to replace lkml.org links with lore to
> > better use a single source that's more likely to stay available long-term.
> > However, it seems these links don't offer much value here, so just
> > remove them entirely.
> > 
> > Cc: Joe Perches <joe@perches.com>
> > Suggested-by: Will Deacon <will@kernel.org>
> > Link: https://lore.kernel.org/lkml/20210211100213.GA29813@willie-the-truck/
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  arch/arm/kernel/hibernate.c   | 4 ----
> >  arch/arm64/kernel/hibernate.c | 4 ----
> >  2 files changed, 8 deletions(-)
> > 
> > diff --git a/arch/arm/kernel/hibernate.c b/arch/arm/kernel/hibernate.c
> > index 2373020af965..2c1f290342e4 100644
> > --- a/arch/arm/kernel/hibernate.c
> > +++ b/arch/arm/kernel/hibernate.c
> > @@ -7,10 +7,6 @@
> >   * Ubuntu project, hibernation support for mach-dove
> >   * Copyright (C) 2010 Nokia Corporation (Hiroshi Doyu)
> >   * Copyright (C) 2010 Texas Instruments, Inc. (Teerth Reddy et al.)
> > - *  https://lkml.org/lkml/2010/6/18/4
> > - *  https://lists.linux-foundation.org/pipermail/linux-pm/2010-June/027422.html
> > - *  https://patchwork.kernel.org/patch/96442/
> > - *
> >   * Copyright (C) 2006 Rafael J. Wysocki <rjw@sisk.pl>
> >   */
> 
> Happy to take the patch through the arm64 tree if Russell acks,
> otherwise I'll just take the arm64 hunk.

Russell, any objections to this patch going through the arm64 tree?

-- 
Catalin

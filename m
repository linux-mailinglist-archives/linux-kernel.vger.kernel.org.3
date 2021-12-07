Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B7D46BCB4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 14:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237197AbhLGNh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 08:37:26 -0500
Received: from foss.arm.com ([217.140.110.172]:60450 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237180AbhLGNhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 08:37:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3100511FB;
        Tue,  7 Dec 2021 05:33:55 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.67.24])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF6583F5A1;
        Tue,  7 Dec 2021 05:33:52 -0800 (PST)
Date:   Tue, 7 Dec 2021 13:33:42 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Jiri Slaby <jslaby@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>, ardb@kernel.org,
        broonie@kernel.org, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        maz@kernel.org, mingo@redhat.com, tabba@google.com,
        tglx@linutronix.de, will@kernel.org
Subject: Re: [RFC PATCH 0/6] linkage: better symbol aliasing
Message-ID: <Ya9itnC28/vr46Qb@FVFF77S0Q05N>
References: <20211206124715.4101571-1-mark.rutland@arm.com>
 <20211207052304.pb76ofjymf7o2yyb@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207052304.pb76ofjymf7o2yyb@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 09:23:04PM -0800, Josh Poimboeuf wrote:
> On Mon, Dec 06, 2021 at 12:47:09PM +0000, Mark Rutland wrote:
> > This avoids repetition and hopefully make it easier to ensure
> > consistency (e.g. so each function has a single canonical name and
> > associated metadata).
> > 
> > I'm sending this as an RFC since I want to check:
> > 
> > a) People are happy with the idea in principle.
> > 
> > b) People are happy with the implementation within <linux/linkage.h>.
> > 
> > ... and I haven't yet converted the headers under tools/, which is
> > largely a copy+paste job.
> 
> Looks like a definite improvement to me.
> 
> The only suggestion I'd have would be to fix a minor naming
> inconsistency: change "SYM_FUNC_LOCAL_ALIAS" to "SYM_FUNC_ALIAS_LOCAL"
> to match the other "<noun>_<verb>" macros.

Sure; I was following the example set by `SYM_FUNC_START_LOCAL_ALIAS`, but I
agree that placing LOCAL on the end looks more consistent overall once that's
removed.

For V2 I'll make that `SYM_FUNC_ALIAS_LOCAL`.

Thanks,
Mark.

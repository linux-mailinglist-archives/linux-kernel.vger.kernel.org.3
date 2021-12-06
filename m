Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6701C46A37C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 18:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345195AbhLFR4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 12:56:55 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48660 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345004AbhLFR4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 12:56:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9602DB811C9;
        Mon,  6 Dec 2021 17:53:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56067C341C1;
        Mon,  6 Dec 2021 17:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638813203;
        bh=qLRTR0XEjjj57UUTMH9jGVFo9hH/vzMUqsdqSdEEGgA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AGHdCLlSEgloeJKS3PSKuDmWUNnN0VGIk264Q6MmMstZg3OQCqZCh/NBUBjSsRDRz
         eUTuc8nRR5g2ut8osXfAldNajXxB8say2gAAxuHvjo+c+DiWmxaaPc38W0h9SBY+Mt
         hVlU2ibQkOFAjtllgAI8rac6DDgGVSvx5YceLi31A1KsFNwqOGFLhlCeN7bpbsIFcn
         /Jm2rUh8WvL7hWYkvdrpFvm8RxHk75suUOiXagsrqIqQuXimvw+1kngkUb+hzw3DKR
         IvtEk0mucGNpeXEm4XmWFQ/VDzBlPHji4bsUtYqxv4pg75uNeUK2TjwT/OUzBHz/tO
         w8KZxrp2KbyNA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 13EC35C1461; Mon,  6 Dec 2021 09:53:23 -0800 (PST)
Date:   Mon, 6 Dec 2021 09:53:23 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        rcu@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        mtosatti <mtosatti@redhat.com>, frederic <frederic@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2] Documentation: Fill the gaps about entry/noinstr
 constraints
Message-ID: <20211206175323.GB641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <875ys9dacq.ffs@tglx>
 <20211130091356.7336e277@gandalf.local.home>
 <878rx5b7i5.ffs@tglx>
 <YadU1aSE6/0yGWny@FVFF77S0Q05N>
 <87v9088a5q.ffs@tglx>
 <Yae9tbtZW5mjcBVt@FVFF77S0Q05N>
 <87ee6w83yw.ffs@tglx>
 <87bl2083mu.ffs@tglx>
 <1158239c-4e65-d3d9-41b3-4fedac856622@infradead.org>
 <Ya5KM05XaUBjlthn@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya5KM05XaUBjlthn@FVFF77S0Q05N>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 05:36:51PM +0000, Mark Rutland wrote:
> On Fri, Dec 03, 2021 at 07:48:08PM -0800, Randy Dunlap wrote:
> > On 12/1/21 12:35, Thomas Gleixner wrote:
> > > +Aside of that many architectures have to save register state, e.g. debug or
> > 
> >                                                           state (e.g. debug) or
> > 
> > > +cause registers before another exception of the same type can happen. A
> > 
> >    ^^^^^ cannot parse (with or without the change to the previous line)
> 
> I think the difficulty here is with "cause register"? That' a register which
> indicates the cause of an exception, e.g.
> 
> * MIPS has `cause` (coprocessor 0 register 13)
> * arm64 / AArch64 has `ESR_ELx` (Exception Syndrome Register, ELx)
> 
> We could probably clarify this as "exception cause registers" or "exception
> status registers", if that helps?

Or to make it word-by-word unambiguous, "exception-cause registers"
and "exception-status registers".

							Thanx, Paul

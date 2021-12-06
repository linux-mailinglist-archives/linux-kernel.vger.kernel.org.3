Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686EB46A319
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 18:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243449AbhLFRk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 12:40:26 -0500
Received: from foss.arm.com ([217.140.110.172]:36594 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231511AbhLFRkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 12:40:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 409CD1042;
        Mon,  6 Dec 2021 09:36:56 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.65.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56D283F73B;
        Mon,  6 Dec 2021 09:36:54 -0800 (PST)
Date:   Mon, 6 Dec 2021 17:36:51 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        rcu@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        paulmck@kernel.org, mtosatti <mtosatti@redhat.com>,
        frederic <frederic@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2] Documentation: Fill the gaps about entry/noinstr
 constraints
Message-ID: <Ya5KM05XaUBjlthn@FVFF77S0Q05N>
References: <8719ad46cc29a2c5d7baac3c35770e5460ab8d5c.camel@redhat.com>
 <875ys9dacq.ffs@tglx>
 <20211130091356.7336e277@gandalf.local.home>
 <878rx5b7i5.ffs@tglx>
 <YadU1aSE6/0yGWny@FVFF77S0Q05N>
 <87v9088a5q.ffs@tglx>
 <Yae9tbtZW5mjcBVt@FVFF77S0Q05N>
 <87ee6w83yw.ffs@tglx>
 <87bl2083mu.ffs@tglx>
 <1158239c-4e65-d3d9-41b3-4fedac856622@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158239c-4e65-d3d9-41b3-4fedac856622@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 07:48:08PM -0800, Randy Dunlap wrote:
> On 12/1/21 12:35, Thomas Gleixner wrote:
> > +Aside of that many architectures have to save register state, e.g. debug or
> 
>                                                           state (e.g. debug) or
> 
> > +cause registers before another exception of the same type can happen. A
> 
>    ^^^^^ cannot parse (with or without the change to the previous line)

I think the difficulty here is with "cause register"? That' a register which
indicates the cause of an exception, e.g.

* MIPS has `cause` (coprocessor 0 register 13)
* arm64 / AArch64 has `ESR_ELx` (Exception Syndrome Register, ELx)

We could probably clarify this as "exception cause registers" or "exception
status registers", if that helps?

Thanks,
Mark.

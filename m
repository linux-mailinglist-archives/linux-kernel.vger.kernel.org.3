Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7FDA49E544
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242713AbiA0O4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:56:31 -0500
Received: from foss.arm.com ([217.140.110.172]:37568 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238299AbiA0O4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:56:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B29CC113E;
        Thu, 27 Jan 2022 06:56:29 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.14.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D73833F766;
        Thu, 27 Jan 2022 06:56:27 -0800 (PST)
Date:   Thu, 27 Jan 2022 14:56:10 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Yinan Liu <yinan@linux.alibaba.com>,
        linuxppc-dev@lists.ozlabs.org, Sachin Sant <sachinp@linux.ibm.com>,
        linux-kernel@vger.kernel.org, ardb@kernel.org,
        keescook@chromium.org, hca@linux.ibm.com
Subject: Re: [powerpc] ftrace warning kernel/trace/ftrace.c:2068 with
 code-patching selftests
Message-ID: <YfKyivFMMjio09Xy@FVFF77S0Q05N>
References: <0fa0daec-881a-314b-e28b-3828e80bbd90@linux.alibaba.com>
 <YfFclROd+0/61q2d@FVFF77S0Q05N>
 <YfKGKWW5UfZ15kCW@FVFF77S0Q05N>
 <yt9dy231gzae.fsf@linux.ibm.com>
 <YfKPmFJ2MGsem4VB@FVFF77S0Q05N>
 <20220127074601.41a3773d@rorschach.local.home>
 <YfKZXvB9vCN1bA1c@FVFF77S0Q05N>
 <yt9dsft9gvyo.fsf@linux.ibm.com>
 <YfKfDnbNGina2lKz@FVFF77S0Q05N>
 <20220127085543.200dd38e@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127085543.200dd38e@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 08:55:43AM -0500, Steven Rostedt wrote:
> On Thu, 27 Jan 2022 13:33:02 +0000
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > I want to get the regression fixed ASAP, so can we take a simple patch for -rc2
> > which disables the build-time sort where it's currently broken (by limiting the
> > opt-in to arm and x86), then follow-up per-architecture to re-enable it if
> > desired/safe?
> 
> I'm going to retest my patch that makes it an opt in for just x86 and arm
> (32bit). I'll be pushing that hopefully later today. I have some other
> patches to test as well.

Great; thanks!

Let me know if you'd like me to give that a spin on arm or arm64.

Thanks,
Mark.

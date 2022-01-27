Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE93549E3EC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239471AbiA0Nzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:55:48 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50544 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236903AbiA0Nzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:55:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E77A8B8226E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 13:55:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21BBC340E4;
        Thu, 27 Jan 2022 13:55:44 +0000 (UTC)
Date:   Thu, 27 Jan 2022 08:55:43 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Yinan Liu <yinan@linux.alibaba.com>,
        linuxppc-dev@lists.ozlabs.org, Sachin Sant <sachinp@linux.ibm.com>,
        linux-kernel@vger.kernel.org, ardb@kernel.org,
        keescook@chromium.org, hca@linux.ibm.com
Subject: Re: [powerpc] ftrace warning kernel/trace/ftrace.c:2068 with
 code-patching selftests
Message-ID: <20220127085543.200dd38e@gandalf.local.home>
In-Reply-To: <YfKfDnbNGina2lKz@FVFF77S0Q05N>
References: <e9422643-a210-b77f-a037-da63a9d2e925@linux.alibaba.com>
        <20220124114548.30241947@gandalf.local.home>
        <0fa0daec-881a-314b-e28b-3828e80bbd90@linux.alibaba.com>
        <YfFclROd+0/61q2d@FVFF77S0Q05N>
        <YfKGKWW5UfZ15kCW@FVFF77S0Q05N>
        <yt9dy231gzae.fsf@linux.ibm.com>
        <YfKPmFJ2MGsem4VB@FVFF77S0Q05N>
        <20220127074601.41a3773d@rorschach.local.home>
        <YfKZXvB9vCN1bA1c@FVFF77S0Q05N>
        <yt9dsft9gvyo.fsf@linux.ibm.com>
        <YfKfDnbNGina2lKz@FVFF77S0Q05N>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2022 13:33:02 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> I want to get the regression fixed ASAP, so can we take a simple patch for -rc2
> which disables the build-time sort where it's currently broken (by limiting the
> opt-in to arm and x86), then follow-up per-architecture to re-enable it if
> desired/safe?

I'm going to retest my patch that makes it an opt in for just x86 and arm
(32bit). I'll be pushing that hopefully later today. I have some other
patches to test as well.

-- Steve

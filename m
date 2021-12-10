Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9B24707AF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244765AbhLJRzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhLJRzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:55:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D37C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 09:52:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D280B82705
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 17:51:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E9BC00446;
        Fri, 10 Dec 2021 17:51:57 +0000 (UTC)
Date:   Fri, 10 Dec 2021 12:51:55 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH] trace: Account bottom half disabled sections.
Message-ID: <20211210125155.27e910f4@gandalf.local.home>
In-Reply-To: <YbN0In1NLVLMLpMj@linutronix.de>
References: <YbN0In1NLVLMLpMj@linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2021 16:37:06 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> Disabling only bottom halves via local_bh_disable() disables also
> preemption but this remains invisible to tracing. On a CONFIG_PREEMPT
> kernel one might wonder why there is no scheduling happening despite the
> N flag in the trace. The reason might be a rcu_read_lock_bh() section.
> 
> Add a 'b' to the tracing output if in task context with disabled bottom
> halves.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>

Looks good to me. Care to resend without the RFC attached, and that will
make sure it gets into my scripts.

Thanks!

-- Steve

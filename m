Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48CE46691F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 18:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348107AbhLBReU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 12:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbhLBReS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 12:34:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A770C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 09:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wWk8IGm0UqXTtkZK7AWFjNgBw91JCQr3xIBg2TefBvM=; b=oF1vL05kiHXV0M4ow57FN6TcJ4
        S1XkJBhYklXrQ3mHgovdcDNItjgVHh2Cj+jyjzlnrp+gOSikl4J4rfnkkRhKbSgh+U1hLiuteQdWN
        iJV0DcsPh+ViWW9HmK9AxHFlw9M5v2EayEOX3Vhc5sGs4zu9l79slyy0lpR6OQnI37nQuP7HX3CBv
        bCwXK1k1uxqQ9GvKCl6Teho3GnW/zV1XIH8M4Kt2rtOK9hX+nDsnpKBUv2UzNDChn/DO5XW8kGML/
        MkqzphF9KC+XQutZjGztjutxkuF67yoQzLWH36FkInLgH80DjtIUZGzn9ZfL7tYyj1D6SV5A7fgXi
        5ArYph0A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mspuv-004vAW-7P; Thu, 02 Dec 2021 17:30:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6904A300293;
        Thu,  2 Dec 2021 18:30:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EFFC7200F876E; Thu,  2 Dec 2021 15:52:37 +0100 (CET)
Date:   Thu, 2 Dec 2021 15:52:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 0/2] workqueue: Fix hotplug/scheduler races
Message-ID: <YajdtQaR3uc/yqcY@hirez.programming.kicks-ass.net>
References: <20211201151945.632214-1-frederic@kernel.org>
 <YaeissBqeatm10+w@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaeissBqeatm10+w@slm.duckdns.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 06:28:34AM -1000, Tejun Heo wrote:
> On Wed, Dec 01, 2021 at 04:19:43PM +0100, Frederic Weisbecker wrote:
> > It's a resend of "[RFC PATCH 0/2] workqueue: Fix hotplug races", with
> > appropriate tags added and scheduler people Cc'ed.
> > 
> > Thanks.
> > 
> > 
> > Frederic Weisbecker (2):
> >   workqueue: Fix unbind_workers() VS wq_worker_running() race
> >   workqueue: Fix unbind_workers() VS wq_worker_sleeping() race
> 
> For both,
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> 
> Peter, Ingo, if there's no objection, I'll route these through the wq tree.

Works for me,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

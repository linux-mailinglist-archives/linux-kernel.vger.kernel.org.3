Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00DD04759A7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 14:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242876AbhLON3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 08:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237408AbhLON33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 08:29:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B1DC061574;
        Wed, 15 Dec 2021 05:29:29 -0800 (PST)
Date:   Wed, 15 Dec 2021 14:29:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639574965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GBgySfTiWHq4d5/4mgjxgny2xuIxe31kHkq2SocLAI0=;
        b=RBSpqn4EUCnAkOCjtXFRe6o2T1mTuTfvwFs1sgJJGtr1leItrP5urS4GTfIt3eTyFKEZAt
        jz0JO4Tfy3XNsFQIZpJceXyOfP/3Hi+0ENZoxPjsRuCHxqoIN6k+ThDyx/L8YRtJ9hK0bA
        ew6/nMwaZG23RyZmrZnA67QnaRHGxTCz42aHQuhlmhvjsc0tCvlYe0yaZ3Atq5kfUDyBP6
        7UqaTh+b9PheADx2co9x0YaoMQ2Byi9muvjhhOLcjMu1DV6y3Zxd7SReBthPOfT0DEcVJ6
        si40tpbJ/wLJehe4yrnGiUPHDw46LWZEwoRCbbQTA3WO4J9tuIuVGlVrHSRK+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639574965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GBgySfTiWHq4d5/4mgjxgny2xuIxe31kHkq2SocLAI0=;
        b=/zyERqOB+X76XCxdndLxeOhF/sZdGe0hJMiGVBv8Ri46uPDVzna09ikHsUZDkWdCgOBZHM
        sqEWSs5CWZGILTAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Fix warnings in blktrace
Message-ID: <YbnttOqgAuD0gygR@linutronix.de>
References: <20211213123737.9147-1-wander@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211213123737.9147-1-wander@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-13 09:37:35 [-0300], Wander Lairson Costa wrote:
> These two patches fix wrong usage of lock primitives with
> CONFIG_PREEMPT_RT in the blktrace code.
> 
> This version fixes a missing piece in the blktrace patch.
> 
> The patches apply to the PREEMPT_RT tree.

I've seen it, need to think about it.

Sebastian

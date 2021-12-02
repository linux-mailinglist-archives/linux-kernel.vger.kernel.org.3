Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18C1465A66
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354035AbhLBAJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:09:08 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:42244 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353970AbhLBAJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:09:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BBB30CE2080;
        Thu,  2 Dec 2021 00:05:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3544C53FCC;
        Thu,  2 Dec 2021 00:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638403541;
        bh=yv6egV7wJcg0dwAsYJ3wz7B0sWH+VRiZCvekSgd5UDo=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=lHSb6VZMtfbib5QMzZ0CeV/Sd6+AVwHVupnPQb8X5x+2SMsQhvVqFvIl2Foe5V9GT
         IUn2EDFkllanznegw24JJriQqkKsEQQKzXOWVxPs7zVnWMeWhovrbl3ZLbCuNmH0NN
         LybFRu3/US73Bk5OULm3BUeKv4326zepiGRPCrzkBq2IrzDCzs0FxX6Zt7kPifjiSn
         vM5rLMV5IjtnyLyhF/4NtGIVDByr/WJw5cvPbEPXndmlgIRQy6zg9YvEhDBVcBDkmy
         7EZrofOTKrtz/aI8XK6q7xAogA9RBfebXVJogXvFjc7Qug5Po3+gI1vZtNq/7RWABL
         /8AnqD7ejY9gw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A37735C1107; Wed,  1 Dec 2021 16:05:40 -0800 (PST)
Date:   Wed, 1 Dec 2021 16:05:40 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH rcu 0/3] Documentation updates for v5.17
Message-ID: <20211202000540.GA3125972@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains documentation updates:

1.	Remove obsolete kernel-per-CPU-kthreads RCU_FAST_NO_HZ advice.

2.	Add refcount analogy to What is RCU, courtesy of NeilBrown.

3.	RCU: Avoid 'Symbol' font-family in SVG figures, courtesy of
	Akira Yokosawa.

						Thanx, Paul

------------------------------------------------------------------------

 RCU/Design/Expedited-Grace-Periods/Funnel0.svg  |    4 -
 RCU/Design/Expedited-Grace-Periods/Funnel1.svg  |    4 -
 RCU/Design/Expedited-Grace-Periods/Funnel2.svg  |    4 -
 RCU/Design/Expedited-Grace-Periods/Funnel3.svg  |    4 -
 RCU/Design/Expedited-Grace-Periods/Funnel4.svg  |    4 -
 RCU/Design/Expedited-Grace-Periods/Funnel5.svg  |    4 -
 RCU/Design/Expedited-Grace-Periods/Funnel6.svg  |    4 -
 RCU/Design/Expedited-Grace-Periods/Funnel7.svg  |    4 -
 RCU/Design/Expedited-Grace-Periods/Funnel8.svg  |    4 -
 RCU/Design/Requirements/GPpartitionReaders1.svg |   36 ++++-----
 RCU/Design/Requirements/ReadersPartitionGP1.svg |   62 ++++++++--------
 RCU/whatisRCU.rst                               |   90 +++++++++++++++++++++---
 admin-guide/kernel-per-CPU-kthreads.rst         |    2 
 13 files changed, 150 insertions(+), 76 deletions(-)

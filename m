Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE33C465025
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350384AbhLAOno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:43:44 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41238 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350322AbhLAOgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:36:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 201D5B81F6E;
        Wed,  1 Dec 2021 14:33:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7AAC53FCC;
        Wed,  1 Dec 2021 14:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638369192;
        bh=RCe2tlGvN+bkGO26pHizOcNSlJIEUA7XSM5qImqAqWg=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=Cl9MNk3gWlGrYSG5P0i7HX0BZJ1Nne4TnH2Zla6jIQ+cjTi7YIfWLJOdgEmoIiryW
         yRZvs+GgwzmIt8agVE1HAa58aT5czMoivmAdXQVYo+xb5zJu+1z9d5MPrWaLgUS9SJ
         /t0JyHI/gp8ZKpmjddPBZpPUFgWfLPODNdI/nuk2rjN+emtQNYhX4xSHwDYgw0mo2S
         vPuE+KT8kH0Mz1dqtmQbzsB/xnS8mvAiw3U9yz0YBWI9j8CWwNG4MfjJhAHc02r9Ga
         6zinuH9irkayr5/bjWa0SxcAKZXDZJSMlyxM61u5lXWUcwrJrHyCdQsn0f8A+d4D1W
         anPrasr4ZbEaA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6EE9D5C0668; Wed,  1 Dec 2021 06:33:12 -0800 (PST)
Date:   Wed, 1 Dec 2021 06:33:12 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     quic_neeraju@quicinc.com, frederic@kernel.org
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: [PATCH] MAINTAINERS:  Add Frederic and Neeraj to their RCU files
Message-ID: <20211201143312.GA3103715@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Frederic as an RCU maintainer for kernel/rcu/tree_nocb.h given his
work with offloading and de-offloading callbacks from CPUs.  Also adding
Neeraj for kernel/rcu/tasks.h given his focused work on RCU Tasks Trace.
As in I am reasonably certain that each understands the full contents
of the corresponding file.

Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a2345ce85213..1f6b3dcb962c2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16084,6 +16084,8 @@ F:	tools/testing/selftests/resctrl/
 
 READ-COPY UPDATE (RCU)
 M:	"Paul E. McKenney" <paulmck@kernel.org>
+M:	Frederic Weisbecker <frederic@kernel.org> (kernel/rcu/tree_nocb.h)
+M:	Neeraj Upadhyay <quic_neeraju@quicinc.com> (kernel/rcu/tasks.h)
 M:	Josh Triplett <josh@joshtriplett.org>
 R:	Steven Rostedt <rostedt@goodmis.org>
 R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

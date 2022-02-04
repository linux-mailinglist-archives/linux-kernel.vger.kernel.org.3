Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65174AA400
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377918AbiBDXIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:08:15 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53354 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377895AbiBDXIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:08:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26BF7B83965;
        Fri,  4 Feb 2022 23:08:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC13BC004E1;
        Fri,  4 Feb 2022 23:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644016086;
        bh=CiCcujZjYhOJvEnjNIIZ+YVdOcFjULHe8Yb/A8k1ttI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H56nWpBosw7NEj7C7wBlD+SpSrCJXvErjGPL4VGUbUO8i6mfjDb+4MXxmr4QaKp9P
         mXZkW06xLnj8joGWYjiIfxl2WiQp3CLeXqkKFKczakIGRSy8bdqRq5Oien5QE7can5
         PCX68Bs1SWxjq07WXda2tljvQPMH5lcZwde3FYtyKeDuGpC/iUZvHU6WCfVHGfSMA5
         sqKCuObsSsAwLalz9e6NOdzWj6gmwGazZ3/F5C0RXhPovi5W7GSdZzQDv3z+cjAPxu
         8sr2Uat7mmxPcuJrCt1O/FoHNo4v/FfJt5nQpc//EAXgconBjx7OkZaXDq8qhzMIEK
         7haNnh7qRWvoQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 950B15C0418; Fri,  4 Feb 2022 15:08:06 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH rcu 1/9] MAINTAINERS:  Add Frederic and Neeraj to their RCU files
Date:   Fri,  4 Feb 2022 15:07:57 -0800
Message-Id: <20220204230805.4193767-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204230751.GA4193671@paulmck-ThinkPad-P17-Gen-1>
References: <20220204230751.GA4193671@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea3e6c9143848..5ad49de532b1a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16298,6 +16298,8 @@ F:	tools/testing/selftests/resctrl/
 
 READ-COPY UPDATE (RCU)
 M:	"Paul E. McKenney" <paulmck@kernel.org>
+M:	Frederic Weisbecker <frederic@kernel.org> (kernel/rcu/tree_nocb.h)
+M:	Neeraj Upadhyay <quic_neeraju@quicinc.com> (kernel/rcu/tasks.h)
 M:	Josh Triplett <josh@joshtriplett.org>
 R:	Steven Rostedt <rostedt@goodmis.org>
 R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
-- 
2.31.1.189.g2e36527f23


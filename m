Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6991148BBC4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 01:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236430AbiALAWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 19:22:01 -0500
Received: from ec2-13-52-33-57.us-west-1.compute.amazonaws.com ([13.52.33.57]:45012
        "EHLO aurora.tech" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236095AbiALAV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 19:21:58 -0500
X-Greylist: delayed 2567 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Jan 2022 19:21:58 EST
Received: by aurora.tech (Postfix, from userid 1001)
        id 9814516402F9; Tue, 11 Jan 2022 15:33:23 -0800 (PST)
From:   Alison Chaiken <achaiken@aurora.tech>
To:     tglx@linutronix.de
Cc:     peterz@infradead.org, paulmck@kernel.org,
        valentin.schneider@arm.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org, glenn@aurora.tech,
        alison@she-devel.com, Alison Chaiken <achaiken@aurora.tech>
Subject: [PATCH 4/4] RCU: update documentation regarding kthread_prio cmdline parameter
Date:   Tue, 11 Jan 2022 15:32:53 -0800
Message-Id: <20220111233253.21692-5-achaiken@aurora.tech>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220111233253.21692-1-achaiken@aurora.tech>
References: <20220111233253.21692-1-achaiken@aurora.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inform readers that the priority of RCU no-callback threads will also
be boosted.

Signed-off-by: Alison Chaiken <achaiken@aurora.tech>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1396fd2d9031..b844978e1bdf 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4439,6 +4439,8 @@
 			(the least-favored priority).  Otherwise, when
 			RCU_BOOST is not set, valid values are 0-99 and
 			the default is zero (non-realtime operation).
+			When RCU_NOCB_CPU is set, also adjust the
+			priority of NOCB callback kthreads.
 
 	rcutree.rcu_nocb_gp_stride= [KNL]
 			Set the number of NOCB callback kthreads in
-- 
2.32.0


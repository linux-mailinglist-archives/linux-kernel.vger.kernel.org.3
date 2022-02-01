Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7514A5FDA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 16:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240134AbiBAPSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 10:18:04 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40654 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbiBAPSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 10:18:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C0C9616A8
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 15:18:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56745C340EB;
        Tue,  1 Feb 2022 15:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643728682;
        bh=FS3nj3RPiryu2Qxy1cXn9BJQGnfR2R0Sx1u4wlU0je0=;
        h=Date:From:To:Cc:Subject:From;
        b=JkkZRc8rEQaQeQo3vcSeU3p0cHllVEQxRTHVLAz64EXiEP6pHWlvbxSGtdgQmDDtf
         FILuVVTDf7fHZhdPxbtlIfla334WClDkcR6q/G6AhnFyResIj+CRtsHO5vtfaW+LQN
         4UTsJtdDWHi3cNDSCU0jmeQp2UnQZ8pv00eTeIM/Pb36d9EeOCJ+d/LinaVMHc6xkj
         GnD1PVeG1oQ8EDMByIlhHiQfH2GWYmpij/CSziGCVX/ql5TRoaMzx1agbDaLNfNLrO
         Ai198rmlFgIkrVhWT7A97m+0aaUuAjn6Y2tIwR2940slXxP2cv6MQ9FwE/51nrvbpi
         prltpoFZOsoQg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7D8BA40466; Tue,  1 Feb 2022 12:18:00 -0300 (-03)
Date:   Tue, 1 Feb 2022 12:18:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1 fyi] tools headers UAPI: Sync linux/perf_event.h with the
 kernel sources
Message-ID: <YflPKLhu2AtHmPov@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To pick the trivial change in:

  cb1c4aba055f928f ("perf: Add new macros for mem_hops field")

Just comment source code alignment.

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/perf_event.h' differs from latest version at 'include/uapi/linux/perf_event.h'
  diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_event.h

Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/perf_event.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 4cd39aaccbe7b904..1b65042ab1db8df4 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -1332,9 +1332,9 @@ union perf_mem_data_src {
 
 /* hop level */
 #define PERF_MEM_HOPS_0		0x01 /* remote core, same node */
-#define PERF_MEM_HOPS_1         0x02 /* remote node, same socket */
-#define PERF_MEM_HOPS_2         0x03 /* remote socket, same board */
-#define PERF_MEM_HOPS_3         0x04 /* remote board */
+#define PERF_MEM_HOPS_1		0x02 /* remote node, same socket */
+#define PERF_MEM_HOPS_2		0x03 /* remote socket, same board */
+#define PERF_MEM_HOPS_3		0x04 /* remote board */
 /* 5-7 available */
 #define PERF_MEM_HOPS_SHIFT	43
 
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255E252AD50
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 23:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240415AbiEQVHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 17:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbiEQVHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 17:07:02 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 17 May 2022 14:07:00 PDT
Received: from xppmailspam12.itap.purdue.edu (xppmailspam12.itap.purdue.edu [128.210.1.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E31532CE
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 14:07:00 -0700 (PDT)
IronPort-SDR: EcolU3GOREYZm/yLvCkxnMomZ4P2+F8XKSTXJZwD7ykZzATvIXRq0ND6JFHoTju0qgPOocEOFw
 3izNZ5cAw4zGVlFzAY/yqXE6hfboe8ZhQ=
X-Ironport-AuthID: liu3101@purdue.edu
IronPort-Data: =?us-ascii?q?A9a23=3A4FZru6rMG9kMKZqXIALiJi0rfWleBmIbZRIvg?=
 =?us-ascii?q?KrLsJaIsI4StFCztgarIBnUPf+PZDb8eownadnj90MD7Z7UytRgTwo6qSsxQ?=
 =?us-ascii?q?SwRouPIVI+TRqvS04J+DSFhoHqKZ6zyU/GYRCztZnOD9BqrLJb7qnxwifOBS?=
 =?us-ascii?q?rbmUbaWIj1rSRJpDiotlEs7yeI+h4dph/m/Ah+M5YOp+pGPaAf91m4mKH8Q5?=
 =?us-ascii?q?oKCtAhr4Kb4tgQeswFsfvtMplLfyyQYActHd6G8Jnf1WKdOGeu+S7qRxb215?=
 =?us-ascii?q?DqBrQ8wEN+4n/D2flBTGuzeOg2Hi3x3Xam+g0QS/XVugvZjbPdFMBVZkTSEm?=
 =?us-ascii?q?dx12e5hj53oRFd7JLDIlcQcTwJcT3N0M5pA9eKVOnO4q8GSkxDLfnawkfVjC?=
 =?us-ascii?q?EY6Yd8R9uptWzkc9PoUOWhQKBuYwfqr2r6mR69hitl6dJvnO4YWu3dByzDFD?=
 =?us-ascii?q?Kp2GsmfE/WSvdIIji0tgs1uHOrFY5ZLYzRYahmdMQZEPU0aCc5jker01GPzd?=
 =?us-ascii?q?SZU9ACcqaYtuTCBzQp9weCwdtHOPMSXX8lIkwCVqn+fpzb1BRQTNdq+zzuZ8?=
 =?us-ascii?q?y783baTzXOjAI9CRqel8vNKgUGIwjBBAhMhU1bm8+KyjVSzWo4CJkEZksb0Q?=
 =?us-ascii?q?XPez2T2CIikN/GEiCTc5EREBoMPS7dSBDylk8I43S7IXgDocRYeMLTKhOduL?=
 =?us-ascii?q?dAb/gfhc+HBXFSDg5XJIZ6pzYp4mBvpUcQjBTJYOXVUHVNtD+7L++nfhjqXJ?=
 =?us-ascii?q?jpq/TXcYtfdQVkcyBjSxMQyail6YWfmCsyGEV77bzKE/vAlTyY04AnGBj/j5?=
 =?us-ascii?q?Rg/fJO/a5Glr1XX8J6sLq7AFAnH5SBCwpPGqrlQUvlhlwTUKAkJNLWo+q3ca?=
 =?us-ascii?q?GT0mUN1E4QssTmh5hZPeKgMvmgvex41bJpslTjBJRW7VRlqzJNNLWaparFfb?=
 =?us-ascii?q?IW2BMAni6PnELzNX/bYdNdfYZ5vcCeI+ShvYQib2GWFuEsliqg5fJuWb+6jC?=
 =?us-ascii?q?nEVDalo1j2rX/xb2rgurgg6xGXOVdX4wg6h3L62enGYU/EGPUGIY+R/67mLy?=
 =?us-ascii?q?C3R8ssEbpPT4w1CSuHjb2/a/ZN7ELygBRDXHrj3rcBGLrPFKREgAHw7B+Lch?=
 =?us-ascii?q?74tZuRYc21uvr+g1hmAtoVwkTITXUH6FDg=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AkbjXja00TIewCBBEiw4LAAqjBAokLtp133?=
 =?us-ascii?q?Aq2lEZdPU1SKOlfq+V7Y0mPHPP+U4ssTQb9+xoW5PtfZqjz+8S3WB5B97LNz?=
 =?us-ascii?q?UO01HEEGgN1+Hf6gylPCHi++ZB3eNJdqRkFZnWBVx35Pyb3CCIV/Et3dSO7a?=
 =?us-ascii?q?jtr+bX1GoFd3AIV4hQqyB0FwuSD0UzbgxPH4A4G5qX7tdGoT3IQwVzUu2LQl?=
 =?us-ascii?q?4IQuXKutWOu5rjYRsXbiRXijWmvHeO5KP2GwWRmjYZSS4n+8ZHzUH11yv0+6?=
 =?us-ascii?q?iqrvn+8RnY2wbonvNrseqk7ddfCcSQgowuJirhkQa0dO1aOoG/gA=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,233,1647316800"; 
   d="scan'208";a="461971464"
Received: from indy05.cs.purdue.edu ([128.10.130.167])
  by xppmailspam12.itap.purdue.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 May 2022 17:05:54 -0400
From:   Congyu Liu <liu3101@purdue.edu>
To:     dvyukov@google.com, andreyknvl@gmail.com
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Congyu Liu <liu3101@purdue.edu>
Subject: [PATCH] kcov: fix race caused by unblocked interrupt
Date:   Tue, 17 May 2022 21:05:32 +0000
Message-Id: <20220517210532.1506591-1-liu3101@purdue.edu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some code runs in interrupts cannot be blocked by `in_task()` check.
In some unfortunate interleavings, such interrupt is raised during
serializing trace data and the incoming nested trace functionn could
lead to loss of previous trace data. For instance, in
`__sanitizer_cov_trace_pc`, if such interrupt is raised between
`area[pos] = ip;` and `WRITE_ONCE(area[0], pos);`, then trace data in
`area[pos]` could be replaced.

The fix is done by adding a flag indicating if the trace buffer is being
updated. No modification to trace buffer is allowed when the flag is set.

Signed-off-by: Congyu Liu <liu3101@purdue.edu>
---
 include/linux/sched.h |  3 +++
 kernel/kcov.c         | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index a8911b1f35aa..d06cedd9595f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1408,6 +1408,9 @@ struct task_struct {
 
 	/* Collect coverage from softirq context: */
 	unsigned int			kcov_softirq;
+
+	/* Flag of if KCOV area is being written: */
+	bool				kcov_writing;
 #endif
 
 #ifdef CONFIG_MEMCG
diff --git a/kernel/kcov.c b/kernel/kcov.c
index b3732b210593..a595a8ad5d8a 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -165,6 +165,8 @@ static notrace bool check_kcov_mode(enum kcov_mode needed_mode, struct task_stru
 	 */
 	if (!in_task() && !(in_serving_softirq() && t->kcov_softirq))
 		return false;
+	if (READ_ONCE(t->kcov_writing))
+		return false;
 	mode = READ_ONCE(t->kcov_mode);
 	/*
 	 * There is some code that runs in interrupts but for which
@@ -201,12 +203,19 @@ void notrace __sanitizer_cov_trace_pc(void)
 		return;
 
 	area = t->kcov_area;
+
+	/* Prevent race from unblocked interrupt. */
+	WRITE_ONCE(t->kcov_writing, true);
+	barrier();
+
 	/* The first 64-bit word is the number of subsequent PCs. */
 	pos = READ_ONCE(area[0]) + 1;
 	if (likely(pos < t->kcov_size)) {
 		area[pos] = ip;
 		WRITE_ONCE(area[0], pos);
 	}
+	barrier();
+	WRITE_ONCE(t->kcov_writing, false);
 }
 EXPORT_SYMBOL(__sanitizer_cov_trace_pc);
 
@@ -230,6 +239,10 @@ static void notrace write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
 	area = (u64 *)t->kcov_area;
 	max_pos = t->kcov_size * sizeof(unsigned long);
 
+	/* Prevent race from unblocked interrupt. */
+	WRITE_ONCE(t->kcov_writing, true);
+	barrier();
+
 	count = READ_ONCE(area[0]);
 
 	/* Every record is KCOV_WORDS_PER_CMP 64-bit words. */
@@ -242,6 +255,8 @@ static void notrace write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
 		area[start_index + 3] = ip;
 		WRITE_ONCE(area[0], count + 1);
 	}
+	barrier();
+	WRITE_ONCE(t->kcov_writing, false);
 }
 
 void notrace __sanitizer_cov_trace_cmp1(u8 arg1, u8 arg2)
@@ -335,6 +350,7 @@ static void kcov_start(struct task_struct *t, struct kcov *kcov,
 	t->kcov_size = size;
 	t->kcov_area = area;
 	t->kcov_sequence = sequence;
+	t->kcov_writing = false;
 	/* See comment in check_kcov_mode(). */
 	barrier();
 	WRITE_ONCE(t->kcov_mode, mode);
-- 
2.34.1


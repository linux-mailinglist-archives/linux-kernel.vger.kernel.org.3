Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A482D577CEA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 09:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbiGRH4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 03:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiGRH43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 03:56:29 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834BD183B2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 00:56:23 -0700 (PDT)
X-QQ-mid: bizesmtp90t1658130956t7fduxie
Received: from localhost.localdomain ( [182.148.15.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 15:55:54 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000B00A0000020
X-QQ-FEAT: I6umPUGCYXFVJ41OBmTHZCAuvOk0nuyFrkzHbZ8yYJoOROKptEgxbDoCpvPR9
        H/m0c+9zbgRNGfDO/X7hMqpdcb4va5GYfy/hmVMHVhWSbkjkUvv8Qt5+CiM1TNmZI2OFFvN
        wfWHF/wSJCGxar3kCDs4Xk+nhc32kr4otZcjYhZrY79pJCYk835bcpIqAax0RMBUVJWGUQ6
        Ecm9kyMl9m2247XTSBRUhN7jRs++ijF/UKv9K/l3QdT0WtpM/KkotQy4m399oHHI2Ld58Mu
        quPaPe16EpC6iEjFk+3L+9QQHocK/Iqdawv4IgD3lngTVdLswAWgkLB+dwBXjeERLxHZxYt
        1AgnKLhEziE3VyMTF7jC1cP7HgBbAAAkfpCn7iIsfzD/Fn/JxrgF7AhPK6btNnFSoUpLQeq
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     paulus@samba.org
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, haren@linux.ibm.com,
        npiggin@gmail.com, nick.child@ibm.com, Julia.Lawall@inria.fr,
        clg@kaod.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] powerpc/pseries/vas: Fix comment typo
Date:   Mon, 18 Jul 2022 15:55:53 +0800
Message-Id: <20220718075553.70897-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `the' in line 807 is duplicated, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/powerpc/platforms/pseries/vas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/vas.c b/arch/powerpc/platforms/pseries/vas.c
index 91e7eda0606c..7e6e6dd2e33e 100644
--- a/arch/powerpc/platforms/pseries/vas.c
+++ b/arch/powerpc/platforms/pseries/vas.c
@@ -804,7 +804,7 @@ int vas_reconfig_capabilties(u8 type, int new_nr_creds)
 	 * The total number of available credits may be decreased or
 	 * increased with DLPAR operation. Means some windows have to be
 	 * closed / reopened. Hold the vas_pseries_mutex so that the
-	 * the user space can not open new windows.
+	 * user space can not open new windows.
 	 */
 	if (old_nr_creds <  new_nr_creds) {
 		/*
-- 
2.35.1


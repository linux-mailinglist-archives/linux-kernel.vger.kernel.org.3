Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182D05308DF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 07:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239401AbiEWFhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 01:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbiEWFg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 01:36:57 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 22 May 2022 22:36:56 PDT
Received: from xppmailspam04.itap.purdue.edu (xppmailspam04.itap.purdue.edu [128.210.5.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4227A1C933
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 22:36:56 -0700 (PDT)
IronPort-SDR: 7S1kxYPAs/kDDMfSrsekWdS8eTswCq5YAtn2a0PAzktF6gr5pbKmBkw+jRW+JyYYbpfluM2fym
 aFu5gfbGSnmwZ8uzXljHcl5ucaI6ehbgg=
X-Ironport-AuthID: liu3101@purdue.edu
IronPort-Data: =?us-ascii?q?A9a23=3ApY2qUqPJMarjxOrvrR2ml8FynXyQoLVcMsEvi?=
 =?us-ascii?q?/4bfWQNrUpx1DxWxmcYCmuBOq2IM2T3c95xPYi2px5QsMXRzNI2HXM5pCpnJ?=
 =?us-ascii?q?55oRWspJjg7wn8dt0p+F+WbJK6+x8lBONTGMu4uSXrQ+kWkPrT79CEuzbySS?=
 =?us-ascii?q?qfxTuPIJ3kpFwNjTS4gjzNlmvI43t4z2ITpU1vVtIOgudDbNX+kxyVwbjAe5?=
 =?us-ascii?q?ZWFpU49p//1oj4Z4gEzaKkT7l/TnnUYFrwFIqS1IyeqS4VYBLfiFf7e1r2k8?=
 =?us-ascii?q?yXU8wp0UoGplbPyc0srRL/OPFTe0SMKC/j62hUb/348yKc2MvYYeHx7sTTRk?=
 =?us-ascii?q?oAj0shJuLyxVRwtYv/GltMbXkQKCCp5J6BHpOLKLHXj48yey0rKLynlz/l0V?=
 =?us-ascii?q?hlkPIsU674qR2pVs+QFMjwQY1aOi//vmOC3Texlh8ICKsj3Pd9P4Sg8nWGBV?=
 =?us-ascii?q?ft2E4reR6jq5MND2GtijM55G/uDNdESbiBibUidbhATaE0bDokywLWhinXlK?=
 =?us-ascii?q?WUKqVSZtPJqpWPIihRsyrTwPZzYdsHTHZdZmUORp2Tn+WXlA01Kb4XDmWrdq?=
 =?us-ascii?q?n/81PXSmS7bWZ4JEOHq/PBdhlDOlHcYDwcbVAfmrPS04qJktwmzEGRJvHt3x?=
 =?us-ascii?q?UQO3BbzFIOlAkfi+CTsUiM0ArK8LcVrsGlh9YKLu251NkBcJtJwQIROWP0eH?=
 =?us-ascii?q?FTG5XfV9z/dPgGDhZXOIZ6r3urO8WniaXB9wVgqPkfoRSNdizXqTRpaYhjnF?=
 =?us-ascii?q?r6PG4bt5jH59K2ZL5lncUEDa7svYc4jj81X/HjGhT69/sWPRRVz/hjNUn+oq?=
 =?us-ascii?q?A51eeZJZaTxswidtK4Gdd3BCADf4xDomODHhAwKJZWMiXfUGLwlBKyz6+uId?=
 =?us-ascii?q?jDQnDaDGrF9qGr1qi/zId04DDZWYR0B3tw/UTP3cVLQvh1565hUM3+nK6RwZ?=
 =?us-ascii?q?uqZAsIm16XxFtL7Utjba9NPZt56cwrv1CJnfkeWmmzgjmAjlqYwPZqUa8GxF?=
 =?us-ascii?q?W1cAqNipBKyRuEAwfooyzo4yGf7W5/21VKk3KCYaXrTTq0KWHOKb/1itfvdi?=
 =?us-ascii?q?B3I6dpCOo2Hxwg3bQFUSkE76qYSK1wbdSV9Douws9FNevOOZAdqBQkc5zbq6?=
 =?us-ascii?q?etJU+RYc259z48kJk2AZ3I=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A/RJRpattgGOoH7bfmqG0oNxA7skDb9V00z?=
 =?us-ascii?q?EX/kB9WHVpmwKj+vxG+85rtiMc5wx/ZJhNo7u90cq7IU80i6Qa3WB5B97LYO?=
 =?us-ascii?q?CMggeVxe9Zh7cKuweAJxHD?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,245,1647316800"; 
   d="scan'208";a="476099845"
Received: from indy05.cs.purdue.edu ([128.10.130.167])
  by xppmailspam04.itap.purdue.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 May 2022 01:35:51 -0400
From:   Congyu Liu <liu3101@purdue.edu>
To:     dvyukov@google.com, andreyknvl@gmail.com
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Congyu Liu <liu3101@purdue.edu>
Subject: [PATCH v2] kcov: update pos before writing pc in trace function
Date:   Mon, 23 May 2022 05:35:31 +0000
Message-Id: <20220523053531.1572793-1-liu3101@purdue.edu>
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

In __sanitizer_cov_trace_pc(), previously we write pc before updating pos.
However, some early interrupt code could bypass check_kcov_mode()
check and invoke __sanitizer_cov_trace_pc(). If such interrupt is raised
between writing pc and updating pos, the pc could be overitten by the
recursive __sanitizer_cov_trace_pc().

As suggested by Dmitry, we cold update pos before writing pc to avoid
such interleaving.

Apply the same change to write_comp_data().

Signed-off-by: Congyu Liu <liu3101@purdue.edu>
---
PATCH v2:
* Update pos before writing pc as suggested by Dmitry.

PATCH v1:
https://lore.kernel.org/lkml/20220517210532.1506591-1-liu3101@purdue.edu/
---
 kernel/kcov.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index b3732b210593..e19c84b02452 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -204,8 +204,16 @@ void notrace __sanitizer_cov_trace_pc(void)
 	/* The first 64-bit word is the number of subsequent PCs. */
 	pos = READ_ONCE(area[0]) + 1;
 	if (likely(pos < t->kcov_size)) {
-		area[pos] = ip;
+		/* Previously we write pc before updating pos. However, some
+		 * early interrupt code could bypass check_kcov_mode() check
+		 * and invoke __sanitizer_cov_trace_pc(). If such interrupt is
+		 * raised between writing pc and updating pos, the pc could be
+		 * overitten by the recursive __sanitizer_cov_trace_pc().
+		 * Update pos before writing pc to avoid such interleaving.
+		 */
 		WRITE_ONCE(area[0], pos);
+		barrier();
+		area[pos] = ip;
 	}
 }
 EXPORT_SYMBOL(__sanitizer_cov_trace_pc);
@@ -236,11 +244,13 @@ static void notrace write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
 	start_index = 1 + count * KCOV_WORDS_PER_CMP;
 	end_pos = (start_index + KCOV_WORDS_PER_CMP) * sizeof(u64);
 	if (likely(end_pos <= max_pos)) {
+		/* See comment in __sanitizer_cov_trace_pc(). */
+		WRITE_ONCE(area[0], count + 1);
+		barrier();
 		area[start_index] = type;
 		area[start_index + 1] = arg1;
 		area[start_index + 2] = arg2;
 		area[start_index + 3] = ip;
-		WRITE_ONCE(area[0], count + 1);
 	}
 }
 
-- 
2.34.1


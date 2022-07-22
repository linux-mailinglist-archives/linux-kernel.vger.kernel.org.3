Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185F257D89E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 04:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbiGVC1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 22:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiGVC07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 22:26:59 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9C7BEB;
        Thu, 21 Jul 2022 19:26:54 -0700 (PDT)
X-QQ-mid: bizesmtp79t1658456796typr1bmr
Received: from harry-jrlc.. ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 22 Jul 2022 10:26:28 +0800 (CST)
X-QQ-SSF: 0100000000000030C000000A0000020
X-QQ-FEAT: fs34Pe/+C2Qz/O+Hf3pkbgMYytZZrxcnUQuiYqbKNuM/YfWCyb6znbn0eKP4A
        tg9KECp98l71ESDFLWUa/Ulvxv0GmzX2U5501W3JWnD9Og8VoPr8yWi7/odg7edKsFyRvMa
        i8JrdIHaiWd15DolXpXPSI4uExjQvTg+PCkwrdOtYBC9CeXrDf/JZJJFkfD+rKRqAiI3UF8
        oVupPlzIjt/F9a3vYtCBdiUdGyO+MLk3bk1t4MxUQ5goSVJsYrIKYgw8px2dcQIncnKYxqJ
        ld0v4Iw8Ta7PoPjRKhkAeDfsU2jEvb6ytICLRmHm3MGbGPZvvXx1oB5hTVFO7YOLRIBxp5K
        IoHe6eTsELYSdN11wH1CqicLlDbB1WiXV9vAFYu3mHkelMHYZrUEQCeIQKgnA==
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] xfs: Fix comment typo
Date:   Fri, 22 Jul 2022 10:26:26 +0800
Message-Id: <20220722022626.16082-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
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

The double `the' is duplicated in line 552, remove one.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 fs/xfs/xfs_dquot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
index 5a6c3c3c4de2..8fb90da89787 100644
--- a/fs/xfs/xfs_dquot.c
+++ b/fs/xfs/xfs_dquot.c
@@ -549,7 +549,7 @@ xfs_dquot_check_type(
 	 * at the same time.  The non-user quota file can be switched between
 	 * group and project quota uses depending on the mount options, which
 	 * means that we can encounter the other type when we try to load quota
-	 * defaults.  Quotacheck will soon reset the the entire quota file
+	 * defaults.  Quotacheck will soon reset the entire quota file
 	 * (including the root dquot) anyway, but don't log scary corruption
 	 * reports to dmesg.
 	 */
-- 
2.30.2


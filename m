Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4847857E77E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 21:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbiGVThJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 15:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236408AbiGVThE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 15:37:04 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1976851437;
        Fri, 22 Jul 2022 12:36:59 -0700 (PDT)
X-QQ-mid: bizesmtp90t1658518598tyvkssad
Received: from harry-jrlc.. ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 23 Jul 2022 03:36:26 +0800 (CST)
X-QQ-SSF: 0100000000200030C000000A0000020
X-QQ-FEAT: RFp2QSjOiS5l1yov7WTteCM0M85ZWVSs2tBFwBBLpH9tZdmWYP9JOkLmltUII
        /pz7FQ1b9b4pVYb52HUyvmtvpNoKWPc2XfUFbADQ71QF2MEu+ixabC02Z2FWD+6LwxY1w9G
        y2FrQ8e/OY3SUx4bKTzCLg42i5qAgISqPVPvomdOvAjazd+kT+GHP8pQ/CKMcIcDyHxJBTe
        CUTGAxC7iYb32QdP5ElA6X66c9nNBZZcnomWvVS0yGW18xR6P2wYj+Ppc1fePcP7k3TBh7R
        aAsW+KFwTLD+TbQgbUZ3sZ4t3NwcONtsUAu71TK1/8We8m24ZYkgERGeflA372eIsJMSZNt
        2f1/oLR6yhoQK66DNa9QdwO9TG0pPP0CT6v7/kTE/NgH2/Fxko=
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     djwong@kernel.org
Cc:     dchinner@redhat.com, chandan.babu@oracle.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] xfs: Fix comment typo
Date:   Sat, 23 Jul 2022 03:36:24 +0800
Message-Id: <20220722193624.18002-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `for' is duplicated in line 3788, remove one.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 fs/xfs/libxfs/xfs_bmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 6833110d1bd4..6f6d87ba29a3 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3785,7 +3785,7 @@ xfs_bmapi_trim_map(
 		mval->br_startblock = got->br_startblock +
 					(*bno - got->br_startoff);
 	/*
-	 * Return the minimum of what we got and what we asked for for
+	 * Return the minimum of what we got and what we asked for
 	 * the length.  We can use the len variable here because it is
 	 * modified below and we could have been there before coming
 	 * here if the first part of the allocation didn't overlap what
-- 
2.30.2


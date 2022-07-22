Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F6C57E78F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 21:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236520AbiGVTkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 15:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiGVTkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 15:40:52 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714BFA1A9;
        Fri, 22 Jul 2022 12:40:47 -0700 (PDT)
X-QQ-mid: bizesmtp72t1658518829t32f9ayz
Received: from harry-jrlc.. ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 23 Jul 2022 03:40:16 +0800 (CST)
X-QQ-SSF: 0100000000200030C000000A0000020
X-QQ-FEAT: +bXiSo2NuBf53w60E3TEIm1fPbBTpgj48TNTmNgo240QYvkObRgBbQ6aMZc41
        HrLbNJS7d5baihB3AQxFKuLAxs4WAp4MZckpFdZ3EODCEJSPs3uLcuHXFvjE2dh9OtlTP3X
        pXuhPSKE2AvrEHXL+61GtNXzbB76VPXMA8PTGRn3gLOjjLdsY1cXrHgn+G8CYizEPunX6dE
        DtJsnchxPchrOX0bvTNzyftpP71r1wlqBpJVCzhCoblpjofFI3CJTToVU3wi21BIZXK4FKb
        +uWJqw92rxo3sAoTCTJg2aCas6/gM/6VWjtCK+pBiwmXHmt9Tc4KfPkmb92Q+ZGOi+syKZ1
        iGqGxot1veOUjW4PrxKAIl72CKQxHqeu5zrI4oZwxYYKEjgmBA=
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     djwong@kernel.org
Cc:     dchinner@redhat.com, chandan.babu@oracle.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] xfs: Fix comment typo
Date:   Sat, 23 Jul 2022 03:40:14 +0800
Message-Id: <20220722194014.18184-1-gaoxin@cdjrlc.com>
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

The double `extent' is duplicated in line 837, remove one.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 fs/xfs/libxfs/xfs_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index d3f2886fdc08..f6bd9181cb13 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -833,7 +833,7 @@ xfs_alloc_cur_close(
 /*
  * Check an extent for allocation and track the best available candidate in the
  * allocation structure. The cursor is deactivated if it has entered an out of
- * range state based on allocation arguments. Optionally return the extent
+ * range state based on allocation arguments. Optionally return the
  * extent geometry and allocation status if requested by the caller.
  */
 static int
-- 
2.30.2


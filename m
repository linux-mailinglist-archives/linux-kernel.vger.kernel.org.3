Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A4D58FE00
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 16:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235446AbiHKOCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 10:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbiHKOC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 10:02:27 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9197D5C9CA
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 07:02:25 -0700 (PDT)
X-QQ-mid: bizesmtp76t1660226534tbgav3ki
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 11 Aug 2022 22:02:12 +0800 (CST)
X-QQ-SSF: 01000000002000G0V000B00A0000020
X-QQ-FEAT: 239gR2IZrlu5NeQzIDZoCbnF5wFNgRbeY+Yl2Ri09D1j7kQOastYLLUKQaFvr
        w1DWIdgIjAjAgwKP62MSMvt3QpjOaghEey7fwjHpgFg1hieT+9cvIjbXpUisHPophgPfYN1
        47p/mCc5kHm3qdJqEjDOJ8afHDHuCRmZfvGaGvBt9W7kgEubJmL16yac+sdm4reTC0l3nrS
        JMLsbFEOpIoRq4uM+WXwW0O+BQJWKYmUbBpKL9vriGmMmksHFOFhg5xnpJ/s20hUk8CLYmo
        EF76k6aMvI1KAKL+IiryVas565Fct0VhTqthycSeDMKkbJa+wk2benXsNOlUR7sVWeBpKh6
        9ZgFM5mlT8uD84pkfs1Jmy9uQgyzjp+wWN0iRqUrfm1EIO+a7QgdR5zB1U06RIprBpbkM0i
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     marc.dionne@auristor.com
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] afs: Fix comment typo
Date:   Thu, 11 Aug 2022 22:02:06 +0800
Message-Id: <20220811140206.30825-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `consider' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 fs/afs/rotate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index a840c3588ebb..1fdb0ad8b66d 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -236,7 +236,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 
 		case VMOVED:
 			/* The volume migrated to another server.  We consider
-			 * consider all locks and callbacks broken and request
+			 * all locks and callbacks broken and request
 			 * an update from the VLDB.
 			 *
 			 * We also limit the number of VMOVED hops we will
-- 
2.36.1


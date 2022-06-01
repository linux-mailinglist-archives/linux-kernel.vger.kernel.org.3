Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC9B539ED3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 09:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350448AbiFAH6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 03:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244461AbiFAH6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 03:58:14 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FD7433A3
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 00:58:13 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 1 Jun 2022
 15:58:05 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Wed, 1 Jun
 2022 15:58:04 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     Jan Harkes <jaharkes@cs.cmu.edu>, <coda@cs.cmu.edu>
CC:     Haowen Bai <baihaowen@meizu.com>, <codalist@coda.cs.cmu.edu>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] coda: remove unused variable
Date:   Wed, 1 Jun 2022 15:58:03 +0800
Message-ID: <1654070283-7216-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable insize is initialized but never used otherwise.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 fs/coda/upcall.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/coda/upcall.c b/fs/coda/upcall.c
index 59f6cfd06f96..c214b424426d 100644
--- a/fs/coda/upcall.c
+++ b/fs/coda/upcall.c
@@ -477,10 +477,9 @@ int venus_pioctl(struct super_block *sb, struct CodaFid *fid,
 {
         union inputArgs *inp;
         union outputArgs *outp;  
-	int insize, outsize, error;
+	int outsize, error;
 	int iocsize;
 
-	insize = VC_MAXMSGSIZE;
 	UPARG(CODA_IOCTL);
 
         /* build packet for Venus */
-- 
2.7.4


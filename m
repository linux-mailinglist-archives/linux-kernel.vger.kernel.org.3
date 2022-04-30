Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC5F51600A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 21:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbiD3TPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 15:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244442AbiD3TPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 15:15:01 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F924FC56;
        Sat, 30 Apr 2022 12:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dTCORFgd4jCzWeUzesuOaQD3lDWMIHwEYU6tlvZ83+g=;
  b=OrYEYOKkZzBCuUMcn2bqN1dniJTGhnKTIqSwJe4oHEORN+FCCcTHeMi5
   nyuONW0G3Djx3C7G78jOQH8z9REk1umwfbFUGiTntJiA/vs7I623XmBGR
   7lF3WUTsQyxRHS+N7oqXllMFB2kAiYtCWm8SqngBnlQ5n9S1/CNEYrwZX
   U=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,188,1647298800"; 
   d="scan'208";a="34084618"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 21:11:32 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     kernel-janitors@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390/hypfs: fix typos in comments
Date:   Sat, 30 Apr 2022 21:11:19 +0200
Message-Id: <20220430191122.8667-5-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various spelling mistakes in comments.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 arch/s390/hypfs/hypfs_vm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/hypfs/hypfs_vm.c b/arch/s390/hypfs/hypfs_vm.c
index 3765c2d81df5..a3d881ca0a98 100644
--- a/arch/s390/hypfs/hypfs_vm.c
+++ b/arch/s390/hypfs/hypfs_vm.c
@@ -190,7 +190,7 @@ int hypfs_vm_create_files(struct dentry *root)
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
-	/* Hpervisor Info */
+	/* Hypervisor Info */
 	dir = hypfs_mkdir(root, "hyp");
 	if (IS_ERR(dir)) {
 		rc = PTR_ERR(dir);


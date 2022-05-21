Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DB552FBE2
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 13:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356594AbiEULXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 07:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349966AbiEULNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 07:13:30 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2053B1059C7;
        Sat, 21 May 2022 04:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ajlODn0UBCgHpmr/xDSe9adH/UaGKwJcJ/bx4WGDDLU=;
  b=qns+9z60FQq4RCGA7pZ29gmbZeEQ6FiACDHafewG8k9tJupBJ89ClEl1
   QOPMjAiwYj9OVI6vIPOZWZtYqxOrPRUwZ+Kg2pxU/ydEbqQjVG3AeKECF
   R7P/7Ghc3kEeyBdF2u3o/Qy7O7KJlokb8n4hFjyhVN6KPiZSonzZ1D4TF
   o=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14727990"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:12:06 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Frederic Barrat <fbarrat@linux.ibm.com>
Cc:     kernel-janitors@vger.kernel.org,
        Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cxl: fix typo in comment
Date:   Sat, 21 May 2022 13:11:32 +0200
Message-Id: <20220521111145.81697-82-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spelling mistake (triple letters) in comment.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 include/misc/cxl.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/misc/cxl.h b/include/misc/cxl.h
index 0410412de16b..d8044299d654 100644
--- a/include/misc/cxl.h
+++ b/include/misc/cxl.h
@@ -30,7 +30,7 @@ unsigned int cxl_pci_to_cfg_record(struct pci_dev *dev);
 /*
  * Context lifetime overview:
  *
- * An AFU context may be inited and then started and stoppped multiple times
+ * An AFU context may be inited and then started and stopped multiple times
  * before it's released. ie.
  *    - cxl_dev_context_init()
  *      - cxl_start_context()


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C040A52FBF6
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 13:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356084AbiEULWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 07:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354913AbiEULM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 07:12:57 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DBA59081;
        Sat, 21 May 2022 04:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0Oe5vh0/YEuMHcpYG5DbrfNq06u/kEWAlQteocqA+zY=;
  b=MQb7ChIWpZB8LD/3VMraIaHbR13voMwZpxVKTl/aPJpd2iKGx6J/cU7C
   QYfdTwRIC2FrN68VlD7imR/jN1E48LCKoXuEF86ScEe84igdy3QaoAZPP
   11f65doEDnOw5+B0nu3JbLJ4JEt/7MVT6QeSQEv2LdPe2Z1Zy8DU5t3ug
   Y=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14727976"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:12:04 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Steve French <sfrench@samba.org>
Cc:     kernel-janitors@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: smbd: fix typo in comment
Date:   Sat, 21 May 2022 13:11:19 +0200
Message-Id: <20220521111145.81697-69-Julia.Lawall@inria.fr>
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
 fs/cifs/smbdirect.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
index b3a1265711cc..c3278db1cade 100644
--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -1350,7 +1350,7 @@ void smbd_destroy(struct TCP_Server_Info *server)
 	wait_event(info->wait_send_pending,
 		atomic_read(&info->send_pending) == 0);
 
-	/* It's not posssible for upper layer to get to reassembly */
+	/* It's not possible for upper layer to get to reassembly */
 	log_rdma_event(INFO, "drain the reassembly queue\n");
 	do {
 		spin_lock_irqsave(&info->reassembly_queue_lock, flags);


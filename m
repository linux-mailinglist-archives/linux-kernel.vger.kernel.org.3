Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92ABC4D84C7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 13:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242424AbiCNM36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 08:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243868AbiCNMVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 08:21:21 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6915F22;
        Mon, 14 Mar 2022 05:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PohfiM/jemSw4lByumgtDX8BMjTHdgwkmP7e9cEnTTo=;
  b=RXw0XrlN4OTwPHzhfcm0YzzUPIdrHr+IaikXeaoun2xV3D55B2BtfOLn
   gNwI+926Y10jB264AiXXPz4oHQQ4Bd21JYPLx6GfUqwIUBvSoUF8aS5St
   9c6tGEVCFhumdDA2ZTkRnlRP5yjL9/Whql9ezg24/orvPQtGEoqwAJN/o
   Q=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,180,1643670000"; 
   d="scan'208";a="25997359"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 12:54:00 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Hannes Reinecke <hare@suse.com>
Cc:     kernel-janitors@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 25/30] treewide: fix typos in comments
Date:   Mon, 14 Mar 2022 12:53:49 +0100
Message-Id: <20220314115354.144023-26-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220314115354.144023-1-Julia.Lawall@inria.fr>
References: <20220314115354.144023-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various spelling mistakes in comments.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/scsi/aic7xxx/aicasm/aicasm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/aic7xxx/aicasm/aicasm.c b/drivers/scsi/aic7xxx/aicasm/aicasm.c
index 5f474e490f3e..cd692a4c5f85 100644
--- a/drivers/scsi/aic7xxx/aicasm/aicasm.c
+++ b/drivers/scsi/aic7xxx/aicasm/aicasm.c
@@ -283,7 +283,7 @@ main(int argc, char *argv[])
 		/*
 		 * Decend the tree of scopes and insert/emit
 		 * patches as appropriate.  We perform a depth first
-		 * tranversal, recursively handling each scope.
+		 * traversal, recursively handling each scope.
 		 */
 		/* start at the root scope */
 		dump_scope(SLIST_FIRST(&scope_stack));


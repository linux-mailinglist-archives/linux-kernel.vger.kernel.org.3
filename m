Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C99B52FB35
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 13:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354979AbiEULNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 07:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242272AbiEULMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 07:12:01 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E66528E33;
        Sat, 21 May 2022 04:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xvf42Wq/qiT5QgcMM2HMSHpMZcoeDbMnj9kopc37qO8=;
  b=tB63a4m/lVFWXVNz4HNaTZtH+vvs5yeot9jAtqY6cZR3lfIit87u8oKq
   5Pzf//atJd21Spnipjxu7TgGT/gbHD7SpTuUTh0F4APZxLTo80E+j16ug
   P9lPLu68sN00zzxso1DGOSYjLNe0Xo+GLBXvtyIuwZoPZ+ElY8UOI9YNf
   k=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14727908"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:11:54 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Mark Brown <broonie@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] spi: fix typo in comment
Date:   Sat, 21 May 2022 13:10:23 +0200
Message-Id: <20220521111145.81697-13-Julia.Lawall@inria.fr>
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
 include/linux/spi/spi.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index d361ba26203b..eadfd3ba3cbc 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1127,7 +1127,7 @@ spi_max_transfer_size(struct spi_device *spi)
 	if (ctlr->max_transfer_size)
 		tr_max = ctlr->max_transfer_size(spi);
 
-	/* transfer size limit must not be greater than messsage size limit */
+	/* transfer size limit must not be greater than message size limit */
 	return min(tr_max, msg_max);
 }
 


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56ACE4DD858
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 11:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbiCRKmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 06:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbiCRKjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:39:06 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC332DA68E;
        Fri, 18 Mar 2022 03:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xLej0MfOKXRLDj+va3Jz5fj64lBRWUL+ijlYgyxy/jc=;
  b=oyto+hKQTeGX4imDHDdUIkpJ0GO4FEuUKhWFtHr9MpUlpl/dkRwcyAKG
   xhFpGIV9yYAcdBE4r+i2B49c2O/7MyfhpdQsXyb6ctQpnc2QQ7b2x621y
   YWarh+T9A27AKA7+LM0/ljCc4ZdVaZwfwZka0fpWm9nUvCrTS42nWTpgv
   I=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,192,1643670000"; 
   d="scan'208";a="8935645"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 11:37:37 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     kernel-janitors@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: mm: fix typos in comments
Date:   Fri, 18 Mar 2022 11:37:08 +0100
Message-Id: <20220318103729.157574-13-Julia.Lawall@inria.fr>
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

Various spelling mistakes in comments.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 arch/arm/mm/cache-b15-rac.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/cache-b15-rac.c b/arch/arm/mm/cache-b15-rac.c
index bdc07030997b..9c1172f26885 100644
--- a/arch/arm/mm/cache-b15-rac.c
+++ b/arch/arm/mm/cache-b15-rac.c
@@ -74,7 +74,7 @@ static inline void __b15_rac_flush(void)
 	__raw_writel(FLUSH_RAC, b15_rac_base + rac_flush_offset);
 	do {
 		/* This dmb() is required to force the Bus Interface Unit
-		 * to clean oustanding writes, and forces an idle cycle
+		 * to clean outstanding writes, and forces an idle cycle
 		 * to be inserted.
 		 */
 		dmb();


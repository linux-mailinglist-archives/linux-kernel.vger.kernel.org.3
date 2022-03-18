Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6354DD85C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 11:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbiCRKlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 06:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235131AbiCRKjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:39:10 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5E62DB59C;
        Fri, 18 Mar 2022 03:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kLFY9Yxqe1s3OOFAPDyKIWGJGBLJRoXKVlnXfo8VTrQ=;
  b=EKOvbyqoGSC/JvN9rk4SvEUe1jyqefG6RQQe6dlY+/PslstO3gPjh2Px
   7vuORTfLDtlAWDsH4A1vWe/Bkx+iGaPJCIRthnj4i/tuHxOKFEG7PaRQz
   8NFKvGigLS1kz6xHrGc1j5x8nurYPRMzUUtwwyM7xhkJdI7SxqUCWPgiR
   I=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,192,1643670000"; 
   d="scan'208";a="8935657"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 11:37:38 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Viresh Kumar <vireshk@kernel.org>
Cc:     kernel-janitors@vger.kernel.org,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: spear: fix typos in comments
Date:   Fri, 18 Mar 2022 11:37:16 +0100
Message-Id: <20220318103729.157574-21-Julia.Lawall@inria.fr>
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
 arch/arm/mach-spear/spear13xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-spear/spear13xx.c b/arch/arm/mach-spear/spear13xx.c
index 74d1ca2a529a..b38391e9d8bf 100644
--- a/arch/arm/mach-spear/spear13xx.c
+++ b/arch/arm/mach-spear/spear13xx.c
@@ -29,7 +29,7 @@ void __init spear13xx_l2x0_init(void)
 	/*
 	 * 512KB (64KB/way), 8-way associativity, parity supported
 	 *
-	 * FIXME: 9th bit, of Auxillary Controller register must be set
+	 * FIXME: 9th bit, of Auxiliary Controller register must be set
 	 * for some spear13xx devices for stable L2 operation.
 	 *
 	 * Enable Early BRESP, L2 prefetch for Instruction and Data,


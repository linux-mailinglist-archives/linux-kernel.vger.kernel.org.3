Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DA952FBEF
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 13:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355693AbiEULWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 07:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354897AbiEULMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 07:12:49 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656B1527DC;
        Sat, 21 May 2022 04:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6cd8sX8fQeDB8o08/mQAvibf5LOyGxA4vJuioHsPmtI=;
  b=WvZn6zpVB9RIg6tHWzUf7sIz5mw31+mqebiByBRvwX29724hssTIPg5j
   RkDP94HTsvtKoegWKVfzi3dhKsFD8V2wH4nDPlz3M/w6ebnQuWzAJu7tA
   iu2bkGeA42HKsQFa78g58+QwfTBfHb5yfabyluzNPLQ/FffquOweT49w8
   M=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14727971"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:12:03 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     kernel-janitors@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Octeon: fix typo in comment
Date:   Sat, 21 May 2022 13:11:15 +0200
Message-Id: <20220521111145.81697-65-Julia.Lawall@inria.fr>
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
 arch/mips/pci/pcie-octeon.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/pci/pcie-octeon.c b/arch/mips/pci/pcie-octeon.c
index 50a3394a9d25..c9edd3fb380d 100644
--- a/arch/mips/pci/pcie-octeon.c
+++ b/arch/mips/pci/pcie-octeon.c
@@ -895,7 +895,7 @@ static int __cvmx_pcie_rc_initialize_gen1(int pcie_port)
 	mem_access_subid.s.nsw = 0;	/* Enable Snoop for Writes. */
 	mem_access_subid.s.ror = 0;	/* Disable Relaxed Ordering for Reads. */
 	mem_access_subid.s.row = 0;	/* Disable Relaxed Ordering for Writes. */
-	mem_access_subid.s.ba = 0;	/* PCIe Adddress Bits <63:34>. */
+	mem_access_subid.s.ba = 0;	/* PCIe Address Bits <63:34>. */
 
 	/*
 	 * Setup mem access 12-15 for port 0, 16-19 for port 1,


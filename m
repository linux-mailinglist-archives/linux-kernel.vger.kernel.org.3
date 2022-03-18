Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18BF4DD859
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 11:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbiCRKl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 06:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbiCRKjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:39:06 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218E72DB588;
        Fri, 18 Mar 2022 03:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nmoN7qrNGdd3GijxnLEUeLBzgeTfrwH2rysgA4ATV18=;
  b=UYBLo2K5nrhJrQKJmy1S161fiIFv6BU68IOxVfLKMZvAaR1IavtjqEbY
   +vUKt6YMzFxIqzH3kG37/f8ZDizFVYe88xzYoj7es9Zn/Jgh483uPpKrc
   LS0Rs1DXOp5miT/jHmV1rYpTC41xwU81LwT1Mnl63WzVSjkx05TnkKOFZ
   c=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,192,1643670000"; 
   d="scan'208";a="8935647"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 11:37:37 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     kernel-janitors@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xen/arm: fix typos in comments
Date:   Fri, 18 Mar 2022 11:37:10 +0100
Message-Id: <20220318103729.157574-15-Julia.Lawall@inria.fr>
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
 arch/arm/xen/mm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index a7e54a087b80..607c1a557ccc 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -105,7 +105,7 @@ bool xen_arch_need_swiotlb(struct device *dev,
 	 *	- The Linux page refers to foreign memory
 	 *	- The device doesn't support coherent DMA request
 	 *
-	 * The Linux page may be spanned acrros multiple Xen page, although
+	 * The Linux page may be spanned across multiple Xen page, although
 	 * it's not possible to have a mix of local and foreign Xen page.
 	 * Furthermore, range_straddles_page_boundary is already checking
 	 * if buffer is physically contiguous in the host RAM.


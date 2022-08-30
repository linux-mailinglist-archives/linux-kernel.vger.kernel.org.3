Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878C85A5D0E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbiH3HfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiH3HfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:35:14 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDDFDF70
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:35:11 -0700 (PDT)
X-QQ-mid: bizesmtp65t1661844901tradk075
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 30 Aug 2022 15:34:56 +0800 (CST)
X-QQ-SSF: 01000000000000B0C000000A0000000
X-QQ-FEAT: xqT8U4SkSphcffoQ/Ktudj7WzE2yp8c105dcbz4IGCxq29X5QrqWOCWIjvN+z
        ayHFYdex1QRZzi3RTz0dxWxz7tLCBR3mgOEsI8Tx/+g1edaKpPr9FR0R4E9DeHLBeTOgLvA
        GLBTqEvfT1TveS82foHHEqriafq0gcCTA0AaEybmQR7Lmh9Wb+Vw/yJIejn8Px+kp7x5hE7
        iPxWSixs75wM04+y7G3copojLS0hQHIHGx091vDVYAERi4TusLfdc6Qd3qJjP+SXmsHmgUz
        zWe/HE1PRDlRz9n3sRywr7lvusy1DJ4WeoMKqbTvIkDiiXybssCavCW96vCjBZWRO+8gm/R
        0vCnHxs0TmL8wDgUWlUTSwRLO7G9pzhDztAaGtsIhUaX1A3feY=
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] mm: Fix double word in comments
Date:   Tue, 30 Aug 2022 03:34:55 -0400
Message-Id: <20220830073455.9094-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix double word "page page" in comments.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 arch/arm/mm/copypage-xscale.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/copypage-xscale.c b/arch/arm/mm/copypage-xscale.c
index bcb485620a05..591325a21f41 100644
--- a/arch/arm/mm/copypage-xscale.c
+++ b/arch/arm/mm/copypage-xscale.c
@@ -5,7 +5,7 @@
  *  Copyright (C) 1995-2005 Russell King
  *
  * This handles the mini data cache, as found on SA11x0 and XScale
- * processors.  When we copy a user page page, we map it in such a way
+ * processors.  When we copy a user page, we map it in such a way
  * that accesses to this page will not touch the main data cache, but
  * will be cached in the mini data cache.  This prevents us thrashing
  * the main data cache on page faults.
-- 
2.35.1


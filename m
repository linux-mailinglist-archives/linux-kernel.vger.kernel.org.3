Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBB458FDF7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 16:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbiHKOAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 10:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbiHKOAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 10:00:17 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BD8B6B;
        Thu, 11 Aug 2022 07:00:13 -0700 (PDT)
X-QQ-mid: bizesmtp85t1660226400t8djmn6w
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 11 Aug 2022 21:59:59 +0800 (CST)
X-QQ-SSF: 01000000002000G0V000B00A0000020
X-QQ-FEAT: STiaxnIrALifAWJvhe4y7QQ5bwysnwrZVhewo0Pfx1+xFcf/1ndCeIuVWDNe2
        qnnw3rda2scOBLI6rOWj3fGJkZwZPqT4Ds/h1usJoERTcnc7imb7DW2j3/IZkAyInlbcn5S
        Lu+o7FpfbuEhIMzGvSx+tmjrV7Vi6C0Ctojv12bJImn+d8XKVLLs1fxfliGbpBenZ1DTF9l
        1KyRqKucHoJKHQR28333hYBHtzpbUifIilwdfHoHmTEuFnlBf8f64/flIpfbF9ZJYffubMi
        hURasZ+MOejxJhZdmejDX92AOO3pA+vcucn6811h6hLvxY4OXbP8bGEu1U44tBgncxcs8vQ
        v88Pbl14Yp4rMSIRoSSKztHMS7iErLOGIusW+YQ+U4ctNAiK/mPaZRwcNEHJpNwZzUN9b1T
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     deller@gmx.de
Cc:     James.Bottomley@HansenPartnership.com,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] parisc: ccio-dma.c: Fix comment typo
Date:   Thu, 11 Aug 2022 21:59:53 +0800
Message-Id: <20220811135953.27950-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `was' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/parisc/ccio-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/parisc/ccio-dma.c b/drivers/parisc/ccio-dma.c
index 9be007c9420f..e863eb648379 100644
--- a/drivers/parisc/ccio-dma.c
+++ b/drivers/parisc/ccio-dma.c
@@ -268,7 +268,7 @@ static int ioc_count;
 *   Each bit can represent a number of pages.
 *   LSbs represent lower addresses (IOVA's).
 *
-*   This was was copied from sba_iommu.c. Don't try to unify
+*   This was copied from sba_iommu.c. Don't try to unify
 *   the two resource managers unless a way to have different
 *   allocation policies is also adjusted. We'd like to avoid
 *   I/O TLB thrashing by having resource allocation policy
-- 
2.36.1


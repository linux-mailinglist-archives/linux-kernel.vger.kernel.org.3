Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40927587C46
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 14:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236899AbiHBMUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 08:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237023AbiHBMTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 08:19:46 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9676750071
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 05:19:37 -0700 (PDT)
X-QQ-mid: bizesmtp75t1659442760t7id9jse
Received: from kali.lan ( [125.69.43.47])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 02 Aug 2022 20:19:19 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000020
X-QQ-FEAT: mRz6/7wsmIjOpqUv9p5BmJfQ5grfCh2SJgC4OIMsQ9wLpVj+IhLvwjontnaU4
        rumjNrDYPzcZunJhz3uuxe8NrFDcvfAdPSuJuxuYOjUHjr6h6zoDmzhO61diOs74ma8nC7b
        VzWsc8ilLrXW4q7JP7LJpn5lnV/4xuKJJEI5CyyDUHlR12ATpyPCGx6rDWoatAc1GeVyw94
        HIB0dBahCFtI3NpN16BbMw7jKg/hm5UyDraQHaHgSORGRhS0WbVg2ExvmEX1mHxDEACg3TJ
        km9hTkzKFlcTYGqjvFWLktElz7ejAyedsvUt7RH68j76s0mpDhlFt73wDeDN3KGr/EJP143
        lnV1JGm8VMall8UVQJrQ85UU1GwPaIqSyISDALZkfO46IRHLT79Pb0Z5SYU0mA2rO/fVx1C
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     vishal.l.verma@intel.com
Cc:     dan.j.williams@intel.com, dave.jiang@intel.com,
        ira.weiny@intel.com, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] nvdimm/namespace: Fix comment typo
Date:   Wed,  3 Aug 2022 04:19:18 +0800
Message-Id: <20220802201918.8408-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RDNS_NONE,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `existing' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/nvdimm/namespace_devs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index dfade66bab73..c60ec0b373c5 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -385,7 +385,7 @@ static resource_size_t init_dpa_allocation(struct nd_label_id *label_id,
  *
  * BLK-space is valid as long as it does not precede a PMEM
  * allocation in a given region. PMEM-space must be contiguous
- * and adjacent to an existing existing allocation (if one
+ * and adjacent to an existing allocation (if one
  * exists).  If reserving PMEM any space is valid.
  */
 static void space_valid(struct nd_region *nd_region, struct nvdimm_drvdata *ndd,
-- 
2.35.1


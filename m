Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95B158BA11
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 09:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbiHGHk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 03:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiHGHkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 03:40:24 -0400
Received: from bg5.exmail.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD20626E1
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 00:40:22 -0700 (PDT)
X-QQ-mid: bizesmtp90t1659858006tyl24yln
Received: from localhost.localdomain ( [182.148.15.41])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 07 Aug 2022 15:39:57 +0800 (CST)
X-QQ-SSF: 0100000000200040B000B00A0000000
X-QQ-FEAT: Ix4jrH1osPwSfnRcbmbAbEHyn46kFc7mesZS/C98ukIj45MHfWO694bXYAN+B
        zYcfYcXpYIItAdoTLfN8geAGaNDwlkl276OZvGYcyQ7Tq9uEeJ9cMKNyOtiL9MrHbRfeEJ7
        nsB0lHEU57+BqDzLyvu9rsZy6XE40s2zkxN76z+kM3FANGpUUnq5GjN6AivFZ5l7DfiF4d9
        Fxs3trisU1VVbIxCAZIf6vQPscL8pEZ4caWZJ9AH7VM9PiuSjs4F8yRG+pzvwhfy4BzzFln
        sbPlsXA+OY3cBgdOxoCJcwcIB25kZ8NaWdoMwb6tOe4CbMvLG7AJWtpLLPEz+J1b8GvaUkU
        qcgB3xq20lW8szt7EzpZFAba988I6WegbJ3Vp5eEcOwFqYf75VG4zOYIK2CHA==
X-QQ-GoodBg: 0
From:   shaomin Deng <dengshaomin@cdjrlc.com>
To:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] tools/testing/nvdimm: Fix typo in comments
Date:   Sun,  7 Aug 2022 03:39:55 -0400
Message-Id: <20220807073955.5556-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the repeated word "from" in comments.

Signed-off-by: shaomin Deng <dengshaomin@cdjrlc.com>
---
 tools/testing/nvdimm/test/nfit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index c75abb497a1a..1694b89aa4a3 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -59,7 +59,7 @@
  * *) The first portion of dimm0 and dimm1 are interleaved as REGION0.
  *    A single PMEM namespace "pm0.0" is created using half of the
  *    REGION0 SPA-range.  REGION0 spans dimm0 and dimm1.  PMEM namespace
- *    allocate from from the bottom of a region.  The unallocated
+ *    allocate from the bottom of a region.  The unallocated
  *    portion of REGION0 aliases with REGION2 and REGION3.  That
  *    unallacted capacity is reclaimed as BLK namespaces ("blk2.0" and
  *    "blk3.0") starting at the base of each DIMM to offset (a) in those
-- 
2.35.1


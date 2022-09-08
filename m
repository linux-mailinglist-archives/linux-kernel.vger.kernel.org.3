Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FB15B1DD7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiIHNDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiIHNDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:03:43 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E269BD5700;
        Thu,  8 Sep 2022 06:03:41 -0700 (PDT)
X-QQ-mid: bizesmtp79t1662642156tspq0fel
Received: from localhost.localdomain ( [182.148.14.0])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 08 Sep 2022 21:02:35 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: xqT8U4SkSphxglenF3k2bqXozjf3d5MHDrSli2VYeA9+TjNEa+EjhBXGYRSx9
        +WTZE3XNwzFqgKl6kPULQhfHSpW7u7X7gpbSI0JYdzaurB2RVFQk58UEDelXIretHmR3zmO
        FyvbLfk1AoFkZ8WwQL+wq5B+h3jyFcux5oHZXKPAv5C20M3uq7TS/s4UZK94sLyLiBydi/3
        tI6GOQu7t6QvXdFLUttQ4rSDZ4hSQIovXDD+062zU5Ny0416jo9bm2gnZvrLoufqGsUu53J
        u0TqDloIjKYTdLKTHFhekvQ0+PvR7vsmwXfYVtJgYy1ZAJINu8b8rne5E7++xNg8jn+Q19+
        4i+au2EvhUcchWh2uZ9YOEUb/26ckTGIya4N9Msqc5u6RcjYAQcXCNAG9PWww==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     kartilak@cisco.com, sebaddel@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] scsi/snic: fix repeated words in comments
Date:   Thu,  8 Sep 2022 21:02:13 +0800
Message-Id: <20220908130213.32075-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_PBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'to'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/scsi/snic/snic_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/snic/snic_debugfs.c b/drivers/scsi/snic/snic_debugfs.c
index 57bdc3ba49d9..a03493ca1e87 100644
--- a/drivers/scsi/snic/snic_debugfs.c
+++ b/drivers/scsi/snic/snic_debugfs.c
@@ -362,7 +362,7 @@ void snic_stats_debugfs_init(struct snic *snic)
  *
  * Description:
  * When Debufs is configured this routine removes debugfs file system
- * elements that are specific to to snic stats
+ * elements that are specific to snic stats
  */
 void
 snic_stats_debugfs_remove(struct snic *snic)
-- 
2.36.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE98057FEB8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 14:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbiGYMDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 08:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbiGYMDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 08:03:06 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B319186C5;
        Mon, 25 Jul 2022 05:03:01 -0700 (PDT)
X-QQ-mid: bizesmtp62t1658750576trgg8haf
Received: from localhost.localdomain ( [171.217.48.70])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 25 Jul 2022 20:02:30 +0800 (CST)
X-QQ-SSF: 0100000000200050H000000A0000020
X-QQ-FEAT: Xr3l1UkvC/aFfYnrLnL9gmj4ixHPv8ux1uSqhGqsqeAbmTsdvkHGxokM33OF4
        eEwie8WHRMYN+gKtfnACdfS0bwTs4WMR6NowGRKX7MVjgAPydTCbHDR7P0ahDY60OmIQ0DD
        IBodpNUOA6RQDUdCf55nCQNk5VSzdUdOezorvactxzQtANdNpVAy5kG/NuWoyi9b72cg6hi
        2lF+dPT5p/5t/13318aLGWqYOpnAzWWM2H7pMBI8n6yACVW52Lts5VmEiNFfNHECX8ook3Z
        vUIP6swyExqd/Ue2cXmDkS9Iujcd+8f4pVxotDE8309vhiKxzr8lYwjOdJZVZ3GfMOXslkI
        GmTTqL670WolCNh8w0HqSsGO8yjQjuIh3PGMePsnPHKlPwPB4N5P7Ahj7tTOA==
X-QQ-GoodBg: 0
From:   min tang <tangmin@cdjrlc.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        min tang <tangmin@cdjrlc.com>
Subject: [PATCH] scsi: Fix comment typo
Date:   Mon, 25 Jul 2022 20:02:27 +0800
Message-Id: <20220725120227.2626-1-tangmin@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `are' is duplicated in line 1229, remove one.

Signed-off-by: min tang <tangmin@cdjrlc.com>
---
 drivers/scsi/scsi_error.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index cdaca13ac1f1..dececd2a2b91 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -1226,7 +1226,7 @@ scsi_eh_action(struct scsi_cmnd *scmd, enum scsi_disposition rtn)
  * @done_q:	Queue for processed commands.
  *
  * Notes:
- *    We don't want to use the normal command completion while we are are
+ *    We don't want to use the normal command completion while we are
  *    still handling errors - it may cause other commands to be queued,
  *    and that would disturb what we are doing.  Thus we really want to
  *    keep a list of pending commands for final completion, and once we
-- 
2.17.1


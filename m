Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3097566364
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 08:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiGEGtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 02:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiGEGtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 02:49:05 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FB9CE96;
        Mon,  4 Jul 2022 23:49:04 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 201531E80D71;
        Tue,  5 Jul 2022 14:47:00 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PSh9Bqo4HVPQ; Tue,  5 Jul 2022 14:46:57 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: jiaming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 0B1671E80D19;
        Tue,  5 Jul 2022 14:46:57 +0800 (CST)
From:   Zhang Jiaming <jiaming@nfschina.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, renyu@nfschina.com,
        Zhang Jiaming <jiaming@nfschina.com>
Subject: [PATCH] scsi: ncr53c8xx: Fix spelling mistakes in comments
Date:   Tue,  5 Jul 2022 14:48:57 +0800
Message-Id: <20220705064857.14662-1-jiaming@nfschina.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix spelling of is'nt in comments.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
---
 drivers/scsi/ncr53c8xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ncr53c8xx.c b/drivers/scsi/ncr53c8xx.c
index 4458449c960b..b8b1a365355a 100644
--- a/drivers/scsi/ncr53c8xx.c
+++ b/drivers/scsi/ncr53c8xx.c
@@ -2638,7 +2638,7 @@ static	struct script script0 __initdata = {
 }/*-------------------------< RESEL_TAG >-------------------*/,{
 	/*
 	**	Read IDENTIFY + SIMPLE + TAG using a single MOVE.
-	**	Aggressive optimization, is'nt it?
+	**	Aggressive optimization, isn't it?
 	**	No need to test the SIMPLE TAG message, since the 
 	**	driver only supports conformant devices for tags. ;-)
 	*/
@@ -3191,7 +3191,7 @@ static	struct scripth scripth0 __initdata = {
 	**	We must send it again all the messages.
 	*/
 	SCR_SET (SCR_ATN), /* Shall be asserted 2 deskew delays before the  */
-		0,         /* 1rst ACK = 90 ns. Hope the NCR is'nt too fast */
+		0,         /* 1rst ACK = 90 ns. Hope the NCR isn't too fast */
 	SCR_JUMP,
 		PADDR (send_ident),
 }/*-------------------------< CLRATN_GO_ON >-------------------*/,{
-- 
2.34.1


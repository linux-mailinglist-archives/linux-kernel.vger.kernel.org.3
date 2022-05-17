Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A0152AD9A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 23:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiEQVjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 17:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiEQVjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 17:39:42 -0400
X-Greylist: delayed 388 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 17 May 2022 14:39:38 PDT
Received: from mail.wantyapps.xyz (unknown [IPv6:2001:19f0:5:305f:5400:3ff:fe88:abd4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF02A42480
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 14:39:38 -0700 (PDT)
Received: from localhost (bzq-79-183-83-88.red.bezeqint.net [79.183.83.88])
        by mail.wantyapps.xyz (Postfix) with ESMTPSA id 416AF7D632;
        Tue, 17 May 2022 21:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wantyapps.xyz;
        s=mail; t=1652823189;
        bh=77TXRvsh7hWaErTGymOW8BHXjkBr9MyPIBb/1lV4nz4=;
        h=From:To:Cc:Subject:Date:From;
        b=pMNaTGFYXkBbzqBR4ubjPKA7zfgD4zYfUvj1SE7As1PbnFh7XB3Owi4Rs34pL8+ay
         1v5gDAaSI00IEEWLkGRjq56Z8HGATGDr4Rx1HQNh8tA9q1T+SDs6E1tPnHoqoiAqmt
         iq5ZUPecBIv9YV+AiqnevFZHeU8WqKRZAm5s6cav5W0+z8ImBXqHt6UI4t8yARG+V6
         qqPoICzto2NMz9j4EMTUAE3wX8f9m28VD8wElew1fIT+fl90SPmz+VtR+pdbM2lpon
         QGLOk8q1nObTij2r6PZNYVxIteRbphoErZRwGExyw1SCw+9r0G8rtIcFnSgtsv5YFQ
         3+lx1sMlvg0vg==
From:   Uri Arev <me@wantyapps.xyz>
Cc:     Uri Arev <me@wantyapps.xyz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: axis-fifo: fix indentation according to checkpatch.pl
Date:   Wed, 18 May 2022 00:33:01 +0300
Message-Id: <20220517213302.671148-1-me@wantyapps.xyz>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,PDS_OTHER_BAD_TLD,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(My first patch!)

scripts/checkpatch.pl warned about an indentation problem in
the axix-fifo.c file.

Checkpatch warning:
	CHECK: Alignment should match open parenthesis

Signed-off-by: Uri Arev <me@wantyapps.xyz>
---
 drivers/staging/axis-fifo/axis-fifo.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index dfd2b357f484..51ce48e68e27 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -383,10 +383,10 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 		 */
 		mutex_lock(&fifo->read_lock);
 		ret = wait_event_interruptible_timeout(fifo->read_queue,
-			ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
-				 (read_timeout >= 0) ?
-				  msecs_to_jiffies(read_timeout) :
-				  MAX_SCHEDULE_TIMEOUT);
+						       ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
+								(read_timeout >= 0) ?
+								 msecs_to_jiffies(read_timeout) :
+								 MAX_SCHEDULE_TIMEOUT);
 
 		if (ret <= 0) {
 			if (ret == 0) {
@@ -526,11 +526,11 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
 		 */
 		mutex_lock(&fifo->write_lock);
 		ret = wait_event_interruptible_timeout(fifo->write_queue,
-			ioread32(fifo->base_addr + XLLF_TDFV_OFFSET)
-				 >= words_to_write,
-				 (write_timeout >= 0) ?
-				  msecs_to_jiffies(write_timeout) :
-				  MAX_SCHEDULE_TIMEOUT);
+						       ioread32(fifo->base_addr + XLLF_TDFV_OFFSET)
+								>= words_to_write,
+								(write_timeout >= 0) ?
+								 msecs_to_jiffies(write_timeout) :
+								 MAX_SCHEDULE_TIMEOUT);
 
 		if (ret <= 0) {
 			if (ret == 0) {
-- 
2.36.1


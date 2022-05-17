Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C9452AE20
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 00:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiEQW1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 18:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiEQW1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 18:27:35 -0400
X-Greylist: delayed 3261 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 17 May 2022 15:27:33 PDT
Received: from mail.wantyapps.xyz (unknown [66.135.5.160])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5434ECF7
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 15:27:33 -0700 (PDT)
Received: from localhost (bzq-79-183-83-88.red.bezeqint.net [79.183.83.88])
        by mail.wantyapps.xyz (Postfix) with ESMTPSA id 758997D63E;
        Tue, 17 May 2022 22:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wantyapps.xyz;
        s=mail; t=1652826451;
        bh=pd6Vee+X5bKnfkJoQvuv34sp7wFRIFqhfKwqf22xJJE=;
        h=From:To:Cc:Subject:Date:From;
        b=cuxxKNrIYB+sbARwoyzCbW2VM8FAjR+hQgkceYmIpqe4rZZDjvYuo5bxABWkx8LUc
         VrQgIaJ5hgv58AvoAY/ouXv28gmZDHD3s4KJ8CleUZpyyhL5EtK/ma+WsuENP2P0Tj
         PpFWhKg5zpIKnxD2ePWdACHDCwYbpLXNZT5+vcn4QqYEDKgRlCJbVB2NTkPhxXdsaE
         znffAar84pz6SOYYjsl4Rubz/genEvSAMXsscdJSfVQRhBEybNGUWf9kZsDkIObukk
         fYXDnY52A4FN58lX700DcwqVfRyEkT8bTQPF0rt02XU+gnhKxpAP0aSu9DJ6I6B+wh
         WHDwhkI0ipSmA==
From:   Uri Arev <me@wantyapps.xyz>
Cc:     Uri Arev <me@wantyapps.xyz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: axis-fifo: fix indentation according to checkpatch.pl
Date:   Wed, 18 May 2022 01:27:09 +0300
Message-Id: <20220517222710.678033-1-me@wantyapps.xyz>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,PDS_OTHER_BAD_TLD,RDNS_DYNAMIC,SPF_HELO_PASS,
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
the axis-fifo.c file.

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


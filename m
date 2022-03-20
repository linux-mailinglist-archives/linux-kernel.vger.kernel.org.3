Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FEB4E199F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 05:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244689AbiCTEZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 00:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239729AbiCTEZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 00:25:09 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AED312A9A
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 21:23:45 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id jo24so1850854qvb.5
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 21:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jhlV91ifQAUPW5Se8C3/lqG0qPR8p3g2utUbCEWboO0=;
        b=WBz1/kTJ2ypHPEsIYv8F3KK9hQ7D9UFfHUXFyi9fKSbJLE5fTuf/LZ6rUERk3wRsbg
         1yjR7l+Krktuj3y6uM6J6XJOGbFzd4WHZp9EdLEFaPBcYmoTpg8xtPOA5shm6YPJPcm8
         sk/kPJ/UFFjCLudJG/mloDxWHuLrI4Exyh7iB0DJGwepB89+I7r/yuQS0ZcmfxxEnokk
         m6Ozed4ULIMdY1I5EoxMM24RAd1p+yX16GkjilScS92qNNHdGjDRilxRmudPiPVd1HrD
         pCcIxl0gu4Ssq+JXI8A5v6/l6R2pCFYkoGsPqkl1KnUX/CAzGbK10907BQA9OHUUAp7q
         7tiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jhlV91ifQAUPW5Se8C3/lqG0qPR8p3g2utUbCEWboO0=;
        b=TcmyIBIy3kprTp3o1KXjewsHqHmTWBDzMoB1AI1ixIY9kmk7MiohDB81beNgEq+HfW
         BcRzEQSK0+CbihShygO9bUBe22AiI07WBbJsuNUkSAkguhaol4DHECG6/2ssn1ONUtK0
         L2cyCJZnZhP0u1Yggm5zyh6MJPsllfHWWQv1E0LofiZhRfTWPKORnmEbSGZg2wz4zFB8
         6ymhNLK8/JMdw7L1FgqQrCszwIaEabcOPzt5ZMJxcrhpOTOcb/FZ4RxrwF3Gk5Q34Gu4
         mjul4zIjB7be8yxK56eyX9ByKfgyxgV8CRw4JBnYKgZrLLS87hUGF6g+KYkAAVXRnHRD
         LWMQ==
X-Gm-Message-State: AOAM530kdXNOABeZ0raNCOzRLhQfhusOxTw6HLGnNiPA+HHc8jbAhOdj
        QrTWkLK7o4ivRttz8kRniHM=
X-Google-Smtp-Source: ABdhPJxlG6nL/g9YxYseZBTdJyktbe5yYMMIqnD3PBoEAh+c7Xoioxj6d11GSE7Q6a9q56nTPzSqKw==
X-Received: by 2002:ad4:404b:0:b0:440:dee0:4ab3 with SMTP id r11-20020ad4404b000000b00440dee04ab3mr11837169qvp.129.1647750223396;
        Sat, 19 Mar 2022 21:23:43 -0700 (PDT)
Received: from localhost.localdomain ([159.223.186.39])
        by smtp.gmail.com with ESMTPSA id c3-20020ac87d83000000b002e1d1b3df15sm9036463qtd.44.2022.03.19.21.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 21:23:43 -0700 (PDT)
From:   "Ryan C. England" <rcengland@gmail.com>
To:     gregkh@linuxfoundation.com
Cc:     lee.jones@linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Ryan C. England" <rcengland@gmail.com>
Subject: [PATCH 2/2] staging: axis-fifo: Fixed parenthesis styling issues
Date:   Sun, 20 Mar 2022 04:23:40 +0000
Message-Id: <20220320042340.49222-1-rcengland@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed open parenthesis alignment issues.

Signed-off-by: Ryan C. England <rcengland@gmail.com>
---
 drivers/staging/axis-fifo/axis-fifo.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index dfd2b357f484..4720d6f877bc 100644
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
+						       (read_timeout >= 0) ?
+						       msecs_to_jiffies(read_timeout) :
+						       MAX_SCHEDULE_TIMEOUT);
 
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
+						       >= words_to_write,
+						       (write_timeout >= 0) ?
+						       msecs_to_jiffies(write_timeout) :
+						       MAX_SCHEDULE_TIMEOUT);
 
 		if (ret <= 0) {
 			if (ret == 0) {
-- 
2.27.0


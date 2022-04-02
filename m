Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBA44F02CE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 15:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354033AbiDBNqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 09:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353026AbiDBNqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 09:46:12 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4FBD61385BE
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 06:44:18 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.31:55616.477137328
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id D041D1002A6;
        Sat,  2 Apr 2022 21:44:14 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-b7fbf7d79-bwdqx with ESMTP id b3a587eefe364da59d7e4dc97f1ad336 for sumit.semwal@linaro.org;
        Sat, 02 Apr 2022 21:44:15 CST
X-Transaction-ID: b3a587eefe364da59d7e4dc97f1ad336
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
From:   Sui Jingfeng <15330273260@189.cn>
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/dma-buf: dma-buf.c: fix a typo
Date:   Sat,  2 Apr 2022 21:44:13 +0800
Message-Id: <20220402134413.1705246-1-15330273260@189.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Sui Jingfeng <15330273260@189.cn>
---
 drivers/dma-buf/dma-buf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index df23239b04fc..775d3afb4169 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -443,7 +443,7 @@ static struct file *dma_buf_getfile(struct dma_buf *dmabuf, int flags)
  *    as a file descriptor by calling dma_buf_fd().
  *
  * 2. Userspace passes this file-descriptors to all drivers it wants this buffer
- *    to share with: First the filedescriptor is converted to a &dma_buf using
+ *    to share with: First the file descriptor is converted to a &dma_buf using
  *    dma_buf_get(). Then the buffer is attached to the device using
  *    dma_buf_attach().
  *
-- 
2.25.1


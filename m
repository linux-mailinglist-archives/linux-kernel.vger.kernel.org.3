Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0ABA57E024
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbiGVKjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 06:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiGVKjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 06:39:05 -0400
Received: from mail-m971.mail.163.com (mail-m971.mail.163.com [123.126.97.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1CF2BA25E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 03:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=fqUdU
        Xy2Zl+4byASQwJhIwAl4pdCqQHryxYw/Ms9mSA=; b=Eyi2/WQ/ALILiYaCIRo7r
        tayd+7/VtyhuOpsjAtL9H9/HWu0rrejwTPbX1JHzV3AVxJ8fC1reheSmlhjsSEzL
        vPXQBdahfO4gNSecwVW8HYXcP/IRy1I/voeRZVU0DOthXnA0L/dHp/zVtnRym4Q1
        B2T7p+Nxk030xcBC7CzPFg=
Received: from localhost.localdomain (unknown [112.97.59.29])
        by smtp1 (Coremail) with SMTP id GdxpCgA3VsZAftpiwt0xPw--.1381S2;
        Fri, 22 Jul 2022 18:38:57 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     lenb@kernel.org
Cc:     linux-kernel@vger.kernel.org, Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] tools/power: Fix typo 'the the' in comment
Date:   Fri, 22 Jul 2022 18:38:55 +0800
Message-Id: <20220722103855.83049-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GdxpCgA3VsZAftpiwt0xPw--.1381S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWUXFW7CF4xWFW7uF1UAwb_yoW3Jrc_Wa
        4xtw18KrWrX340kF1vkry7uFyxWayxWr4DJF13Cry7Z3WktanYya4UGrZrA3W5ur4Ut39r
        uryDJFs8Z3WfKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sREJ3kDUUUUU==
X-Originating-IP: [112.97.59.29]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCdQlGZGBbEb4EsAAAs+
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'the the' with 'the' in the comment.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index ede31a4287a0..ad4c9b79c051 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5398,7 +5398,7 @@ void print_dev_latency(void)
 }
 
 /*
- * Linux-perf manages the the HW instructions-retired counter
+ * Linux-perf manages the HW instructions-retired counter
  * by enabling when requested, and hiding rollover
  */
 void linux_perf_init(void)
-- 
2.25.1


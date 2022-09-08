Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03755B1DA0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbiIHMt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiIHMtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:49:55 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF6C275E7;
        Thu,  8 Sep 2022 05:49:53 -0700 (PDT)
X-QQ-mid: bizesmtp63t1662641385to0nxmnw
Received: from localhost.localdomain ( [182.148.14.0])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 08 Sep 2022 20:49:44 +0800 (CST)
X-QQ-SSF: 0100000000200090C000B00A0000000
X-QQ-FEAT: D6RqbDSxuq7qPSDf6UWuqsfd/jAQQms76FllP7hnZVszsvX5KpVHi3+Y6mBVU
        UxDcfkdWpnJPj1ghtf/wwTDwVfhzKnhfOWndYOXch4RSzlrJ5rVeySUsv8KHqDNcANBFUAg
        y2rLltN9yi01G2fyWKPmmr/SS+dDEOH8DotL58tQMLZKzmOFeZnl3ktar9kVVXh3qkqJmvj
        L3UaXmUcFIKhrjiZ7j+cbs3ma0WXU+GTzVQerbBZLhw3YcVzVZLWerfqdFS3/VFnlvEthw4
        i/nKIODJZRFcDGVZi2jXTszX5ah0DjA09ycymKeMArOiKuwB/mECuIpmzUVTvYJ3r6OXUK/
        irlSUwRpf0fT1qjWtKb5OGAg51ErNAJOcEY056ywLJLlp9ZEJoy5nWoGr/+uQ==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     damien.lemoal@opensource.wdc.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] drivers/ata: fix repeated words in comments
Date:   Thu,  8 Sep 2022 20:49:37 +0800
Message-Id: <20220908124937.25962-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'in'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/ata/libata-eh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 7c128c89b454..ca865a95cf24 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -863,7 +863,7 @@ void ata_eh_fastdrain_timerfn(struct timer_list *t)
  *
  *	Set ATA_PFLAG_EH_PENDING and activate fast drain if @fastdrain
  *	is non-zero and EH wasn't pending before.  Fast drain ensures
- *	that EH kicks in in timely manner.
+ *	that EH kicks in timely manner.
  *
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
-- 
2.36.1


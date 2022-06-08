Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A5C5430FA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 15:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239890AbiFHNE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 09:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239855AbiFHNE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 09:04:57 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C4E23356D;
        Wed,  8 Jun 2022 06:04:51 -0700 (PDT)
X-QQ-mid: bizesmtp63t1654693458t6gkyl6p
Received: from localhost.localdomain ( [111.9.5.115])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 08 Jun 2022 21:04:10 +0800 (CST)
X-QQ-SSF: 01000000002000C0H000B00A0000000
X-QQ-FEAT: q6FcPYdgG0j/KN8E2vfhBxbKRMPS7A5j1h6d5+w82C+Q9RY6OwevC8v+SOEsR
        hSrpBsYYlHOn0tiiwyBZInY5KYN8uMsA7Kxkx6geiZp2JZIb9VFd8TrzrONdMMqhAeA1cv3
        Uid2dJcuPjXzkxNjvm/KodYXo3y4wY72tcOfc3E7fXLJ6QC9O9ty9ioqm3Y4pfjj3Aqf/NU
        Uo5G9SFRClH02HXoI7qdMK4n+KMtjaA0aHcuqHqXDKtJF2Evi5NhhxQKZBWaEoDLAnnjNij
        /V20LuLZg4xBqZ0P3wU2aiiAG1aB8wuxfTEOTinCxNEmCNXaFfrhfypvpZMajP8fAB9LgKd
        KsSyIt3wnyjz/xbCks=
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     bjorn.andersson@linaro.org
Cc:     mathieu.poirier@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] remoteproc: omap_remoteproc: Fix typo in comment
Date:   Wed,  8 Jun 2022 21:04:06 +0800
Message-Id: <20220608130406.46005-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'The'.
Delete the redundant word 'to'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 drivers/remoteproc/omap_remoteproc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
index 32a588fefbdc..430fab0266ed 100644
--- a/drivers/remoteproc/omap_remoteproc.c
+++ b/drivers/remoteproc/omap_remoteproc.c
@@ -243,7 +243,7 @@ static inline int omap_rproc_get_timer_irq(struct omap_rproc_timer *timer)
  * omap_rproc_ack_timer_irq() - acknowledge a timer irq
  * @timer: handle to a OMAP rproc timer
  *
- * This function is used to clear the irq associated with a watchdog timer. The
+ * This function is used to clear the irq associated with a watchdog timer.
  * The function is called by the OMAP remoteproc upon a watchdog event on the
  * remote processor to clear the interrupt status of the watchdog timer.
  */
@@ -303,7 +303,7 @@ static irqreturn_t omap_rproc_watchdog_isr(int irq, void *data)
  * @configure: boolean flag used to acquire and configure the timer handle
  *
  * This function is used primarily to enable the timers associated with
- * a remoteproc. The configure flag is provided to allow the driver to
+ * a remoteproc. The configure flag is provided to allow the driver
  * to either acquire and start a timer (during device initialization) or
  * to just start a timer (during a resume operation).
  *
@@ -443,7 +443,7 @@ static int omap_rproc_enable_timers(struct rproc *rproc, bool configure)
  * @configure: boolean flag used to release the timer handle
  *
  * This function is used primarily to disable the timers associated with
- * a remoteproc. The configure flag is provided to allow the driver to
+ * a remoteproc. The configure flag is provided to allow the driver
  * to either stop and release a timer (during device shutdown) or to just
  * stop a timer (during a suspend operation).
  *
-- 
2.36.1


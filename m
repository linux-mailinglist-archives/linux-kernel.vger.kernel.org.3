Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397A65A2554
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245604AbiHZKCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245723AbiHZKB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:01:29 -0400
Received: from smtpout140.security-mail.net (smtpout140.security-mail.net [85.31.212.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39F96F25A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:01:26 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by fx409.security-mail.net (Postfix) with ESMTP id 4CD483236F2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 12:01:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1661508085;
        bh=vvFfyIzVOt+FBtDJHEyLUs+N/uAy6HQNA/KHZSgA5D8=;
        h=From:To:Cc:Subject:Date;
        b=CgwopXANpNqyg6YtzA3SripPIjrvnzTiWBwNLhmQi1z17QQipQAAN0OOnGqotm9vM
         qZIEfaXtms72/nlexVIA1VfhqJR1TU2onBpUWChj97llbhBVP1xxl/K2sgiy1McZVT
         vjkTtdRQftjGmZTikoDKP8QAr0j9ewyhWFjBzysQ=
Received: from fx409 (localhost [127.0.0.1])
        by fx409.security-mail.net (Postfix) with ESMTP id B3E8032363E;
        Fri, 26 Aug 2022 12:01:24 +0200 (CEST)
X-Virus-Scanned: E-securemail
Secumail-id: <5a32.630899f3.d3b51.0>
Received: from zimbra2.kalray.eu (unknown [217.181.231.53])
        by fx409.security-mail.net (Postfix) with ESMTPS id D5B9B3238AC;
        Fri, 26 Aug 2022 12:01:23 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTPS id B5F5827E02FA;
        Fri, 26 Aug 2022 12:01:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 9E51827E0392;
        Fri, 26 Aug 2022 12:01:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 9E51827E0392
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1661508083;
        bh=M/RfIAISD7kAlTMJPp9AUX7+0n4u8J4cxKaRTfK45Jk=;
        h=From:To:Date:Message-Id;
        b=gGI6sadZ5EwB55pMsAHuFLe/ZLEWEaWS4jmEeGy0Rmcwx+BoKeK03zXymXKatxl1k
         fRH59Y5+Lr3wmydZI3NheomjaQMBJ6lnxwbltN2ev4tkacOWA2dbES6H3oi0aN9Aq4
         6uv9RGDeLEML9faz7OvFYcqcrgPRhvuN+sGXtlnA=
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wanPIDXbM-ba; Fri, 26 Aug 2022 12:01:23 +0200 (CEST)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id 8CED527E02FA;
        Fri, 26 Aug 2022 12:01:23 +0200 (CEST)
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Jules Maselbas <jmaselbas@kalray.eu>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        linux-media@vger.kernel.org
Subject: [PATCH] media: platform: ti: Fix repeated word in comments
Date:   Fri, 26 Aug 2022 12:00:46 +0200
Message-Id: <20220826100052.22945-18-jmaselbas@kalray.eu>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: by Secumail
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant word `the`.

CC: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
CC: linux-media@vger.kernel.org
Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
---
 drivers/media/platform/ti/davinci/vpbe.c | 2 +-
 drivers/media/platform/ti/omap3isp/isp.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/ti/davinci/vpbe.c b/drivers/media/platform/ti/davinci/vpbe.c
index 5f0aeb744e81..509ecc84624e 100644
--- a/drivers/media/platform/ti/davinci/vpbe.c
+++ b/drivers/media/platform/ti/davinci/vpbe.c
@@ -280,7 +280,7 @@ static int vpbe_set_default_output(struct vpbe_device *vpbe_dev)
  * vpbe_get_output - Get output
  * @vpbe_dev: vpbe device ptr
  *
- * return current vpbe output to the the index
+ * return current vpbe output to the index
  */
 static unsigned int vpbe_get_output(struct vpbe_device *vpbe_dev)
 {
diff --git a/drivers/media/platform/ti/omap3isp/isp.c b/drivers/media/platform/ti/omap3isp/isp.c
index d251736eb420..a6052df9bb19 100644
--- a/drivers/media/platform/ti/omap3isp/isp.c
+++ b/drivers/media/platform/ti/omap3isp/isp.c
@@ -1528,7 +1528,7 @@ void omap3isp_print_status(struct isp_device *isp)
  * To solve this problem power management support is split into prepare/complete
  * and suspend/resume operations. The pipelines are stopped in prepare() and the
  * ISP clocks get disabled in suspend(). Similarly, the clocks are re-enabled in
- * resume(), and the the pipelines are restarted in complete().
+ * resume(), and the pipelines are restarted in complete().
  *
  * TODO: PM dependencies between the ISP and sensors are not modelled explicitly
  * yet.
-- 
2.17.1


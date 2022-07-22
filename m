Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2219557D817
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 03:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbiGVBsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 21:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiGVBsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 21:48:22 -0400
Received: from m12-12.163.com (m12-12.163.com [220.181.12.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9A6D972D8;
        Thu, 21 Jul 2022 18:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=aKN9G
        rPpUB3VkgLNbdmd4hl3W/u3Va2puFbeMm1q2Lc=; b=oJ4WcqIvSCKt2R1gt4m4G
        1WbWKM/70yAgGHRsopJ6ukAn4bbPjCtmZu4OHWN8d2qmCHpmCh5cZeRcf02L1L6z
        2s28J3CjoitgAj9GnQ2jV/20QiM5ob8KeJWnRhYhZmhOmxcQ4sXfBKewjjk60PO8
        zQ1IQhUnbSo+M6c6w6gX0Y=
Received: from localhost.localdomain (unknown [223.104.68.59])
        by smtp8 (Coremail) with SMTP id DMCowADnLMvNAdpiVr1mOw--.510S2;
        Fri, 22 Jul 2022 09:48:00 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] media: dvb-frontends: Fix typo 'the the' in comment
Date:   Fri, 22 Jul 2022 09:47:55 +0800
Message-Id: <20220722014755.63338-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowADnLMvNAdpiVr1mOw--.510S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFyDGw4rurW7Kw47WF15Arb_yoW8Xr15p3
        yDtryI9FZYg3Waqr1kJ3WUWF98tan5XFy0kw17Aan3ZF1fuFy3Xr4DtayUAr13Xa1fGFsF
        q3ZIqry2kwn3tw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRm-e8UUUUU=
X-Originating-IP: [223.104.68.59]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbivxBFZFWB0jZ7sQACs2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'the the' with 'the' in the comment.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/media/dvb-frontends/tda1002x.h | 2 +-
 drivers/media/dvb-frontends/tda10048.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/dvb-frontends/tda1002x.h b/drivers/media/dvb-frontends/tda1002x.h
index 60a0952c1bca..00491bea9975 100644
--- a/drivers/media/dvb-frontends/tda1002x.h
+++ b/drivers/media/dvb-frontends/tda1002x.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
     TDA10021/TDA10023  - Single Chip Cable Channel Receiver driver module
-			 used on the the Siemens DVB-C cards
+			 used on the Siemens DVB-C cards
 
     Copyright (C) 1999 Convergence Integrated Media GmbH <ralph@convergence.de>
     Copyright (C) 2004 Markus Schulz <msc@antzsystem.de>
diff --git a/drivers/media/dvb-frontends/tda10048.c b/drivers/media/dvb-frontends/tda10048.c
index d1d206ebdedd..0b3f6999515e 100644
--- a/drivers/media/dvb-frontends/tda10048.c
+++ b/drivers/media/dvb-frontends/tda10048.c
@@ -1118,7 +1118,7 @@ struct dvb_frontend *tda10048_attach(const struct tda10048_config *config,
 		state->pll_pfactor = 0;
 	}
 
-	/* Establish any defaults the the user didn't pass */
+	/* Establish any defaults the user didn't pass */
 	tda10048_establish_defaults(&state->frontend);
 
 	/* Set the xtal and freq defaults */
-- 
2.25.1


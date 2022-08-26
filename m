Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A6D5A2549
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245703AbiHZKCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245547AbiHZKBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:01:30 -0400
Received: from smtpout140.security-mail.net (smtpout140.security-mail.net [85.31.212.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CD19C1EB
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:01:27 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by fx601.security-mail.net (Postfix) with ESMTP id 1BB4C3ACEC9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 12:01:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1661508086;
        bh=FL2kL4VkOcbIIUP2+DJXexnRiRjPgLGKb2H7npN08ME=;
        h=From:To:Cc:Subject:Date;
        b=TvaOt7OA3K9FyOOposSPENC9vKGCsJDIaRzZdAvwvr1hdi0MWCDtAmgEfeHegJOzL
         dBLagupYNN8DTCWYKAOzd1lsCdsUOk7+GO7hgxMh4yL4TX3oAJuK9Vr+T6NO/+Kuna
         zjy3Z/2dbC0cKUDn7pNxC/+rpdNf6E7FGW3Qj1Kk=
Received: from fx601 (localhost [127.0.0.1])
        by fx601.security-mail.net (Postfix) with ESMTP id 751563ACEC2;
        Fri, 26 Aug 2022 12:01:25 +0200 (CEST)
X-Virus-Scanned: E-securemail
Secumail-id: <598d.630899f4.90da8.0>
Received: from zimbra2.kalray.eu (unknown [217.181.231.53])
        by fx601.security-mail.net (Postfix) with ESMTPS id 9236E3ACC21;
        Fri, 26 Aug 2022 12:01:24 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTPS id 730A327E0396;
        Fri, 26 Aug 2022 12:01:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 5C3AC27E0392;
        Fri, 26 Aug 2022 12:01:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 5C3AC27E0392
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1661508084;
        bh=ZLOui77VJF4L/AKDWT1oLYTzZXXPuvwmiFMUZzsMKvs=;
        h=From:To:Date:Message-Id;
        b=By68bO5vWjYlzD3JnnLoRhl1dphlaJ27E4JIwa4yF9VCycgxjaekVF76xEOCdp5nu
         Yh+u4mfI+ybN6hYEt/fxQtAdE+KxfXBBPImU8A0JsHRQFtYXyonz+OrbiYH2oSjcls
         psxfge5b2+O+fcxTpONDKB13LBiPM6Tpw4aTvSec=
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id e5VH8Q9L9fKg; Fri, 26 Aug 2022 12:01:24 +0200 (CEST)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id 4CB1227E02FA;
        Fri, 26 Aug 2022 12:01:24 +0200 (CEST)
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Jules Maselbas <jmaselbas@kalray.eu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: [PATCH] media: dvb-frontends: Fix repeated word in comments
Date:   Fri, 26 Aug 2022 12:00:47 +0200
Message-Id: <20220826100052.22945-19-jmaselbas@kalray.eu>
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

Remove redundant words `the` and `this`.

CC: Mauro Carvalho Chehab <mchehab@kernel.org>
CC: linux-media@vger.kernel.org
Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
---
 drivers/media/dvb-frontends/dib8000.c  | 2 +-
 drivers/media/dvb-frontends/tda1002x.h | 2 +-
 drivers/media/dvb-frontends/tda10048.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/dvb-frontends/dib8000.c b/drivers/media/dvb-frontends/dib8000.c
index d67f2dd997d0..25980e90d6bf 100644
--- a/drivers/media/dvb-frontends/dib8000.c
+++ b/drivers/media/dvb-frontends/dib8000.c
@@ -3212,7 +3212,7 @@ static int dib8000_tune(struct dvb_frontend *fe)
 
 	case CT_DEMOD_STEP_6: /* (36)  if there is an input (diversity) */
 		if ((state->fe[1] != NULL) && (state->output_mode != OUTMODE_DIVERSITY)) {
-			/* if there is a diversity fe in input and this fe is has not already failed : wait here until this this fe has succedeed or failed */
+			/* if there is a diversity fe in input and this fe is has not already failed : wait here until this fe has succedeed or failed */
 			if (dib8000_get_status(state->fe[1]) <= FE_STATUS_STD_SUCCESS) /* Something is locked on the input fe */
 				*tune_state = CT_DEMOD_STEP_8; /* go for mpeg */
 			else if (dib8000_get_status(state->fe[1]) >= FE_STATUS_TUNE_TIME_TOO_SHORT) { /* fe in input failed also, break the current one */
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
2.17.1


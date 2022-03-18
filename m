Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4164DD1E9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 01:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiCRAYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 20:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiCRAYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 20:24:39 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B44619D626;
        Thu, 17 Mar 2022 17:23:21 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b19so9632112wrh.11;
        Thu, 17 Mar 2022 17:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EUZS5i1fz1kAVVM80Oyu7b+mX6O5QtCzcdOhcl/QHOU=;
        b=EqFWZ5eHPSolbx4tQvCZl+Q2JTRB/fXuFH9BjeWTK4jAKAVb6PTRAGug9WAbrk2UXe
         ciaWvoPFO23aVrZKDwXLh059VIvo8btA5iTGOsiW2bAW/1KEePA1VvheichxFgswdqRn
         ikJI2ZoE0tUa8rygZTxkWPLCQhcyf+26XSqsJke/Sd5WZ84as7rQl0MiS81U74hyLc55
         LIu9Gd7JCW3OFke8+RKm0NHtzkFYTyH7lUMNBc5GhizqB808+YBdr/V3oExqSr0E+0Hj
         r6WQ5xNiTg7voZQNAMuySEwlhQiYB/RG+ryBk3GwvUINdPgSgcKPZ50MpS755BveHCRB
         caSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EUZS5i1fz1kAVVM80Oyu7b+mX6O5QtCzcdOhcl/QHOU=;
        b=VO7LFDfK9To/n/jn3zNNigZ0BbzgcahU+0fjBGsxNQ/5G67CbYzSzCEC7yhZSiujRX
         /KHmdFrmL2iktJawpCBl5B0UG91jVO/UZDsLG6OdbVeGkPGs0edXADu8nOThKTjumu9e
         Hp0y2rpP+3N3e6qej8kVhO9u4913jsLnxmnrUjZ/KADg8fgia32KOcRB5wHXGSmGCI4g
         sAG5AqQDl11X97HZZojana24xNBYBvd5dTr8XbHOM0oeMbtMuBsHTBmW1a9UyNYtlnoE
         Lw+EuGhki90i9N68pLVDFNU3zx/5ebLaxDmB8H5ZFoKTqR2FTNerU/cBPUZEeIoOcl/L
         QGqw==
X-Gm-Message-State: AOAM530kQ6fU2m93QfyVE7s9Fsz4opCQ5nD199KR3EtM8mPFcTMqSZKs
        VUpUBFZZr84lbOOIyaYmzdo=
X-Google-Smtp-Source: ABdhPJzDt190+x1gAiJfV2NyyJQ7Ohh8/brsXamRrkHlsLOW2WrvCVh6+ledfezGgCck7Y2vWfM3gw==
X-Received: by 2002:a5d:504d:0:b0:203:e60e:49ef with SMTP id h13-20020a5d504d000000b00203e60e49efmr5835724wrt.546.1647562999664;
        Thu, 17 Mar 2022 17:23:19 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id g13-20020a05600c4ecd00b0038a0165f2fbsm6207260wmq.17.2022.03.17.17.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 17:23:18 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] Input: adi: remove redundant variable z
Date:   Fri, 18 Mar 2022 00:23:18 +0000
Message-Id: <20220318002318.80519-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Variable z is being assigned a value that is never read, the
variable is redundant and can be removed.

Cleans up clang scan build warning:
drivers/input/joystick/adi.c:139:6: warning: Although the
value stored to 'z' is used in the enclosing expression,
the value is never actually read from 'z' [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/input/joystick/adi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joystick/adi.c b/drivers/input/joystick/adi.c
index 592c95b87f54..e10d57bf1180 100644
--- a/drivers/input/joystick/adi.c
+++ b/drivers/input/joystick/adi.c
@@ -123,7 +123,7 @@ static void adi_read_packet(struct adi_port *port)
 {
 	struct adi *adi = port->adi;
 	struct gameport *gameport = port->gameport;
-	unsigned char u, v, w, x, z;
+	unsigned char u, v, w, x;
 	int t[2], s[2], i;
 	unsigned long flags;
 
@@ -136,7 +136,7 @@ static void adi_read_packet(struct adi_port *port)
 	local_irq_save(flags);
 
 	gameport_trigger(gameport);
-	v = z = gameport_read(gameport);
+	v = gameport_read(gameport);
 
 	do {
 		u = v;
-- 
2.35.1


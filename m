Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AFB4EB3D1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 21:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240783AbiC2TDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 15:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbiC2TDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 15:03:34 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C915AE1254;
        Tue, 29 Mar 2022 12:01:50 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n63-20020a1c2742000000b0038d0c31db6eso2083274wmn.1;
        Tue, 29 Mar 2022 12:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R3zMo+uDtp2l+2kaX1Lp74xR1gw/ziE5ozZsnq4hQ8k=;
        b=U+PDa1smVYwC3pwXcJQc790e48a0STXHiJ1Tob4ZhZoOp359ppRiQcIiaruJv4Wonw
         vtGz291Bq4w0J332K00NGOGkTfqExMDhH7mrTif2Ci+lxQZFI47qvSACcVIamsVQKuLs
         /UtkQTP3EyFjF9oFQg5iTDAgeqdbOKGJLcTHCfzi11U5u131O6A7BpsZ5uFkyOd4CkqB
         7W/jshZwoROJnQ/czND4bmqo018rQ5HtLCDsIFC3fWDbNX7e1rIpXsvlC/m0bxguZbNy
         hS0ex9YQURLG4ZwalU3bmxGgm7oOxduNVuQR/7GA9DXN8v5Li/sQ/9qlc+K9sMrWJOE/
         9UaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R3zMo+uDtp2l+2kaX1Lp74xR1gw/ziE5ozZsnq4hQ8k=;
        b=XxKrOpBMW01WB/E18W0vAprExU4UfV8cA0UEMkvl+vNvR13wBUHKO9OgHKHSXMmpFo
         XqU1aZgC+yoJvIOFrreqI+Lr7JVT/YNOGNXmJwSAW1Cndtk0gPC7va8uPkA5Zu1hLHdj
         A4WUlC5ZXq138TalNrtb6wdW4m3XBafSwWNo469yIdf/NP5o+/glwW+3Cv7VIo8OOAjH
         /kAEs4kvgZnWP8I8ZFnwCLsPIjgpFzm07rEloA3Fz5khvUGUv3ymxVEttABPZG40TKud
         Rdjoq7YrP88niOFmyShyyOUiqzGx++StdhvSIhKIFubcxq8Bay6dfADu5el4bFZxEYyQ
         P9Gg==
X-Gm-Message-State: AOAM530PRGwgREVJK7c8rcH6vWR1WXErejJIOY+Ag1sEiJljFo0eNuW5
        pkWq3ZXDHssqfKt9rQZ4i7I=
X-Google-Smtp-Source: ABdhPJztfYohtHoyBbHivKC+K8e7yMSDnLaeZ2arGqm7/qRuJ+I4cwrg3KZKsxzzBqJCb9PiJYomfg==
X-Received: by 2002:a05:600c:1d26:b0:38e:2c97:6f19 with SMTP id l38-20020a05600c1d2600b0038e2c976f19mr916630wms.89.1648580509138;
        Tue, 29 Mar 2022 12:01:49 -0700 (PDT)
Received: from alaa-emad ([41.37.132.115])
        by smtp.gmail.com with ESMTPSA id j16-20020a05600c191000b0038ca3500494sm4884687wmq.27.2022.03.29.12.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 12:01:48 -0700 (PDT)
From:   Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, eng.alaamohamedsoliman.am@gmail.com
Subject: [PATCH] media:av7110:av7110_av.c remove blank line
Date:   Tue, 29 Mar 2022 21:01:33 +0200
Message-Id: <20220329190133.6243-1-eng.alaamohamedsoliman.am@gmail.com>
X-Mailer: git-send-email 2.35.1
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

according to checkpatch.pl results
"CHECK: Please don't use multiple blank lines"
after lines 73 and 78 ,I removed the blank lines

Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
---
 drivers/staging/media/av7110/av7110_av.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/media/av7110/av7110_av.c b/drivers/staging/media/av7110/av7110_av.c
index 91f4866c7e59..1544f120e8b1 100644
--- a/drivers/staging/media/av7110/av7110_av.c
+++ b/drivers/staging/media/av7110/av7110_av.c
@@ -70,12 +70,10 @@
 #define PIECE_RATE	 0x40
 #define SEAM_SPLICE	 0x20
 
-
 static void p_to_t(u8 const *buf, long int length, u16 pid,
 		   u8 *counter, struct dvb_demux_feed *feed);
 static int write_ts_to_decoder(struct av7110 *av7110, int type, const u8 *buf, size_t len);
 
-
 int av7110_record_cb(struct dvb_filter_pes2ts *p2t, u8 *buf, size_t len)
 {
 	struct dvb_demux_feed *dvbdmxfeed = (struct dvb_demux_feed *) p2t->priv;
-- 
2.35.1


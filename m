Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8097D57F7EC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 03:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbiGYBaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 21:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiGYBaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 21:30:04 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C49111477
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 18:30:03 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id t3-20020a17090a3b4300b001f21eb7e8b0so12381848pjf.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 18:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=m1dRgUMuzdI2W6jtj1PDhO4KN+PS8FitydtRUWXc1Q4=;
        b=pvhNpucwy0eK8RytVjzfaFAKXl/n4pGkdpRqDlHjU3GquB9k0+Gqnra+SWuTmPEdGj
         MNpRF6p9S8V5sVJ95vK0ob7kbYIcd4uiUDCYD7AvfkTD7KkiG/tOfpGa+6t5DiLw2dmJ
         EBYV4XLjvGm9OMQIg2Ym1ESDB2c5F3RYxYINcZUfzzh9nBZAzQ80zu8FIQwGTJTqz4On
         H8FXlG1/m0EwAhwId4fDvYfhs/GFMbSKK/cSlIndK/1fzQKaNEntfkWU3Nq/KRDVOimi
         2SV1TBiZfpvsoNYJTL7D2R383vYg18IrS6vZ+T3JcSLCbnF8ZfmsLZrqIxk6IbXDUcmz
         3f8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=m1dRgUMuzdI2W6jtj1PDhO4KN+PS8FitydtRUWXc1Q4=;
        b=JY6PKglEHraxiTG6NQfvAWGHKP2Sp6D6q2pJ1KKzJzEtAT+WkfG3GJNyE6gNCm12c3
         j0GYZzMjW5u1PheLCpBYWdwLOL6sgnC44UgYtoY9pFHDAa87eS5i+5Zx74yPKQDDRPBQ
         9xUqJzHVEoVaJqrrx30cOfdIKcc0BHmvodKYsT9rbyHqN+a/dLUZMCDtkFQWkGxpYTfe
         ctIlOSeBnXRzgo7MlxiO2DAroXYb4uyZlgSYvX6K3GdWrATAvsDmuiwSqltlb35MZrSM
         t6GA7nbXdx7H8W84ee9PeTH+u9lcXhhDyDY1hhfjPGAs8PY4ZEz9W9NA+veWL2WTDdgb
         nXJA==
X-Gm-Message-State: AJIora95e3MapnTtcwUgYABVbnMb+4j/OB8/ZuM5fKTSAHYHh7A8yt5n
        E/HLkETSpWJ73+/Gtz0Un+A=
X-Google-Smtp-Source: AGRyM1sqrwl/QLGKflGlc6ktIh2Qimi+ExeP8Bl7GLA5EnCeztvGDdhuilof5zqr7Kzlf68kf1EMHQ==
X-Received: by 2002:a17:903:2151:b0:16d:2dcf:fa2e with SMTP id s17-20020a170903215100b0016d2dcffa2emr10127394ple.124.1658712602594;
        Sun, 24 Jul 2022 18:30:02 -0700 (PDT)
Received: from localhost.localdomain ([122.172.90.97])
        by smtp.gmail.com with ESMTPSA id p2-20020a17090ab90200b001f0097c2fb2sm7513705pjr.28.2022.07.24.18.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 18:30:02 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     linux@dominikbrodowski.net, tony@atomide.com, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org,
        "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] pcmcia: Removed unused variable control.
Date:   Mon, 25 Jul 2022 06:59:55 +0530
Message-Id: <20220725012955.4928-1-jrdr.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>

Kernel test robot throws below warning ->
drivers/pcmcia/omap_cf.c:127:7: warning: variable 'control'
set but not used [-Wunused-but-set-variable]

Removed unused variable control.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>
---
 drivers/pcmcia/omap_cf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pcmcia/omap_cf.c b/drivers/pcmcia/omap_cf.c
index 1972a8f6fa8e..c96943805f77 100644
--- a/drivers/pcmcia/omap_cf.c
+++ b/drivers/pcmcia/omap_cf.c
@@ -124,7 +124,6 @@ static int omap_cf_get_status(struct pcmcia_socket *s, u_int *sp)
 static int
 omap_cf_set_socket(struct pcmcia_socket *sock, struct socket_state_t *s)
 {
-	u16		control;
 
 	/* REVISIT some non-OSK boards may support power switching */
 	switch (s->Vcc) {
@@ -135,7 +134,6 @@ omap_cf_set_socket(struct pcmcia_socket *sock, struct socket_state_t *s)
 		return -EINVAL;
 	}
 
-	control = omap_readw(CF_CONTROL);
 	if (s->flags & SS_RESET)
 		omap_writew(CF_CONTROL_RESET, CF_CONTROL);
 	else
-- 
2.25.1


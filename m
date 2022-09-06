Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B45F5AEDFC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242217AbiIFOpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242170AbiIFOor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:44:47 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36664B7D7;
        Tue,  6 Sep 2022 07:04:30 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bj14so2354727wrb.12;
        Tue, 06 Sep 2022 07:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=6qmWJOLRR+n4c7sVjdfAUPTsyzenHuuzlHk1wiFMkLo=;
        b=ZghPrPVGnY0NJr9kyqP6SguuWE16ZeTMQr/gX/w075kNfE2vCSEUsM9wCYOyt4I7x0
         NT8mmE5xAnh0QMjkIqiMhXx5raZmDL1WAUa79E/CxRWWK/7+X12M7Gj9RlXsY/i/EQwF
         Z6pMacus3IW/EVkoyRSPivC/U/cJOQ6MBTvT+7CfDR5ojwcw67v/lqlcpbufsn/QY5EZ
         W+uk5qU57YclFrjQaGpZwU6AUt+EMAGM7V90nsWOxAi4CJAmmmyFfgMiGhhQ7dwVMgrj
         VXGVmzCXsEE4xHdWuxy7cYGuQvIj+S9Z8ytbQ9RhbKxKIrMw9N26v6roiecJFyrH/ZLy
         ZF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=6qmWJOLRR+n4c7sVjdfAUPTsyzenHuuzlHk1wiFMkLo=;
        b=XLevXNRF4r3KZfetSxn/ErmxJmZAHlWB0h8HoIigM1OZ8UgMKMYor6uVf1AGhekx1H
         k4BGmV8sflNoJ3V81gpyDpHwrqJ9ibrjKmJ2UrhXPkT0osklBeq15nc7Gvy9I9FmesqS
         CZ967krpAhTZW0OidOP0DndzkSoOVenYYk0SqNljrFlJB7vjFJiVQnNClpJ/clV9m4Be
         Pu02ABlRLVxST7LwreX3Y0FJ0+ke1scVlfP0v/5HFw1cn05O0S/RA8qWASNSlM8wVfOU
         Wbiu+QQbmurWgAtHD+KHFctB2CZGyfjrYkdHNxqz4wnDuIUdAuNrtyES0kAUGfEzCig+
         LzVg==
X-Gm-Message-State: ACgBeo1fYNkpANOBcb0vVa+FRy5j//p1j9l10Ylnr3PdS0S9R57tfeW2
        FHsYNSC0qwT6iW5fgRJNiqQ=
X-Google-Smtp-Source: AA6agR5b6Y7mG/H4/nwWAeRBkvKJP6MTXAPVn9o3Mcv5TE06x6z3xSOGO0zYrMTyGM7YJJ3kVM02iA==
X-Received: by 2002:a5d:458e:0:b0:228:cd6e:dc56 with SMTP id p14-20020a5d458e000000b00228cd6edc56mr3853162wrq.614.1662472995649;
        Tue, 06 Sep 2022 07:03:15 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id h23-20020a05600c2cb700b003a2f2bb72d5sm26239598wmc.45.2022.09.06.07.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 07:03:15 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] thunderbolt: debugfs: Fix spelling mistakes in seq_puts text
Date:   Tue,  6 Sep 2022 15:03:14 +0100
Message-Id: <20220906140314.194565-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.1
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

There are a handful of spelling mistakes in seq_puts text. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/thunderbolt/debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/debugfs.c b/drivers/thunderbolt/debugfs.c
index a1df3a7f159b..834bcad42e9f 100644
--- a/drivers/thunderbolt/debugfs.c
+++ b/drivers/thunderbolt/debugfs.c
@@ -351,7 +351,7 @@ static int margining_caps_show(struct seq_file *s, void *not_used)
 		seq_puts(s, "# hardware margining: no\n");
 	}
 
-	seq_printf(s, "# both lanes simultaneusly: %s\n",
+	seq_printf(s, "# both lanes simultaneously: %s\n",
 		  both_lanes(usb4) ? "yes" : "no");
 	seq_printf(s, "# voltage margin steps: %u\n",
 		   usb4->margining->voltage_steps);
@@ -366,7 +366,7 @@ static int margining_caps_show(struct seq_file *s, void *not_used)
 		seq_puts(s, "# returns high or low voltage margin\n");
 		break;
 	case USB4_MARGIN_CAP_0_VOLTAGE_BOTH:
-		seq_puts(s, "# returns both hight and low margings\n");
+		seq_puts(s, "# returns both high and low margins\n");
 		break;
 	}
 
-- 
2.37.1


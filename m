Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753CE544110
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 03:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbiFIBa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 21:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234804AbiFIBay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 21:30:54 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174CB357F8E;
        Wed,  8 Jun 2022 18:30:51 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id q18so19074433pln.12;
        Wed, 08 Jun 2022 18:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NbcFqWO7j7XREwqzym411oNkBJtnizas0IMJ4blzmdA=;
        b=pJfABryT04hjujSVRrSop31+/1O6kUxJT6iilXPda5zYI2JhKvNwMUHRrLT8XuiRcO
         bYjJO4PDA/K9sJJ3LAPr257pzh+rHPmpKKvtpgA5vP4nRzefh2qIx8ZlsAsPnmSpZkNW
         HFeP01z5c/6pFNVEPeMFN0DpPndqfiGFgfLhtaTcZDZCIxYqlEewLy+ZUrjHsGX6xHnj
         N3l8ZcEMEe5PN1HGeLa3d7FnThfhu/onUGtjaGndu0b5aqlV01xuWxiV5b+bnj5ed4li
         oxSh9YnymgDyGnNKIRkjzOpeSbWPkErFTmTSisD83i7nNDvzf+SN59i1ScDyToywlaSN
         NQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NbcFqWO7j7XREwqzym411oNkBJtnizas0IMJ4blzmdA=;
        b=by3768N8f68A9y5rzH2rCpkLjHz8PmMBn1nwCmhMvmoMBgKkmzgGp39He1c9O258dI
         Y4wncja9FLS+fve/oPP9BR87FpiCLHRfAQHSNDdMbsZPOknK3uuOnh1RtvRw0tO+6YR5
         qy1B2kMm86fCtu9g0rRhdFS/u198H/eDvmHIhgJs4vnlZrDd6gTHe2y7IWktEannbNYT
         qPiD8sbDuP2P4F+5jCZQXfXJ2dJurbC+DQN9nodUJhYe4SZS+AjLhRXokQ1xarusPgNs
         cb1SCAhSBNRyiEQprF6owr+T5FUDgfJ8w7o4MoTNRCiP2juAZZO8ZgCwCFfl1QCS5O9j
         2acw==
X-Gm-Message-State: AOAM532g/74m+3PtDgN74IjHAGlm1fEQ++Wbya8Y/wGOQXt4M+y/jWVY
        iLbWNuuxqDgL+dC+4APNMzM6YcTvHVwDAf7Gz5dQfg==
X-Google-Smtp-Source: ABdhPJymgEIFYdVi7qbpayUVn4kKLEWaHeD93CkKHc4vPn/3wLdkAHwcBmblk2fbE92ObydZzs7qeA==
X-Received: by 2002:a17:90b:4d90:b0:1e3:3025:66fe with SMTP id oj16-20020a17090b4d9000b001e3302566femr827364pjb.145.1654738250915;
        Wed, 08 Jun 2022 18:30:50 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id jj19-20020a170903049300b00164097a779fsm283114plb.147.2022.06.08.18.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 18:30:49 -0700 (PDT)
From:   luoxueqin <luoxueqin66@gmail.com>
X-Google-Original-From: luoxueqin <937225041@qq.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luo Xueqin <luoxueqin@kylinos.cn>
Subject: [PATCH -next] watchdog:Fix typo in comment
Date:   Thu,  9 Jun 2022 09:30:11 +0800
Message-Id: <20220609013011.54175-1-937225041@qq.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luo Xueqin <luoxueqin@kylinos.cn>

Spelling mistake in comment.

Signed-off-by: Luo Xueqin <luoxueqin@kylinos.cn>
---
 drivers/watchdog/pc87413_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/pc87413_wdt.c b/drivers/watchdog/pc87413_wdt.c
index 9f9a340427fc..c7f745caf203 100644
--- a/drivers/watchdog/pc87413_wdt.c
+++ b/drivers/watchdog/pc87413_wdt.c
@@ -442,7 +442,7 @@ static long pc87413_ioctl(struct file *file, unsigned int cmd,
 	}
 }
 
-/* -- Notifier funtions -----------------------------------------*/
+/* -- Notifier functions -----------------------------------------*/
 
 /**
  *	pc87413_notify_sys:
-- 
2.25.1


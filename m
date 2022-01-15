Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D055948F6AA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 13:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiAOMPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 07:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiAOMPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 07:15:21 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AACC061574;
        Sat, 15 Jan 2022 04:15:21 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id s30so39304215lfo.7;
        Sat, 15 Jan 2022 04:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MiI6w/5hjGm8XCjU8jAMKhntd2/3CYQYixb5tgCZxjk=;
        b=CeyE0801M0KpLNHCzVoqXTm2Frz2DrWLvnPo3pSAHER2j7hrEEZzMsWG4oNp7A/k2g
         d2ASBR1M6c1FBBRbA6R9G2xsYh78uyPdjQMHrrYmABJkkkINsxlKNUY66Bxf8Q2Ft2O0
         RFbuhuE/EGk3BpYv+B9fBX6iZLfwXeIWiMqP7iarQ4eMnoClmjQ4KyqvX4fIIJu6c/Zp
         uGx1whXcgRKMM3dvaULqAG/C/A85rvWODGrqgC7eQ24wDM98htbaJ3Sl8zgffTxBKfYP
         Ztv28Bc2L4S5zWts6RHLtpnleDFb0RI8mP/UO0MV5Plnv4CIoLuxY9ACcdiv2xKeD9fD
         WJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MiI6w/5hjGm8XCjU8jAMKhntd2/3CYQYixb5tgCZxjk=;
        b=XV58DQfBhxdAeDy8f4McOKRIhh+IOzHZd6eu7cM0yLXpTeAlVUaf8iiDAznxOsUPnU
         5nG/Mh0DRFqtkTcfj4SODdBrql7+7fWPA3Hilwvg9OMRlIt6lQgH32rGK1DKNdWVRZiJ
         L8Jy4t2jKQivdAr/SxtjOTHjOL1ZIK0TuWQz4M7/CMEZ4w+KwsHJWCRnEUBL5Mk9GT5K
         u033JFOYnu/9MidJSoxIKBvNuaGeJuO/7zClaaiE9A9tYbpA8SNdHYIxPW9s0P6BxjLV
         otCdofU9KJwcOj8OGlxbeP1MPQ4I1bQP6jnCUQMGQCHL5m3aGN6BEmbxzSJ+yl1rtUNn
         zR3g==
X-Gm-Message-State: AOAM533rB5hylOG65IzR2mO9miWGZuxtNWk4dOOXLlzTptDqGWLEUZAZ
        R9DfVKNmNtftCYV9guUX3zhE99ovvLE=
X-Google-Smtp-Source: ABdhPJz+e3krenSKInYFF0ag/d0FsplQIFrqq+iAzDuyxzck504BYNPsVOHY2J0czhPA98rYRhwOnA==
X-Received: by 2002:a2e:8447:: with SMTP id u7mr9655087ljh.530.1642248919765;
        Sat, 15 Jan 2022 04:15:19 -0800 (PST)
Received: from localhost.localdomain ([2a05:3580:f312:6c01:1b6d:df4d:cbec:e4a2])
        by smtp.gmail.com with ESMTPSA id q1sm851989lfa.216.2022.01.15.04.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jan 2022 04:15:19 -0800 (PST)
From:   Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc:     Arnaud Ferraris <arnaud.ferraris@gmail.com>,
        Andrey Skvortsov <andrej.skvortzov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Avri Altman <avri.altman@wdc.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Huijin Park <huijin.park@samsung.com>,
        =?UTF-8?q?Christian=20L=C3=B6hle?= <CLoehle@hyperstone.com>,
        Yue Hu <huyue2@yulong.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: core: Wait for command setting 'Power Off Notification' bit to complete
Date:   Sat, 15 Jan 2022 15:14:46 +0300
Message-Id: <20220115121447.641524-1-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SD card is allowed to signal busy on DAT0 up to 1s after the
CMD49. According to SD spec (version 6.0 section 5.8.1.3) first host
waits until busy of CMD49 is released and only then polls Power
Management Status register up to 1s until the card indicates ready to
power off.

Without waiting for busy before polling status register sometimes card
becomes unresponsive and system fails to suspend:

  [  205.907459] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
  [  206.421274] sunxi-mmc 1c0f000.mmc: data error, sending stop command
  [  206.421321] sunxi-mmc 1c0f000.mmc: send stop command failed
  [  206.421347] mmc0: error -110 reading status reg of PM func
  [  206.421366] PM: dpm_run_callback(): mmc_bus_suspend+0x0/0x74 returns -110
  [  206.421402] mmcblk mmc0:aaaa: PM: failed to suspend async: error -110
  [  206.437064] PM: Some devices failed to suspend, or early wake event detected

Tested with Sandisk Extreme PRO A2 64GB on Allwinner A64 system.

Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
---
 drivers/mmc/core/sd.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index e223275bbad1..842b886bdd4e 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -66,7 +66,7 @@ static const unsigned int sd_au_size[] = {
 		__res & __mask;						\
 	})
 
-#define SD_POWEROFF_NOTIFY_TIMEOUT_MS 2000
+#define SD_POWEROFF_NOTIFY_TIMEOUT_MS 1000
 #define SD_WRITE_EXTR_SINGLE_TIMEOUT_MS 1000
 
 struct sd_busy_data {
@@ -1663,6 +1663,13 @@ static int sd_poweroff_notify(struct mmc_card *card)
 		goto out;
 	}
 
+	/* Find out when the command is completed. */
+	err = mmc_poll_for_busy(card, SD_POWEROFF_NOTIFY_TIMEOUT_MS, false,
+				MMC_BUSY_EXTR_SINGLE);
+
+	if (err)
+		goto out;
+
 	cb_data.card = card;
 	cb_data.reg_buf = reg_buf;
 	err = __mmc_poll_for_busy(card->host, SD_POWEROFF_NOTIFY_TIMEOUT_MS,
-- 
2.34.1


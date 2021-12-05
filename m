Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8FA4688B1
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 01:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhLEA0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 19:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhLEA0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 19:26:11 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2708C061751;
        Sat,  4 Dec 2021 16:22:44 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id c4so14012221wrd.9;
        Sat, 04 Dec 2021 16:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8WvnHvP5Xh5zEZuwYzlSuOSILzoaAjIl1mg5Ih9vLFg=;
        b=EAAvKcrVXVAALdtMA8FFuOs4mAPjRxdQ0Wz7pqiUeT1h93jqY2j7LMW6AaE9wufNz7
         N6eM6+bv2P2qrDJcvGswWXSwnzfkp4g4EnFiyWqQb9sVv0pMo4+7f0BHtxAi+yDP/qy9
         VKTY7yIBXzY3NroFHnJrIylRxTJceqNK0m+Anp7B+TKQUzQEC8sBXVCq0e/Hr4D4LLs+
         gxEYW2ChBDhIh8HmJ9sSTQWKIY2lPtpbLatk53qiogpJ60QmYPwVXRV+kXzPo//0Nc0A
         iz19OkxuviFBqWcjuajPfGCbdcUVK6eCSzYOJLpeTFDqI/fMgamFA5OeFv2E4APji+NC
         hjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8WvnHvP5Xh5zEZuwYzlSuOSILzoaAjIl1mg5Ih9vLFg=;
        b=vDk5cO6wISdkVklCAJbrwQn+A+nWaCODyVQvzyWWXeF8LT/mGda0iXaOPw3NwL2ohA
         IHjVSFNPmZ+zNH0/UfhXTgfVH0SQlfOEdfdE2z+Jbyv1oobkeUBIdd8MuUeQdmL8pf0K
         haf2rwd78zOymtL2pFqR1rg/TtJUpkMfCVvEX6bwo0prxG0GNkpjPsNWBOaSE7C5vMk9
         UCdN16r6sc0eQC2aECH2+eVOSM9CFa7XmXVhYXI9Q5wom2ZOGfgAvYZMyN4eQay4G79W
         x0eaav/MCYZaJx/ZGrQvQxEZNuUC0vRRR9VeHJOZaV1eeU50lWV/r2cK3J/EuEuITQ/X
         PcSw==
X-Gm-Message-State: AOAM5301CzF8t0+W4k5SYfBGMeAEzqp2Ys5X0SSOVodNPX+jNtyWLCBD
        MkqTMf93GabeXP8B6EjEZTDg7oBKUlujng==
X-Google-Smtp-Source: ABdhPJyMXPmWprMR6uuyVjokyNQWqpV/DA5jlV67129FrIOIuzDXSydHlQT/sDZc12mztOE4DMA8qw==
X-Received: by 2002:a5d:4ccc:: with SMTP id c12mr32804357wrt.453.1638663763373;
        Sat, 04 Dec 2021 16:22:43 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id l8sm10517430wmc.40.2021.12.04.16.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 16:22:43 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     prabhakar.csengg@gmail.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: davinci: remove redundant assignment to pointer common
Date:   Sun,  5 Dec 2021 00:22:42 +0000
Message-Id: <20211205002242.202769-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointer common is being assigned a value in a for-loop and the pointer
is never read afterwards. The assignment is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/media/platform/davinci/vpif_capture.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/davinci/vpif_capture.c b/drivers/media/platform/davinci/vpif_capture.c
index aba105fa7ef9..8fe55374c5a3 100644
--- a/drivers/media/platform/davinci/vpif_capture.c
+++ b/drivers/media/platform/davinci/vpif_capture.c
@@ -1467,7 +1467,6 @@ static int vpif_probe_complete(void)
 	for (k = 0; k < j; k++) {
 		/* Get the pointer to the channel object */
 		ch = vpif_obj.dev[k];
-		common = &ch->common[k];
 		/* Unregister video device */
 		video_unregister_device(&ch->video_dev);
 	}
-- 
2.33.1


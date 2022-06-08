Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE84542263
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiFHFHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 01:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiFHFHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:07:04 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FB738C090
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 19:04:00 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id y69so12511894oia.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 19:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EfN+xmO5HEHNw9kDgXvrcd+sdptDLYv5NOEy2D1EBJA=;
        b=bMHzfw/mm/MBc6+X8i7fRm6xf6xKEbKM8KsbDKtZz1Z0IcY5jHkQzD85mF5EcE9vek
         B4B1y6p9YKR8QdC0dc/kGraqPQ1isYwZlXB+nEiAXFQFejqHedgLcAOP+tfx2zqoAb6Y
         JA9IsEVXbI1XV0kC3Ni3t03Ru7MtiWwB4UT0HHNA4KHJma3xuUsk4VpPvNH4+Dyt/JML
         ScTRd5IqXDLqUYv2owJQIu477dL29zLcshUKteXYtji60raXfn7A/M76gL8IS9MJqOMV
         aqhFwuQVzHfP8vGlqrtIZjrKlDqklPhASm4NHQ9H2O4g/UHjXRj/EsJytbdthCOCu9m1
         mfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EfN+xmO5HEHNw9kDgXvrcd+sdptDLYv5NOEy2D1EBJA=;
        b=zr/LiU9bW1NFHhkA+Vvkj1vu8tuihVP5AQ5N8SnkGC2h+6AYEs++wqlRPG4plWtrTz
         SioRs06e22OATQe2/6uau++cTT3vY953W5YVmn7ArvkiD7GrOxQEvfwHy5cWsmLz1FZ7
         dBYGnD8yUkuqrVtFXaJpKkqpLI0czer5BMV9ddN4FUWIsoszJL4vHiOXixDdiL0kWXZ/
         7KIQ5qFEY5mhi/Sbu0XKzzWsuJcULmHgttVFjv2+3N5TdnsU3p4OvMuU7eGw/L0jA/lo
         IMDyB4HZfzRV9Xeqp+Yw6G91v6N3VBCHCZpQNappQBdZfpMw4f7cgOlcmLp392qdUUOP
         HHXQ==
X-Gm-Message-State: AOAM531H9pWdI3NPkAsEejqAdp4LzXd6emIX+Ng21tO02DLMQApUMLL1
        7mjb2Rt9osxxHcNFjSCFNCLo+0j3s7h7Jg==
X-Google-Smtp-Source: ABdhPJzCTYzm7dq0pCbAK9GXHdfaJV7jG4EWrDyaZxHeEac8jL4V7FEOkKJmUZoVM3HtS7Mv8nabwA==
X-Received: by 2002:aca:7c6:0:b0:32e:5138:9044 with SMTP id 189-20020aca07c6000000b0032e51389044mr1132955oih.198.1654653830520;
        Tue, 07 Jun 2022 19:03:50 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id bk18-20020a0568081a1200b0032e642674dfsm6987620oib.9.2022.06.07.19.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 19:03:49 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel-edp: Add LQ140M1JW48 edp panel entry
Date:   Tue,  7 Jun 2022 19:06:14 -0700
Message-Id: <20220608020614.4098292-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add panel identification entry for the Sharp LQ140M1JW48 eDP panel.

Due to lacking documentation, a delay similar to those for the
LQ140M1JW46 numbers are picked for now.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index c96014464355..fe3897b86665 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1860,6 +1860,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('K', 'D', 'B', 0x0624, &kingdisplay_kd116n21_30nv_a010.delay, "116N21-30NV-A010"),
 	EDP_PANEL_ENTRY('K', 'D', 'B', 0x1120, &delay_200_500_e80_d50, "116N29-30NK-C007"),
 
+	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1511, &delay_200_500_e50, "LQ140M1JW48"),
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1523, &sharp_lq140m1jw46.delay, "LQ140M1JW46"),
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x154c, &delay_200_500_p2e100, "LQ116M1JW10"),
 
-- 
2.35.1


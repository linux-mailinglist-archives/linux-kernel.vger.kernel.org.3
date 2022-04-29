Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256F651531D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 20:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379846AbiD2SEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 14:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiD2SET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 14:04:19 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5A786E33;
        Fri, 29 Apr 2022 11:01:01 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id q23so11775371wra.1;
        Fri, 29 Apr 2022 11:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kwQwtR8Oa7bR+n2zK/7E32nJYLiZTZEmGGHscOLXyGg=;
        b=omW4ZgNy3/eRtdMQX8jV0vHYKuikLSy/pjGklKPyktIR3Op8rhe25cBdCRhn2QLg6G
         tolziYACJvJKqVxSLXiJ/CVYDj9EdJWiIKSCfkJ0w/kD/v8jlaUmtvo5TQrb/355Vd8P
         zTFyi62DxQ2O3fgqT+ikw1unEpXCip02UU5mh2DWoAZuDaqg5Cj182s4p+jG/5khKQAR
         G/LLHH5/cbRAf5WCi9jXfgDsWiIxtXMecyQ70EGGibHC7Vu+odSNPRl0IRVFZHKAnOZL
         h3g0Nx/Wpu8F0X8H2VdyzaSOZL2uAE3mVDy7eaoXI+3zlIhwtc2bXoHHAuTs5M87ZUtX
         vFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kwQwtR8Oa7bR+n2zK/7E32nJYLiZTZEmGGHscOLXyGg=;
        b=Vrd/E/lLav8L0dZGzLQoKX3OHpqMbRNiHg9Lpbria0luMz4ysyFcLG/dqVOn4WJacU
         XoH+BKzCMwkJ9RCWmlzGP+MeTBlJqVyLy6jrj19lI2XqcSc/yXdUjsOHRJdoFzECsS95
         fSuh+j+qZSJMM90nR2zibkL7OJHQGG9JG9H6fDyRPLaJ0UYGH2PVjFa3rhiOPO4uQg50
         SU41qCYFHCj1og7h71VRNcIwRfV7KEfnIVUSm7hJ2CViT2g7OUL+FU7szIJw0C36+6fZ
         UL+pzbE/7cG46FlOymrVLTp0pw+5w/j3tMECgjIpAq+iz2O6KMFt8krYyIyTZQNrS57G
         dJ0A==
X-Gm-Message-State: AOAM532AHjG+Xs6DOmSpt8XgG2mhAy7a39LzjtT+08WDWHiA6SwxTN4Z
        kfM9FKLNuQOMimZnFZkrKlY=
X-Google-Smtp-Source: ABdhPJyojKtW+Lvnm5YqDhEX45F4uXf5KSoPl4PhvF828tf3rDJwWkjJ0zVderhj/1i5vb1y0rhebA==
X-Received: by 2002:adf:b613:0:b0:20a:c7db:3ce4 with SMTP id f19-20020adfb613000000b0020ac7db3ce4mr269389wre.70.1651255259533;
        Fri, 29 Apr 2022 11:00:59 -0700 (PDT)
Received: from xws.localdomain (pd9e5acba.dip0.t-ipconnect.de. [217.229.172.186])
        by smtp.gmail.com with ESMTPSA id s30-20020adf979e000000b0020adfb1292fsm3041309wrb.16.2022.04.29.11.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 11:00:58 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/surface: gpe: Add support for Surface Pro 8
Date:   Fri, 29 Apr 2022 20:00:49 +0200
Message-Id: <20220429180049.1282447-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.36.0
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

The new Surface Pro 8 uses GPEs for lid events as well. Add an entry for
that so that the lid can be used to wake the device. Note that this is a
device with a keyboard type-cover, where this acts as the "lid".

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/surface_gpe.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/surface/surface_gpe.c b/drivers/platform/surface/surface_gpe.c
index c1775db29efb..ec66fde28e75 100644
--- a/drivers/platform/surface/surface_gpe.c
+++ b/drivers/platform/surface/surface_gpe.c
@@ -99,6 +99,14 @@ static const struct dmi_system_id dmi_lid_device_table[] = {
 		},
 		.driver_data = (void *)lid_device_props_l4D,
 	},
+	{
+		.ident = "Surface Pro 8",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Surface Pro 8"),
+		},
+		.driver_data = (void *)lid_device_props_l4B,
+	},
 	{
 		.ident = "Surface Book 1",
 		.matches = {
-- 
2.36.0


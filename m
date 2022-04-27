Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425785112EB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359131AbiD0Hzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244093AbiD0Hza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:55:30 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7A788B3F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:52:20 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id t13so938234pfg.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2rvDZbBDA6+4uzAH76fZ3kFLE9a9v7X2eun+8bu8ABA=;
        b=nv8hZjQmc8nZqur1WSfPeCGh+4kLRik3Jg/Yw1w3vnxKTtVx5b5tQ88WzojPqYrk8E
         hoHAJSF/edDeWyP6H8COsaZ5D3uXuyq9KchcE9WnBe4itmWQc27tkA2XqtBI4c6fU9r6
         OpjNOWrFuTY02shGKHPG+JZOvMgcf2T2TIAJzCXzbPlTlTEpkBsKUodAVI8cH/j0/maq
         Y888rO1kOAvkpbUZt+9mRVwgbyHNX5cdrewIAKEfRTjblnzPyzggwkpR7/2tAW4bvwNG
         XmU4Eh7ADBlpggWDX/S3FroMTNN+HZsKg+Crt+9hGbQinPM7F98gMbjUuU3c4LXqujGj
         6Ceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2rvDZbBDA6+4uzAH76fZ3kFLE9a9v7X2eun+8bu8ABA=;
        b=nicsJa3d8RNLEXqIeQOeIDzwymRmSX9vySnLKW8cAvEOjRu+8106c3O7C/QEuE97sC
         kq1pNdydnbaFJdqY9miqaor3AtWqw81uwbIe3nO6aR4ObWfDG/TS0XD8viS/wkalxKdk
         diU7Xj5VOB+i7trdDwvCykpPWPvHOq8W+ZODg8zAKu4n54Z/j0SJjty+O3DZUM3uPcxk
         Df67q9lLgOJbp1Zy1aSHeKY0bFLoXVgNmdpDoxlNvHJbwwvP0T/qPkH1hWVGcB28cYfL
         2/de9TA9AqynBm4UwcQjhewYMJP9K2dJvfOxULma57xJ4tY3bxEt58v4a8f7gtvSnTOr
         vxpw==
X-Gm-Message-State: AOAM531ld01tuT5p/5Vj92am5D8Kqr8A5PsytG6M3VtVHFPKkMWQ542B
        xqMPOIpnheVSUMv4kaQc1Bc=
X-Google-Smtp-Source: ABdhPJzfx2BmKTDhlgtytFet1cDd0UztmeYh3uEPYkybXAyku50I3+aeY/pWrPpK8/PvIxXUPFbnJw==
X-Received: by 2002:aa7:9852:0:b0:50d:6d10:2094 with SMTP id n18-20020aa79852000000b0050d6d102094mr4133485pfq.4.1651045939843;
        Wed, 27 Apr 2022 00:52:19 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id m11-20020a17090a71cb00b001cd4989feebsm5671738pjs.55.2022.04.27.00.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 00:52:19 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     lee.jones@linaro.org, orsonzhai@gmail.com, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: sprd: change the device_id data order
Date:   Wed, 27 Apr 2022 15:52:12 +0800
Message-Id: <20220427075212.3409407-1-gengcixi@gmail.com>
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

From: Cixi Geng <cixi.geng1@unisoc.com>

Ordered with the smallest number at the top.

Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 drivers/mfd/sprd-sc27xx-spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
index cf4f89114ae4..d05a47c5187f 100644
--- a/drivers/mfd/sprd-sc27xx-spi.c
+++ b/drivers/mfd/sprd-sc27xx-spi.c
@@ -240,15 +240,15 @@ static int sprd_pmic_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(sprd_pmic_pm_ops, sprd_pmic_suspend, sprd_pmic_resume);
 
 static const struct of_device_id sprd_pmic_match[] = {
-	{ .compatible = "sprd,sc2731", .data = &sc2731_data },
 	{ .compatible = "sprd,sc2730", .data = &sc2730_data },
+	{ .compatible = "sprd,sc2731", .data = &sc2731_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sprd_pmic_match);
 
 static const struct spi_device_id sprd_pmic_spi_ids[] = {
-	{ .name = "sc2731", .driver_data = (unsigned long)&sc2731_data },
 	{ .name = "sc2730", .driver_data = (unsigned long)&sc2730_data },
+	{ .name = "sc2731", .driver_data = (unsigned long)&sc2731_data },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, sprd_pmic_spi_ids);
-- 
2.25.1


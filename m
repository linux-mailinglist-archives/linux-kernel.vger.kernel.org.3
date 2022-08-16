Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A0A59588E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbiHPKhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234704AbiHPKgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:36:35 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BC3BC96;
        Tue, 16 Aug 2022 01:58:56 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t22so9197050pjy.1;
        Tue, 16 Aug 2022 01:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=UV497+nq9aRZ6EHD8/12Y71WbNxm7+fRZfBRKqrBQwM=;
        b=CQoQ8WFq7aduitDEdmjUkyykiF1V1Q40rxJ6zyuzNCuJ7Xu0CDc+RMhO1m3ehYAgdy
         wVMlVAakJKiadX6VSivL79hJriVdtS8XHoTHYi4DZeh3Aqla1eiO6Os0BejcmJ+xJC93
         lrw0gEC8B1HHQOxGSMBoD2IXv0LjmUzT8l3vrhF7aYLs0F+XB0Kj2TAWj6qz23l4zZ/T
         7mC+i1TTPI4/EVDVjtW3HtETDG/jOjk1kp+m1tdCaHUqMN7zu6hy7PNzfsvyuTZEEpJe
         6Wz8Hjae39X2ErNk38HqXXftFUeIZHlSCVrrbZQh5za9q9/wzEKCSP4oWhNo0eh8eL0Z
         QN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=UV497+nq9aRZ6EHD8/12Y71WbNxm7+fRZfBRKqrBQwM=;
        b=VH9Jd8vUCXE/BH0Tu5lT3Nohxj+iWDJLeOiS5zNt06O4fQQ3P55Ksj2BrGu/zyrfyR
         umiHMGWDUrwlwegz6K8X1XamGGCHAhCppCb9ORVYk7Jtu6Wq/BtbbdUK30/yD04uDDUV
         Le54BeRW2cfKXiVCajEdC9rMrImcGQoQ459ro7Dk4IRebgWdBiNaKCklPPNPj+j6CZfa
         XhJw/nU5n8Ys8F4h68gwJGk8AIEMM9PwdRpaoVgew973MNx9k/xeyUDg8naf8/bYKLT0
         7lXK9lwk9NSLtel8+7hdBNFh9Jtyj/PY3wdXJ6Ifgquq2W5LRPCEx0b4sEN3rf5f/5Q+
         N0xA==
X-Gm-Message-State: ACgBeo31+e8U/TMmZOUTXrAIx2A0RWDaXO0VSZb3ZgBR+e2pChcWJOgR
        WSD/MkyWco8DLQ+/B8tIjn8=
X-Google-Smtp-Source: AA6agR6h4VsRwPE0IQM4jMyBWSUeeD40gs80UzAbpro2X2WbTUDtRikbrK3DGxrU6kDvw7MrxB0zsw==
X-Received: by 2002:a17:90b:390c:b0:1f5:5bbc:2e8 with SMTP id ob12-20020a17090b390c00b001f55bbc02e8mr32891611pjb.233.1660640336247;
        Tue, 16 Aug 2022 01:58:56 -0700 (PDT)
Received: from localhost.localdomain ([129.227.148.126])
        by smtp.gmail.com with ESMTPSA id x1-20020a17090300c100b00170a8973137sm8446285plc.17.2022.08.16.01.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 01:58:55 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     narmstrong@baylibre.com, mchehab@kernel.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        bin.liu@mediatek.com, matthias.bgg@gmail.com,
        m.szyprowski@samsung.com, andrzej.hajda@intel.com
Cc:     linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH] media: platform: fix some double free in meson-ge2d and mtk-jpeg and s5p-mfc
Date:   Tue, 16 Aug 2022 16:58:19 +0800
Message-Id: <20220816085819.39108-1-hbh25y@gmail.com>
X-Mailer: git-send-email 2.25.1
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

video_unregister_device will release device internally. There is no need to
call video_device_release after video_unregister_device.

Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 drivers/media/platform/amlogic/meson-ge2d/ge2d.c     | 1 -
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c | 1 -
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c     | 3 +--
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/media/platform/amlogic/meson-ge2d/ge2d.c b/drivers/media/platform/amlogic/meson-ge2d/ge2d.c
index 5e7b319f300d..142d421a8d76 100644
--- a/drivers/media/platform/amlogic/meson-ge2d/ge2d.c
+++ b/drivers/media/platform/amlogic/meson-ge2d/ge2d.c
@@ -1030,7 +1030,6 @@ static int ge2d_remove(struct platform_device *pdev)
 
 	video_unregister_device(ge2d->vfd);
 	v4l2_m2m_release(ge2d->m2m_dev);
-	video_device_release(ge2d->vfd);
 	v4l2_device_unregister(&ge2d->v4l2_dev);
 	clk_disable_unprepare(ge2d->clk);
 
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
index 87685a62a5c2..3071b61946c3 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
@@ -1414,7 +1414,6 @@ static int mtk_jpeg_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(&pdev->dev);
 	video_unregister_device(jpeg->vdev);
-	video_device_release(jpeg->vdev);
 	v4l2_m2m_release(jpeg->m2m_dev);
 	v4l2_device_unregister(&jpeg->v4l2_dev);
 
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
index 761341934925..f85d1eebafac 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
@@ -1399,6 +1399,7 @@ static int s5p_mfc_probe(struct platform_device *pdev)
 /* Deinit MFC if probe had failed */
 err_enc_reg:
 	video_unregister_device(dev->vfd_dec);
+	dev->vfd_dec = NULL;
 err_dec_reg:
 	video_device_release(dev->vfd_enc);
 err_enc_alloc:
@@ -1444,8 +1445,6 @@ static int s5p_mfc_remove(struct platform_device *pdev)
 
 	video_unregister_device(dev->vfd_enc);
 	video_unregister_device(dev->vfd_dec);
-	video_device_release(dev->vfd_enc);
-	video_device_release(dev->vfd_dec);
 	v4l2_device_unregister(&dev->v4l2_dev);
 	s5p_mfc_unconfigure_dma_memory(dev);
 
-- 
2.25.1


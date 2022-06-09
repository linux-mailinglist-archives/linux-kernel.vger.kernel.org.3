Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63E45450DD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242311AbiFIPbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240115AbiFIPbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:31:50 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9C81AD8A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 08:31:49 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id el14so16763831qvb.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 08:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4U9tS0TY3KQZ435ts/jOG5/NkA8FDER6JfA1XuwruEc=;
        b=GO/ZD7nJmNNk5znGqfkplygLhVlLFll4LrMSC3aMHrJN95dIQM47T+WK6Hf358NNed
         pkdfFs2NnoU/a1wY9wkHSerQRTWEZ6TVrSReqSDEKcPt1Xj+pcqsWG10+o0ynboeLcef
         /ffECQsZZuozFGNsarwsPNyJmCb4YrfRV6ELPYtc1q5AoU3Qd4crtNBUv5ICZhONtUC8
         o3ZkfFIN6IWLKEjvkYvTMiihc/uFcaQfN+CwpNJgvah3wG+IUUe73IwABrsE5RON9zQh
         22jK5e/NEByz4FYpel0RBOOC6cqBmcTMdHKhQr3fojpEpTzIrIBMSQfHw/nHyr2e4EW+
         8YCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4U9tS0TY3KQZ435ts/jOG5/NkA8FDER6JfA1XuwruEc=;
        b=vbvS3QmXiF1yj22Wfo6/0CAYOVQ9xRXRTgfidwXlctaCGiVkTP0srKsEcepONdVs+p
         11/5S3YvMut/7mp1HwxpVnYNBrXsiWOjlLCanf4i6hw533UTCetxjl1BLjOVOVhMlSb1
         C4jbl+bpIeL3O7w3N2DeOp+n0A/kFmYyGIWyyw+RoPFiqTsn0yzUa9rKbtGomzzYVkro
         9lrB6UIxmPAc5j7TFSTjrVs7Bs4NMOxH2nvPsm7Z1eiS2y6wfeETEqm+EHPH0ntxyC/8
         GN/2NL6u0fziq1ASkrmodjqP449Ya6lwVJlqWALDfq+QOk2wn6HQiPDpidyUJCl24uDn
         +94g==
X-Gm-Message-State: AOAM5315MEylYBAOaUuibysxQcB/moU1P5vnvLAKxAJ1/6P4+tzuQ/e6
        x4xOZ8thhKUCMzxYNDVnpBM=
X-Google-Smtp-Source: ABdhPJyGw3HPEdkBQ1FLH0cDnMy0u+XWLFOapa7dgKtiV7lxnCmyJZfpfNO1C2KgxZU2qzih8jwhTg==
X-Received: by 2002:a05:6214:ccd:b0:46b:b0ee:bece with SMTP id 13-20020a0562140ccd00b0046bb0eebecemr13867099qvx.114.1654788707834;
        Thu, 09 Jun 2022 08:31:47 -0700 (PDT)
Received: from Agam.hsd1.mi.comcast.net ([2601:402:4500:22e0::e952])
        by smtp.gmail.com with ESMTPSA id gb3-20020a05622a598300b002f93554c009sm16795726qtb.59.2022.06.09.08.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 08:31:46 -0700 (PDT)
From:   Agam Kohli <agamkohli9@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Agam Kohli <agamkohli9@gmail.com>
Subject: [PATCH] Staging: rts5208: spi: Removed unnecessary ftrace-like logging
Date:   Thu,  9 Jun 2022 11:31:44 -0400
Message-Id: <20220609153144.11803-1-agamkohli9@gmail.com>
X-Mailer: git-send-email 2.36.1
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

Coding Style Fix

Signed-off-by: Agam Kohli <agamkohli9@gmail.com>
---
 drivers/staging/rts5208/spi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rts5208/spi.c b/drivers/staging/rts5208/spi.c
index f1e9e80044ed..0d2d065508d3 100644
--- a/drivers/staging/rts5208/spi.c
+++ b/drivers/staging/rts5208/spi.c
@@ -460,7 +460,6 @@ int spi_set_parameter(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	spi->clk_div = ((u16)(srb->cmnd[4]) << 8) | srb->cmnd[5];
 	spi->write_en = srb->cmnd[6];
 
-	dev_dbg(rtsx_dev(chip), "%s: ", __func__);
 	dev_dbg(rtsx_dev(chip), "spi_clock = %d, ", spi->spi_clock);
 	dev_dbg(rtsx_dev(chip), "clk_div = %d, ", spi->clk_div);
 	dev_dbg(rtsx_dev(chip), "write_en = %d\n", spi->write_en);
-- 
2.36.1


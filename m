Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600B15336A3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 08:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244085AbiEYGFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 02:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbiEYGFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 02:05:48 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D4563BC3
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 23:05:47 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id v6so13273597qtx.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 23:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ZLmsI3mFDmtOtF3aT52i4MAWs/hALcyNzI74HA0AHXU=;
        b=nW5NkqlXQqJQSkIWq131BVqt9j5lP6Vh2bxie0rjYK2YPa3xLWnTVOiL+snKfXPxco
         Ha0w5XgZukM1po5iYj7B5jXXzFcZ7kPHUwyczDtjJtmvR1ElM59sCWRiMYUltN5X96jg
         6Y/7djVpJ6GgscmokreryJvB03okmPiy6UXFcDkcFlTK8aW0CRmsuImJlttIa9u36TdQ
         fXYcDJ4Nkj9T0fJItIIKSg34GTEA8u6FnI6MqOG+NRUzYY6WvUydFbAcosL2QuIJ8ChR
         /iEwn6yNqiBUBsWCW5dKHJDGObRvgGWNmihlyxyTP1F+fGkGC8EiOlCEVMP/P9V4q3GJ
         buqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ZLmsI3mFDmtOtF3aT52i4MAWs/hALcyNzI74HA0AHXU=;
        b=n+xFgyjqurspX6bsiI3a/WlCuQi3p4cfn0o3UFnRfC7ZDx06v6As/vjPlFHRkyKDq1
         KVJwp357ANf0KwOw4tYQVx3TKXKI7X0b84To1CxXJNC+gc1O8xeP9kTq87AHBwXxD8eD
         qDGaWdrp7a/IsOfJLydQ+5PkXsyojn+nOy3N+WTyx5//CHUxMPQArmQ/Rfw5gEIYFSaT
         N470yEKWaa+ZIVtcvjFKp4m9FntFaoEWfpzs7cLMkgPuVe0V9XzB+xrs+CrJgk0dghn1
         u/uucw2Qu3NLoidIt1KpCYu+7PBeCi2PC6ZAN6uT4MY9CQ2EDKuS6km+LHn+q46M7xNz
         A9Yw==
X-Gm-Message-State: AOAM532ajOdrVuxsxKA1l0SLrk7ozf+0JDMtbb6Us7F6AdnCevqBAprI
        1z6NinTfzcpGAp43BEJ8rkk+ZJf61sI=
X-Google-Smtp-Source: ABdhPJzosTULADrwpgytKjBnG14NrIocdJqp3oU360L+0BI1Dz73+N8+mjt+C0N4hLmQvJiMRdlcTg==
X-Received: by 2002:a05:622a:cc:b0:2f9:e34:ead7 with SMTP id p12-20020a05622a00cc00b002f90e34ead7mr23351217qtw.581.1653458746699;
        Tue, 24 May 2022 23:05:46 -0700 (PDT)
Received: from Sassy (bras-base-oshwon9563w-grc-26-142-113-132-114.dsl.bell.ca. [142.113.132.114])
        by smtp.gmail.com with ESMTPSA id cj23-20020a05622a259700b002f39b99f689sm954363qtb.35.2022.05.24.23.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 23:05:46 -0700 (PDT)
Date:   Wed, 25 May 2022 02:05:44 -0400
From:   Srivathsan Sivakumar <sri.skumar05@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: rts5208: spi.c: fix codestyle error in dynamic
 debug code
Message-ID: <Yo3HOPPKnWHez7ES@Sassy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

reduce number of spaces in dev_dbg() code
format the commit and changelog more clearly

Signed-off-by: Srivathsan Sivakumar <sri.skumar05@gmail.com>
---
Changes since v2:
 - Condense three dev_dbg() code lines into one

Changes since v1:
 - Remove unneccesary ftrace like logging
---
 drivers/staging/rts5208/spi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rts5208/spi.c b/drivers/staging/rts5208/spi.c
index f1e9e80044ed..e88fe1a998f8 100644
--- a/drivers/staging/rts5208/spi.c
+++ b/drivers/staging/rts5208/spi.c
@@ -460,10 +460,8 @@ int spi_set_parameter(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	spi->clk_div = ((u16)(srb->cmnd[4]) << 8) | srb->cmnd[5];
 	spi->write_en = srb->cmnd[6];
 
-	dev_dbg(rtsx_dev(chip), "%s: ", __func__);
-	dev_dbg(rtsx_dev(chip), "spi_clock = %d, ", spi->spi_clock);
-	dev_dbg(rtsx_dev(chip), "clk_div = %d, ", spi->clk_div);
-	dev_dbg(rtsx_dev(chip), "write_en = %d\n", spi->write_en);
+	dev_dbg(rtsx_dev(chip), "spi_clock = %d, clk_div = %d, write_en = %d\n",
+		spi->spi_clock, spi->clk_div, spi->write_en);
 
 	return STATUS_SUCCESS;
 }
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151B94DBB74
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 00:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243142AbiCPX5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 19:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235411AbiCPX5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 19:57:33 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81FCF1;
        Wed, 16 Mar 2022 16:56:17 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j17so5215481wrc.0;
        Wed, 16 Mar 2022 16:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f70EsVw2RgUgnRRblJ9CzsRoGjkOsNA56/XaNB7y5ZI=;
        b=SPSy+zObDPT1uAkB/yo4FlrCngip1QPnkmDiqerLhE127K6Vs8r4iOhxSKbgCTeE56
         MxLa9/IYOp8zYlYhBOBMjUQV9mYAJow1+PzIG751SmnAP2ZEFFPZ4+/DxyN/inCo9hTD
         7H317FRPKjCAgejBCLYqJe6ZedXjC1LBCCaUEUAJ5sWRACdTDEvERd4EK+Wv9AX2ljMN
         oo/ggGXmKNZtdEoVRZrxPvwP07ZYLEra4HYfcpDf34X4kgeFGNgBkZ/1SSvU2uZ6gC94
         fq4P/Rp9UfrQ1Fm13A35eehDGUp3UhfzNPO/ku+MOFtfJ5W1J8dpe+iO6b8Oo7Er/BOO
         aJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f70EsVw2RgUgnRRblJ9CzsRoGjkOsNA56/XaNB7y5ZI=;
        b=dwIZJGqBPHGqsrmLkQDV7Ou7SleZ3XjrzGiR0auAyaypu5KBL+f1NYiFZkxjZ8FabA
         HUd+XLqgHEkPF2NN0f9hMh2baHkIAeMaRRToYtIYhWCgHRz/2RG2gF8ZtIohaJQxNFTI
         5ybUrVGEovWmYHOMZIhyudLhvAwVMYVL52zbeFAAmNTXfCj+njoZMk0gfwCxF8YEATz4
         2vZjeYTR3dGpZi3FrcYH2+FB9kMJpGkT5Kyw+LT9a7N16R4gEOg8sEdICCw0HAfSQNHB
         2qoPzLuaxxPK14CGGVDZYptn9oiyzxKM2aXXBkxAKrh39YuYyQLb7nCrc38xMjxKFP6o
         XqHQ==
X-Gm-Message-State: AOAM531qPevFOP59dw9lMTFseDCegm0dzawIL7QeuCU5mQl9U3EWugo0
        HotohJ7i/BvlPCFACA0rcCk=
X-Google-Smtp-Source: ABdhPJxbQiznLyThV54ZddWLujUO4TKVRn1SP1Khn+RurQOBlxzHfsRGWwc8MOe4M4GCeHiSbX6Hxw==
X-Received: by 2002:a5d:47cb:0:b0:1fa:c92a:b1c with SMTP id o11-20020a5d47cb000000b001fac92a0b1cmr1715603wrc.459.1647474976530;
        Wed, 16 Mar 2022 16:56:16 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id g2-20020a5d46c2000000b001f079ba0158sm2688566wrs.60.2022.03.16.16.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 16:56:16 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: isci: host: Fix spelling mistake "doesnt" -> "doesn't"
Date:   Wed, 16 Mar 2022 23:56:15 +0000
Message-Id: <20220316235615.56683-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
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

There are a few spelling mistakes in dev_warn and dev_err messages.
Fix these.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/scsi/isci/host.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/isci/host.c b/drivers/scsi/isci/host.c
index d690d9cf7eb1..35589b6af90d 100644
--- a/drivers/scsi/isci/host.c
+++ b/drivers/scsi/isci/host.c
@@ -413,7 +413,7 @@ static void sci_controller_event_completion(struct isci_host *ihost, u32 ent)
 				dev_warn(&ihost->pdev->dev,
 					 "%s: SCIC Controller 0x%p received "
 					 "event 0x%x for io request object "
-					 "that doesnt exist.\n",
+					 "that doesn't exist.\n",
 					 __func__,
 					 ihost,
 					 ent);
@@ -428,7 +428,7 @@ static void sci_controller_event_completion(struct isci_host *ihost, u32 ent)
 				dev_warn(&ihost->pdev->dev,
 					 "%s: SCIC Controller 0x%p received "
 					 "event 0x%x for remote device object "
-					 "that doesnt exist.\n",
+					 "that doesn't exist.\n",
 					 __func__,
 					 ihost,
 					 ent);
@@ -462,7 +462,7 @@ static void sci_controller_event_completion(struct isci_host *ihost, u32 ent)
 		} else
 			dev_err(&ihost->pdev->dev,
 				"%s: SCIC Controller 0x%p received event 0x%x "
-				"for remote device object 0x%0x that doesnt "
+				"for remote device object 0x%0x that doesn't "
 				"exist.\n",
 				__func__,
 				ihost,
-- 
2.35.1


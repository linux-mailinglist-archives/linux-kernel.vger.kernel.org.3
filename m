Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DF8506535
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 08:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349149AbiDSHBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 03:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349144AbiDSHAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:00:51 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D0731DE1;
        Mon, 18 Apr 2022 23:57:59 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id s70so6044259qke.8;
        Mon, 18 Apr 2022 23:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wtHprdS5qVUgI1B4WGLQZMUd5U+p5+WHqHW383Y1PAQ=;
        b=odc9XxskL3SaX69jaYWVsff++71kMg1o56XrNlqrIlcQCxJDGxmzFFroN2+rWiDT8t
         KsiR8/DriVug/R299reWRqOI6bY1m5amHJjYm34l3WHvFP9kvRthsMtF4BZTulC/Puaz
         mJYgPTV8xz3cIfWyX6T5Eo8Zt+V90XZBtrS7LE4oGIBePzs0K9tfguvTj3JS9yL0pD5a
         Pmq48weFsSJq/6KciYY+yiNvzkXf99x0sLqFhZLnmuQzBBbLKdU9XZinCEj5IzNh2NsI
         qsCMTZpazSf6VQacyc+wBywjYBHv4vrqmEHkLUcqPJHlQexngcghyCdbR0+XTP7npbF6
         sQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wtHprdS5qVUgI1B4WGLQZMUd5U+p5+WHqHW383Y1PAQ=;
        b=xmT1mAW70DFtbSJHVL/+RjPiBKGTghQTnKQhCWndGZj0zyNDc/dByeOWuBjxoOOtRr
         KVNR2ZNEamWidpAOtZToDXlZNcAzOWZEzVAxB5uG5QOu4+zf/aZjkSjY6CufeO14Aq6p
         25OFbOFBdRMV6HRMHIFTEKPW7oFOJeOWW6PLoCuKSDT6rOVPW01p7AItB1fUsCIn5Gia
         3rfd4YaNQnDt39Qy+VSMiCbl7H5P8wb9bOa4XwBJ/rNkhEF8nhwjosjVN8POACKbsrOF
         TXiwv8yD9kNGLFobflWODlH76MeiDBa1iQFZg4pVQPT1r7kfmru3pZEK2VHgU+R6hVZj
         +Llw==
X-Gm-Message-State: AOAM531kto7nM1uWa8QuPxd7hHoWobIUcG5Ra/TGNmi7cRjNHeDbzm49
        xMxcLu7dXB2OGM4+ON3Ftpc=
X-Google-Smtp-Source: ABdhPJzyg5vxvZb7br6vAQNBuOZmYTr86vCbuBCenGPpOxzZBsdDMpG8jd9aVxAhgzDJvMC7AI1M9A==
X-Received: by 2002:a37:a896:0:b0:69e:8b7a:3829 with SMTP id r144-20020a37a896000000b0069e8b7a3829mr5729860qke.626.1650351478269;
        Mon, 18 Apr 2022 23:57:58 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id w17-20020a05622a135100b002ef480d2559sm9223144qtk.34.2022.04.18.23.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 23:57:57 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     james.smart@broadcom.com
Cc:     dick.kennedy@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] scsi: lpfc: Remove unneeded variable
Date:   Tue, 19 Apr 2022 06:57:50 +0000
Message-Id: <20220419065750.2573861-1-deng.changcheng@zte.com.cn>
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

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Remove unneeded variable used to store return value.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 drivers/scsi/lpfc/lpfc_sli.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index bda2a7ba4e77..328b8f4440ef 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -3717,7 +3717,6 @@ lpfc_sli_process_sol_iocb(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 			  struct lpfc_iocbq *saveq)
 {
 	struct lpfc_iocbq *cmdiocbp;
-	int rc = 1;
 	unsigned long iflag;
 	u32 ulp_command, ulp_status, ulp_word4, ulp_context, iotag;
 
@@ -3857,7 +3856,7 @@ lpfc_sli_process_sol_iocb(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		}
 	}
 
-	return rc;
+	return 1;
 }
 
 /**
-- 
2.25.1


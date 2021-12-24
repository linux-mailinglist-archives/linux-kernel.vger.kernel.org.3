Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C83B47F073
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 18:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344219AbhLXRwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 12:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239382AbhLXRwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 12:52:44 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB6CC061401;
        Fri, 24 Dec 2021 09:52:43 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id r17so18712380wrc.3;
        Fri, 24 Dec 2021 09:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9s9YpkJBZ58otRSrRJngVaydwgm1jdjzkaw2OtPRDsw=;
        b=GuJp+nr6HHQbuXpNNl6kyL8F5fHI4yaoXR2gHLlRq32g7H+e0ia5MmvTKAa3F0/b2g
         Ueao6kW0+nO7Px0KXXiGhfB2bSHXdXkzT42sg86OECNOOPjq2MXVs2x8cQZfVKbps53p
         3o2mqPyQOdLuxNiv9saZWeAcrdDRINhtsFfTRoz62kJavBh7ZXtYgIi4dIkGDHGl021u
         9N9B62LrrorKSMub3nnjR2XlMlNR14IQ2hQaHPY3HyB+6sV0OOuV5Vh2tAAW23kYoxvp
         Ieak3Vl9NMzgsjHSmg2sc/saGNa+Y/S93ctCXjha8HFiwk06ldpSzZBBKAQk5cqxrWXI
         /KAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9s9YpkJBZ58otRSrRJngVaydwgm1jdjzkaw2OtPRDsw=;
        b=8Q5IBXezYkndGlXKm1xTzQWRveO9DLkIjhWBJbhG5jDQoV3sPgludU5EbXU8jzEJXZ
         8Ra9jpPY0imHaDIwDe3hi7zuD2O+VNkT9TrHgD4Miy8ybOMHdgRrCqOLRlLYkSz4CC+7
         M/zJ3YgPN6pEhRM9OUJg6xuZFyRZednb7y0V2luDh/hYMOKDFjlU3IKZcHFr+OpcNFDU
         a4R5XaXSP8DpMxfn1YdKIAcTLSdxsr0maBNv+2PTuKJgoMqG7hPSEwlDrs4yP+eIJO+V
         zRfW/XUaWm+PSmfXp/eulu47OPWXmThttgtLW7mk7860Sns5XVOL3RgTWa+3X5YwtdtX
         w5Ig==
X-Gm-Message-State: AOAM531J7K5Xt5bun3/pxiS3owfxbFycCPpYuCBl9+GByPGs9oK5iHIG
        DVepID++GnLv3jCxU7lKRRz720MvCs8uBfrpxRg=
X-Google-Smtp-Source: ABdhPJyEyitH+0KoGYcnay+AejWiogM2fVByKdIf2pxpQkiHbq2Uxej7qFGpwOVjmNxMMkHK4BIh+w==
X-Received: by 2002:a5d:47a8:: with SMTP id 8mr5329911wrb.575.1640368362336;
        Fri, 24 Dec 2021 09:52:42 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id r20sm7837493wmd.37.2021.12.24.09.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 09:52:41 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] scsi: mpi3mr: Fix some spelling mistakes
Date:   Fri, 24 Dec 2021 17:52:40 +0000
Message-Id: <20211224175240.1348942-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some spelling mistakes in some literal strings. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/scsi/mpi3mr/mpi3mr_fw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index c39dd4978c9d..eb07334dd43d 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -901,7 +901,7 @@ static const struct {
 	},
 	{ MPI3MR_RESET_FROM_SYSFS, "sysfs invocation" },
 	{ MPI3MR_RESET_FROM_SYSFS_TIMEOUT, "sysfs TM timeout" },
-	{ MPI3MR_RESET_FROM_FIRMWARE, "firmware asynchronus reset" },
+	{ MPI3MR_RESET_FROM_FIRMWARE, "firmware asynchronous reset" },
 };
 
 /**
@@ -1242,7 +1242,7 @@ static int mpi3mr_bring_ioc_ready(struct mpi3mr_ioc *mrioc)
 		ioc_state = mpi3mr_get_iocstate(mrioc);
 		if (ioc_state == MRIOC_STATE_READY) {
 			ioc_info(mrioc,
-			    "successfully transistioned to %s state\n",
+			    "successfully transitioned to %s state\n",
 			    mpi3mr_iocstate_name(ioc_state));
 			return 0;
 		}
@@ -3844,7 +3844,7 @@ int mpi3mr_reinit_ioc(struct mpi3mr_ioc *mrioc, u8 is_resume)
 
 	if (mrioc->shost->nr_hw_queues > mrioc->num_op_reply_q) {
 		ioc_err(mrioc,
-		    "cannot create minimum number of operatioanl queues expected:%d created:%d\n",
+		    "cannot create minimum number of operational queues expected:%d created:%d\n",
 		    mrioc->shost->nr_hw_queues, mrioc->num_op_reply_q);
 		goto out_failed_noretry;
 	}
-- 
2.33.1


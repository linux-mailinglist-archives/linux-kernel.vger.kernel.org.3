Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6284948271B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 09:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbiAAIt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 03:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiAAItw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 03:49:52 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDC3C061574
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jan 2022 00:49:51 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id j18so59723993wrd.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jan 2022 00:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W9/q/NrnqBEqANyC37JD6gUeY78R63lo51Y9u+z8PxE=;
        b=OXz9HIVqaHeShNoGYKUneSqpMx0Fc1iwbb69AUIMtTNKLVpWOLT6KpioyVruyaBfP5
         oANCad/nPO3BPx5qIbKKJ4wgajhOVqdayrWLtgnaN2nCg+4BA3oToLAKPLFq16RmlarF
         UyEYWtss0eMJ31q8E6Drivzy8jzLnkM7SOL5vkZhz9fj6VeGhdlw8yurhEiX7qYyGL1o
         gAjY9S0uYNXr0gimMbXwVjsPLfh/TbYNn14KQUXx8bXuU0CSwU58qGO4ZBFk52pFYp7U
         rbNxwT+6rDv+x1bp7JJXzLveJjwZ5Wq/pKv4rD88QwKcDCLFTWOckU32ktx1VllJClZC
         PIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W9/q/NrnqBEqANyC37JD6gUeY78R63lo51Y9u+z8PxE=;
        b=SI6kczwE4Vl/9ArznAjcloo3x3SMNs01tK8bExcvr1BWsgrwgU6O+HtKkmXMuTvp5l
         6CG43DCXR3O+m8VdG4L0ZtGCehAYAF++OckrkOCIUIKk9uPnfVuXbUtv9QDYfOz/pvPY
         O58wYHx4pPLeGSRKO8UYR1fSR1bBE729pU57rywhGKNqbK6RFFR5WHpL7PGffsHUYDGT
         kHBXX77zTQhmjj6izvzZ5wAfZLNAfAzLU8UUM7WnrzkhDW3bgUU4Ve1LApWmrzZaLwdF
         yhE87GZcU1Ienx+BxlHKgqHHggrIKS33d4yCNNS038ZFKrwDs+cnUS1MxlaJk+O44pjI
         B9sQ==
X-Gm-Message-State: AOAM532Aa48TAOl5qyO0h6+5Cm4/XCKKdxwHKnW3rUd1GDJxBX5iSy9C
        8loEBS8z7cR69ZKI9nOgFu4=
X-Google-Smtp-Source: ABdhPJxPfVYNrz8QGNcH358gEHOu4NYNmhqY0/4FG8C9nVPLTfRjpkh1wHkaQrWyL6HYZ1eZZbk8Sw==
X-Received: by 2002:adf:f70b:: with SMTP id r11mr32894435wrp.496.1641026990486;
        Sat, 01 Jan 2022 00:49:50 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::d7e8])
        by smtp.gmail.com with ESMTPSA id o9sm14806578wri.97.2022.01.01.00.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jan 2022 00:49:50 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 2/7] staging: r8188eu: UsbRxHighSpeedMode is set but never used
Date:   Sat,  1 Jan 2022 09:49:32 +0100
Message-Id: <20220101084937.3411-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220101084937.3411-1-straube.linux@gmail.com>
References: <20220101084937.3411-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field UsbRxHighSpeedMode of struct hal_data_8188e is set but
never used. Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v3: no changes
v2: no changes

 drivers/staging/r8188eu/hal/usb_halinit.c      | 5 -----
 drivers/staging/r8188eu/include/rtl8188e_hal.h | 3 ---
 2 files changed, 8 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 104705ef170e..96db9a8e7667 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -502,16 +502,11 @@ usb_AggSettingRxUpdate(
 
 static void InitUsbAggregationSetting(struct adapter *Adapter)
 {
-	struct hal_data_8188e *haldata = &Adapter->haldata;
-
 	/*  Tx aggregation setting */
 	usb_AggSettingTxUpdate(Adapter);
 
 	/*  Rx aggregation setting */
 	usb_AggSettingRxUpdate(Adapter);
-
-	/*  201/12/10 MH Add for USB agg mode dynamic switch. */
-	haldata->UsbRxHighSpeedMode = false;
 }
 
 static void _InitOperationMode(struct adapter *Adapter)
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index e8cb093abb62..8b54f52f49e2 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -262,9 +262,6 @@ struct hal_data_8188e {
 	u8	OutEpQueueSel;
 	u8	OutEpNumber;
 
-	/*  Add for USB aggreation mode dynamic shceme. */
-	bool		UsbRxHighSpeedMode;
-
 	/*  2010/11/22 MH Add for slim combo debug mode selective. */
 	/*  This is used for fix the drawback of CU TSMC-A/UMC-A cut.
 	 * HW auto suspend ability. Close BT clock. */
-- 
2.34.1


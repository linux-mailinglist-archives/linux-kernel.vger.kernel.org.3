Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78EC53690A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 00:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355077AbiE0WyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 18:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353186AbiE0Wx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 18:53:58 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9D113327E
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 15:53:52 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z43so2558240ede.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 15:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=hP5/xUyD7yW6cvIyRkoeePUvJc0jXic9WcbLUxigB40=;
        b=RtFIrUQp2WIbvXh5KekjWJD1NIOKq8nVs0YGApK2nMqngdwnUMYAJIVoTtFBRRNUou
         IaLblgNvd1QTfcDLwS+kesv/ZORUtM10mjGRwyVPqZE8OBSgsVQEBospFrzBKgQ8Y0bv
         lK4l581kiWyxxVu4C4t2NviB/6LVaEdBpuoTYuEoEtoYZb+4tsoOSi09kyDT64iz9a0n
         N1BFixAP2vGL86aNDvt7K/dcjjVc1DAxORMLPy4BDD9NM2Btt0OX04n3UAwHDwSZIdnA
         mb5y1M07KfoGtwHUuJW6LXO9gckrEuDiIBiyRgjS60n8FI9GRFhjOcHzELlYIzUCC6PB
         mp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=hP5/xUyD7yW6cvIyRkoeePUvJc0jXic9WcbLUxigB40=;
        b=ezI1z0avluVJZojzs0vKbWo0f5M7p0Z/UBzE9H4oUncVjtFgXSVvMnsjovzl4PbX44
         8pnBVJ+Qnb2LdxDKOSWH6V99BxA6+9hH0caW6tJBhvYKlElhSDoEv9VjMvsK0RZWemsR
         vrbj2F4jVRHUSyuxkJNihdZRCJDci5n8geEiJiHIlbbxNw4Rsp+qedvFMNd2KCTuXaOY
         9cn8WyDAzUL8dcxaI09q9WPBuCRm/ZpvHMJJLwkmnH2qrA3/C4usHou7xpMZg9lZN99n
         yJdS8v2es9M47WtieQKFhCBGXpYpyq3TDm4ZBJQ0LzNgD080LfL0LGEAyLNxS2Q3pvUw
         xy7Q==
X-Gm-Message-State: AOAM530CF7sijdwIpNF3prD3NTM6nZiL3duU+9O/Vyzt+nrYEhaC3gSt
        fvFX7NI9RW9R3iX3PzsTBYMKx/IFYig=
X-Google-Smtp-Source: ABdhPJw3+sf7/q9knV+x05CL4/Yby+9GQ2EEHXSBNOh+rlPfovbZlZoz4hpOgUN6SwECEi0pU0J/3A==
X-Received: by 2002:a05:6402:2712:b0:42b:476b:6c71 with SMTP id y18-20020a056402271200b0042b476b6c71mr34964679edd.413.1653692031032;
        Fri, 27 May 2022 15:53:51 -0700 (PDT)
Received: from nam-dell ([2a02:8109:afbf:ed88:4971:2aa6:72b5:e75])
        by smtp.gmail.com with ESMTPSA id n24-20020a170906689800b006f3ef214e72sm1816390ejr.216.2022.05.27.15.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 15:53:50 -0700 (PDT)
Date:   Sat, 28 May 2022 00:53:50 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH] staging: sm750fb: fix camelCase function name
Message-ID: <20220527225350.GA220436@nam-dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change camelCase function name sii164GetVendorID to sii164_get_vendor_id
as suggested by checkpatch.pl

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/sm750fb/ddk750_dvi.c    | 2 +-
 drivers/staging/sm750fb/ddk750_sii164.c | 6 +++---
 drivers/staging/sm750fb/ddk750_sii164.h | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index 029d9acec47d..e0c7ff3352bf 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -15,7 +15,7 @@ static struct dvi_ctrl_device dcft_supported_dvi_controller[] = {
 #ifdef DVI_CTRL_SII164
 	{
 		.init = sii164InitChip,
-		.get_vendor_id = sii164GetVendorID,
+		.get_vendor_id = sii164_get_vendor_id,
 		.get_device_id = sii164GetDeviceID,
 #ifdef SII164_FULL_FUNCTIONS
 		.reset_chip = sii164ResetChip,
diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index 73e0e9f41ec5..3da1796cd7aa 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -29,13 +29,13 @@ static char *gDviCtrlChipName = "Silicon Image SiI 164";
 #endif
 
 /*
- *  sii164GetVendorID
+ *  sii164_get_vendor_id
  *      This function gets the vendor ID of the DVI controller chip.
  *
  *  Output:
  *      Vendor ID
  */
-unsigned short sii164GetVendorID(void)
+unsigned short sii164_get_vendor_id(void)
 {
 	unsigned short vendorID;
 
@@ -140,7 +140,7 @@ long sii164InitChip(unsigned char edge_select,
 #endif
 
 	/* Check if SII164 Chip exists */
-	if ((sii164GetVendorID() == SII164_VENDOR_ID) &&
+	if ((sii164_get_vendor_id() == SII164_VENDOR_ID) &&
 	    (sii164GetDeviceID() == SII164_DEVICE_ID)) {
 		/*
 		 *  Initialize SII164 controller chip.
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index d940cb729066..ca330f6a43e2 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -27,7 +27,7 @@ long sii164InitChip(unsigned char edgeSelect,
 		    unsigned char pllFilterEnable,
 		    unsigned char pllFilterValue);
 
-unsigned short sii164GetVendorID(void);
+unsigned short sii164_get_vendor_id(void);
 unsigned short sii164GetDeviceID(void);
 
 #ifdef SII164_FULL_FUNCTIONS
-- 
2.25.1


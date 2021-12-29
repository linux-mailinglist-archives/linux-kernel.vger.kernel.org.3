Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096B5481163
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 10:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239580AbhL2JrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 04:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbhL2JrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 04:47:20 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D1FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 01:47:20 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id jw3so18094140pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 01:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=SZt+PdB0ksyIlIomXjnYYgxpDLtpRJk7mrjUXL3/SSc=;
        b=Bk2zDX9ojYrZN7oWsfacN1JWYmi3ylxb7LAqzopN4ngSoqNyqYkoC5yFSp/2GE+S2l
         ZsvJ2gaWnOUZQoYqYLh/OaQOuwm0US2gEAecPBGnDSFiVendAdZjNG+y3w3ex+og3Tpz
         4bBFKgIoqtsz6ejXfdCL+/JZ904vDk03+o9Vf5AbMV3WBGTbh5JFcAIn+gTCnXsm3Hwn
         wBZ1pEWeyR5qej9DHL632ycz09P10O5jS4MtPR+7Q/lyr2vI1Wd/uecPBfbje2Giogqq
         37Y7uTQVhWfJq6dYJ2LKg1YeAB8MX46CKaQntrm42aeSKzx5RRIyWGomVdCRj+GSbovy
         Pe6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=SZt+PdB0ksyIlIomXjnYYgxpDLtpRJk7mrjUXL3/SSc=;
        b=mnFJjZouvwUbBgWcrp06qkxyf9UjKkcCWSSeL92VVILlBXuVVeAbqbPRUXkCDOd9P5
         s3rB/Sb55oasiaslL0+L7AnidNzv006WD/g87fOBRUCBMs5eE/sJYsYdOLckIP1xmMwE
         iX2FVeIkvYLjIIgzH/NB4lbYCY3CFGfPH0MweeIPpiGudV1BeIyR8T2ltrr/u5HX3jZ4
         P/LxUK27ieVPeogvXzw8Hayw2RpOnlmgkZPYFJV2agI5AkPlPDdE55T7g8l2mvNi0Cgz
         r4cN+jxxTUC4YdtapA/UMPfznpi+IswtC95IBp3QfOJGxIZc7p3ZWlrJdJmQB+0u0ioB
         Mlsg==
X-Gm-Message-State: AOAM533IormvlktjnzDR/MEy+AqpN56vQtJZkbqe1JXairf6E9J3Wdfl
        uR6cDCpp+lL4PRHBrU35rBY=
X-Google-Smtp-Source: ABdhPJz6/T+KLZzxfQ2wy0I4wTo+QS0cfasrrZF/tfBUmYiwfzfmVH0b2eZ5IQebxE7cVPNioFHCQw==
X-Received: by 2002:a17:902:c401:b0:149:7451:2200 with SMTP id k1-20020a170902c40100b0014974512200mr17245850plk.14.1640771239605;
        Wed, 29 Dec 2021 01:47:19 -0800 (PST)
Received: from localhost.localdomain (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id v3sm4940247pgl.64.2021.12.29.01.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 01:47:19 -0800 (PST)
Date:   Wed, 29 Dec 2021 22:47:13 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: pi433: add docs to packet_format and
 tx_start_condition enum
Message-ID: <20211229094713.GA28795@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While pi433 driver deals with the nuances of the different possible
config combinations, it's hard (at first) to understand the rationale
for some of the tx/rx-related source code unless you're fairly familiar
with the rf69's inner workings.

This patch documents the expected behaviour and limits of both
packet_format and tx_start_condition enum fields.

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
 drivers/staging/pi433/rf69_enum.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/staging/pi433/rf69_enum.h b/drivers/staging/pi433/rf69_enum.h
index fbf56fcf5fe8..c902916a063d 100644
--- a/drivers/staging/pi433/rf69_enum.h
+++ b/drivers/staging/pi433/rf69_enum.h
@@ -109,13 +109,32 @@ enum fifo_fill_condition {
 	always
 };
 
+/*
+ * Defines the packet format used.
+ *
+ * In both modes the length of the payload is limited to 255 bytes if AES
+ * is not enabled or 64 bytes otherwise.
+ */
 enum packet_format {
+    /*
+     * Used when the size of payload is fixed in advance. This mode of
+     * operation may be of interest to minimize RF overhead by 1 byte as
+     * no length byte field is required
+     */
 	packet_length_fix,
+    /*
+     * Used when the size of payload isn't known in advance. It requires the
+     * transmitter to send the length byte in each packet so the receiver
+     * would know how to operate properly
+     */
 	packet_length_var
 };
 
+/* Defines the condition to start packet transmission */
 enum tx_start_condition {
+    /* the number of bytes in the FIFO exceeds FIFO_THRESHOLD */
 	fifo_level,
+    /* at least one byte in the FIFO */
 	fifo_not_empty
 };
 
-- 
2.25.4


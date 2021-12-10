Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012F447004F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 12:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240786AbhLJLv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 06:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240459AbhLJLv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 06:51:27 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6B9C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 03:47:52 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso8800993wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 03:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DdPRnVGVlNPycJ9DTbcky3GEfi1/qO6rilh8GdIfKm8=;
        b=PwbcylkTeZEeIL6UBJi3g6ypNrRUQOcj0MzGxICst0UQEnZGD4GKrXqHNcF7ANjdmz
         vcmzuEXie0jFhjkU50uMLPZx6wD/EX4AO122aPqsRw/ErgXh5bj4MEuGcRJquZwtWLld
         RmMHDtepCxyMpFJ1SukqoshAu9d2PJ08+4z+c+Qppqio2PrJoOVATfZdryPw+62m+gBY
         94hVO607KSg2weyTuWrVxqgZlEFkMQPp+dSdJ1HRxJJDX8wGvzycs9q93gQW7biMr8y2
         f1J5CSeyx72WhuVgnHn+NExrRUZzfll0H86ltWXcgZLh1q+jtbb5Qdpjw+NfGPRUgaHy
         eGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DdPRnVGVlNPycJ9DTbcky3GEfi1/qO6rilh8GdIfKm8=;
        b=qGgJmiuak8k3Xbzyjgfq2A/TMB/WzXFrdwx01vvcxN7JUkNMTDKtfGf/o2SssZYmOk
         Go6cAna1oIQZeiC+YsIy9b+Gb4WNs1A5OYruJk5bA5F14/8fUCmbOxy1DJo9fgeTntRP
         ai+do258uMiXnsD0cVSUPzlPTCE1xYHHuzrN8mU4s85wm7OhhgwOG+ncn5J9abxIBtQt
         Wgt5tqEHLjf6d5uqSwVCrM/Bu/N6oG377uazb+JGTcD37HOFdpQfPrrWnH43c9S3O16Q
         TsO4+cn2RnOk9yRLARBAudJILnXykb2+G3lS9y1ezByV3z/AhJcj11C/JCtDAe4B4y+1
         mD9w==
X-Gm-Message-State: AOAM532LreeB7+tFpsWbmtbNVw/Vb08obzHQNc6fXMKiGL9w+JKRh8C6
        3NfYORA4gA7Zb/gfyaRb8mhhqi19l2Fz2g==
X-Google-Smtp-Source: ABdhPJx7yY3Fqo+dlZ2ZI3y6N+B/3ysazcxkVn8RR8G3dVto96Ljv5epauhXEivULr6OwbtUvuqHKA==
X-Received: by 2002:a7b:c257:: with SMTP id b23mr15907315wmj.67.1639136870916;
        Fri, 10 Dec 2021 03:47:50 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id a9sm2412753wrt.66.2021.12.10.03.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 03:47:50 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     lee.jones@linaro.org
Cc:     srinivas.kandagatla@linaro.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: wcd934x: fix typo and a duplicate register define
Date:   Fri, 10 Dec 2021 11:47:47 +0000
Message-Id: <20211210114747.1485-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like we ended up with a typo and a duplicate in WCD register defines.
Fix these.

Fixes: 6ac7e4d7ad70 ("mfd: wcd934x: Add support to wcd9340/wcd9341 codec")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/linux/mfd/wcd934x/registers.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/mfd/wcd934x/registers.h b/include/linux/mfd/wcd934x/registers.h
index 76a943c83c63..bcec70a66fff 100644
--- a/include/linux/mfd/wcd934x/registers.h
+++ b/include/linux/mfd/wcd934x/registers.h
@@ -34,7 +34,6 @@
 #define WCD934X_DMIC_RATE_MASK					GENMASK(3, 1)
 #define WCD934X_CPE_SS_DMIC2_CTL				0x021a
 #define WCD934X_CPE_SS_DMIC_CFG					0x021b
-#define WCD934X_CPE_SS_DMIC_CFG					0x021b
 #define WCD934X_CPE_SS_CPAR_CFG					0x021c
 #define WCD934X_INTR_PIN1_MASK0					0x0409
 #define WCD934X_INTR_PIN1_STATUS0				0x0411
@@ -375,7 +374,7 @@
 #define WCD934X_CDC_RX2_RX_PATH_SEC3				0x0b74
 #define WCD934X_CDC_RX2_RX_PATH_DSMDEM_CTL			0x0b7b
 #define WCD934X_CDC_RX3_RX_PATH_CTL				0x0b7d
-#define WCD934X_CDC_RX3_RX_PATH_CFG0				0x0b6e
+#define WCD934X_CDC_RX3_RX_PATH_CFG0				0x0b7e
 #define WCD934X_CDC_RX3_RX_PATH_CFG2				0x0b80
 #define WCD934X_CDC_RX3_RX_VOL_CTL				0x0b81
 #define WCD934X_CDC_RX3_RX_PATH_MIX_CTL				0x0b82
-- 
2.21.0


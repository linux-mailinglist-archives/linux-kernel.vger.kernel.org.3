Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57707482B61
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 14:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbiABNMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 08:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbiABNMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 08:12:03 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABDFC061785
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 05:12:02 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so17028976wme.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jan 2022 05:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h2Wgv5+h6GkK0yvQzGrFoIs9n84Jg+EZtpnr/gveYGk=;
        b=LPaNYgMwLimHQx2Rx+2wiEz+1Q2OFGbl7Qwb3B+JZNtvKZ59eCi2VS/O68QvhUpVqr
         zGdfHKiuBxk/sgKUNVGV3R+dlogQ/OMJKq5gB8vCPHTeBNmwgRj2LLq4bTEPOcPsuhxl
         S7a7gwe4ASEbt1LGXsQorpplIFVWaEiNC/YIU2xjEme3rLAajjutetyx3C3jRKD9gTjM
         5hPKlUzIN/ZXQWuH6a9rxvfroOZrDsTwtrTy+Kj0YQZL6ssypPFTpWkhoq6fPb/TWVKS
         HO/xzb1GGCnfqik3bPBV9ShVToAJZf9JSbuBW3VMcPtz3Wm5pK03T69YHCt+Jhk9Of5G
         phQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h2Wgv5+h6GkK0yvQzGrFoIs9n84Jg+EZtpnr/gveYGk=;
        b=49hFJDiHgzWy9Ra5471nFSQyAg82ntI9Ik7JZdbwN/TnhTf7PXg8TGyRirM1iPH1FL
         a4U/oBI+6WXAbjTVvaR3sTapnsM80BPGkFVvQpkcz0Pti6EVfCk0h5YT99n4gHUe8khh
         MTGUACyhYdKs1u12xgCBnRlKyR0E23lxKMixjlQWv2StrHgLbY+12KbzmjlILn8NS1ze
         kJaE78AKVRjHt/nFbxg5WcTTvSEjoZsuzSJ2VEwAye7ID4IzWF0TtB/tAbGZq8THJfbf
         RKlnWCZxJcPiFUclm4/YIK22JFgQQgR5E/hDUi95mvTGQswAPBmAL1DsBadRUo9kNhMO
         NA7Q==
X-Gm-Message-State: AOAM533LxRK7OEaBcHyZGAEsv9jO3h6ySOpaWhPwbpSYQklc6XjEXwKc
        YClNU2GNQF9it+5UFWbp964=
X-Google-Smtp-Source: ABdhPJzXrDJ1xfuTMXZ5i9fgSc+eewr/EqNnwIbFqucWjPniEFYY3k8kz1Wc6NBLGqPw+O8kVKSQWg==
X-Received: by 2002:a05:600c:3ca1:: with SMTP id bg33mr35890695wmb.80.1641129120951;
        Sun, 02 Jan 2022 05:12:00 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id m35sm65640044wms.1.2022.01.02.05.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 05:12:00 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 10/11] staging: r8188eu: remove unused defines from Hal8188EPhyCfg.h
Date:   Sun,  2 Jan 2022 14:11:40 +0100
Message-Id: <20220102131141.12310-11-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220102131141.12310-1-straube.linux@gmail.com>
References: <20220102131141.12310-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused defines from Hal8188EPhyCfg.h.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/Hal8188EPhyCfg.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
index e01de2ebb75f..2517a08bc95a 100644
--- a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
+++ b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
@@ -4,12 +4,6 @@
 #ifndef __INC_HAL8188EPHYCFG_H__
 #define __INC_HAL8188EPHYCFG_H__
 
-#define LOOP_LIMIT			5
-#define MAX_STALL_TIME			50		/* us */
-#define AntennaDiversityValue		0x80
-#define MAX_TXPWR_IDX_NMODE_92S		63
-#define Reset_Cnt_Limit			3
-
 #define MAX_AGGR_NUM			0x07
 
 enum rf_radio_path {
@@ -26,7 +20,6 @@ enum rf_radio_path {
 #define MAX_CHNL_GROUP_24G		6	/*  ch1~2, ch3~5, ch6~8,
 						 *ch9~11, ch12~13, CH 14
 						 * total three groups */
-#define CHANNEL_GROUP_MAX_88E		6
 
 struct bb_reg_def {
 	u32 rfintfs;		/*  set software control: */
-- 
2.34.1


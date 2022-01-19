Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 516F9493678
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 09:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348416AbiASInC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 03:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241516AbiASInB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 03:43:01 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90283C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 00:43:01 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id f8so1780596pgf.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 00:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=M7jJlTEMEKB2QzR8ziKOvVVAOFD3F55n+Hx6E1xt8NU=;
        b=YBe2dbmtF2RjjHb+admP4DumYuDawvkxYKiXsKcv0EuRD7d9qSwGWWbqnyfO2+NfrC
         57W+/LSbVvv38WvxkgqYR7TK4LKEuMoV8+FVuc9obDqhyxDmhCs8LWRQm4gsBAMYXiQR
         f2fuRFILbBqb7lPXHsxROiK/fQ9fsOWDtzgkVpvwE+c76D7lf+w5csI1l9efH7FTJbnN
         cpz4OIAaA184NATTg/DfDvOURjcQgV8xFC4EiqNMSz+420ZbNS91IBkW2e+MiGSkIy2G
         +zuW3COXewmsSmm1Oy1R5bMkH5iyZytq7EWFpLiShLE88IYroI1TIeKQAduHksPMcvfP
         GeNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M7jJlTEMEKB2QzR8ziKOvVVAOFD3F55n+Hx6E1xt8NU=;
        b=3/zXcsZho3wq9d9UI5A0D1SYc5wCYmqHVDiWFEVbFkvFC0PrHSTbkGgi3cDcNMpMN9
         mMe4jq5MqofvNZIAqiYRLxAC/34yu0ndSFhtUtMewlD60xdCzk9g7H31a+Rpi5vfUwbn
         EUmx6zwY5mECMiSsC2KqHQ1IUwH3my4dahaqyGDTmMjxcvzCCR2JK1WIGqY4rzxI/oyz
         JXSrZGPNF0wmsKyoBfbhbLrCkIVHNP1CUpP98JvJH352zOibgWQf6Gf9D7paWOCNfFaF
         4nrjCsX3ZUa/XHOjW0RHllQlL0jSFtxDdwGwRH4qp2nuWk2+FPjFntCoyzuSGugDkV9f
         FxDQ==
X-Gm-Message-State: AOAM533psumEO9sH8F/qvJl96rPk5pfCXbUQ2DVptAsHzMXV/UrZj6ns
        hhWSMUl8MXr5Xjy1sdgBIAE=
X-Google-Smtp-Source: ABdhPJzOEFGYx8bUrK1WwCIntSEYIu8tsTw7mMmz+J2KE6kC4rlQwDvcpSmkWFONZT9hFypocI1Y4Q==
X-Received: by 2002:a05:6a00:ac4:b0:4bd:6555:1746 with SMTP id c4-20020a056a000ac400b004bd65551746mr29805763pfl.39.1642581780937;
        Wed, 19 Jan 2022 00:43:00 -0800 (PST)
Received: from localhost.localdomain ([103.70.199.75])
        by smtp.googlemail.com with ESMTPSA id c21sm9469277pgw.41.2022.01.19.00.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 00:43:00 -0800 (PST)
From:   Ajith P V <ajithpv.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ajith P V <ajithpv.linux@gmail.com>
Subject: [PATCH] staging: fwserial: rearrange comment to avoid warning
Date:   Wed, 19 Jan 2022 14:11:59 +0530
Message-Id: <20220119084159.5759-1-ajithpv.linux@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fwserial.h comment contains word "bits" 2 times together.
The sentence required this however it produce warning.
Change the comment to make it proper.

Signed-off-by: Ajith P V <ajithpv.linux@gmail.com>
---
 drivers/staging/fwserial/fwserial.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fwserial/fwserial.h b/drivers/staging/fwserial/fwserial.h
index 1d15f183e0fa..ae7cf84ceafc 100644
--- a/drivers/staging/fwserial/fwserial.h
+++ b/drivers/staging/fwserial/fwserial.h
@@ -203,7 +203,7 @@ struct fwconsole_ops {
  * @break_last: timestamp in jiffies from last emit_breaks
  * @hangup: work responsible for HUPing when carrier is dropped/lost
  * @mstatus: loose virtualization of LSR/MSR
- *         bits 15..0  correspond to TIOCM_* bits
+ *         bits 15..0  correspond to bits TIOCM_*
  *         bits 19..16 reserved for mctrl
  *         bit 20      OOB_TX_THROTTLE
  *	   bits 23..21 reserved
-- 
2.17.1


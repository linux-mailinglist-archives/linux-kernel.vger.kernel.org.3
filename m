Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7DFD4757C6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237245AbhLOLbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbhLOLbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:31:40 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CA8C061574;
        Wed, 15 Dec 2021 03:31:39 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id m12so32838727ljj.6;
        Wed, 15 Dec 2021 03:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u/WpwxjhXhKPLEsZCHHJaWrhenS1141huRo9nJnkSqM=;
        b=ZhmVV+uXqO4OY7R7PT8sUIRIm+DdcohcjTlK015m0/nkBQ+ooTwdKUP87q4w/tipys
         AMLO8jnsoV4uTomaybmRNGAMUb2W19INewD6tQ7WT/9goKOevhovzu0s6P4FMrKbR2ia
         uWvZqbVu/+ZN4BFhL+Yx8cRrnANG20DGDducWT/O5j4xX11sZij/YN88rWi9FcpT7Amx
         fU01hfNXLeNS71PW+vuYyG0FJqr2btfZtYnlaiZZ1q3WQeh4qJgOV1+uQeUzWPCDjQX3
         kNeghqzRoAdMEAwVX0oB2v/0aUS9z3UZnrp72KeoJvziEGVA5jKNrswAfbphrsQwZfxs
         Y3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u/WpwxjhXhKPLEsZCHHJaWrhenS1141huRo9nJnkSqM=;
        b=yQCcYxWjpQUkMJpKpPtUFKU2m3tp8MjI9Z6zFX+/2U80Yrvss209Gp023jn/izr7O9
         ecogWWeIVt3zj5bG3wwIDXrdyA90osWNSyrIT+ryMd8CeB6qFOTwHPK1rklNMUneFnWn
         TvQGQHeqpbhj28EcCl1vzg2kc5ZZ5Kq++GtTqF5ilvaqd55sR8O2EwVC46bkpjaD/rv3
         TGzGyVFl9IKJxsJHs/RRtWZAl/jKyGaUOJHbE5xptaazAMeCZ+01OOcfH12W9zFxOROP
         qXW1wbORqVxUjASDM7SYM/ONrSuTMcfOPHd2qzFO9QyQtlVAWW7EayWwxhTMkPf73hyb
         T98g==
X-Gm-Message-State: AOAM533hhu/6dDIjyif4/hpyZAKZePSgqugByQRxbdL7COp/Aza3cxV6
        14mrgCM1ZQUqOfBJayjQGBSFu8EB84M4Wv0w
X-Google-Smtp-Source: ABdhPJyJ7Mw1muK0bruoBZ3SSdGksntkJY8Bu3g7KohHwyMu4euTBey6HMXrLMTZphtOUfFBGROy4w==
X-Received: by 2002:a2e:a786:: with SMTP id c6mr9801702ljf.161.1639567897106;
        Wed, 15 Dec 2021 03:31:37 -0800 (PST)
Received: from NB-893.corp.yadro.com ([89.207.88.249])
        by smtp.googlemail.com with ESMTPSA id p11sm279546lfk.7.2021.12.15.03.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 03:31:36 -0800 (PST)
From:   Arseny Demidov <arsdemal@gmail.com>
X-Google-Original-From: Arseny Demidov <a.demidov@yadro.com>
Cc:     arsdemal@gmail.com, Arseny Demidov <a.demidov@yadro.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon : (mr75203) fix macro typo
Date:   Wed, 15 Dec 2021 14:30:23 +0300
Message-Id: <20211215113023.2945-1-a.demidov@yadro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the file mr75203.c we have a macro named
POWER_DELAY_CYCLE_256, the correct value should be 0x100

Signed-off-by: Arseny Demidov <a.demidov@yadro.com>
---
 drivers/hwmon/mr75203.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
index 868243dba1ee..1ba1e3145969 100644
--- a/drivers/hwmon/mr75203.c
+++ b/drivers/hwmon/mr75203.c
@@ -93,7 +93,7 @@
 #define VM_CH_REQ	BIT(21)
 
 #define IP_TMR			0x05
-#define POWER_DELAY_CYCLE_256	0x80
+#define POWER_DELAY_CYCLE_256	0x100
 #define POWER_DELAY_CYCLE_64	0x40
 
 #define PVT_POLL_DELAY_US	20
-- 
2.25.1


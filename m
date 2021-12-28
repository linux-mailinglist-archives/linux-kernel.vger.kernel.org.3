Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53318480852
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 11:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbhL1KRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 05:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbhL1KRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 05:17:52 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F72C061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 02:17:52 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id y16-20020a17090a6c9000b001b13ffaa625so21038230pjj.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 02:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p/VayS/BsqiSiN6ukY1nlzS20RWmSqXpiNahjHrdYfs=;
        b=mqJ+zuSLjx9zZFj3oo94UbK16dt1vE8SMoRs/PTFjMm2aX9CfHxzezaOoGbQIN5dJH
         WjbuuCtbmOT90pqr6edA/FFjQIDcc5XhwtGHQg3nIaPTKksiWfwEz/JLDrvsuo0xGuRo
         +89fP6UocmvfqAA2HEguqblCZ7FlS8g0n1hrSv4i9Lzt5GwODQHzlzdP3jvy+J74t19C
         ThpoqXwqTKQqre/JyArMxgl9e2YxqjtstwPnNE3X6qiVt30AzAbvXKhk8/i+c7kW5HVo
         Z7il6hZpddGc7KDSupj8VfH6YmcZLyyUxd1e6r8Gd2plutgGU6Z38ttxnAjB03k5g/qO
         Cenw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p/VayS/BsqiSiN6ukY1nlzS20RWmSqXpiNahjHrdYfs=;
        b=YWvTRpoIbhWBWLD6cMsRd2zIvUUOnTp2s532YSlAr57jTACcVSuLeC3h7pXgjQ5oOT
         ZIPm4VeOqBrszYS5AcARFdwXvKbJ29jq+hXeiso0aq3kVq72vcvb10gkLlbK/MM6YPJu
         R+wehWo9Mn1CjC1trgEmso1RUzdFok7CxslTk7Qvbe6vhiNDC+jakLfT1NCc/ZVx5FJK
         JSoPxxCFPGKOYsy6wBOe82IIX6dEeIzl9BfNBiTbwKZxwZAk5RWg9gQInYqGfQTTgBYx
         8nR0Zb9I5iAFj64/XNrnlwAkNdqGjXCNpWg0iCLeHy9w6f2nv2qzuN7lytgXeEacdjxM
         9xmA==
X-Gm-Message-State: AOAM5324W0/majU3dcpFy8OzP8Nbq1eGSzxkuefDJSa/Vl43EOPXepr8
        CDs1mRoIrNO/toCi/5caWRw=
X-Google-Smtp-Source: ABdhPJzMgkPnEDB3/JPDkBk1kIfG7elVB019OKw2Fkhr8+SouvbJ3YYsUFUWtQgjNV++iOu2zF4/Cg==
X-Received: by 2002:a17:90b:384f:: with SMTP id nl15mr14747235pjb.91.1640686671744;
        Tue, 28 Dec 2021 02:17:51 -0800 (PST)
Received: from localhost.localdomain ([103.230.148.190])
        by smtp.gmail.com with ESMTPSA id f7sm18795938pfe.71.2021.12.28.02.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 02:17:51 -0800 (PST)
From:   Gautam Menghani <gautammenghani14@gmail.com>
To:     nsaenz@kernel.org, gregkh@linuxfoundation.org,
        stefan.wahren@i2se.com, gascoar@gmail.com, ojaswin98@gmail.com
Cc:     Gautam Menghani <gautammenghani14@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] Drivers : vc04_services : Remove repeated word in vchiq log warning 
Date:   Tue, 28 Dec 2021 15:46:15 +0530
Message-Id: <20211228101615.5073-1-gautammenghani14@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a log warning in vhciq code, the word 'count' is repeated twice. 
Remove repeated word 'count' from vhciq log warning.
This change has been suggested by checkpatch.pl

Signed-off-by: Gautam Menghani <gautammenghani14@gmail.com>
---
Changes in v2:
- Specify a description of why the patch is needed
- Write a more descriptive subject

 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index c650a32bcedf..6759a6261500 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -1661,7 +1661,7 @@ vchiq_dump_service_use_state(struct vchiq_state *state)
 				  service_data[i].clientid, service_data[i].use_count,
 				  service_data[i].use_count ? nz : "");
 	}
-	vchiq_log_warning(vchiq_susp_log_level, "----- VCHIQ use count count %d", peer_count);
+	vchiq_log_warning(vchiq_susp_log_level, "----- VCHIQ use count %d", peer_count);
 	vchiq_log_warning(vchiq_susp_log_level, "--- Overall vchiq instance use count %d",
 			  vc_use_count);
 
-- 
2.25.1


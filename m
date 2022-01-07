Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E52487056
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 03:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345393AbiAGC0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 21:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345384AbiAGC0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 21:26:09 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A8AC061245;
        Thu,  6 Jan 2022 18:26:09 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id v4so4294198qtk.0;
        Thu, 06 Jan 2022 18:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V1f0cCaEdimj+Qhl14+tLN/0LqLxCZYAJyfZ5GKR66k=;
        b=cuw4elrPm3u4TIuhUoLMw9XNU1vrCEpCGRAj3S9IeDw47deVRw134oqEZdLHSX/rbI
         7uDdDbBQre1dE781Pc7Mx1AZSGBR+0s/gnAIfm70UuYuzZzZoJPSusCib0gPajr+pvmp
         TlkQxo0/kHYnmuJtckCmV0zI7hFi6kUpD002/7ioLq+9rhcqdi0KPA3wXJCz5pR1UDeE
         WSO9Xs9gOg0t4L2F5B2BCo6zluhjY4YFj4cO45lvgU0sqXkDCSJT2EGKZ93eA++sSBJV
         TgkzFCnQQ5geADGKoo6Wh8Q8Lv0/NiUwWl/xSo3sTM9n6RJ6O21U3srVEg6grhKkl3je
         dM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V1f0cCaEdimj+Qhl14+tLN/0LqLxCZYAJyfZ5GKR66k=;
        b=tUXIFYp7Umcm3dsjhfFwRQKan1rxhbQSjQ3/reamMtCQwZMKL4mEMqX2aVDFgmUvYN
         sExPdkrBGI9ZSonx5Su0bVLF+mhu8WnP3R9eze93Pltdw6CqI/4A8jrsmFDnJz7qqYiT
         QkDfbPJ0uX/cTZ3R7uxTouqYemZnpKrAfRynUaj2r/XyEuAD/nGJ/cpCHwVorR755IbI
         zUBsXRQr0RG+iyDe1WrjcoS/efnGQEyL05/hqIuSMKkNzb4m3efjLnm1jljEUHEyaQ5A
         br99j1H8ltt8kCsYjRjbnNIoVIQnQkaXiBpS+reVpW8VPgb1O670qviXoWseH38Z3N5j
         2siw==
X-Gm-Message-State: AOAM5331qYX4TSuTwQ5TC8NV1XeVGG39tsc9vpCNuF/uLdtTVnsKSd0k
        GtRvv2U0nEgEH+nh/p9KrD4=
X-Google-Smtp-Source: ABdhPJyw1w8Zqf3SxiEeSE2o1kjSVJAA9XBqI3EdbtKfPsl6Pd9s758fUcfq7C//1R0Xd7CgcmAbgg==
X-Received: by 2002:ac8:5e4e:: with SMTP id i14mr54135746qtx.646.1641522368739;
        Thu, 06 Jan 2022 18:26:08 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 82sm2405725qkd.77.2022.01.06.18.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 18:26:08 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] power: supply: ab8500: remove unneeded variable
Date:   Fri,  7 Jan 2022 02:26:02 +0000
Message-Id: <20220107022602.622455-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Remove unneeded variable used to store return value.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 drivers/power/supply/ab8500_fg.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index b0919a6a6587..3927f4ad7c38 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -3170,7 +3170,6 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 
 static int ab8500_fg_remove(struct platform_device *pdev)
 {
-	int ret = 0;
 	struct ab8500_fg *di = platform_get_drvdata(pdev);
 
 	component_del(&pdev->dev, &ab8500_fg_component_ops);
@@ -3178,7 +3177,7 @@ static int ab8500_fg_remove(struct platform_device *pdev)
 	ab8500_fg_sysfs_exit(di);
 	ab8500_fg_sysfs_psy_remove_attrs(di);
 
-	return ret;
+	return 0;
 }
 
 static SIMPLE_DEV_PM_OPS(ab8500_fg_pm_ops, ab8500_fg_suspend, ab8500_fg_resume);
-- 
2.25.1


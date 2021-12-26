Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6F147F883
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 19:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbhLZSmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 13:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhLZSmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 13:42:24 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01EBC06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 10:42:23 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id v7so28258774wrv.12
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 10:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j1aFnyHFUtPdBZotM5iBED56xT2FvKcAtJi+DzbG5wA=;
        b=KdpXsUBvXceMlS3BbbivfGX38reWvw/ataU6adl3aWWSdA0MMAeYpnG/EgMZ6+vdUj
         D3HZgQF/Vd2gcjsGO77PDmV5n8e5xQKImGcwlcDDg5EvQNVDH3KIbHD7DdYRuiGDpFql
         1yVswVelaXTskyge3EfGoOQy3NA/lapbL5zCiBz26ycww8I5xpSMZHG/zPGt6Pj2fnYy
         Mbo2Wxa2gH0gyP7hfhzoT34KtMZ9Eg8A/Sc9qEA2qz1oIsvoKONcj75J+NBHOmy3+Bvi
         Lp2S2+cE9RdTRwDMR1c/gbscYQbR21JD0pwtnow/a0Dqs9fbVAbHndoSyP+cb2etQTL9
         bPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j1aFnyHFUtPdBZotM5iBED56xT2FvKcAtJi+DzbG5wA=;
        b=lvWzC/TDw76MAsocvFlDEpHDgQLJC017mcWhbc0dt9zK3ydt8zMTc1LxuWKH33/aAc
         sHiHWcVXpRzop0IbfA2XsYsp+alJA0qVboBQb3j7viYkIOAShgzQM4PCn1WhTbwqwWIj
         9uji24lwlgCEWwhar6+LsqsHlwODNWz0qZRI+bE2PhS8jJO4SfUop5pneciLrhmLXRxX
         86G0jRZxo3HJNK4R9i7k59Wf/fCDx1Sw5HDDp0F6iXKF8JlAyWNnXv3EPWFNR9C461sP
         5OPY0/srR5LweUuJ9GgWTiimCfJacEHm2H8QRIOUd8Ra+hzWbSHhLoAXXZ2KBYPVld4z
         uA2Q==
X-Gm-Message-State: AOAM5318QSm7hSCw5pDF86JEHlltneTvkMGBYcaKIUhI/tV3OyU/oIQD
        8uKdTcEixv2Rsp+wpwhdoM0=
X-Google-Smtp-Source: ABdhPJwDY7Ucruwn5gzXi8gy4EPXbNU+4YBcDRBXoC7wULgEfe0NyHFGWdiUFjJPpEF7NIfueAB1Rg==
X-Received: by 2002:adf:ecc3:: with SMTP id s3mr10351148wro.713.1640544142264;
        Sun, 26 Dec 2021 10:42:22 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::abe6])
        by smtp.gmail.com with ESMTPSA id u10sm13809421wrs.28.2021.12.26.10.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 10:42:22 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: remove GET_CVID_ROM_VERSION
Date:   Sun, 26 Dec 2021 19:42:17 +0100
Message-Id: <20211226184217.9726-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro GET_CVID_ROM_VERSION is not used. Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/HalVerDef.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/HalVerDef.h b/drivers/staging/r8188eu/include/HalVerDef.h
index 1d96657e6a98..62b94c993f0d 100644
--- a/drivers/staging/r8188eu/include/HalVerDef.h
+++ b/drivers/staging/r8188eu/include/HalVerDef.h
@@ -35,7 +35,6 @@ struct HAL_VERSION {
 #define GET_CVID_CHIP_TYPE(version)	(((version).ChipType))
 #define GET_CVID_MANUFACTUER(version)	(((version).VendorType))
 #define GET_CVID_CUT_VERSION(version)	(((version).CUTVersion))
-#define GET_CVID_ROM_VERSION(version)	(((version).ROMVer) & ROM_VERSION_MASK)
 
 /* Common Macro. -- */
 /* HAL_VERSION VersionID */
-- 
2.34.1


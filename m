Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED89550E6D9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243856AbiDYRVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243896AbiDYRUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:20:55 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A3A28986
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:17:50 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n8so27890140plh.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8YzR51QEc0FmsjhtLkzToQteumKq7pdzNMCr5bpUTLA=;
        b=KI8XoIn8sA1Kr0nnIo9Ua9/WXx/WtnTL7iCD+xyEb2AqSff5ssQSSwz67cRCldCuz2
         5tGXvRzZusva2cah+TXpAQRyWUu8v3pDwDKXgOWXk5zNuAwDLFs0YbzQv3DYsaWuAIgt
         ubFS1DwY4ijVRG+Lb0NA209xKewZH372xe9fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8YzR51QEc0FmsjhtLkzToQteumKq7pdzNMCr5bpUTLA=;
        b=kha6Y9+ExqwVSDb7WSERQWq0F8OHruF9GqMHT4Xf6do9tBQrB8p6w7+H9l8FTl5qVk
         GP+4iKNp7MTK/yVq7fo4nR8y8wxKNuxzlwZAMJZqz8ZhFgzAOkMuG0cIRVlPS8iiFden
         moZxVsOIVL6Dt4JbhEHOEWcF8PICk1UijwC6rS3gwJVsp4rdjocfm2popcsSi65KDwf+
         dFK0MgyWwNWWnHkAA7lP5TKLgp1qheTgWBwvgNGxlXsZzBbzFOBxNF3b5ANeE2YN6CY9
         Ecd9hdW6BuILWJTtGYQkaE6lR611xGcomQgr75Zg5fNDaQQa+1iNprnc/Zsy2iSD0ad5
         /agg==
X-Gm-Message-State: AOAM5329E4YIcNG4Yz3D6bO9tGUNzn2NkdJDEcxToo9eF9xLlzjpsSds
        jqf1k+FissR3Z1LO2zinessRoA==
X-Google-Smtp-Source: ABdhPJyZ0i9zPof9RW56oqxaQTCkRXXF1qA+ge9Y5uWq/CGWH38Llght29WWiBDMfc7MqV2Y83VE5A==
X-Received: by 2002:a17:90b:4d01:b0:1d0:f39f:6073 with SMTP id mw1-20020a17090b4d0100b001d0f39f6073mr21941393pjb.175.1650907069957;
        Mon, 25 Apr 2022 10:17:49 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:3897:4488:e7c2:f2a1])
        by smtp.gmail.com with UTF8SMTPSA id h6-20020a056a00218600b004f65315bb37sm12804907pfi.13.2022.04.25.10.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 10:17:49 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 1/2] soc: rockchip: Clean up Kconfig whitespace
Date:   Mon, 25 Apr 2022 10:17:36 -0700
Message-Id: <20220425171737.321813-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are spaces instead of tabs, and other inconsistent indentation.

I'm going to be editing one of these, so get it in shape first.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 * New patch

 drivers/soc/rockchip/Kconfig | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/rockchip/Kconfig b/drivers/soc/rockchip/Kconfig
index 156ac0e0c8fe..aff2f7e95237 100644
--- a/drivers/soc/rockchip/Kconfig
+++ b/drivers/soc/rockchip/Kconfig
@@ -23,23 +23,23 @@ config ROCKCHIP_IODOMAIN
 	  voltage supplied by the regulators.
 
 config ROCKCHIP_PM_DOMAINS
-        bool "Rockchip generic power domain"
-        depends on PM
-        select PM_GENERIC_DOMAINS
-        help
-          Say y here to enable power domain support.
-          In order to meet high performance and low power requirements, a power
-          management unit is designed or saving power when RK3288 in low power
-          mode. The RK3288 PMU is dedicated for managing the power of the whole chip.
+	bool "Rockchip generic power domain"
+	depends on PM
+	select PM_GENERIC_DOMAINS
+	help
+	  Say y here to enable power domain support.
+	  In order to meet high performance and low power requirements, a power
+	  management unit is designed or saving power when RK3288 in low power
+	  mode. The RK3288 PMU is dedicated for managing the power of the whole chip.
 
-          If unsure, say N.
+	  If unsure, say N.
 
 config ROCKCHIP_DTPM
 	tristate "Rockchip DTPM hierarchy"
 	depends on DTPM && m
 	help
-	 Describe the hierarchy for the Dynamic Thermal Power
-	 Management tree on this platform. That will create all the
-	 power capping capable devices.
+	  Describe the hierarchy for the Dynamic Thermal Power Management tree
+	  on this platform. That will create all the power capping capable
+	  devices.
 
 endif
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog


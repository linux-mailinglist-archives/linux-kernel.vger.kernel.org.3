Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673FC4B99DB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 08:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236307AbiBQHc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 02:32:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbiBQHc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 02:32:57 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A2C209D2F;
        Wed, 16 Feb 2022 23:32:43 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id qx21so4925554ejb.13;
        Wed, 16 Feb 2022 23:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OdwrWOrEdwiMMYGpBIS4fJP8/7wOvnlAzLGSpTwQbl8=;
        b=E0Pzt+TrC0hs8egvDVPuY7K5vH+NKUaV8qof//O22zvXO9UyYLDFazEeg8cE0CMAJ2
         0rI/PKYCdzT3tXnhBKnC97iiHh0lpr/TqFatp5+Sgo0e2F24AGSoI3wd5ApFfzTxCx2+
         nQ6BptuAC4C6UXGYg+o/gOcsIUHb8sGy6HkZqrVONDjcaBYGpgiSJ7MjN9sZzB/zH61P
         O96yi5F2ni00IAfoJ5J0U7BJiTlDa36grFqL9jh+rvwOQjYA5+w+0Ew4gvjfHYutVh3g
         YMPy/shPsIBWG3x0+3iXBedde2kfptsjSYxbjHyM0uzSaOvPDYXf7i1921ubnh/ICF6M
         LaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OdwrWOrEdwiMMYGpBIS4fJP8/7wOvnlAzLGSpTwQbl8=;
        b=8MbxaNXy6v4p7phZq3SydY4fcvH0b0+AQOwcm1EwhhnPxlVm1TZAPcKGhcBfDTQN4o
         iGGLRpLVaIIkfLFWjAK5GRtvLb/v/FhlfaKVfrDNy5rZE3B1SGLD4Q3BMmyQMLR0pq/X
         pJOzKajNe8PWBS0/KZkzRL6VSSoOJgxUQtO7zCMcnxWuw9OADzSjJ5t2apC1P4/Kxfq+
         1B569Ls4lDmGhBduZZqrG6edENPEw/wfT2Ha3X9jRAS1CJizqqABbjngHr3FQlbUP/l1
         iJJWgT5fAL6kst8yFKftOmVhP80yQYinVl5TLmxFaOfd/BM5lAQs+tOxqfCNnzC9LIj2
         MRrA==
X-Gm-Message-State: AOAM533fGQF5pHiVYNFfi6O1IIg/HQaafTWrRrK8mPiuguUCrz5zPiM9
        aZNdeBRfITjk5BUBYrndgIY=
X-Google-Smtp-Source: ABdhPJxthUt8R6DtAvZkHZw8oQS0b2DrKQR6ztXC+JXuymJum5MeryM9Myb82M/Ua5QFK4FBtTeCJA==
X-Received: by 2002:a17:906:2ac9:b0:6ce:dc0f:9139 with SMTP id m9-20020a1709062ac900b006cedc0f9139mr1341927eje.206.1645083161784;
        Wed, 16 Feb 2022 23:32:41 -0800 (PST)
Received: from tiger.museclub.art (p200300cf9f235800e668694710673d4b.dip0.t-ipconnect.de. [2003:cf:9f23:5800:e668:6947:1067:3d4b])
        by smtp.googlemail.com with ESMTPSA id m4sm892028ejl.45.2022.02.16.23.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 23:32:41 -0800 (PST)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (asus-ec-sensors) depend on X86 in KConfig
Date:   Thu, 17 Feb 2022 08:32:38 +0100
Message-Id: <20220217073238.2479005-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the supported mainboards are for the X86 platform

Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 drivers/hwmon/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index ce9149e0648f..b3597ba66ddb 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2284,6 +2284,7 @@ config SENSORS_ASUS_WMI_EC
 
 config SENSORS_ASUS_EC
 	tristate "ASUS EC Sensors"
+	depends on X86
 	help
 	  If you say yes here you get support for the ACPI embedded controller
 	  hardware monitoring interface found in ASUS motherboards. The driver
-- 
2.35.1


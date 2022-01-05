Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75371485041
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 10:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239013AbiAEJmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 04:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbiAEJl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 04:41:56 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D9CC061761;
        Wed,  5 Jan 2022 01:41:56 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 200so35076400pgg.3;
        Wed, 05 Jan 2022 01:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ij2/PEZo/kB0cy8ZkQ9Gkx/6WmFNfo8g3EBz9u3NBx8=;
        b=cEGp9N3L4a1guOCLM5EC5ayuIr6DJyN6zCBP10+Cp3OJdLKfIkB5FSCNvO6J1Bn50Z
         fgW4kkc5b1LWym4Ci3AKTd0Htkvf4o1EY8zbQQlyivqSr/MXRSyo08ChcMRvsbpYtmGj
         LPOz6cn6s+dmmOBDwkwXykCwzsiNtT1ZHr17954oxoC1viDqB8C4ps5ATV2qQ1C+GzIB
         uPHyZXGqGnGn7yLrzUbhSh/BZYW3O6Izp3uP2zjTke6RKnhdYiZKLtkMfgCahBO13B8V
         wX3ZjPynfP5Z7tSt/Wn4y7dLVIDXnWXozhp1PufkWe3hQ3Mg6TxVvG5e3R97MRU9ecV+
         oD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ij2/PEZo/kB0cy8ZkQ9Gkx/6WmFNfo8g3EBz9u3NBx8=;
        b=TiM/soUQXy3T8GOIip3VITzplW5I0xQZ112YcNRdI7Fn+QrNWcyv5b4e0sMGz5GRE8
         kcWLoMXmDUx2m4Szl8WeBBZdRKsyig7JcAptBeTUHA1RGItZky+diTOSBQibsHNtB3DW
         J6BQ0t8S2pQ5UZhojz6arg6O7WWCy3skCMxE+Ovm4bUkxerbx655ZIvimAHkPqslw0vP
         Jtcm9zDIlcAvHd+wQe6G9vqrid1Q0I23tU/BwOVKgSiPyVbse65jGh77/x/JYgJr8FVs
         oNPU3oCNaFm6e6FhtZ4RT7qsouEoWyCf3HKNvWTpRNqYAkZkZmgTdtB3+rSa5B4SDDM+
         1IMA==
X-Gm-Message-State: AOAM533Pmk96l62vBPII2FozG77hyMWOluq1LfdbbUWxaXwaqmzrkwoG
        ABz7/w5FQE4/bzetrPFy5zA=
X-Google-Smtp-Source: ABdhPJzG0tqkZDjvl0SUw8BDNySrbL7XL9YwE5JAgtBSjUAV/Tt2slIcygusBs1lZxyjHb/SxkufMQ==
X-Received: by 2002:a05:6a00:a94:b0:44c:ecb2:6018 with SMTP id b20-20020a056a000a9400b0044cecb26018mr54850347pfl.57.1641375716364;
        Wed, 05 Jan 2022 01:41:56 -0800 (PST)
Received: from localhost.localdomain (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id c17sm1988453pjs.34.2022.01.05.01.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 01:41:55 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jonathan.Cameron@huawei.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        u.kleine-koenig@pengutronix.de,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>
Subject: [PATCH] counter: 104-quad-8: Add COMPILE_TEST depends
Date:   Wed,  5 Jan 2022 18:41:37 +0900
Message-Id: <20220105094137.259111-1-vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

104_QUAD_8 depends on X86, but compiles fine on ARCH=arm. This patch
adds support for COMPILE_TEST which is useful for compile testing code
changes to the driver and Counter subsystem.

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Syed Nayyar Waris <syednwaris@gmail.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index 3dcdb681c4e4..5edd155f1911 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -14,7 +14,7 @@ if COUNTER
 
 config 104_QUAD_8
 	tristate "ACCES 104-QUAD-8 driver"
-	depends on PC104 && X86
+	depends on (PC104 && X86) || COMPILE_TEST
 	select ISA_BUS_API
 	help
 	  Say yes here to build support for the ACCES 104-QUAD-8 quadrature

base-commit: 088879292a0a3672a6acc9215174fbc355ed3daa
-- 
2.33.1


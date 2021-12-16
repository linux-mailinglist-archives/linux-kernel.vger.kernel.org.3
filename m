Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF86B476BFF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 09:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbhLPIdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 03:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbhLPIdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 03:33:07 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF968C061574;
        Thu, 16 Dec 2021 00:33:06 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id l22so48157797lfg.7;
        Thu, 16 Dec 2021 00:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZeuoAPntk3hXwhFRVqNwsz2JIoOQMdkHLY6+hrxWebk=;
        b=RBlQLIYIk3EKDUD0ddqeYK9I+MrDrQ1eTNcv1Z/II8hQcvkH39XWFW+Iu1X3rzaD8B
         22Qrx5IqvkUzTfxtOZTSef5s/metOSUftONiv3Ms6iMSb3Fxm/i8kFz9nNMg6qpSR31q
         LID9GC3IKbCVs3pQG5Nxogo0GmqZnjTEYEb6qUTP4qOFu+qWUb95oUD+DVlPqUPXCMHZ
         G3IF87r9ALmyNHP3uLNZuD82SH98wKsYbPrqkhzLMAC4D9nWqWUFxAxLFlADwNE3PFkI
         d+y3xhYI3ApO03lbv4K5eWr7i8f2kJDw18UJrTBInCYk1PQpNfAlRbRi6ErMsXb/4091
         sVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZeuoAPntk3hXwhFRVqNwsz2JIoOQMdkHLY6+hrxWebk=;
        b=3C3D1mhd68esO/2qfiO7LG53wxndJilIy7Nhbuc5YNEdDT50jT+1NYtgg4uZdlKI2Y
         uA50NmMs4LqdqQ+TaJXS5E2Ae5Kvbe5LoPCaSPqi0wi6KS7VQYdU8gj/HI91Ef4M/YsK
         FYP7P/YnfYE9UezvlwaoUzUBOH7t/b3mp6beyPuyr5uiFI1aFZ4jdX2wdkiKIt4SSFxh
         iM/W2KWc+qNKaP3cEQhuIGicCLsm02a87/Wco3ZDvjJ5Wj9UrnnDIZUe8BWtFQmc7KzG
         vkEN5WA9ldjRwRisoDMv6/RnTo+zC/xnNA5nRyjH0OTaWzTrqffrCbII899GAGGi2L5Y
         /ghA==
X-Gm-Message-State: AOAM532stOpz8y+OCQt/qDdYwY6G/gmsnCmmYKeJgoQS2zzxrad+voeM
        V8TL3NQsLrUFYpvxgQ9sMdKTGEHCC5ZatAu1mOo=
X-Google-Smtp-Source: ABdhPJyy7KZQLrZ2S+3EQXDdnieeVzasTDFGA0g1IzBfGoA5XtGkI2iOXswKQ1Zx0owOoe9R8wAXdw==
X-Received: by 2002:a05:6512:370c:: with SMTP id z12mr131328lfr.458.1639643585259;
        Thu, 16 Dec 2021 00:33:05 -0800 (PST)
Received: from NB-893.corp.yadro.com ([89.207.88.249])
        by smtp.googlemail.com with ESMTPSA id d16sm993066ljj.87.2021.12.16.00.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 00:33:04 -0800 (PST)
From:   Arseny Demidov <arsdemal@gmail.com>
X-Google-Original-From: Arseny Demidov <a.demidov@yadro.com>
Cc:     arsdemal@gmail.com, rahul.tanwar@linux.intel.com,
        andriy.shevchenko@intel.com, Arseny Demidov <a.demidov@yadro.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon : (mr75203) fix macro typo
Date:   Thu, 16 Dec 2021 11:33:02 +0300
Message-Id: <20211216083302.986-1-a.demidov@yadro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the file mr75203.c we have a macro named POWER_DELAY_CYCLE_256,
the correct value should be 0x100. The register ip_tmr is expressed
in units of IP clk cycles, in accordance with the datasheet.
Typical power-up delays for Temperature Sensor are 256 cycles i.e. 0x100.

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


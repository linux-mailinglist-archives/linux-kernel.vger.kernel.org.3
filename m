Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF0F46887F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 01:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhLEAFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 19:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhLEAE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 19:04:56 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407D5C061751;
        Sat,  4 Dec 2021 16:01:30 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 133so5332224wme.0;
        Sat, 04 Dec 2021 16:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b1M6WEJIqos5aucBCd6jDkuxOEQFBoT8fWsTpX9EDKk=;
        b=FlL7KwJCcyZsmPVH3LXx0VSSOPNNdtZqL4LESL4aHEcMTk0qPiEJIBmc53nH9SA15J
         dN4N7uIL9ZxxXWPU9enmL+Vm7bsUQvZp5ue/d2p6r4T8f7gDj++ORUTePyr9HANzHimK
         UEVLrl4J65Wm77CMiYzLjL+pS/CFLhXuPo8mgAUZEA7DfyIwuiASXdSxPyTNb/q0iYct
         VIY3fK49de5NQkPGsCh8ZoSD+tTbwln2T5JZB2QyeuY36mvIfbnsMDO+aVXaSHflMOhI
         3JwxmjVklNN+Oy7D/kfZycL15G/4aq/HWFM+1ALtha2aeMvy8/U1oyoUQDVjV7mpguo4
         U47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b1M6WEJIqos5aucBCd6jDkuxOEQFBoT8fWsTpX9EDKk=;
        b=JzCRzqX8CkrhunfEU+E7pZYuVYTN6vn5xFbbbq7Aw0QlyjwIcbdoY4wAeqt/D+cUCf
         qpN8ki5xLq0fBSHiiFLDQlJSdunIP4ERc8eBvkg6v7/gdS9a3QhjrQ6e2HpLeVI9EyJ6
         s5ZXA7qdLN5jH9JNXRPLIOeJyJJdfWN11BUNKIm1OOr6oJ+Y+V9gKy8QUWViXCJT6d7F
         Sovcbjt3pm4R7mu7WqDnPmIPU9gX2y4rXEd2Cc+SFxf8TRCoUzYaepX1EIzMWQWxZ93s
         QErCK/FWtTJJACHMqZLzWf/XVn10wUlY97LSBXFegTHe3Ui6n0/tAJCecd+ELtUlhLUB
         uQRw==
X-Gm-Message-State: AOAM532rpSyGMm0JSCZHvt+c3RZOKv0GrV2PEp/vrcZaJ5jcoYqb3HZC
        Kbn6o9HEqkec+UT6kVcqgfgGOgBptLRS6Q==
X-Google-Smtp-Source: ABdhPJwML48TZcpQ7TSDCm+L82uEYbc8vAr3fJS5fAziPl80LaLVXf5jfsgufzw8PuRAGvkwegamRA==
X-Received: by 2002:a05:600c:19d1:: with SMTP id u17mr26886894wmq.148.1638662488920;
        Sat, 04 Dec 2021 16:01:28 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id 38sm7341234wrc.1.2021.12.04.16.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 16:01:28 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: ti_am335x_tsc: remove redundant assignment to variable config
Date:   Sun,  5 Dec 2021 00:01:27 +0000
Message-Id: <20211205000127.129554-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable config is being assigned a value that is never read, it is
being re-assigned a new value immediately afterwards. Remove the
redundant assignment.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/input/touchscreen/ti_am335x_tsc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index 83e685557a19..13241268ace0 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -155,7 +155,6 @@ static void titsc_step_config(struct titsc *ts_dev)
 		titsc_writel(ts_dev, REG_STEPDELAY(i), STEPCONFIG_OPENDLY);
 	}
 
-	config = 0;
 	config = STEPCONFIG_MODE_HWSYNC |
 			STEPCONFIG_AVG_16 | ts_dev->bit_yn |
 			STEPCONFIG_INM_ADCREFM;
-- 
2.33.1


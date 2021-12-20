Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D122147B0C1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 16:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237644AbhLTPzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 10:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237485AbhLTPza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 10:55:30 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BF6C061574;
        Mon, 20 Dec 2021 07:55:29 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id i22so20964949wrb.13;
        Mon, 20 Dec 2021 07:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9FPHt4xWJuyC6gdHJsu28XiwBLFa9d5usSSlTiDeCYw=;
        b=c8IvuhTEtIBHwwXw3dX7LRmVixLdlxaYUGHybVAQVwwXG4eQf5J9X+YhrOyRL4UC6D
         paFv3FscJAJQkAz95YljUdLLhbJgjoI+neVJzFFNvrzHWoHRR2I7dzn+VFC6C4BnehdG
         alldIw57cUKc1XEoGWI5UOwFn9BnUG5oEoAf9gGbeKGzSwSC7HtAIeRBMmdKWq0X8cTB
         GSKrT94y4n8EwBdtJ+qFhdLROCaG8RJHs7npZpsSO54NMrZRzTolMgmyuuwqBXxVqk2q
         kQAe38bZkALupoYJH+oHaLJys8da9nGG3z/BuTUdQjmwrw/9ot35gWUCne0AekE+oPV6
         0jPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9FPHt4xWJuyC6gdHJsu28XiwBLFa9d5usSSlTiDeCYw=;
        b=Motu4rFJqh3mjuZ68FlMy7IH9Yl4tuYBTHj2WODL1NLeokrswU0dV6j+SZkn4QjiJ1
         rxpBV+cLLazH/5kgAjCiobj6OdRVm6Qqszpjdz2ggfH/CzRGe/F1fYG1BUyEpyVGHkW4
         VxiZ3vGYtR0spiYkEaJkAn+KRDltCoCiTf0hdwhJeALxOoqfztyVVtXgSUDoPuUmR2Bl
         PPOlJ7brCZxrUXP3yL/3ZNE814m7343q2submd9dtmjBGsKQC3LgFg6qT5H+Ux5bTHW6
         KKtMqJBv+IQ8F7TenE14Dom5fotsXc6GygLpAfBkcbrCAOMR2UwbrYa/XULyOL9SIZ8P
         tJSg==
X-Gm-Message-State: AOAM530blkJXwWxxVVR9aCK27Qu0XVE9KROR/hCk8DX00rS5RWbx81Td
        1AVoDceV3nBd06iqVMJURF4=
X-Google-Smtp-Source: ABdhPJzhHDlAtzMTkmgBhfZNL3YQOcg2PDhKP1f6lkVEeVqJ3mrcrGIKbbldJpB3rP45ucn6NZAhhA==
X-Received: by 2002:a5d:47ab:: with SMTP id 11mr5624491wrb.249.1640015728498;
        Mon, 20 Dec 2021 07:55:28 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id b19sm21053664wmb.38.2021.12.20.07.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 07:55:28 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] hwmon/pmbus: (ir38064): Fix spelling mistake "comaptible" -> "compatible"
Date:   Mon, 20 Dec 2021 15:55:27 +0000
Message-Id: <20211220155527.179125-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in the module description, fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/hwmon/pmbus/ir38064.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/ir38064.c b/drivers/hwmon/pmbus/ir38064.c
index 07bdbb16f216..0ea7e1c18bdc 100644
--- a/drivers/hwmon/pmbus/ir38064.c
+++ b/drivers/hwmon/pmbus/ir38064.c
@@ -85,6 +85,6 @@ static struct i2c_driver ir38064_driver = {
 module_i2c_driver(ir38064_driver);
 
 MODULE_AUTHOR("Maxim Sloyko <maxims@google.com>");
-MODULE_DESCRIPTION("PMBus driver for Infineon IR38064 and comaptible chips");
+MODULE_DESCRIPTION("PMBus driver for Infineon IR38064 and compatible chips");
 MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS(PMBUS);
-- 
2.33.1


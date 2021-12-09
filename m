Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC2646E080
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 02:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238873AbhLIB5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 20:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbhLIB5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 20:57:30 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DE2C061746;
        Wed,  8 Dec 2021 17:53:57 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id x7so3316845pjn.0;
        Wed, 08 Dec 2021 17:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E8BO8VV/6qLXRIvEgLOZY3lZVJmNDElsUWxpp8vW694=;
        b=S/JqkabhtdsxBzqpHLg5YPOvqUYux8W6PNImFWoIDXET491epw7D18lV7nLulO4XZ+
         vZOo8rGCvPMXUiEScGKqW3qqOzDoj44pDYequnJOr6ZUbtKFPvnu9PPs94fsZEdrQLCF
         HDUY583dYYzUOv3k/WQBuMMmd4g0rUSdzRBAB8Pv0vypRCf6xyDfB8fOYJD4g8cwTFnB
         TZzXGP+pNg8gc9NDnGgSjQSuESjw8/ZfjQJLgLq0Db3yMbCCPuuoOU3qlbER2fjzLPb9
         z24p+jti34KGyuy6y3T7c0b+TKUT+hHUC5y3q1oqthjjXPMZtEp5+u0NdfpPIcOrc9OY
         iaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E8BO8VV/6qLXRIvEgLOZY3lZVJmNDElsUWxpp8vW694=;
        b=X7temFfIeBMw2jBZgJf6HZGSI4H0jXxl3OyXtFjvhPoW25CC43E7SeqQMpuUx84gPe
         +OIXaxVv/+VIyLVnCbMoCJ/hIxfgk2dPu7aJoj3YM7mdgvs5pHmjekotfIXLrAhc9P0C
         /+tFnghjlFq1KDs1CGe0GeDGkLRHui+CDpLAhbMYxc/CFFze87fmCboT5PBNNzcG5tuy
         mTb8chkOMNCeZwVqcRMKhC9lcoKjtikWaWblHyCw2CTTXc918hllOICGEIuuVWRako+4
         ayQNyyEpzgdnrv0y/3xVOSXZ+Tysd00WzdAEPpiHLQONzAr7wb3cMpSux47LmS/YhJVX
         EA5g==
X-Gm-Message-State: AOAM530teKlNqOomWMufRp3EeHzoWrYi0n7S2Owrmjj0aJcj3AjNMJWx
        2cEuaC9a0pa/Rf6qQOd/aoSAWaT5xlQ=
X-Google-Smtp-Source: ABdhPJz97aD7aBSkPAS/LKuqwOLVSetfZ7089L1ro00cytBI60caR4U9yVTsprn+b1Vo4sz8ALDAUA==
X-Received: by 2002:a17:902:d491:b0:142:892d:a89 with SMTP id c17-20020a170902d49100b00142892d0a89mr62509652plg.20.1639014837114;
        Wed, 08 Dec 2021 17:53:57 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y8sm4864899pfi.56.2021.12.08.17.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 17:53:56 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     wim@linux-watchdog.org
Cc:     linux@roeck-us.net, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, chiminghao <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cm>
Subject: [PATCH] drivers:watchdog:remove unneeded variable
Date:   Thu,  9 Dec 2021 01:53:53 +0000
Message-Id: <20211209015353.409612-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chiminghao <chi.minghao@zte.com.cn>

return value form directly instead of
taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cm>
Signed-off-by: chiminghao <chi.minghao@zte.com.cn>
---
 drivers/watchdog/pcwd_pci.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/watchdog/pcwd_pci.c b/drivers/watchdog/pcwd_pci.c
index 54d86fcb1837..edbc0f28d399 100644
--- a/drivers/watchdog/pcwd_pci.c
+++ b/drivers/watchdog/pcwd_pci.c
@@ -215,10 +215,7 @@ static inline void pcipcwd_check_temperature_support(void)
 
 static int pcipcwd_get_option_switches(void)
 {
-	int option_switches;
-
-	option_switches = inb_p(pcipcwd_private.io_addr + 3);
-	return option_switches;
+	return inb_p(pcipcwd_private.io_addr + 3);
 }
 
 static void pcipcwd_show_card_info(void)
-- 
2.25.1


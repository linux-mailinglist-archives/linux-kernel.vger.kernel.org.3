Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D7F488EDB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 04:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238301AbiAJDMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 22:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbiAJDMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 22:12:36 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF34C06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 19:12:36 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id i8so9984733pgt.13
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 19:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W7ns24hJzFvAWvzuWZP01tC92QonI9qqQCzq/t0/f1M=;
        b=otV+dLdOwvWEhoQm6fhpqKPOzOR9Rlf/zPp84rmt8AnFiPn+leaB5/7XSk3piAh1tY
         KHVc5vPZJ3/5oq34YZX4WNWnjzA5MAKXeHcnhKux6LDhYIXFTWzIql6mNXgyezzfGTSc
         eQZyqzDTyZVZpSJHRZwO59FSlLTNu6TMC77m8Y1OOfiEf16s5vKtIVgvffAuhx+YNaiV
         Ky/lEv1nwRGdq9jLp5sYZTaQdSJTx0mVfDoCyZRfmnNn3DeXOktSkOTWPtypgaDBAXhA
         4wfoCDtRn22C1tcgetEnbzQw6725RoyKmSiqHDydTeRfPLNm/caB3f5yKyoFJPtRQkZ9
         dneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W7ns24hJzFvAWvzuWZP01tC92QonI9qqQCzq/t0/f1M=;
        b=eS+mBHg9u9ACXG4hyO/59R+ONhmny/QWJ0t3qX64rQslxchFetVJmjswok1q1Qs0KY
         Jco4WHVK1PNiHGArL/mq7z8tFW7KFL0EY0qB5fsswRrsAnJ1jhbDh/tblgKvsZjCFEmE
         ywctcNyCoeRlHgwmDIZjSeIWTcMTxYaDJijIya9W484ZuQMjZvq4F5BymCf2OJ/UXwAT
         IaoN1ARNSX7PoawzDPB+oGSgGFioxRofLzSZs+NoBWRG9IgNkPgy17W4rxzs3vVbxO7/
         niYH9DNDfxv/IBmsBug8o3QymwJKKslkFxyWotMP0dEVImSk9wGxHHMNuYuZJKVMnwwX
         QH2w==
X-Gm-Message-State: AOAM532+kAPimxtiXMfm1xfV2lfA7oSN6r5GWhyh/atFi0lHlF519YlP
        0eaQWnXJNA5RrpJsnsyn38w=
X-Google-Smtp-Source: ABdhPJw+DGHzxP8RToh7xSngjP/J/B5PHI0KlFBymrn0VOeHGMEj1RRdRahyrp8dErb7wHYuVkrcdQ==
X-Received: by 2002:a63:4602:: with SMTP id t2mr65440282pga.108.1641784356099;
        Sun, 09 Jan 2022 19:12:36 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 93sm6974360pjo.26.2022.01.09.19.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 19:12:35 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     miquel.raynal@bootlin.com
Cc:     conor.culhane@silvaco.com, alexandre.belloni@bootlin.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] i3c: master: remove unneeded variable
Date:   Mon, 10 Jan 2022 03:12:31 +0000
Message-Id: <20220110031231.644805-1-deng.changcheng@zte.com.cn>
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
 drivers/i3c/master/svc-i3c-master.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 7550dad64ecf..d6e9ed74cdcf 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -1597,12 +1597,11 @@ static int __maybe_unused svc_i3c_runtime_suspend(struct device *dev)
 static int __maybe_unused svc_i3c_runtime_resume(struct device *dev)
 {
 	struct svc_i3c_master *master = dev_get_drvdata(dev);
-	int ret = 0;
 
 	pinctrl_pm_select_default_state(dev);
 	svc_i3c_master_prepare_clks(master);
 
-	return ret;
+	return 0;
 }
 
 static const struct dev_pm_ops svc_i3c_pm_ops = {
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC2C48E53D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 09:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbiANIMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 03:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbiANIMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 03:12:23 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58390C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 00:12:23 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id h16so10199924qkp.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 00:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hKrZ7aea6T8UW10yLp5/RF48EailUZuU/n1ieIhEdB4=;
        b=NLl+qHtU5qjQlWu53hZvddcTiKV2JDQH41oiXBk0vJXn7zNznC24LrQC0kXr687FYD
         bL6mfOSiY6U2v86xc4ZAYI+gS9nkFiuaHFpcWFtS0wCRuCFUsJAT7DixF3PJG+RaJ0Zn
         r6NXW4Wgfo0jTHrYzbCtlGWLLlTJrO06bzA/yXRwiQMJFEAjWozxhoJx/DLYby1SqPVe
         LfA4GmMCfyCu7WllH0cPZYd1KAPzomY5p0jVHpvOq1W3Ujh6INP3H+J360PRiHA1/uHa
         3wXLLGBbXHrVVUDqwsd/VKnDktPuKpR+I68QKzoYzYvFL6GtyFbZuuuepOrdDQvdB4as
         MX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hKrZ7aea6T8UW10yLp5/RF48EailUZuU/n1ieIhEdB4=;
        b=EH7DMidjllLdF4/OgCZ/xgmPTFVK87KhWDKLkRTdEEe7JkJwIWs6RLsinSH8IMlPv1
         3dosHDNRqoQtKOWf8QRbcWng3EWQVg+xOOjdztDN63iFmXtO64cVdc/PWy5x9OhF38cM
         nJXp56NACScNdz5XOb6ltmpop0T9bEqQE7vst1xOr/h7mJmwl9O+j07+l5E2xtl0ry+k
         3W50O3RtOdvzB87Rbqlm5lgYxr89Sowiewopt2fgtBb/ItDB4kL+XyI4iuB4UyuFwvOX
         oNv+L1cZ/VvbO6St6sb+uJkrJxT7rxb0xu8p4w72vRzsRG0L1yK6SbSPC538M3soj0oP
         x9qg==
X-Gm-Message-State: AOAM5327AKKB0R5UXWoZDuIJBO17PPAD8xAA3Rs9DXb4N6jtyOHX8IAv
        mRJ6BcKYwuRFrRTqay1MiHE8YRYhKv7GQg==
X-Google-Smtp-Source: ABdhPJwi9hdZAQa/zdRa7r+1SWbMbyosqkq5IyAbPq4njrNrH0QrdGqnkfsTUV7Bs7pU8kqQtDECvw==
X-Received: by 2002:a05:620a:1a91:: with SMTP id bl17mr5755213qkb.175.1642147942437;
        Fri, 14 Jan 2022 00:12:22 -0800 (PST)
Received: from localhost (ec2-3-142-145-253.us-east-2.compute.amazonaws.com. [3.142.145.253])
        by smtp.gmail.com with ESMTPSA id s1sm3506643qtw.25.2022.01.14.00.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 00:12:22 -0800 (PST)
From:   Schspa Shi <schspa@gmail.com>
To:     tytso@mit.edu, Jason@zx2c4.com
Cc:     linux-kernel@vger.kernel.org, Schspa Shi <schspa@gmail.com>
Subject: [PATCH] random: fix typo in comments
Date:   Fri, 14 Jan 2022 16:12:16 +0800
Message-Id: <20220114081216.60403-1-schspa@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/or/for

Signed-off-by: Schspa Shi <schspa@gmail.com>
---
 drivers/char/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 227fb78027387..ba8d63f52c058 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -101,7 +101,7 @@
  * ===============================
  *
  * There are four exported interfaces; two for use within the kernel,
- * and two or use from userspace.
+ * and two for use from userspace.
  *
  * Exported interfaces ---- userspace output
  * -----------------------------------------
-- 
2.34.1


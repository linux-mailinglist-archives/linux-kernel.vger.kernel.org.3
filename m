Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376844A3AF4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 00:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356877AbiA3XVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 18:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiA3XVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 18:21:43 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB86C061714;
        Sun, 30 Jan 2022 15:21:43 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id f22-20020a1c1f16000000b003525bf08b1eso3799335wmf.0;
        Sun, 30 Jan 2022 15:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rh/aFR88ZjhEdPve2CXuC7cMgVrXGj4EEkYxSGMGtsI=;
        b=WGaZDSaea1WBFdb9VHHA32p9PKIEoEFqqgKs1wZ7/wAdUMv2fIWvUEZFYuQSKoXbKZ
         F+PLYr+4zu7MRByWKy17A7PMmnti3PS3fRNBlm4lhjVO/TRdneH9/q+2nN1VUjitJerC
         tAQSi9YKEacH1RP4Sso+L9X876le2ThycEAUJPIr681OBAPmKfUJMCpPwmuVHNPM4PpF
         eGENwTdsI13URuLz6zYKVuA8fKxgEwPWNcUuoFnc4OyN+KP8NQgwH9UJkLLVteQXua4R
         o4su1QeCcMN/1gFqTnWC5Jvw65hAjqR5hfnJv7n7Ic+14O8wXj5lyVQw+vFwR6CiL31Z
         g6GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rh/aFR88ZjhEdPve2CXuC7cMgVrXGj4EEkYxSGMGtsI=;
        b=GCUqKyt4SbP40kwOt5zSs1I5McMVVwstmvxvB+pkei9YBTTXUX/ojUIr0hGhtQWE8s
         ntJUkZI3itgPeKLCgFc7tYvUVuI5eaqfdCsEfMGjIwUhBhDV4Z2TcIt/mSj1EKRzB+v6
         xS2FBfCNFye+N8Anw81ozFiCtMrfwTRdUsYsXp8t6eI3e1dnbwJz4s4+VCShwgEV0wRg
         NBy58t0+69hQOgrlZEIIEFNkETmm6FoIryIC9EW6RjmuU65fH1tvUVpMscSzs1uahi0J
         BapfY+q7eIs4yR7i40Ag1wRcxmYbXTTz5xupV3pQXHxrav2xLFkE9eY2xtBz8rdWjrU2
         T+TQ==
X-Gm-Message-State: AOAM5330wr9m91EZWmPLmksUc7ZsaYMtEW2JNKV/hUSByk0i0VDzwdEq
        5qFfKrejnT+ruB/LWAvj9tEkw8ZDDoLK/A==
X-Google-Smtp-Source: ABdhPJxkd1ti9Bh4CKpLYv7SgqqhgMYHdXol+GBQUQsqLYXXmYUYh6zyE4NFIP350LIUsJNOljDHTg==
X-Received: by 2002:a7b:c455:: with SMTP id l21mr6764046wmi.91.1643584901750;
        Sun, 30 Jan 2022 15:21:41 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id z1sm7539919wmk.32.2022.01.30.15.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 15:21:41 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: saa7164: remove redundant assignment to variable idx
Date:   Sun, 30 Jan 2022 23:21:40 +0000
Message-Id: <20220130232140.9053-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable idx is being assigned a value that is never read, it is being
re-assigned a new value in the following for-loop. The assignmen is
redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/media/pci/saa7164/saa7164-cmd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/pci/saa7164/saa7164-cmd.c b/drivers/media/pci/saa7164/saa7164-cmd.c
index a65d810ce212..42bd8e76005b 100644
--- a/drivers/media/pci/saa7164/saa7164-cmd.c
+++ b/drivers/media/pci/saa7164/saa7164-cmd.c
@@ -187,7 +187,6 @@ static int saa7164_cmd_set(struct saa7164_dev *dev, struct tmComResInfo *msg,
 	mutex_lock(&dev->cmds[msg->id].lock);
 
 	size = msg->size;
-	idx = 0;
 	cmds = size / bus->m_wMaxReqSize;
 	if (size % bus->m_wMaxReqSize == 0)
 		cmds -= 1;
-- 
2.34.1


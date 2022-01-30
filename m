Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE144A3AE6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 00:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356805AbiA3XP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 18:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233966AbiA3XPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 18:15:23 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70350C061714;
        Sun, 30 Jan 2022 15:15:23 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id a13so21955121wrh.9;
        Sun, 30 Jan 2022 15:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HQzOpjN4jpynU13c99nks/ZsXDYZn3CGAw5YdJAL/50=;
        b=G22ikONgvyleMpBATP4ER6XpwoglCzlAaOsHMPEHY4q2tzIQFYZpjWtB5OFVPFPzh8
         KR4QxGZ5WWdxDhkGWf8lMcbLUXIWRd6mEYzFpEneYIte7rw/WT29ENxQ8LW0+q0vEGqB
         G8Jej4Ao5o4HYcScuur+iI3dyE7ApK+pwAWsJiBJcq2an8SmVwFghRmsZo6g/qHGQw3E
         Xi8l19XRinATB+duyRMdzRot08AZ6Fb5ubeEZI0ZLPrCycF3WA36Wr5vGPT3wMyqvOX7
         oGW3JUfPs/2qFCfulo5kspeKmhnCrsQNrDS8HkRbKy/yBBeI17vx9CzQPmd+9k8Vjb5G
         vFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HQzOpjN4jpynU13c99nks/ZsXDYZn3CGAw5YdJAL/50=;
        b=IuLi8pMF6oEEG6v5eLNYskHBk2mZHXQEBffaqQx8mCjg7di3XRS3tVSeIjbiooilqI
         k4I/mybk3vHdrs5uB/wKGQsc+XC4kkQdm/9wz+cYbrBiJMJHhx3mVUOz5fLPQHYaukik
         hOCK5Kf570Xt7DUNFE7YlMZkn2m4gODQ4a4Hkjjzo8Nlk3IET1UiQsZu1VF7wZuQTLPX
         Qo9OtLDLVb/9Vt/UeeBc3+Mxk6YyZRaOcP6jsCMy8e/C8EGvR++qpxPmMt/TiguR/sby
         NJ2Iz1D190g/Nf6ucMCQdIGb8FNrE8oi1136uz8PhZYx25KMGXMRE7G2iQOcXkjBWrXN
         FXCw==
X-Gm-Message-State: AOAM531E5hYLoRTtA7f+8euzCHm7OZ8hUTEvdTQO4t8lRCCeOULoOWdJ
        nKtIgnujPA7YMcJGGI22qds=
X-Google-Smtp-Source: ABdhPJz4t5PWEY7rzyZ8lAe1gm5TbbOpIDWuK3JLRzkWTP957SBb9P+Q9hpAXxWC3Odf0/HECyJJ2Q==
X-Received: by 2002:adf:f9c9:: with SMTP id w9mr14736464wrr.15.1643584521962;
        Sun, 30 Jan 2022 15:15:21 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id p8sm11079205wrr.16.2022.01.30.15.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 15:15:21 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: saa7134: remove redundant assignment to variable id
Date:   Sun, 30 Jan 2022 23:15:20 +0000
Message-Id: <20220130231520.8800-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable id is being assigned a value that is never read. The
assignment is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/media/pci/saa7134/saa7134-video.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/media/pci/saa7134/saa7134-video.c b/drivers/media/pci/saa7134/saa7134-video.c
index 7bc4c7709f4d..48543ad3d595 100644
--- a/drivers/media/pci/saa7134/saa7134-video.c
+++ b/drivers/media/pci/saa7134/saa7134-video.c
@@ -1535,8 +1535,6 @@ int saa7134_s_std(struct file *file, void *priv, v4l2_std_id id)
 			return -EINVAL;
 	}
 
-	id = tvnorms[i].id;
-
 	if (!is_empress(file) && fh == dev->overlay_owner) {
 		spin_lock_irqsave(&dev->slock, flags);
 		stop_preview(dev);
-- 
2.34.1


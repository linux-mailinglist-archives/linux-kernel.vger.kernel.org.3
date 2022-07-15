Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A2C5762B3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 15:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbiGONYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 09:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGONYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 09:24:17 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D78F785BB;
        Fri, 15 Jul 2022 06:24:16 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id x23-20020a05600c179700b003a30e3e7989so835279wmo.0;
        Fri, 15 Jul 2022 06:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zJhQUMYCZEmFeAJVf4TYYWzusKGcCiCwl6yCYU1DmkY=;
        b=lTCwIrTi40aVylTJM0ugG97hRPG08sXGUP/QN1brdfq3yxnZGSmx5Q/jQi/x5SEVZ9
         d69rqOCiOuS3dkNvbolerb+f8/K9qZIrqfC0LMlHQnkYEDBJR5katfwScceaJRDHJ8np
         sDlUo7FE/btrwmbzrSxLpSMzxZMIH6xLAuC2ieJiR3ljj+f0n1RCTQBBw+3qFDWxk2vX
         amrM/VM/S+Tv7DaEAqqcJALDUHkBcCzwwYusndJl1O9UUVdCyVE6Yx1VpeYv+EvXOtWy
         0z9ebp+r2lY4wxxAc6XMLN4mhFlyNgyiD7Tws33bEstvTxWMrl2SwBDbk8BcuMv55Z96
         WzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zJhQUMYCZEmFeAJVf4TYYWzusKGcCiCwl6yCYU1DmkY=;
        b=jUKKdgO4P+qGZTkIoCJQkPe2pksyMrUr3WZ8lfrFAqsRObVfJr1910LFhEnxcccJJu
         /pR4JmuJqfHyPJD2yc6g+Bdf18Lb+Nonm+IBHb/iLLA54CBma8ngHn+wlBo/x4//Wo+R
         Jcycg0qAtWLzjbF+L5os48xyCnVRkIp1AExQDzE1+WNxgjRv6e/xazXHt494FEzU0eDZ
         IxY41g83Cn/TnwBk5b1PuRn2o5zXlWWUL+6c2L50chXmz5Rphhj8gn0kLoDI0Q3Ie86F
         8/MXRtbFf2wI14QKLOYEV7WbqMEwNJY7fDKhof1Sn4T9YpANE/2homZtpXc/VRqEUtYj
         EXXw==
X-Gm-Message-State: AJIora8bzK2N1c98CpF2EI7QyKa3wyZ68bO9PjNNlRjZKtRExrXUlIGD
        qbMcYgSYhk0Epk0th4QdySs=
X-Google-Smtp-Source: AGRyM1tmaQIYhbcwqUbI5/O4ZkgdwAVDAQWlsKB3fIw8jJG87a/FlVQrnB/cibtVidZE7ukUvpMpsg==
X-Received: by 2002:a05:600c:19ca:b0:3a1:9897:410e with SMTP id u10-20020a05600c19ca00b003a19897410emr14708128wmq.88.1657891454598;
        Fri, 15 Jul 2022 06:24:14 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id o3-20020adfeac3000000b0021d6ac977fasm3823636wrn.69.2022.07.15.06.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 06:24:13 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] nvmet-auth: Fix a couple of spelling mistakes
Date:   Fri, 15 Jul 2022 14:24:13 +0100
Message-Id: <20220715132413.301017-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a couple of spelling mistakes in pr_warn and pr_debug messages.
Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/nvme/common/auth.c | 2 +-
 drivers/nvme/target/auth.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index 0c86ebce59d2..f93d369b8850 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -346,7 +346,7 @@ int nvme_auth_augmented_challenge(u8 hmac_id, u8 *skey, size_t skey_len,
 
 	hmac_name = nvme_auth_hmac_name(hmac_id);
 	if (!hmac_name) {
-		pr_warn("%s: invalid hash algoritm %d\n",
+		pr_warn("%s: invalid hash algorithm %d\n",
 			__func__, hmac_id);
 		ret = -EINVAL;
 		goto out_free_key;
diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index bf92435c783c..b41c7bbcc436 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -515,7 +515,7 @@ int nvmet_auth_ctrl_sesskey(struct nvmet_req *req,
 					  req->sq->dhchap_skey,
 					  req->sq->dhchap_skey_len);
 	if (ret)
-		pr_debug("failed to compute shared secred, err %d\n", ret);
+		pr_debug("failed to compute shared secret, err %d\n", ret);
 	else
 		pr_debug("%s: shared secret %*ph\n", __func__,
 			 (int)req->sq->dhchap_skey_len,
-- 
2.35.3


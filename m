Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6D651585E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 00:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381475AbiD2WbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 18:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236352AbiD2WbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 18:31:18 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E8B19C0D;
        Fri, 29 Apr 2022 15:27:59 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id e2so12454171wrh.7;
        Fri, 29 Apr 2022 15:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nsjE3QKtAVvW/MLkRyN5l4C+aBmSf+4Dv2yksVjLqPM=;
        b=f4Tt7kEGc9oP5m2Fns+kJtkTT/bAx1yczE7r1AZ1nVDCBGeFiYtJ7lFp/qFYY/gX1I
         8vJajc0dG72959sfzk72deF7U40qztm+P4b8ayidfbh/p2vlus3l065rm1UoYwO9DeJ6
         Z3IHnzq5yVqtZdmnhpMMSKdQcidiZ+LBMnBTINQQHJjYvJ3gWjDZBRO5ufs4MKF33gSw
         PugmfDq2fyy4Di3sRU8BTQF8PLFCT/hyY8Bg6tNQSUDry++R/wjxzgP+1WWHsz1zs1fm
         cRkoo5eV4gjixZ10FWijgTNJ1fMawQRBKHhwF5L0qGMCZP+Rgpxr1Irdx95WkqrrxvyU
         hHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nsjE3QKtAVvW/MLkRyN5l4C+aBmSf+4Dv2yksVjLqPM=;
        b=GC19a1tIE/irHcjvd/gp2JQ0v5DWahzoPJ7tdyJI8Xer+W3Piw5c2sYx3hNdHDDjFJ
         VDIh/jwT+tZKOUwAiivypcn+EZelJgNOqvKGAiibz+JfmcxIGJzhjTnxCGyH8heO/uis
         R82mI6FAHa6g41ckwy6KigwucxTvmTfeQmPWb1hG9OR/QWzzhOHgtncQGKXK2Z5KxZq7
         nvmRQP4nDa24Nzs+lI2dIfGTG9WQOxwiwuHMXEIneSlBvA+dDmVr2LUI2S7Bv9R4042X
         x3Op/HSupJAUxBSExb/OW1oJf6dTwC7Go01i5/e1W6e03ZSEi93z+68PKqmW4KYabYTu
         YA1w==
X-Gm-Message-State: AOAM5308zQFvKJM6OSogAHnY+Zt8nYLiWxp99xnDvlRdJpQqbDEJ9NLv
        RlSVRJ6y/nG3IihBRtmavRZIXKD6nfw=
X-Google-Smtp-Source: ABdhPJwgbv+IlMyD1djSsO4A7o0801rhCx/tsHbjsMHvPjoxrrhpmacEwGXWYVqssSHZ+cZxMpD++Q==
X-Received: by 2002:adf:ec03:0:b0:20a:d0b5:a06f with SMTP id x3-20020adfec03000000b0020ad0b5a06fmr855296wrn.669.1651271277758;
        Fri, 29 Apr 2022 15:27:57 -0700 (PDT)
Received: from localhost.localdomain ([141.72.243.13])
        by smtp.gmail.com with ESMTPSA id o29-20020adfa11d000000b0020c5253d8efsm356167wro.59.2022.04.29.15.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 15:27:57 -0700 (PDT)
From:   Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
To:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
Subject: [PATCH] media: i2c: ov5645: Remove unneeded of_match_ptr macro
Date:   Sat, 30 Apr 2022 00:27:54 +0200
Message-Id: <20220429222754.11333-1-mosescb.dev@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
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

of_match_ptr isn't required as CONFIG_OF is already a dependency in Kconfig

Signed-off-by: Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
---
 drivers/media/i2c/ov5645.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
index 368fa21e675e..ea73c060514d 100644
--- a/drivers/media/i2c/ov5645.c
+++ b/drivers/media/i2c/ov5645.c
@@ -1283,7 +1283,7 @@ MODULE_DEVICE_TABLE(of, ov5645_of_match);
 
 static struct i2c_driver ov5645_i2c_driver = {
 	.driver = {
-		.of_match_table = of_match_ptr(ov5645_of_match),
+		.of_match_table = ov5645_of_match,
 		.name  = "ov5645",
 	},
 	.probe_new = ov5645_probe,
-- 
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B4B4B9D86
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 11:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239314AbiBQKsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 05:48:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbiBQKsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:48:05 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140481E4C45;
        Thu, 17 Feb 2022 02:47:51 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id y6-20020a7bc186000000b0037bdc5a531eso4328566wmi.0;
        Thu, 17 Feb 2022 02:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wDOa5zAjxEYdZwQwENexU8DjbH6bq4RkGCaO539Y7fA=;
        b=SEZtit2TYLlZ/CFGrluRQZeV2omoXH19rw3xlKJdlVIUe2ntmFOGvLtJX8Q06Ize2I
         w6Ez8FL2EEo/CyelOhNsac7tbA//euZj5/tdMpE4SeUTEhiinaQH6n3NnO7tlaZdkv6f
         gKG5i702oy+D2ftnUb+wC2U93LGsa0TewSfGgrfPkwSDsPkT9A8XUGCb7JCjfCd9rVuM
         NK+EFWOq6+3Mrokj1f7jliRkubSonsyTmgdN5Jlo8VItpwbFJlb19JrDBuBAhuOGJ0H8
         1QzgUmCDJXFfaZtCHN3pNYFysPfOHyxFX+Lm4P0diJllyfaeGoUEmvAdI07WosTEepXA
         PDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wDOa5zAjxEYdZwQwENexU8DjbH6bq4RkGCaO539Y7fA=;
        b=qvgtfdh0Q4NiGxSxisOOEzhu2kY/9L+48XcUYQ9aTt3FJEG55UjBCDqbhfBXGHvHGB
         cwxJgCxIJpFkTrqORmSOFd7zp25xsOAZVmOxbLJEl0eU2/IIiFYbBpFWAjmP1cjPKGB7
         0uyLvHq4tq3QnkKE9EMvBOzFbR/Wa04ybP267QMBArF1UqvecAn4X4Okh+Qq3fbo1YwT
         omK4EMJEQIan4r1qSoGbjB8JPcBVXXWD1CSaJA/nKWDWA0ilHznGsFxHcppQMHUj6B2g
         2qbtJy86KjSqqqnI2RSsh0O2YkgmGSpIOJy48zi74Y7oO1BeKaQxZO42JGeWqWOPqP+C
         M2sA==
X-Gm-Message-State: AOAM533Dn5veRtCqFmKTwIvGPYBBy0g1rnQW/cM3UZXfwoPLvh89qqir
        mAvbdcAbecpSUsAw/BrdklM=
X-Google-Smtp-Source: ABdhPJyp+txqXxigrnTRyLOPTaPW0lu6yiIYHRrXl/74gmUQ+6rN929i/lmlIS8oTnw09BzzkYn4WQ==
X-Received: by 2002:a7b:cb90:0:b0:37b:b88b:b4a2 with SMTP id m16-20020a7bcb90000000b0037bb88bb4a2mr2155841wmi.148.1645094869500;
        Thu, 17 Feb 2022 02:47:49 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id p7sm13690196wrr.95.2022.02.17.02.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 02:47:48 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] staging: wfx: Fix spelling mistake "unexpectly" -> "unexpectedly"
Date:   Thu, 17 Feb 2022 10:47:47 +0000
Message-Id: <20220217104747.15424-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in a dev_warn message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/staging/wfx/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wfx/main.c b/drivers/staging/wfx/main.c
index 0ddc67b56589..d832a22850c7 100644
--- a/drivers/staging/wfx/main.c
+++ b/drivers/staging/wfx/main.c
@@ -190,7 +190,7 @@ bool wfx_api_older_than(struct wfx_dev *wdev, int major, int minor)
 			goto next;
 		}
 		if (chunk_len > WFX_PDS_MAX_CHUNK_SIZE)
-			dev_warn(wdev->dev, "PDS:%d: unexpectly large chunk\n", chunk_num);
+			dev_warn(wdev->dev, "PDS:%d: unexpectedly large chunk\n", chunk_num);
 		if (buf[4] != '{' || buf[chunk_len - 1] != '}')
 			dev_warn(wdev->dev, "PDS:%d: unexpected content\n", chunk_num);
 
-- 
2.34.1


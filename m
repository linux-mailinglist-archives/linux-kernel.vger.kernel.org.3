Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100B54F0144
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 13:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354717AbiDBLuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 07:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353872AbiDBLua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 07:50:30 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178D211166
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 04:48:36 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h4so7584273wrc.13
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 04:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sLXbcmO5F8pv8rU06HtWAEl2LZNlFUBFepYo7bqA8sQ=;
        b=YZ0ff4QfkkKYik0Vim4MSpP3bN0N0LcK+nM0VE1FGCerrllFUhIfVbhPJZSGOq9UY2
         rm++WGs1Uro1wZ9AqpC08iVStCTiZf9w+0aj6NM6GdHlV/IgA8MhU3YqTg9J3dYmoTmQ
         ESa/8d1mte243ArJihnXqBeB55SdB5UWhpcKzn20c1R7oUmV7kuuNY+qdcSTqCithHDp
         qn5TN4a2bFyfN52cjMmDBsc7elP1Ss8qh2mWnr9cyIRHruTO/eGkkq4sayiT4rpdHhhN
         hYHkqNk9GL4jqwSiYdjfYXQjf/3+EgnjMqUbRTYjP/KT0dB+8KYjety3U5a9NfpngyrB
         +Dng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sLXbcmO5F8pv8rU06HtWAEl2LZNlFUBFepYo7bqA8sQ=;
        b=x4KBtEEEQuwON3D34R+KdahJjbEQFcIqX0NqB6vpK15WsTtZPwRyT//CExvi5FLRRP
         A+wK+CMng4MJXnNu+AQNF4VmNs/6K9MsIRiYo1q8qWYJRjQNvIK4rbBbt3F4DL6Duac+
         0b0PYLPC6+7wGBucGArUeyVXhdtVVHeK8rLJRvpl6Q509kasyJaMtBn+jc6PFa9M2pGJ
         eDBiJSKl4tAp0ZQYAlpNYa5Bh6pgRVA95k5fPRirbo2tPeTHniMzQeL8sv4dnBf54u22
         qdJeQCJqDQrxPw6L1IsMMpt2z/kHyiFqhvjYNneAriwkAxWPL/+m/4D2rR3ZQ00CujgF
         qG+A==
X-Gm-Message-State: AOAM533cMSY7a0Qa0P9Junqgritw4DHbo6W8dUt820c0PI0Y3gTw8zlH
        ujMwW5IX5ck0bd0iYB5YLQcr2qUbEEM=
X-Google-Smtp-Source: ABdhPJzlEQrZpBfNWxy5rUyYWm2MUxbS9tdhMq6oiwzO860+COc7AiCOzFMqZeStqkrybW2oOky2DQ==
X-Received: by 2002:a5d:6d8b:0:b0:203:f9b4:be1d with SMTP id l11-20020a5d6d8b000000b00203f9b4be1dmr11020010wrs.298.1648900114696;
        Sat, 02 Apr 2022 04:48:34 -0700 (PDT)
Received: from alaa-emad ([197.57.138.121])
        by smtp.gmail.com with ESMTPSA id v1-20020adff681000000b00205f21617d5sm4532563wrp.105.2022.04.02.04.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 04:48:34 -0700 (PDT)
From:   Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, jerome.pouiller@silabs.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        eng.alaamohamedsoliman.am@gmail.com
Subject: [PATCH] staging: wfx: remove space at the start of a line
Date:   Sat,  2 Apr 2022 13:48:31 +0200
Message-Id: <20220402114831.14977-1-eng.alaamohamedsoliman.am@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
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

Fix " WARNING: please, no spaces at the start of a line"
Reported by checkpatch

Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
---
 drivers/staging/wfx/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wfx/main.c b/drivers/staging/wfx/main.c
index b93b16b900c8..e575a81ca2ca 100644
--- a/drivers/staging/wfx/main.c
+++ b/drivers/staging/wfx/main.c
@@ -170,7 +170,7 @@ bool wfx_api_older_than(struct wfx_dev *wdev, int major, int minor)
  *
  * The PDS file is an array of Time-Length-Value structs.
  */
- int wfx_send_pds(struct wfx_dev *wdev, u8 *buf, size_t len)
+int wfx_send_pds(struct wfx_dev *wdev, u8 *buf, size_t len)
 {
 	int ret, chunk_type, chunk_len, chunk_num = 0;
 
-- 
2.35.1


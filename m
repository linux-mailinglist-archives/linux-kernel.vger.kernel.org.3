Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D324AFD8F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 20:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbiBITeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 14:34:46 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237143AbiBITdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 14:33:21 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4828C1DF81C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 11:32:49 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id w27-20020a9d5a9b000000b005a17d68ae89so2225659oth.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 11:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0IpGy20grOcd5vJjpM1uGLot1+fNqnNeUgBZOKzN3GE=;
        b=EjJky+ALw6AJ6laDzAhpshF2DLSxDj4k8++q+GZ0VC99je6G7oC/AQWrtQCVMjK5xT
         9S59hpSUn17L+XuMhORtvm9kJCWyaScDbyS/14zaqlaBbwiePd5VkVrpQd2N53kd76mx
         bo+bNugiNa+w+48EDoRSGzVX1V6zhwkYGLNW8rQ6jkt7LWRFqm/Qs4RGQCSWVzY60pi+
         cTrBkJwBcyG+/7NrVoKxw9/2522ms/OoLn7srlPyrfg9oxXtssM2lrlf6z4AzEWsjURo
         At4B/z+b5nryn71IYYfaNw1bVdI0xdpS9Wm2Q85i+6/FofqHvc1BFDT+6W2p5i6YH81F
         cKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0IpGy20grOcd5vJjpM1uGLot1+fNqnNeUgBZOKzN3GE=;
        b=U8jV3KLx09biW/yPO2ndYzCqLpHEM02EKY3a0IPo9fL9wwnF5tkSa7ZH4nZFpqq754
         msCgWQpu6CJKg2uGAG1uKBz7bkXQBVxxrVo/cSNg3EJkBd3hV3gPli5RRYih9DZp7u7q
         AT3emk6BOXQ+2+6BHerBCZzM4NEDeHw8ahyXLAKemybAGKb5RX49DhMpV3rmWb3NTDM3
         OTxDR5LTfIHi3ceg7GiVjJVG9cz2+0pzl4mz9qahxeg+DCh3lX55CDTRGM7s7rCyBPVP
         q9CwYwn4nX6ITI0xT9gk/RsT5POZEaP4GlYKSJFaxt2xzTDq1hYiv8prrfeTb2moAgSr
         iM5w==
X-Gm-Message-State: AOAM531jl2Je5oD2Gz/p+RZV0D3IkMTTqELpgAjgwi930EOHDT/vVHwt
        HZ5UAUDg9LLXiJMStzvri94=
X-Google-Smtp-Source: ABdhPJxV1azGRFBKVpgbmq7a9Jfa0UljglBe26tdIR90GlY1fS3Ti5+MYtjWfrTdeglU6YROg2Kj6g==
X-Received: by 2002:a9d:71c2:: with SMTP id z2mr1581359otj.188.1644435160401;
        Wed, 09 Feb 2022 11:32:40 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:4cd8:12bf:758b:9a0d:6e95:934f])
        by smtp.gmail.com with ESMTPSA id j6sm6885572otq.76.2022.02.09.11.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 11:32:39 -0800 (PST)
From:   Leonardo Araujo <leonardo.aa88@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Leonardo Araujo <leonardo.aa88@gmail.com>
Subject: [PATCH] Staging: r8188eu: core: Possible repeated word: 'the'
Date:   Wed,  9 Feb 2022 16:32:09 -0300
Message-Id: <20220209193209.25934-1-leonardo.aa88@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following checkpatch.pl warning:

WARNING: Possible repeated word: 'the'

Signed-off-by: Leonardo Araujo <leonardo.aa88@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 8bfb01c2ebb5..bf15f224aee7 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -529,7 +529,7 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 
 	psecnetwork->IELength = 0;
 	/*  Added by Albert 2009/02/18 */
-	/*  If the the driver wants to use the bssid to create the connection. */
+	/*  If the driver wants to use the bssid to create the connection. */
 	/*  If not,  we have to copy the connecting AP's MAC address to it so that */
 	/*  the driver just has the bssid information for PMKIDList searching. */
 
-- 
2.29.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FD458AF19
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 19:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241440AbiHERpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 13:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241225AbiHERpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 13:45:15 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549D310CF;
        Fri,  5 Aug 2022 10:45:14 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z12so3986553wrs.9;
        Fri, 05 Aug 2022 10:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=sVUnYUiqgDOEyKsFOHDCuNFttJQVrMM85r8ctmHqwSA=;
        b=ZQff00UC57TIFPqypveLUbq/+vRYZVv4cmOcV0Mzw2DpDh6KETnTqH6F/NXDLV8u6N
         DDZtE1a6KYWhntLpxmmWxf4pMCMiifqicM2ZM8TaHdOZtHTrW6UB17TV1++dm3eDAeMi
         d/SmrgJcu29nbix2PjsagcNENkfd7kpiK6GFJ2pRR04xY9hlc4peoDRUv7MRGbXYdWcG
         cVfHepBnJRPqmNvqOAzUHUmVGhoG90PMUzYCG6RFFoI+OWCNzGvRXuWek+b4Mr1jIj50
         M6xdDmnl+EeSmNv1KsS4z2VpjXWQSPzEF7ASyLk8waZAoEU6YdJsN7vrZqVctvrjB+Wl
         grdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=sVUnYUiqgDOEyKsFOHDCuNFttJQVrMM85r8ctmHqwSA=;
        b=Cc6Df8tpi7mfryMt71FOQSkGSltrX5IESll9KF8ChXzBHzoG2eFJql0/6RWEQtXBKX
         wDdINRy8Ox3haUiAQw4AbvWLj8RnOfiFZq1VeIVPmqn317LFGNn9TaE7lfmRTVAM7zpl
         fydRPOQk8WG3VJ4tYICD+La32IVAS6IYTfAJYSLIsOCCioFOospRLVFL9Po+rnYE8etS
         cPI0vYRShJQo6c9aZJDMn1Bj1+jE/OlTficvhn4J1KQr6iGkUU328ztKf6MsQ4dlQJXy
         xvpjsyDZ5qtUSqyCHS4upgiuguikqQZnUCV+blrtN9fH0SZNZIYc9NCwWvPHX2iGfWxX
         xuNw==
X-Gm-Message-State: ACgBeo3dksRecxDKgonU4rwRWSQutw+lEPueXX+nWpZ6aYS3TmNb/Opn
        GQeykl198lxz0JmKJeNC710=
X-Google-Smtp-Source: AA6agR498gUMEm87n1ZGVegOZwBy48DVqnv5fagT2cokE89UVx9XD8ZnnBnf+y1gSfCyIBjooIUWNA==
X-Received: by 2002:adf:d1cf:0:b0:21d:a2cd:522d with SMTP id b15-20020adfd1cf000000b0021da2cd522dmr4881924wrd.383.1659721512743;
        Fri, 05 Aug 2022 10:45:12 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id bi19-20020a05600c3d9300b003a342933727sm10514737wmb.3.2022.08.05.10.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 10:45:12 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: applespi: Use correct struct names in comment Content-Type: text/plain; charset="utf-8" Content-Transfer-Encoding: 8bit
Date:   Fri,  5 Aug 2022 18:45:11 +0100
Message-Id: <20220805174511.2374162-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
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

The incorrect structure name is being used in the comment for struct
touchpad_info_protocol. Correct it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/input/keyboard/applespi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
index cbc6c0d4670a..fab5473ae5da 100644
--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -202,7 +202,7 @@ struct command_protocol_tp_info {
 };
 
 /**
- * struct touchpad_info - touchpad info response.
+ * struct touchpad_info_protocol - touchpad info response.
  * message.type = 0x1020, message.length = 0x006e
  *
  * @unknown1:		unknown
-- 
2.35.3


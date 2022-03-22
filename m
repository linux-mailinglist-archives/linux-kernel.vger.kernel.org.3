Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBC44E35BF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 01:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbiCVAvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 20:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbiCVAve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 20:51:34 -0400
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695CB116E;
        Mon, 21 Mar 2022 17:50:07 -0700 (PDT)
Received: by mail-pj1-f43.google.com with SMTP id b8so14374361pjb.4;
        Mon, 21 Mar 2022 17:50:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0wglNJyRHwtUAggnzMNHl+7ASKue+VasSxZXhnwJJfc=;
        b=cuoyFmhbHkuuLummvHbbJUJVBgF64b5jSQAzt3K8o8gY6E/HG7QcVuEpXB20cZBmxQ
         Gzhqr4sTOwUv/rtfd+3OXka69F/R9MOL0XS/UhvGDZYsPsb5Uq2pMIF0LkxNW3MJU13T
         Geg+cLgXd9clfXsCNFCYkTIKtEvP++YUWMBDIkS+C2jnEGelDBtypMmJ4mQR0fU3klN3
         Yg8OqmMF8+0GiqtTopGFTm4/jQN0I9zzSqiYFXeI0Cot+90tutU/wyDf83F5PAdMUVTn
         AkIREUYUv3UlzwTYnUdxfaOr6v350UcVY+lAFE1DhtOgx9t0LP1sfue/lwozHEIx3hnA
         d5GA==
X-Gm-Message-State: AOAM532Ge/umGjtNTiPyqpUdvkyULuX2ffyDGcreTHzI3oBqGf97u7XU
        3czrtddGxyvAduGiqAqLEZSEUdhqx/M=
X-Google-Smtp-Source: ABdhPJzsH93eWargkXdsI8zOEnpGFISqGM4SB413BAVvMt1gQJVxEI+qHXy31+5cJ2KcMbeIJtlN6g==
X-Received: by 2002:a17:90b:38cf:b0:1bf:42ee:6fa with SMTP id nn15-20020a17090b38cf00b001bf42ee06famr1934480pjb.9.1647910206618;
        Mon, 21 Mar 2022 17:50:06 -0700 (PDT)
Received: from localhost.localdomain ([61.74.27.164])
        by smtp.gmail.com with ESMTPSA id z14-20020aa7888e000000b004f79f59827asm20953779pfe.139.2022.03.21.17.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 17:50:05 -0700 (PDT)
From:   Namjae Jeon <linkinjeon@kernel.org>
To:     linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] MAINTAINERS: ksmbd: switch Sergey to reviewer
Date:   Tue, 22 Mar 2022 09:48:40 +0900
Message-Id: <20220322004840.142176-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey don't have the time to work ksmbd. He will continue to review
ksmbd works at free time. This patch switches him from maintainer
to reviewer.

Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 69a2935daf6c..6a8a6baac29c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10453,9 +10453,9 @@ F:	tools/testing/selftests/
 
 KERNEL SMB3 SERVER (KSMBD)
 M:	Namjae Jeon <linkinjeon@kernel.org>
-M:	Sergey Senozhatsky <senozhatsky@chromium.org>
 M:	Steve French <sfrench@samba.org>
 M:	Hyunchul Lee <hyc.lee@gmail.com>
+R:	Sergey Senozhatsky <senozhatsky@chromium.org>
 L:	linux-cifs@vger.kernel.org
 S:	Maintained
 T:	git git://git.samba.org/ksmbd.git
-- 
2.25.1


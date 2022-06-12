Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E2D54792E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 09:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbiFLHPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 03:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiFLHPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 03:15:47 -0400
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C073F193F1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 00:15:44 -0700 (PDT)
Received: by mail-pg1-f194.google.com with SMTP id 129so2957274pgc.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 00:15:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=575NP7awIhloB41yOKYfL1oPbvMoxjfZLNv5WIm33CA=;
        b=0JWrnAZBfISjx2rm89rsyMFYHJJS0Bv1Lcj0GH6SgrBeLNRWaqh9fld7cJz4DHQyWk
         P5dpHQ4zTjX9cqWHLEj3WNzftjSoT1GE/L6gHj1pUodPvHiKPW3fjHZu0Ht0qGq9hYjr
         +Mp7OFfoeJuL0xTBFFoZajaOFomoEO27hXY31hJ4YP/gCMFp/0Ok33TLMoEBqUGIDgKh
         wssCBphtekpKD2YiOyx+jdyAwn5bBwiMog3hg0TKt0gyRgRXLOxVVHy8NNnYElkS4Eh4
         A4m3u2zp7Hv5PDodwk29YTERxAOHXrsAjadlzd90/1pXMUXWBOGUrXdaLvxBHH2nQ26R
         K7OQ==
X-Gm-Message-State: AOAM5324HS+MQPK4IsLH6WcDy4MjizrIFguay39bze96JVbJsSH5u2ZR
        YkLvyVFTa7Cu3S2jPr7HPw==
X-Google-Smtp-Source: ABdhPJyqv3pqST2Z14kPsRVF1NuwJeYNEmkebNWmO50qlc9gx/RKyRAMWQcVkRXNIclmGZzasU8gqg==
X-Received: by 2002:a05:6a00:c89:b0:51c:2ad8:47ad with SMTP id a9-20020a056a000c8900b0051c2ad847admr31359982pfv.42.1655018144340;
        Sun, 12 Jun 2022 00:15:44 -0700 (PDT)
Received: from localhost.localdomain ([156.146.53.107])
        by smtp.gmail.com with ESMTPSA id z11-20020aa7958b000000b0051bdb735647sm2666741pfj.159.2022.06.12.00.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 00:15:43 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     noodles@fb.com, dave.hansen@linux.intel.com, bhe@redhat.com,
        robh+dt@kernel.org, frowand.list@gmail.com
Cc:     linux-kernel@vger.kernel.org, sunliming@kylinos.cn,
        kelulanainsley@gmail.com, kernel test robot <lkp@intel.com>
Subject: [PATCH RESEND] of: Add missing function declarations
Date:   Sun, 12 Jun 2022 15:15:35 +0800
Message-Id: <20220612071535.1179039-1-sunliming@kylinos.cn>
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

Fixes the following w1 warning:

drivers/of/kexec.c:126:5: warning: no previous prototype for 'ima_get_kexec_buffer' [-Wmissing-prototypes]
drivers/of/kexec.c:153:5: warning: no previous prototype for 'ima_free_kexec_buffer' [-Wmissing-prototypes

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 include/linux/of.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index f0a5d6b10c5a..3a166a1c4ef6 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -844,6 +844,16 @@ static inline phys_addr_t of_dma_get_max_cpu_address(struct device_node *np)
 	return PHYS_ADDR_MAX;
 }
 
+static inline int ima_get_kexec_buffer(void **addr, size_t *size)
+{
+        return -ENOSYS;
+}
+
+static inline int ima_free_kexec_buffer(void **addr, size_t *size)
+{
+        return -ENOSYS;
+}
+
 #define of_match_ptr(_ptr)	NULL
 #define of_match_node(_matches, _node)	NULL
 #endif /* CONFIG_OF */
-- 
2.25.1


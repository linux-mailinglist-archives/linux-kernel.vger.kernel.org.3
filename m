Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522715242FB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 05:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244366AbiELDDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 23:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244911AbiELDDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 23:03:45 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CA966AC7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 20:03:44 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id j14so3655102plx.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 20:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q41Jr8VR5dY09mKNn7RY5RfYlHLETTBtn1k7thCkKuQ=;
        b=J/zsEQMuV3jeFz2ZNyP7VN5TA+LgtwO4M2U3fzh8HvTEAuUbQNRfq7QJ9DC12ZVfn4
         I8TTZ5KkOAOZxahJkyBOlCo1U2T2zkc03IKM6xt3J77YxyPEaOL0Vwl7tKMlMRSXogCp
         d3ZluyhDUTx4//RZrGv0wFfOp3u4s0S7Tp33qk561OC64mhOSZrVZuRTeohjmV+qI7q6
         hbYyzx3z2iWEhcgWfnAN+06TIfsNB6ORPz8rwURmywoHEKF+TpiZgsCgXzVCjHAbyBR4
         d5yxPSkTuXmq4T+SQBxa7W0HtrS3sKh3kO9N0X7tRqggNj4gahwMG3eyaBdDKgGJFCD8
         sBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q41Jr8VR5dY09mKNn7RY5RfYlHLETTBtn1k7thCkKuQ=;
        b=ExNFMLiHxeYkUUO8kqGSSGCNynU4PLyQ158IuH9nrYxid9SYFNquPqJeJkNcrxT7tw
         s0CgMk2D20eLtrErsKtNPjTm5lEUL7cFCT8EHgPIqsoUz8f9kIDB2J/ulTPXiMVbh++P
         ltxMg/1yeczpYCd6uiAzRuvdGF6BOifDpvYdqf9NSwlw5KxEE2S74B41EekO3Xg1v/NG
         Zjq7LKEg2OPeUbahPpj21BE1bNvDP5RRBVy/2ctrdecxLJeXwaAQNS5G8lPP3zZ2B0TO
         o+txbE6NTymlmnPmZzZkTSf0Kvjr4ibbwWr+nCb5pZVjCIae8XJf8jG113AIjkSRPJkt
         booQ==
X-Gm-Message-State: AOAM533QtBNEgRLAg462NiSM4mEJQFg80OF7IDAPzNSY7yMxZb2ZVzQZ
        6u0y0ck7VkfoXJFWCWrDKsU=
X-Google-Smtp-Source: ABdhPJzMEbwjlTwN4njMLoFUKyG6CTBFqiX1Z2hsX7AHrrVgcWAFRUs76ym8HM2zKTrZihSX41SbVg==
X-Received: by 2002:a17:90b:3901:b0:1dc:5a24:691 with SMTP id ob1-20020a17090b390100b001dc5a240691mr8562489pjb.40.1652324624077;
        Wed, 11 May 2022 20:03:44 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id 5-20020a17090a190500b001d77f392280sm640890pjg.30.2022.05.11.20.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 20:03:43 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Brendan Higgins <brendanhiggins@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] arm: npcm: Fix some refcount leaks
Date:   Thu, 12 May 2022 07:03:34 +0400
Message-Id: <20220512030334.52918-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
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

of_find_compatible_node() returns a node pointer with refcount
incremented, we should use of_node_put() on it when done.
Add missing of_node_put() to avoid refcount leak.

Fixes: 7bffa14c9aed ("arm: npcm: add basic support for Nuvoton BMCs")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/arm/mach-npcm/platsmp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-npcm/platsmp.c b/arch/arm/mach-npcm/platsmp.c
index 21633c70fe7f..fe63edc9886d 100644
--- a/arch/arm/mach-npcm/platsmp.c
+++ b/arch/arm/mach-npcm/platsmp.c
@@ -35,6 +35,7 @@ static int npcm7xx_smp_boot_secondary(unsigned int cpu,
 		goto out;
 	}
 	gcr_base = of_iomap(gcr_np, 0);
+	of_node_put(gcr_np);
 	if (!gcr_base) {
 		pr_err("could not iomap gcr");
 		ret = -ENOMEM;
@@ -63,6 +64,7 @@ static void __init npcm7xx_smp_prepare_cpus(unsigned int max_cpus)
 		return;
 	}
 	scu_base = of_iomap(scu_np, 0);
+	of_node_put(scu_np);
 	if (!scu_base) {
 		pr_err("could not iomap scu");
 		return;
-- 
2.25.1


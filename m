Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F34450974E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 08:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384722AbiDUGUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384706AbiDUGTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:19:53 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B0213EB3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:17:03 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 12so4575827oix.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c/YUdcMD+TzJWpV326bXpNNEpPFfwjsPIN5Hj2Tq+ho=;
        b=UEBKLbMyc5dvu1qJRCaUdtVxuvwTfk0nAT0lL7GP5DPcl7KoVOcRXh6iEGnYVzojZm
         HN2McMk0uB1dU3329VIyAsOT9OjmysKVJ3dXab1svwvcnMNU/WzVkrFsF01yPvNAdc1N
         yFYB0FXUPvjAtsi+JCeKmCjLyE0wEsjhzqp34Fkw23sG8qKchlxGMk6BscZD6ZXXlb/g
         sUf4a17MO6nHC2Z6mzz4+byGmCfDNn6n8wyq83WNQPQiR1yS+RlBsnGOUFXilY7bCnpf
         B6trbKC3BJe2uzhx6o6lfnNlrt3QchwSbHEbDuBRf7ugxrbP7ABaOu+JDWTw6xFx7dKI
         QTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c/YUdcMD+TzJWpV326bXpNNEpPFfwjsPIN5Hj2Tq+ho=;
        b=BVU7Lg/yK5VSWALevcJhULUYwdqaFmF6+QoetoQP+EDdni2xT4wcgPlDrfEmsWghhS
         kgRz2nT7XH8VY0G3x6yNZm3c8XXTRcfsldp+s/sxkL5Fotr6Zd3xOxdVubEfmAK3Uscj
         EVfLisL3zA4FlqZTc38xbUI+LFKL/05XCQnbvrgW9054QVXYbBoAdnfuGheviGPOGpp6
         xTbVLEaE1cacY1dPgkhefSJJnYgJ4i+OUdCBMKwDr3yz2Kypn2g7hmoauRffWohsJE4C
         sTEBZpvhYTSN+O/7SCQ0ZUz1xE/hj6N2jqEOSFozKt2NGNo7SjmLXS6Kvt/oc+yh83CX
         J5fQ==
X-Gm-Message-State: AOAM533sUvfxelDOLIbTnG/1itPscsYMVAhv/AQPjygLGgcf98r3TgjD
        xCtN0+p6xQ/CpYjRGYev6j1M6SpTej+fTA==
X-Google-Smtp-Source: ABdhPJzLe/a+SWUub/2Rp5G1a/DjQ/2ni5N92b0tmHdm9PHVEb/aJxtpMvRns2IgyWUf+/x2xILPTg==
X-Received: by 2002:a05:6808:148f:b0:2fa:767d:3c86 with SMTP id e15-20020a056808148f00b002fa767d3c86mr3550066oiw.198.1650521822540;
        Wed, 20 Apr 2022 23:17:02 -0700 (PDT)
Received: from localhost.localdomain ([189.35.230.120])
        by smtp.gmail.com with ESMTPSA id n25-20020a4a3459000000b0033a622c3b5dsm2557275oof.27.2022.04.20.23.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 23:17:01 -0700 (PDT)
From:   Diego Viola <diego.viola@gmail.com>
To:     tglx@linutronix.de
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        Diego Viola <diego.viola@gmail.com>
Subject: [PATCH] kernel/cpu: fix "its" -> "it is" typo
Date:   Thu, 21 Apr 2022 03:16:29 -0300
Message-Id: <20220421061629.32157-1-diego.viola@gmail.com>
X-Mailer: git-send-email 2.36.0
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

Signed-off-by: Diego Viola <diego.viola@gmail.com>
---
 kernel/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index d0a9aa0b42e8..f30994cfe63a 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -965,7 +965,7 @@ void clear_tasks_mm_cpumask(int cpu)
 
 	/*
 	 * This function is called after the cpu is taken down and marked
-	 * offline, so its not like new tasks will ever get this cpu set in
+	 * offline, so it is not like new tasks will ever get this CPU set in
 	 * their mm mask. -- Peter Zijlstra
 	 * Thus, we may use rcu_read_lock() here, instead of grabbing
 	 * full-fledged tasklist_lock.
-- 
2.36.0


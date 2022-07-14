Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D595744CC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 08:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbiGNGFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 02:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiGNGFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 02:05:03 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B162F001
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 23:05:02 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o31-20020a17090a0a2200b001ef7bd037bbso1779972pjo.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 23:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eGkXc885c1hCSI4ONJ+dbs87JEZwIoCuBJ6Z3BoEJIY=;
        b=lrVYuDg15X44pQb/2AI//flwNaC0TQ8ZCV7UZO6STgS3wEmvfXzA8fXbqGTtCB6Ia5
         hzlUEAAj2/+Vtvo8+9Gn40/A8tVl9oDiOrNh//i0jb/Z7V11hIx4hCgXAiCN08swI1BI
         ofK3oSD5qrMM6z2rEvDSkvc7uRlkaQrui7bEaQqMENmeIQJuYve4/iXVkazN2pRZEhh4
         apOmoySSVJ4yI9eb+ATVqrJ358/aqLR8ZUiblVQjV1RHxdYueBsNLiE0Pyz4kKE6EyOg
         Kv/gGWXZ8OCJBefWK96tar6mS57jc6F1VyF9DY2312TGSKSksFUC9E9XJHWt+P27wIXh
         qSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eGkXc885c1hCSI4ONJ+dbs87JEZwIoCuBJ6Z3BoEJIY=;
        b=lvBmK1xx4k1lNjOilv679W6J7CtsBbNQncftll14DGHY3dDipj5Av7MG7aBAuzCzv5
         DZqdFb1lsDgV6ndq6wpJzwzc7C+vaupYzSJmRF+gOcLpzgLMDlPSy666EmzXhSk7YwFF
         RdfB7pjIrhCwFj0KaG+HdWUKj6emsWwyvKaHFZJ7aHexkQiv4wSnmH0zHLm9nLaBqRtv
         LUgDRQoYN1XQ4G+Vp4AulkUMQxn7aqHIskfKPdy2C72iex+eRA/QLhkxoJECti6KOqRW
         A6sbM78PcezvLud1Yu9hDVsN2IB9QrX7KMvkAN1igvFpnDZTFWxjAYzIvNsyUkUA2L9J
         GpEw==
X-Gm-Message-State: AJIora8tyqnEqvWT/VgxpnkDBdLM/GxpL1gvRAHeU6QFLmqG9N6vPiEu
        I74OGkOqcPJEBN1LZtmSDAOU42p2can+tA==
X-Google-Smtp-Source: AGRyM1uNflhHsjaGJlWnopAz4E+lk58waV1Winwi77jHW5iw0BVm87YuRQjN5MyECKHy/f5PaAVjWQ==
X-Received: by 2002:a17:903:245:b0:16b:9c49:6b1c with SMTP id j5-20020a170903024500b0016b9c496b1cmr6624712plh.153.1657778701641;
        Wed, 13 Jul 2022 23:05:01 -0700 (PDT)
Received: from gavin-desktop.hitronhub.home (S0106bc4dfb71c2f3.vn.shawcable.net. [50.64.54.244])
        by smtp.gmail.com with ESMTPSA id p10-20020a170902a40a00b0016bea75a3dfsm492301plq.50.2022.07.13.23.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 23:05:01 -0700 (PDT)
From:   Gavin Keusch <gavinkeusch@gmail.com>
To:     pmladek@suse.com
Cc:     linux-kernel@vger.kernel.org, Gavin Keusch <gavinkeusch@gmail.com>
Subject: [PATCH] kernel: watchdog: fix missing space coding style issue
Date:   Wed, 13 Jul 2022 23:04:57 -0700
Message-Id: <20220714060457.96599-1-gavinkeusch@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Fixed missing space causing coding style error

Signed-off-by: Gavin Keusch <gavinkeusch@gmail.com>
---
 kernel/watchdog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index ecb0e8346e65..b6b150c4b179 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -306,7 +306,7 @@ static int is_softlockup(unsigned long touch_ts,
 			 unsigned long period_ts,
 			 unsigned long now)
 {
-	if ((watchdog_enabled & SOFT_WATCHDOG_ENABLED) && watchdog_thresh){
+	if ((watchdog_enabled & SOFT_WATCHDOG_ENABLED) && watchdog_thresh) {
 		/* Warn about unreasonable delays. */
 		if (time_after(now, period_ts + get_softlockup_thresh()))
 			return now - touch_ts;
-- 
2.34.1


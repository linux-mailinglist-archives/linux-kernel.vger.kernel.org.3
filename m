Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79660542242
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbiFHFHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 01:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbiFHFHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:07:04 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD4938C095
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 19:04:01 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id c14so17544861pgu.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 19:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gZXrszXX7k1pBY3XgYLyYIZ6g0yO7YcboidjDQLSSdI=;
        b=S+W8GHU4TmgSe6etHH92wHg1dGZtvtlP2y0QBbAsfuAeIlQ22yprzG9DlmaA+LRnQc
         LMArhYFLeryQ8PWLSbsV17y48C1nMDqHF7iurVrqSLzHbEWk2QgmH6aWoPUZNdUNUgt7
         Fgwg9dpFIrJm0VRRVxV4IWiEEFfIPbUZE5J+KHPUgJfZSArkqiyvaAA6/Re1qaY59epZ
         ihOx08WsNcHCCHnL4aM7PJ+dGtxDp6qxWy1v5fXQjDUBWivDOkrYJC+YC57RdH7mJZR4
         ftFvw5N4djR2oF9ogEjaF0Br/q3IHt1RFICnS/k8zhUj/O4WzXGeZBX4Glveje+X08re
         nHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gZXrszXX7k1pBY3XgYLyYIZ6g0yO7YcboidjDQLSSdI=;
        b=nosekiZrgWvFSE59MEsGm0P0RGQVm9kpQJynZItuj1DUtylu9+HDMSWt9phVkCcYTT
         iBVXRLcDgRQokfPAlv3ntKnrrDqZ7MavlP8KX6zM3qmWJ1ET/lMKFyoB14qC/9pzlNCZ
         LHUE0lynU7OV8GbCkBUNSS1du5SWTMo3LJutz8JxeleosVblGn3Zuyn52rw0fWvRcQOU
         WjpuEc1Ohwvee7vF7aHOUrAfANJDg1ikchw/HfJctMKyaQ3USZVelTHtzp12lWq5gWDj
         ZCVnC7vR+5r5wQIYJyWOHH5QhLxfAfdpwVIlADKt1Qp3/GDq57ACqFFGsjUzqu6KDeME
         xUHw==
X-Gm-Message-State: AOAM5319Xm9IcYFnL8+ulwTgCsyAdzJ7MhLBkEL504tM4bUJ2EZW/7PY
        Wr8NAMFjAoosQEcxqt4pOxa1gm8ZvRDLX6/zsSUEaPWr
X-Google-Smtp-Source: ABdhPJzQs/lopGPQRYXnXLzcsZTMGBV+KHwYVJQRqvXdwK53PrvrN0T5j3K/Wzll29dP6UVOVS7LIw==
X-Received: by 2002:a63:1c5c:0:b0:3fc:109e:8386 with SMTP id c28-20020a631c5c000000b003fc109e8386mr28437657pgm.133.1654653832995;
        Tue, 07 Jun 2022 19:03:52 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id kp12-20020a17090ae94c00b001e310303275sm12597126pjb.54.2022.06.07.19.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 19:03:52 -0700 (PDT)
From:   luoxueqin <luoxueqin66@gmail.com>
X-Google-Original-From: luoxueqin <937225041@qq.com>
To:     jk@ozlabs.org, joel@jms.id.au
Cc:     alistair@popple.id.au, eajames@linux.ibm.com,
        linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        luoxueqin <luoxueqin@kylinos.cn>
Subject: [PATCH -next] fsi: Fix typo in comment
Date:   Wed,  8 Jun 2022 10:03:46 +0800
Message-Id: <20220608020346.5002-1-937225041@qq.com>
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

From: luoxueqin <luoxueqin@kylinos.cn>

Spelling mistake in comment.

Signed-off-by: luoxueqin <luoxueqin@kylinos.cn>
---
 drivers/fsi/fsi-master.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-master.h b/drivers/fsi/fsi-master.h
index cd6bee5e12a7..4762315a46ba 100644
--- a/drivers/fsi/fsi-master.h
+++ b/drivers/fsi/fsi-master.h
@@ -51,7 +51,7 @@
 #define FSI_MMODE_CRS1SHFT	8		/* Clk rate selection 1 shift */
 #define FSI_MMODE_CRS1MASK	0x3ff		/* Clk rate selection 1 mask */
 
-/* MRESB: Reset brindge */
+/* MRESB: Reset bridge */
 #define FSI_MRESB_RST_GEN	0x80000000	/* General reset */
 #define FSI_MRESB_RST_ERR	0x40000000	/* Error Reset */
 
-- 
2.25.1


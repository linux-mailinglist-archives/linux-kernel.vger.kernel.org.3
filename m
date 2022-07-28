Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55869583CD9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 13:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236402AbiG1LGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 07:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234621AbiG1LF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 07:05:58 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB14F65D1;
        Thu, 28 Jul 2022 04:05:57 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id z16so1648247wrh.12;
        Thu, 28 Jul 2022 04:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yhZlWwZ2aQAcb5Ac/P4g7OKOOl/DwgChSFhZXGIU0iI=;
        b=lnpFIPYzXyhASIKtJmQSmzazL7sezgW4TaTlf/Br8zzBAFwQ6G2hTOMlm5M6aqqNtL
         mS8y/SBeyzSgU3q+jsMMECFP7IIRYkFLjL/V0Z27JO4oH4yHyoE3rbKc1/OPva1QvbCt
         N0Dm1AuFaqoxxvPS3fxaPGaMt2N4+hRz+/Wf00OtKsJ68e6jGU3bBRqF1IRPlkZ64Wmm
         0rfaDTEU8ouIq2kP6M7fFKimqyB/qbwdSpYKFxmD23s+bw92jAwFlYqTYE2WTs9v+y37
         Kbae7pFBEmNOePixp+ZmacyZNubWczrvQWc3lqmolwV00cNziM7zFEGM9IDgD9eDOIdE
         F+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yhZlWwZ2aQAcb5Ac/P4g7OKOOl/DwgChSFhZXGIU0iI=;
        b=w+8J2anpuFHBBrXWgdCMuGlnRr1lFEa7DFWAFVyb9x1fXcpAlTwXXssyAKQSfKWnBp
         MbdRTOilvsSzOQVS6ZyR8dBWsZdhxDNgm5InAhqLdUnhDJBPOC8iwTdsE+pyCV7RDEp/
         xYcG0k6nO/vsI9xbarkjneajxCvGYtBvfWN/eGh60y7FljF91ZOh2l0UArjeFGblC3z+
         uE3+IJjYqMqWInEtVqfQiKe/WeNxk9d3CrjzVrMlYO9WO0IJQXHo2RY7ZsyQ9GXV4CRX
         zNWSSbqUwWHERZ+GIMejBDhv2AE2SpXmzm8b/DftfwOTf/s77Urww1MxnhOPj1M/ODWA
         SDaQ==
X-Gm-Message-State: AJIora/DqhUn6/Uv6Rr1B9bGr44DMaliMEwWgFYdoKuufQgvzwoD7DRh
        Qw8qEtVjeHnuHGvEkcaDtU8=
X-Google-Smtp-Source: AGRyM1v5rxVvmv/o67Tfzlr3gPbJIGiXB4xPfw0q0uV5+CNkpbEXDCRbqDSUDOaBCn+qZnHQwaWZxw==
X-Received: by 2002:adf:fbc6:0:b0:21e:3960:45b3 with SMTP id d6-20020adffbc6000000b0021e396045b3mr16407847wrs.92.1659006356252;
        Thu, 28 Jul 2022 04:05:56 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id a6-20020a5d53c6000000b0021ea5b1c781sm701021wrw.49.2022.07.28.04.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 04:05:55 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Marco Felsch <m.felsch@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] reset: tps380x: Fix spelling mistake "Voltags" -> "Voltage"
Date:   Thu, 28 Jul 2022 12:05:54 +0100
Message-Id: <20220728110554.18320-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in the MODULE_DESCRIPTION text. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/reset/reset-tps380x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/reset-tps380x.c b/drivers/reset/reset-tps380x.c
index e07f5865fe30..09d511f069ba 100644
--- a/drivers/reset/reset-tps380x.c
+++ b/drivers/reset/reset-tps380x.c
@@ -122,5 +122,5 @@ static struct platform_driver tps380x_reset_driver = {
 module_platform_driver(tps380x_reset_driver);
 
 MODULE_AUTHOR("Marco Felsch <kernel@pengutronix.de>");
-MODULE_DESCRIPTION("TI TPS380x Supply Voltags Supervisor and Reset Driver");
+MODULE_DESCRIPTION("TI TPS380x Supply Voltage Supervisor and Reset Driver");
 MODULE_LICENSE("GPL v2");
-- 
2.35.3


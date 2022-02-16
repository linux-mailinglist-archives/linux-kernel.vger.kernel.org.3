Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D9F4B7F89
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 05:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344423AbiBPEh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 23:37:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234726AbiBPEhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 23:37:19 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B91F4063
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 20:37:08 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id c10-20020a251c0a000000b0062272fc32bfso1821033ybc.17
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 20:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OKBUHG1lRWv0hIHjB+K86/IQNwkPb8MQNKlRJE3S5/M=;
        b=VUKQadDEbJa7NbTRkkm9nXOiw5f7n4c/vBTT4/HCJWwWVQPU0Hjj5/WouVFgkdx5r0
         5HaPzh3tug4Nku+8HqNjqBnLZItmom14x7t1m6cm4N0zVIgXoKyRrluJCmlSMKeqD/UK
         Za0giSQCOFnj+d6ofgO3QQVjdR+6tDdSU8xbQLEZ+Symgkh1gEcRuoNrkMxTUY1UIuWF
         MatIw38UqS1LYMThe7hED4+dLLc5p+CSgkFORU/SiXdNOewheb0cvViesjOGgoxcTlgO
         VAFKdNQRjz6+JUmG0cYis3eP8Nnwwxr4ZALSNHtrNuzM09shesfSvxvSGF39jKC0uDVj
         B+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OKBUHG1lRWv0hIHjB+K86/IQNwkPb8MQNKlRJE3S5/M=;
        b=bZr8tnue6jqA+vXBbK92MucgOltk2lz4HNCSKaM6JH140r++zZVh9cSUHtaR2Jcj7B
         x5aFc7As65pcEMCba3W+KIWQRpqY1aCo6mKFYzFcWkVEi8iRnezX3dkvBIcG6onlMLCH
         i7CQAcrog3DGNijBD31vXhAMdWH20Juh4EbnhlzAo24OIOMaFZyFpLJcr9K7xGvLnbFj
         I7X7VpDJm5q+uT6O/G8DvXndOBdcxdbOenPNxqnG4J8kD7MotIRO5m7s2Io14y5Y0/ed
         L2/RyBa+ka4S54P67RMQ3gi5baB4/jlRA4KMrz9LPXWq4C5k8STkvGbIQ/kwVZhtxWDL
         pkwA==
X-Gm-Message-State: AOAM533olVzZd9+cd8mpFdkCBswsMOUFcGum32EBaPPNPrA3/v+Psbfn
        vSH0w1jUrWS/R/T0BCn0BFOYBRm/eXOD
X-Google-Smtp-Source: ABdhPJzsgKkCNM0CwKrs5c/H0XxeTDPiDod5RuJfAv1iM/iFm/zfXxW9uh5NrhHf0S5CbIQ38ur+wObnWL3B
X-Received: from tzungbi-z840.tpe.corp.google.com ([2401:fa00:1:10:8ce7:5b2:9787:1a0b])
 (user=tzungbi job=sendgmr) by 2002:a81:49c8:0:b0:2d0:ad27:5be5 with SMTP id
 w191-20020a8149c8000000b002d0ad275be5mr895168ywa.27.1644986227331; Tue, 15
 Feb 2022 20:37:07 -0800 (PST)
Date:   Wed, 16 Feb 2022 12:36:38 +0800
In-Reply-To: <20220216043639.3839185-1-tzungbi@google.com>
Message-Id: <20220216043639.3839185-5-tzungbi@google.com>
Mime-Version: 1.0
References: <20220216043639.3839185-1-tzungbi@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v4 4/5] platform/chrome: cros_ec: sort header inclusion alphabetically
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@google.com,
        pmalani@chromium.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort header inclusion alphabetically.

Reviewed-by: Guenter Roeck <groeck@google.com>
Reviewed-by: Prashant Malani <pmalani@chromium.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
Changes from v3:
(https://patchwork.kernel.org/project/chrome-platform/patch/20220209095703.517608-6-tzungbi@google.com/)
- Add R-b tags.

No changes from v2.

Changes from v1:
(https://lore.kernel.org/lkml/20220125101527.1812887-1-tzungbi@google.com/T/#u)
- Use imperative mood in commit message.

 drivers/platform/chrome/cros_ec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index b6604a9ab315..a3921fe5813a 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -9,12 +9,12 @@
  * battery charging and regulator control, firmware update.
  */
 
-#include <linux/of_platform.h>
 #include <linux/interrupt.h>
-#include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/of_platform.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
+#include <linux/slab.h>
 #include <linux/suspend.h>
 
 #include "cros_ec.h"
-- 
2.35.1.265.g69c8d7142f-goog


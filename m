Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0774B827F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 09:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiBPIDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 03:03:55 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiBPIDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 03:03:52 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97B42174A7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 00:03:36 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a32-20020a25ae20000000b0061db8f89e46so2679653ybj.14
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 00:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5qzVLz39P8G9OalJ4OG5+jRLXwbeqjg2qWS0xq1akwM=;
        b=Zt68xi5ETqf1AmcUeuq3ib3RwFunxoigHxeX4oruUT1ON8IYS1e5HH57S7oZhXaOsf
         lQUppbLjWJe645AnEI28KBFMw3wGt9d16s8XxdeHG0hgOfa9m0va4ZJsq+OvZrlF8iAE
         k9fg0a5WwdMak8ryMGAL4ruVOC8cZN/fqrcG8Zhv7AbqjpyxzODOHGCSvm5hmqZfhgEF
         SJQtMINdk8NoYNUcLD5VWvmhs2WOofypKOX4l/bFZtbiR0JWHaM1KvYa4LIvq+hnsK02
         FO1fere4I1Z2Oub7t3kwrVCYpZxwUGPnmFcYkZtBG/COKzdtk5R6ul3HMYFrTgB32c1x
         2cEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5qzVLz39P8G9OalJ4OG5+jRLXwbeqjg2qWS0xq1akwM=;
        b=VC9n993QcFsq0+S+I9jv6mHEYLJGUE62RKsmxc2vzN3o2O/dFYX/8Li0hEnPvEpcUT
         nJtUxT9mD3E+aA6Z1o5bRuOlPjcZYFS3duFj3Nb/zoqa+BFePGO859SN1+LYg4yE10rJ
         wfb0hxebYVske+L6lDYdH2/5RFcdIgOtv1sq55b7xTWftsMtlV8b4Hd3O0qN5nQmlGHh
         MG+pXmGXBmdV0BoUwSv6SIja0mdIYj+wDJQaHbn9B6F5n3PptbCVgkiMAmtxGWC48+th
         oAHVsuAOZ1Q5wRB9EzZ+keVhegB7baVjbrV7CH6SMKSWcnYcUfPp06fxYgOFSGm92wG7
         /XeQ==
X-Gm-Message-State: AOAM5313JxbnY76h7lq1/gtD765mbSOUWwcY4tLAQzj/NM2C+bdJzutw
        DIK3taV0Xq+XFdlqVDTyrO7dt319wg2X
X-Google-Smtp-Source: ABdhPJxuoL+5eeFURcGTKeIxlEdvNBxd1Inw7r0oDhOhJ1nc7+k4RTjtYrDB9xE1YHMUHY0ThoqlAGBTkHgf
X-Received: from tzungbi-z840.tpe.corp.google.com ([2401:fa00:1:10:8ce7:5b2:9787:1a0b])
 (user=tzungbi job=sendgmr) by 2002:a25:68cd:0:b0:619:8e35:2c3d with SMTP id
 d196-20020a2568cd000000b006198e352c3dmr1133711ybc.266.1644998615855; Wed, 16
 Feb 2022 00:03:35 -0800 (PST)
Date:   Wed, 16 Feb 2022 16:03:05 +0800
In-Reply-To: <20220216080306.3864163-1-tzungbi@google.com>
Message-Id: <20220216080306.3864163-5-tzungbi@google.com>
Mime-Version: 1.0
References: <20220216080306.3864163-1-tzungbi@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v5 4/5] platform/chrome: cros_ec: sort header inclusion alphabetically
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, pmalani@chromium.org,
        tzungbi@google.com, linux-kernel@vger.kernel.org,
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
No changes from v4.

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
index a013fbceeb03..1e1a24a80d9f 100644
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


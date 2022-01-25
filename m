Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0A849B179
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345564AbiAYKVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243278AbiAYKQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:16:12 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C13FC061786
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:16:12 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e130-20020a255088000000b006126feb051eso40617506ybb.18
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aI21/4gV7GE78BNvrrZ+I/runsfBL/IYqx2eo04++Yg=;
        b=KB7Nun3RrziiFsC6bhOEwRZe9FK8Zz9A9CN5rOClV7t3nf+hc4lZsYVdXt7rRA3NDs
         ILUG4f9LEqOxTDVy6SRXrvKX8614c9lTX4zPO0dq9O4aRw5RDSsAS2m0D3uTiiOFLMHV
         F2a85E+vo1CmaUF6Gp83CTgq9t8NNyyrGZfalJoCDkgA86+XnaEBitt6BwzoPVVVFpSK
         dJ619OOeiGr8RqH8YL+afoKCNw3sHkv/zNZdN3bn0vWEQDdjKSWJBicALSdCSO9AqMZ3
         1otX2jiePEajjqb2MmIM19OFQ/G+iVKedsJ4rOo2vBoqm+AIhKHgrm/HCsT6QJX143MW
         AHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aI21/4gV7GE78BNvrrZ+I/runsfBL/IYqx2eo04++Yg=;
        b=DK1IM+JCzAoBjuFamjm4H3lyej6Plr0rQWegjLz5rNI9TK4BznlkCHROXFWDmOu39H
         xTJHUTz1mOAh03khA8z+vIuYqPZPxVwlJQkyuTq/NuHPByezkd2s9RilCTBbzpE6jsvB
         aDQQUVEVV8bMRygt/IrAfFror/LhMHJ6HlC4jKkMNuYVV8HoE+ZnomEjxUBpCXas8cjb
         hlWKrzL0u0hakkJ8mMD7Kjl/IeR7kp8hUW4ZYQLeECu5/iEQuFaBd2w8x+8yxM7LsNmM
         20ryt3GQvYXyunk/Ag62Tepc4JrWD2uQ2o/KyUkayZCAFzf3mhqCXepVmbV9aj//YFDm
         DKmA==
X-Gm-Message-State: AOAM533FVhdPuUU+SwB9pdzqLENoHp0SDRSUdeZcNyh1EDqufx0afxYq
        dZYfIebAQLd+CN5UMnOVJqnJRSntILR3
X-Google-Smtp-Source: ABdhPJzDBPGHBST943mTHqe9TTEk25fUz6fXiUzvGnsyP2G0HUwkWvJs5jpEIhVscISHLTiow0YfHNpRmJWM
X-Received: from tzungbi-z840.tpe.corp.google.com ([2401:fa00:1:10:69af:7f25:2010:2c85])
 (user=tzungbi job=sendgmr) by 2002:a81:d8b:0:b0:2ca:287c:6bb3 with SMTP id
 00721157ae682-2ca287c6e04mr5759177b3.88.1643105771441; Tue, 25 Jan 2022
 02:16:11 -0800 (PST)
Date:   Tue, 25 Jan 2022 18:15:26 +0800
In-Reply-To: <20220125101527.1812887-1-tzungbi@google.com>
Message-Id: <20220125101527.1812887-6-tzungbi@google.com>
Mime-Version: 1.0
References: <20220125101527.1812887-1-tzungbi@google.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH 5/6] platform/chrome: cros_ec: sort header inclusion alphabetically
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     bleung@chromium.org
Cc:     groeck@chromium.org, tzungbi@google.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorts header inclusion alphabetically.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 drivers/platform/chrome/cros_ec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index c2c7a748e48f..934ab30c9d08 100644
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
2.35.0.rc0.227.g00780c9af4-goog


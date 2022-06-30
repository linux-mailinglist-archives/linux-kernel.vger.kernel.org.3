Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA1A562158
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 19:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236472AbiF3Rec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 13:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235954AbiF3Reb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 13:34:31 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D9036141
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 10:34:26 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y141so97840pfb.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 10:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1s1jurQNn/fJ4wlZGRfg1PNeoKP8xQg/ofkOwb0NO2E=;
        b=N0Zd0OVM4bQky4uabYzuMEV8PyZPfQ/N09BFx0mH52wgBdjlxbeg3dltvfkX2ydhgZ
         qGVMGj4nSzoaZK0ajiSbgouaegww7bDUoWn2zDXg/JhW89N1ZOAeMeamP4XyqoL0bX+A
         Z3qdd0mFEG9XDfttKG3enTn3ZS0Gyytg1pdi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1s1jurQNn/fJ4wlZGRfg1PNeoKP8xQg/ofkOwb0NO2E=;
        b=1sY/PdCcwyyctG1ZRXaXvh/mAa2qXsmSVAwAs5j+vguM6NKnQGft7CRia23zi2B4KU
         hij+z7dM71X9VyvYeWZT4i2rEKdmvTLHBvBjLG0Rsfdtm4zFugs/jkzKRQ5lu0ikHpxk
         1VxVV2VwVH/xz7bDqPe7HH6IzPAl591uoqLlbszSbiJFlimsD+oQ1l38Qe1ri0ghpEGO
         bCFwBPLtjgGsHUqXxlRt1WZzPT/SW/4+uF99Y+bsixKUzYHufesJ7Vlbv5wLwL3JMFPO
         P+g1eIubKqg5ieYYRWjgQdb+qRmsJ3jnR0zonIVFQy/b5FTaR7bo6Ue4wB2+jWKrKLVd
         nBag==
X-Gm-Message-State: AJIora+ZB5yQxOp6/oiWKoWLPScF9NzXajaF2gHl9MCTjcvMdoj0/82G
        mt6ozt9ABaRB/iHiKq3wj0qnDQ==
X-Google-Smtp-Source: AGRyM1sTkUaMZfcu6ioDPGwJiwe0TTGaBaUHp6sw3z9cYqSKpyM+kx7JG47ES5+UsaveuyB1Qkoe6A==
X-Received: by 2002:aa7:910b:0:b0:524:f8d9:a4c4 with SMTP id 11-20020aa7910b000000b00524f8d9a4c4mr17128695pfh.5.1656610465558;
        Thu, 30 Jun 2022 10:34:25 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:5175:e079:2e5a:2405])
        by smtp.gmail.com with ESMTPSA id m20-20020aa78a14000000b00518950bfc82sm14331125pfa.10.2022.06.30.10.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 10:34:25 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] video: of_display_timing.h: include errno.h
Date:   Fri,  1 Jul 2022 01:33:29 +0800
Message-Id: <20220630173328.1369576-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_OF is not enabled, default of_get_display_timing() returns an
errno, so include the header.

Fixes: 422b67e0b31a ("videomode: provide dummy inline functions for !CONFIG_OF")
Suggested-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 include/video/of_display_timing.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/video/of_display_timing.h b/include/video/of_display_timing.h
index e1126a74882a5..eff166fdd81b9 100644
--- a/include/video/of_display_timing.h
+++ b/include/video/of_display_timing.h
@@ -8,6 +8,8 @@
 #ifndef __LINUX_OF_DISPLAY_TIMING_H
 #define __LINUX_OF_DISPLAY_TIMING_H
 
+#include <linux/errno.h>
+
 struct device_node;
 struct display_timing;
 struct display_timings;
-- 
2.37.0.rc0.161.g10f37bed90-goog


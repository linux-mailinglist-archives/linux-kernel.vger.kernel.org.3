Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981014FCBFD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 03:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbiDLBwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 21:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiDLBwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 21:52:50 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203D0765B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 18:50:34 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id 141so3098468qkf.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 18:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sEEO1a9gpg66HFf13zmhoKxUPpsxt/WYjEBH7Mta+38=;
        b=aXVbsRa2yH5DAASxHCBOihAz6ipOW8TA49XkgznzBFXPNgMxrfaH1kbEz7GlFFkcq+
         1XhueTEgVssesDPYvJOa5CcZS2SrQSNKRmkEvlNOlQ9GyK8bhy1jdvSRlXnNZTh6nr7W
         At4MeV5SRXN4YGyYuijU853lKVzVQpGtNmxT1Mch4kEb6d12LIIDHziyGyBRPZz+IXwt
         5ES2GjLuCzEqHPG3Y1dys8xtAM+ZZpVUHoNd3ETVgLgEOfxjL4TNagIBPcjl2ONRBrK3
         yLICfOldH1XCFa/nnqcjCV+Nd7gxsRh4FWsq4wdnXXH6D+8ALMcEqCO6Q197UMPBig7o
         TXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sEEO1a9gpg66HFf13zmhoKxUPpsxt/WYjEBH7Mta+38=;
        b=38U4FtP3vjL0QH5/4KMslq1MZ3PqPDoDCyNCws4U8O0kDwbszonHVQbLiLC6HUC4d6
         bkAeTeroePNxFDBuu9RIvyEIao1++lciTrVf9cK1zMk+2IOyZSjT8ANHwciRhDdy0Tsa
         kDS+LkI+xLy9kifbhgXTYhoZ+YU1dqwAV9VWYvLsNsuuHMyl3l+z3ItrAEwLXLprF8iy
         hH4cMC/9L5jmqT38OrQrwzQtR57hE8fYMULtfGDyxBdzjiQoJ65VMkqk0Ftkf41oWCh9
         Oq3v0OwTKomXofS6QXapCooi3EjIjSKNphJH2FedsJSDTSctz0EG4e6TGBP8/MUDhiah
         KdGg==
X-Gm-Message-State: AOAM531gNIvX8s9PfYV4BHkBpU0y7myrsoJBtx7FgOhKp/HfOWjaxY4M
        ct2teL6Yg2LSOXXhFpJV2LA=
X-Google-Smtp-Source: ABdhPJxsOqNQqNWBE75c7gOwbm9rwZ7jKHdxtsI5WotnoPMlls4ptrYn5I1yj0kL0v98wKpQREt+1A==
X-Received: by 2002:a05:620a:3728:b0:67d:4fe0:1e0c with SMTP id de40-20020a05620a372800b0067d4fe01e0cmr1634898qkb.102.1649728231862;
        Mon, 11 Apr 2022 18:50:31 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme.lan ([2607:fb90:50fb:900e:25ab:983d:ac30:58b5])
        by smtp.gmail.com with ESMTPSA id s16-20020ac85cd0000000b002e1ed82f1e5sm29556305qta.75.2022.04.11.18.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 18:50:31 -0700 (PDT)
From:   Jaehee Park <jhpark1013@gmail.com>
To:     johan@kernel.org
Cc:     elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev,
        jhpark1013@gmail.com
Subject: [PATCH 1/2] staging: greybus: correct typo in comment 'Atleast' to 'At least'
Date:   Mon, 11 Apr 2022 21:50:21 -0400
Message-Id: <1c4f0dfb83ad0c603a9efddafac37cccb7204415.1649712572.git.jhpark1013@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1649712572.git.jhpark1013@gmail.com>
References: <cover.1649712572.git.jhpark1013@gmail.com>
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

Correct spelling typo.

Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
---
 drivers/staging/greybus/arche-apb-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/arche-apb-ctrl.c b/drivers/staging/greybus/arche-apb-ctrl.c
index bbf3ba744fc4..45afa208d004 100644
--- a/drivers/staging/greybus/arche-apb-ctrl.c
+++ b/drivers/staging/greybus/arche-apb-ctrl.c
@@ -445,7 +445,7 @@ static int __maybe_unused arche_apb_ctrl_suspend(struct device *dev)
 static int __maybe_unused arche_apb_ctrl_resume(struct device *dev)
 {
 	/*
-	 * Atleast for ES2 we have to meet the delay requirement between
+	 * At least for ES2 we have to meet the delay requirement between
 	 * unipro switch and AP bridge init, depending on whether bridge is in
 	 * OFF state or standby state.
 	 *
-- 
2.25.1


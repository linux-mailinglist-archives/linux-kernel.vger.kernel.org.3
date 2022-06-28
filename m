Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3743455CF78
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243780AbiF1FfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 01:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245043AbiF1FfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 01:35:12 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5A627179;
        Mon, 27 Jun 2022 22:35:08 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id i1so11465616wrb.11;
        Mon, 27 Jun 2022 22:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=dTA90lOxgIQa7DSNgHRMqmr5kjIWrAUMbJ6Fyb/GRMc=;
        b=bY5f5tFedfpsQKz1aQmaceJv6zFDOLQqCGAazVWhHE8Xn5Lll0Gc/8UIjvRUTJtwCY
         QL2cX0G2hIpoz4mIRi7CLMBoqxXzr9oknenx16HBcihBdJWOQzak6zt6vRPj0WvRo6U0
         LaejvQNs2AhEmMIb7YU+977cOzzwm5zrzb2TGtPr0DvoT1qQV34NsYJ9iKhVITO5x+LT
         nZouZzinwoUqYQ8D3PlXeeayF3hGIhmQanrxScuUfJo4xcqU8jL91IBVbNHb4D9J6Hat
         eAtc75xaKJm3kNxe1WfZLh0iJRFaZzF34Dvgr8cfr6rC503ZUkFz3NqvWMudTXd+SsYp
         RHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dTA90lOxgIQa7DSNgHRMqmr5kjIWrAUMbJ6Fyb/GRMc=;
        b=wPOOd9FcAkrGd/Aa5peXilvQ7Bi55xwsn+p7dllVzr3QoP80yNOlFRvxlHGUZIgW/B
         XgBVA9OFxMyp/T8bVnb3LfkIvDNkPz1EihEfLWMYR241tYxx7ilQMPtbxurWmvN59MgX
         ZYvdk3j3957abgiNLd1nRBrsz8Nnv8F4yl6AVCWJO8dgBg/ZGyZsUxASG2iGTVj0vKbT
         ig6FA5A6NX9l7CABVBToDIhV0KortsZCRXwe90iPz3D85pIYsIaCDI1N6GltV8gOMoN1
         h7IJvavxv5Y7BrBetYt4VAKRBf85x1o0/Sa2llaaAhlki+3NfrCZjozdwRu3K6z9vqmo
         EDyg==
X-Gm-Message-State: AJIora/MhCmRuIp8I70zwaTpzGoiS7XqodRYraSsdf9t6fjtvJqWRaGQ
        zw+S3x2HJR3w20fS8FixvHlW2KvUxG8=
X-Google-Smtp-Source: AGRyM1vLAMJ+61yUhFEg9AbQGG5npHVsKB5g4gkTqpyARgo8j4Sx5eAmyy4kf0WSC/KsZsOZioG+qQ==
X-Received: by 2002:a5d:5581:0:b0:20f:fc51:7754 with SMTP id i1-20020a5d5581000000b0020ffc517754mr16224632wrv.413.1656394506441;
        Mon, 27 Jun 2022 22:35:06 -0700 (PDT)
Received: from felia.fritz.box (200116b8267a9e00e50a985511ee89f7.dip.versatel-1u1.de. [2001:16b8:267a:9e00:e50a:9855:11ee:89f7])
        by smtp.gmail.com with ESMTPSA id u16-20020a05600c441000b0039c4d022a44sm16293928wmn.1.2022.06.27.22.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 22:35:06 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] PM / devfreq: passive: revert an editing accident in SPDX-License line
Date:   Tue, 28 Jun 2022 07:34:11 +0200
Message-Id: <20220628053411.22438-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 26984d9d581e ("PM / devfreq: passive: Keep cpufreq_policy for
possible cpus") reworked governor_passive.c, and accidently added a
tab in the first line, i.e., the SPDX-License-Identifier line.

The checkpatch script warns with the SPDX_LICENSE_TAG warning, and hence
pointed this issue out while investigating checkpatch warnings.

Revert this editing accident. No functional change.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Chanwoo, please pick this minor non-urgent fix to your latest change above.

 drivers/devfreq/governor_passive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index 72c67979ebe1..326482a68986 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -1,4 +1,4 @@
-	// SPDX-License-Identifier: GPL-2.0-only
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * linux/drivers/devfreq/governor_passive.c
  *
-- 
2.17.1


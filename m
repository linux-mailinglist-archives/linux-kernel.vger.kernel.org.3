Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119394C0F4F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 10:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239330AbiBWJiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 04:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236736AbiBWJiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 04:38:12 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDB65A0BF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 01:37:45 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id v22so21808792ljh.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 01:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IjMUCjiPoBwvZY4LPgThLM6FoxJ7wQ3fXZU9VFqm1tI=;
        b=fF7zn+RcEzxi5D8flAwOc5on5mwzPtk2y8xNUG1EU2sbaBd6i0gpXGUoI33/3p63mA
         u2hZ4tFuQhaA5KUqEDEC908E0CPgSyXEUrXmDtUYKOjI0xmT86ZyZEeEFkjEYtqeEIBh
         S0jm/rf1hHynZ6KfKiSzUwtKONyFmWU9OTygrCzcJOuOwb7nyLpMUsBH4z7lSjHlHXyV
         Xnpq4kwlkjhRedjr+cUdQFpY2mUnLv1AkKrjEzWDGqBhx5GxYQXnJ2gbhxXIlIDQVCkj
         JUsVk6zIFv4++ECoMPg16c2V0jNjnLyzoLSBPneLeDy4N06b9RREruUnzwd9xVa65sKm
         EBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IjMUCjiPoBwvZY4LPgThLM6FoxJ7wQ3fXZU9VFqm1tI=;
        b=p6KSqwHouQg52Xl3tiw9ussc37jYwHMb8gOJxY2efOOnS0yVsm9Be/sHolrhaKTWh/
         rLZBDCfuR9OeJqwRMc4MMuenkrN1yL/Ly4i+8ugWs6oWx2KiBy4BwfoYWl7i0daTPHDf
         ECYx6am26m6gYUwZ5YTKW83L3FcFMO26Q264bsl9R8An/4mcJGx4Zm8AOJnaSfN2tj2U
         ojwub/YYgOECh016zpUdAz5hY+xI8E1jwv8VZRR8Hxp0F54GgnqKsBjnPqPeuE4Imv23
         PL3eCCI2/6BcYYzOQqFTrmEEfDRjoTK5fnUs6kAeg+5pig7fPon9hfJ/d4R9/HYezyOv
         LM9g==
X-Gm-Message-State: AOAM533AcHN87L/PEUvUsIvAXd5qqMl3ycEBDbcAZgsicOyxXds245Lr
        RORG6TiPkbGHhaOTFM4Ke6U=
X-Google-Smtp-Source: ABdhPJy526t9D119CPsDWgI4y9/8uS0UBdtDaA2H+7efd3LFUYpfXS1mTSlJy7IMzepjW5AUw4zDjw==
X-Received: by 2002:a05:651c:c7:b0:246:12a0:25e2 with SMTP id 7-20020a05651c00c700b0024612a025e2mr20247101ljr.471.1645609063810;
        Wed, 23 Feb 2022 01:37:43 -0800 (PST)
Received: from gmail.com ([46.38.44.117])
        by smtp.gmail.com with ESMTPSA id k1sm1594675lfu.136.2022.02.23.01.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 01:37:43 -0800 (PST)
From:   Vladimir Davydov <vdavydov.dev@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>
Subject: [PATCH] MAINTAINERS: remove myself from memcg maintainers
Date:   Wed, 23 Feb 2022 12:37:42 +0300
Message-Id: <4ad1f8da49d7b71c84a0c15bd5347f5ce704e730.1645608825.git.vdavydov.dev@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Signed-off-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 777cd6fa2b3d..cbadcffbff50 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4913,7 +4913,6 @@ F:	kernel/cgroup/cpuset.c
 CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)
 M:	Johannes Weiner <hannes@cmpxchg.org>
 M:	Michal Hocko <mhocko@kernel.org>
-M:	Vladimir Davydov <vdavydov.dev@gmail.com>
 L:	cgroups@vger.kernel.org
 L:	linux-mm@kvack.org
 S:	Maintained
-- 
2.25.1


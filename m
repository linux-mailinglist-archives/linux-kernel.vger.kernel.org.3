Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6736359E648
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 17:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237712AbiHWPoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 11:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242560AbiHWPnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 11:43:32 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D006E29A717;
        Tue, 23 Aug 2022 04:41:36 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q9so2980401pgq.6;
        Tue, 23 Aug 2022 04:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc;
        bh=EX/82qnQonQiLqn4wSbDmFcuxyzSeSG7gW+qIxvJMUI=;
        b=EFoqdBDkG/5UPV6HPIgvFcGc0TyYf/CF3yiYdCUZx4myoPyDIRta+YXXtjyiRuQroo
         34I1JKEGwEmYjmYB0oFj/hVGgCOcNAdGKuSp7d7eSNpTBV7s5pNKvxG36/ySBhSvMqHE
         qCaiJyxYJV+IFtlBSUSgkipI330atbUVMCk4hQzY1rxtI+m2mV24n0ZLez9g1GXR3suN
         AOTWJuHdfS0pLOYdoOh3ktoXGcQpmkpOTAYDA1FZVMijbtwvnhvrWalj9gGn02HKRN5/
         VCKYUVyZzr8EIVzLhFNgeeEHBMANveL39F7scu6vEWxpymxF/265DWRbQwOEEZ9W7NOB
         OWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=EX/82qnQonQiLqn4wSbDmFcuxyzSeSG7gW+qIxvJMUI=;
        b=Mdc7aEY2Dv0KCW67Yz8eJuGhX9ZdELjmulb9ZLR7NxLAlxBQQ/Eg+Wdtsx2QY8TeBN
         aPUxx7ViTOSWSxoMfJ6daQ60W/JTvKLZDCeMUb8EkAo0JKifINqLQYWEuI6CgF+Cy/7O
         pWIAI6PrI7hNF3FTLGIiBhSM7XUOIm8cT4YFJU9suj+l7F7ED1cLqEyX62bD3Pdp2f/p
         LA+hrEFmk+ok6fFS1fw0h9BYrHDr/RgBRVt8+HKoL29FYXMKB80/D+x9bqkR6TbpA51V
         9UYEvGbCXZ+9NOSE1Ad+MG8PVBxluxM4GCO1lw2oAHzfYsQmCr0jsUSKuixMVbGi4W29
         2moQ==
X-Gm-Message-State: ACgBeo1vZMaQuI5wqJy4iOFwoqwOYeJjQJz7VTl5IVuxfI3FFXti1esJ
        Hp6+R5syjFJBtTAZg/Dv5Xc=
X-Google-Smtp-Source: AA6agR6Zoi1wt/3LicRsVwqrm1eY/YMZMWLbHbEeTaewbnS24yU05Iszmm4dd63rApd0x4zfOTf9vw==
X-Received: by 2002:a05:6a00:88f:b0:530:dec:81fd with SMTP id q15-20020a056a00088f00b005300dec81fdmr25156305pfj.64.1661254867730;
        Tue, 23 Aug 2022 04:41:07 -0700 (PDT)
Received: from KASONG-MB0.tencent.com ([103.7.29.31])
        by smtp.gmail.com with ESMTPSA id w23-20020a627b17000000b0052d16416effsm10562930pfc.80.2022.08.23.04.41.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Aug 2022 04:41:07 -0700 (PDT)
From:   Kairui Song <ryncsn@gmail.com>
To:     damon@lists.linux.dev
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Subject: [PATCH v2] Docs/admin-guide/mm/damon/usage: fix the example code snip
Date:   Tue, 23 Aug 2022 19:40:53 +0800
Message-Id: <20220823114053.53305-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.35.2
Reply-To: Kairui Song <kasong@tencent.com>
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

From: Kairui Song <kasong@tencent.com>

The workflow example code is not working since it got the file names
wrong. So fix this.

Fixes: b18402726bd1 ("Docs/admin-guide/mm/damon/usage: document DAMON sysfs interface")
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 Documentation/admin-guide/mm/damon/usage.rst | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index d52f572a90298..ca91ecc290785 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -50,10 +50,10 @@ For a short example, users can monitor the virtual address space of a given
 workload as below. ::
 
     # cd /sys/kernel/mm/damon/admin/
-    # echo 1 > kdamonds/nr && echo 1 > kdamonds/0/contexts/nr
+    # echo 1 > kdamonds/nr_kdamonds && echo 1 > kdamonds/0/contexts/nr_contexts
     # echo vaddr > kdamonds/0/contexts/0/operations
-    # echo 1 > kdamonds/0/contexts/0/targets/nr
-    # echo $(pidof <workload>) > kdamonds/0/contexts/0/targets/0/pid
+    # echo 1 > kdamonds/0/contexts/0/targets/nr_targets
+    # echo $(pidof <workload>) > kdamonds/0/contexts/0/targets/0/pid_target
     # echo on > kdamonds/0/state
 
 Files Hierarchy
@@ -366,12 +366,12 @@ memory rate becomes larger than 60%, or lower than 30%". ::
     # echo 1 > kdamonds/0/contexts/0/schemes/nr_schemes
     # cd kdamonds/0/contexts/0/schemes/0
     # # set the basic access pattern and the action
-    # echo 4096 > access_patterns/sz/min
-    # echo 8192 > access_patterns/sz/max
-    # echo 0 > access_patterns/nr_accesses/min
-    # echo 5 > access_patterns/nr_accesses/max
-    # echo 10 > access_patterns/age/min
-    # echo 20 > access_patterns/age/max
+    # echo 4096 > access_pattern/sz/min
+    # echo 8192 > access_pattern/sz/max
+    # echo 0 > access_pattern/nr_accesses/min
+    # echo 5 > access_pattern/nr_accesses/max
+    # echo 10 > access_pattern/age/min
+    # echo 20 > access_pattern/age/max
     # echo pageout > action
     # # set quotas
     # echo 10 > quotas/ms
-- 
2.35.2


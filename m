Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748D059BDF9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 12:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbiHVK47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 06:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbiHVK45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 06:56:57 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3A331EDC;
        Mon, 22 Aug 2022 03:56:55 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id p18so9564554plr.8;
        Mon, 22 Aug 2022 03:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc;
        bh=hUQZ/Tp1Sqyiv6w3yUz+ygSiTM9PrSsj+REeubDk2qE=;
        b=C3HaUGLQY/5xCsQrVkt+OdGw/vWjDEQbsfd0003LDMRZiClk+Q/ID/FH98FpvzpkhW
         YmozuFBomyLxUP7iEui4cprVH2IL/wR6kybEI06V3D+1rKIOvuB2TD1db8RGJWmOn8BO
         Ratq2FuXP5lPY+ygKTFYyzIWy0inHKk727PrNQfDFkKvRBTwLEKbXo+/gn+HMMKgYacO
         rdBCeFi1Bl6PTxOETCCW7oGQBBfh+B+wNCG48TleMWHAtuFuzBf7Vns0E08EYK9wDqPu
         zpaNILIeB1gIwrhs1EoEHnqsdoj9pdDc0wUs235s2eOFfGUM0Jyhgt9dzstb17bArH26
         KoAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=hUQZ/Tp1Sqyiv6w3yUz+ygSiTM9PrSsj+REeubDk2qE=;
        b=Lf4wRxuSSo5TDCbkX9mMGUzMDY+0yxVL7AlT8EyzaR4u/JJaQDLUpFNivem5kHQQ/I
         HbqW2MitBSSL1XbQOv19YHaB20J3JxvcIE58elUgSxX0pHt6l8colBHw+Z91YNG9uYqb
         gX7I5w53G+5J9SL4/xJZQIXBE/q7bMBDPchgLJW6ZWikTmHtbCSM08H3r6sgCDtTtUvu
         Gdn+FYx8Zybu0w5FV3iCMsaGBPKoMTOSQs13INoiy7q9AoObDKZGbzpXEW7L8XYjyVWl
         sPdMDKkiO9bVK09/tYZbrqyTUNn91hi/3ALdyRFEYT8zpI1PbyKUuOh3rg4WsHYz/xhU
         3tdQ==
X-Gm-Message-State: ACgBeo0KiR1XAzHzIEV03KQedPUXdY73JX84nyO0Xjt/Fm/4dRyY1bIU
        KobS52gDLGOBOPfkQ0yrgX8=
X-Google-Smtp-Source: AA6agR5CXRqUs3HJRCeXUJI+lLofKDx4VbPUBq2jOgPfCZ7L6aGgxEOblRidGxRmwmFYt28M9X+3mQ==
X-Received: by 2002:a17:902:7005:b0:172:98ef:863c with SMTP id y5-20020a170902700500b0017298ef863cmr19616019plk.131.1661165814407;
        Mon, 22 Aug 2022 03:56:54 -0700 (PDT)
Received: from KASONG-MB0.tencent.com ([103.7.29.31])
        by smtp.gmail.com with ESMTPSA id m7-20020a1709026bc700b00172d9f6e22bsm3727399plt.15.2022.08.22.03.56.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 22 Aug 2022 03:56:53 -0700 (PDT)
From:   Kairui Song <ryncsn@gmail.com>
To:     damon@lists.linux.dev
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Subject: [PATCH] Docs/admin-guide/mm/damon/usage: fix the example code snip
Date:   Mon, 22 Aug 2022 18:56:17 +0800
Message-Id: <20220822105617.75524-1-ryncsn@gmail.com>
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


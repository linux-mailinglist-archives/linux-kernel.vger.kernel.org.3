Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A33550C91
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 20:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbiFSSgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 14:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiFSSge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 14:36:34 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4850636D
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 11:36:27 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id go6so3545053pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 11:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gs-ncku-edu-tw.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HRs4AILoAryNBdQTWtn8v3T5EEZ9N6zKdCokWLYId6s=;
        b=LEjwhQflmcAq9KSffJhC1mgyt5HQuY62XOD7X3kzwi5UDFNx6y5bOuyeMdwhUaWZT/
         8lguxxShRZLdBtAO81QdEQN270vTwvuvAKCQuvL71Cpn/LSlEs9coVM+yzkcMnRlRxAV
         btRutvf/NbMNuqyqr6oFWk+HQcDANBG0X+Cgn59BPeE+Yhj4prznBgTHtt81CMd3urbC
         WgXBBlgYnJ2Mp+dZt6hz/ZNihJW45f1tZegfy6ea3ta7O28Winjidggq2oezD2V9ZWfM
         mW82w1B/uLRaXiuY+yKB1xKZXECFSu4nQcCTswp15xpzlJy4KmCm8gFHcFpyRS0YrYSJ
         ixKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HRs4AILoAryNBdQTWtn8v3T5EEZ9N6zKdCokWLYId6s=;
        b=Ll/W9JHjvDDgxErbp9Lu4hHLoSxI7JjSDso/xi/6dRZMMh6kmiZkltGy7FH1x0WAYh
         YntIPAz46VqmxYdlR+sUu5dEYooIB+ERCiy2CjUSbx7sUMFyhbfyCbHspEpXwiTkHQ5R
         Qo4WzSh6lnCZz10Qtgd8YhXnjX3c3nPE87VfneR2XYikjXN+c9ojFrMFnIqHDyIY7dc8
         JubzVfLN45wqCnoSFhrk9834S4va1npAyrTNaLMKNeTsFp0v/K00zGTB7AymnK5xsE/Y
         uhRwUCnkEToUz5dHR9iDMdyK7anzScN0uMMxk7E/M8/egEcudJS1EJS+/yzs1AHjnmc9
         qrUQ==
X-Gm-Message-State: AJIora/jGh/MqmPsqDEW4M/Fj2DbypnZiuaJlnST7voE+9qrluteU1Ze
        /B9VsU7V5p9uuc6F0Kmb9wbZvw==
X-Google-Smtp-Source: AGRyM1suoXsMbdMdT2ysOh1yHhjaoTUdEa+1y+W7B2F71G80vPjKVpmVTp/lQuG6P35jSurGiiMeEg==
X-Received: by 2002:a17:902:f646:b0:168:e2da:8931 with SMTP id m6-20020a170902f64600b00168e2da8931mr20160974plg.84.1655663787167;
        Sun, 19 Jun 2022 11:36:27 -0700 (PDT)
Received: from localhost.localdomain ([2001:288:7001:2724:a6bf:1ff:fe8c:70bc])
        by smtp.gmail.com with ESMTPSA id r18-20020a639b12000000b00408a81ea6basm7386307pgd.21.2022.06.19.11.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 11:36:26 -0700 (PDT)
From:   Yun-Ze Li <p76091292@gs.ncku.edu.tw>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yun-Ze Li <p76091292@gs.ncku.edu.tw>
Subject: [PATCH] mm, docs: fix comments that mention mem_hotplug_end()
Date:   Sun, 19 Jun 2022 18:36:17 +0000
Message-Id: <20220619183617.1018438-1-p76091292@gs.ncku.edu.tw>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Comments that mention mem_hotplug_end() are confusing as there is no
function called mem_hotplug_end(). Fix them by replacing all the
occurences of mem_hotplug_end() in the comments with mem_hotplug_done().

Signed-off-by: Yun-Ze Li <p76091292@gs.ncku.edu.tw>
---
 include/linux/mmzone.h | 4 ++--
 mm/compaction.c        | 2 +-
 mm/vmscan.c            | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index aab70355d64f..7c7947109986 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -591,7 +591,7 @@ struct zone {
 	 * give them a chance of being in the same cacheline.
 	 *
 	 * Write access to present_pages at runtime should be protected by
-	 * mem_hotplug_begin/end(). Any reader who can't tolerant drift of
+	 * mem_hotplug_begin/done(). Any reader who can't tolerant drift of
 	 * present_pages should get_online_mems() to get a stable value.
 	 */
 	atomic_long_t		managed_pages;
@@ -870,7 +870,7 @@ typedef struct pglist_data {
 	unsigned long nr_reclaim_start;	/* nr pages written while throttled
 					 * when throttling started. */
 	struct task_struct *kswapd;	/* Protected by
-					   mem_hotplug_begin/end() */
+					   mem_hotplug_begin/done() */
 	int kswapd_order;
 	enum zone_type kswapd_highest_zoneidx;
 
diff --git a/mm/compaction.c b/mm/compaction.c
index 65970107b789..b8c1f60c84b9 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -3009,7 +3009,7 @@ void kcompactd_run(int nid)
 
 /*
  * Called by memory hotplug when all memory in a node is offlined. Caller must
- * hold mem_hotplug_begin/end().
+ * hold mem_hotplug_begin/done().
  */
 void kcompactd_stop(int nid)
 {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c6918fff06e1..bd6aaf85ee7f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4586,7 +4586,7 @@ void kswapd_run(int nid)
 
 /*
  * Called by memory hotplug when all memory in a node is offlined.  Caller must
- * hold mem_hotplug_begin/end().
+ * hold mem_hotplug_begin/done().
  */
 void kswapd_stop(int nid)
 {
-- 
2.25.1


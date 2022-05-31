Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9BA5389C9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 04:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243467AbiEaCEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 22:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240271AbiEaCEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 22:04:35 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18B470376
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 19:04:33 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id v11-20020a17090a4ecb00b001e2c5b837ccso995164pjl.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 19:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QVmLfgn1Nm0LiEUGoHnz2dUGee44h4bxPJzSoBNxosU=;
        b=uos1a+yHGla5I6drZ9n+twHQmjFUu6SMLxAAfWu7H8cv8HExB6g2cQTVyGmgnKTCEk
         pAagV+KHi6edesy4J8md/RWFKce8nc3wPtbxqYYIUbtCbRgoZeaa8MNgCld6R0U6AZlN
         L9kE5+HYnVFFRTQq5aHOyNhBBoYZSr/vQRqjQtPm8as8FHeUGqIlV/9q8ia9WA0Oq642
         fcF33pHIdydP4sOxGuZgWseVrT2eChQ3dqWiimur9ncs+ilqT6zIbVitx9Qx0ABtxKgF
         IXMU9mK/D7n7vN9LhdYfrtm/hgwlxojRfP/6Aln0D+GVLpODRbQH7wNc49Tt0bkiPut8
         g4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QVmLfgn1Nm0LiEUGoHnz2dUGee44h4bxPJzSoBNxosU=;
        b=HwJIgsR6C2LGeFuDKIBZEQjz6DHzX37VHTtN363VK6YlKfcbS0G0U5fX1hLRkHj4VG
         hgDYPW0f1+YqcKDdaSfxtM7vJYqMdO2JlKHvLeotDJ1j6yxf305SHQ+g3pJUmdoiSdW+
         9pNGR2n9dzR4aP6CMlnxrgFtAfU7rwseXfK0vhY6I4OU8EoT+eqC+tJWlGt8Nma6+9nq
         Cev7MBbKCsYbViU2GebMKR+FCfaOg7WdUwVciBJCyTiolP3rsaKUHwDNkYt7zlLRYyjz
         XBwMvsIDz3NS0yOeIt0qSsJLtvsXHuILgf7/dcSd23kXR+QJVH7eRnUiKloBG5Ii1ukl
         lTGA==
X-Gm-Message-State: AOAM531YEJcyKhdZ+4lGt+MqoSOqSoDpgk+Azmgnnj2yh5sPiRQZyrxJ
        EfNoUeqd/uwx/1VJWFesChINQg==
X-Google-Smtp-Source: ABdhPJwqyfqh3TdM8rEWKG+tvJdNyCdIntwg0OJn3Jsu+EfLz1PnNkvtFHLVLTje863Tc3rsUCUElQ==
X-Received: by 2002:a17:90a:b703:b0:1dd:1e2f:97d7 with SMTP id l3-20020a17090ab70300b001dd1e2f97d7mr26005094pjr.62.1653962672535;
        Mon, 30 May 2022 19:04:32 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id q60-20020a17090a1b4200b001e2f8163810sm367573pjq.30.2022.05.30.19.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 19:04:32 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     sj@kernel.org
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2] mm/damon: remove obsolete comments of kdamond_stop
Date:   Tue, 31 May 2022 10:04:21 +0800
Message-Id: <20220531020421.46849-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 0f91d13366a4 ("mm/damon: simplify stop mechanism")
delete kdamond_stop and change to use kthread stop mechanism,
these obsolete comments should be removed accordingly.

Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
v2:
 - explicit termination uses damon_stop() instead of __damon_stop()
---
 include/linux/damon.h | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 7c62da31ce4b..2765c7d99beb 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -397,7 +397,6 @@ struct damon_callback {
  * detail.
  *
  * @kdamond:		Kernel thread who does the monitoring.
- * @kdamond_stop:	Notifies whether kdamond should stop.
  * @kdamond_lock:	Mutex for the synchronizations with @kdamond.
  *
  * For each monitoring context, one kernel thread for the monitoring is
@@ -406,14 +405,14 @@ struct damon_callback {
  * Once started, the monitoring thread runs until explicitly required to be
  * terminated or every monitoring target is invalid.  The validity of the
  * targets is checked via the &damon_operations.target_valid of @ops.  The
- * termination can also be explicitly requested by writing non-zero to
- * @kdamond_stop.  The thread sets @kdamond to NULL when it terminates.
- * Therefore, users can know whether the monitoring is ongoing or terminated by
- * reading @kdamond.  Reads and writes to @kdamond and @kdamond_stop from
- * outside of the monitoring thread must be protected by @kdamond_lock.
- *
- * Note that the monitoring thread protects only @kdamond and @kdamond_stop via
- * @kdamond_lock.  Accesses to other fields must be protected by themselves.
+ * termination can also be explicitly requested by calling damon_stop().
+ * The thread sets @kdamond to NULL when it terminates. Therefore, users can
+ * know whether the monitoring is ongoing or terminated by reading @kdamond.
+ * Reads and writes to @kdamond from outside of the monitoring thread must
+ * be protected by @kdamond_lock.
+ *
+ * Note that the monitoring thread protects only @kdamond via @kdamond_lock.
+ * Accesses to other fields must be protected by themselves.
  *
  * @ops:	Set of monitoring operations for given use cases.
  * @callback:	Set of callbacks for monitoring events notifications.
-- 
2.36.1


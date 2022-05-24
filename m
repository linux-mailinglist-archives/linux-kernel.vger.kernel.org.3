Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1B2532357
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 08:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbiEXGjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 02:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbiEXGjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 02:39:51 -0400
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC7997282
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 23:39:50 -0700 (PDT)
Received: by mail-pl1-f195.google.com with SMTP id i1so15057392plg.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 23:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FLpQhU4wIuQ9gfzVdP55j5y40oEenp5w7XtKqslAoUw=;
        b=bYLQLMQYGZ+1wreuSC65/4M2mv2T46CooIuy4pIM8sdbvzkUk5SVAwWTtiI5TSr9Zv
         kJDi2eCE866buM1P6Qlf/2gCKWlm7w0gHwJX3iXTC+9f0oih59c/8mjsSU43oviTrsVu
         86Eg3rHS1t3zzG6WDFoaICNGG2TMLooV3HsoRdU2U95zhKKhsap3TXv6Nvqz1LHBLNcQ
         AreqqHr5lwgbQWz/Uo0Qpv1bMfMyjyxoPWIWK+AkusYWOgAhK3qm+nicmInJczBFmlPS
         NEYz9z1Z61sXg7fhA5XY1DSrkiBIqBcxq9zxJrf1GJAyUnUBKew37bc+wLXqSP1v64kQ
         A5sg==
X-Gm-Message-State: AOAM533oP+72IZHcye73qXKT9veaK7fOneeQCQeYhO4/Etp9TeZrIE/p
        BJ0E2ny+xSXw97hZ4U5pqEGipXrLBVsk
X-Google-Smtp-Source: ABdhPJxg5pHFGAY4+FjK5uaGkgnzLTNfSpF72Xikt4ph+KNrBzfT+QY1/eexWrVFAQnYa0VjsM3vUg==
X-Received: by 2002:a17:90a:1b6c:b0:1df:6940:e856 with SMTP id q99-20020a17090a1b6c00b001df6940e856mr3026855pjq.240.1653374389570;
        Mon, 23 May 2022 23:39:49 -0700 (PDT)
Received: from localhost.localdomain (ns1003916.ip-51-81-154.us. [51.81.154.37])
        by smtp.gmail.com with ESMTPSA id r5-20020a170902ea4500b0015f300ed0b7sm6269634plg.76.2022.05.23.23.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 23:39:49 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, sunliming@kylinos.cn,
        kelulanainsley@gmail.com
Subject: [PATCH] tracing: fix comments of create_filter()
Date:   Tue, 24 May 2022 14:39:37 +0800
Message-Id: <20220524063937.52873-1-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name in comments of parameter "filter_string" in function
create_filter is annotated as "filter_str", just fix it.

Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 kernel/trace/trace_events_filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index b458a9afa2c0..4b1057ab9d96 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1816,7 +1816,7 @@ static void create_filter_finish(struct filter_parse_error *pe)
  * create_filter - create a filter for a trace_event_call
  * @tr: the trace array associated with these events
  * @call: trace_event_call to create a filter for
- * @filter_str: filter string
+ * @filter_string: filter string
  * @set_str: remember @filter_str and enable detailed error in filter
  * @filterp: out param for created filter (always updated on return)
  *           Must be a pointer that references a NULL pointer.
-- 
2.25.1


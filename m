Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F456534AC9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 09:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346370AbiEZHaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 03:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234551AbiEZHaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 03:30:07 -0400
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A8A94192
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 00:30:05 -0700 (PDT)
Received: by mail-pf1-f194.google.com with SMTP id y199so1016014pfb.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 00:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XVO0c4OFjvyWu5NyVZrsMQeQ9KE+Mb796uF0sFFvmwU=;
        b=QsLq3aSPnQDhbnCBGdGo+ePL2PRM83yzJkbEFR+B32E7xoIo5FXFMCes4OYiLEEBs8
         vyNsACIQ9dPE07WXcyE2hXphU9IqkszoSWxJXM6f6jlSPKLVe4CtS0szSWFTy0zaGLHP
         kBQU0kYVRV2g0Qv41yP49H7Htg8NXgivgxmjRSrM7AeW7xAFEgw3EHLagZXZpOtl72cu
         Zla0AfLXbKYxb7n8/usR1oGDL7+TtkMFVctRuBNHb5fSc8DLxh0wqPlbLuUVTQfCgrrK
         Nf/uXMf5xd8Fm6rydKvJBK1y8R1u9TV+qpxtcH+VglgksWG9MF24Z3I5pt0GhCJbhMp9
         Q9ZQ==
X-Gm-Message-State: AOAM533/yu/r7K2SOzbIdvQEqZHU/BXP0VyJYoerqcyQBUncEQ1nqJGr
        071XYiS4dd86O92KcRTVmQ==
X-Google-Smtp-Source: ABdhPJw3B5iWNJ0GLIdOm+Uugh6KlnaGVNABHFWgMh1BjzQjtnxjq7XhfbPzFWOxnJDTufB/wLbRfA==
X-Received: by 2002:a63:4c57:0:b0:3fa:beab:dbc8 with SMTP id m23-20020a634c57000000b003fabeabdbc8mr8736077pgl.291.1653550205036;
        Thu, 26 May 2022 00:30:05 -0700 (PDT)
Received: from localhost.localdomain (ns1003916.ip-51-81-154.us. [51.81.154.37])
        by smtp.gmail.com with ESMTPSA id k6-20020a170902d58600b0015e8d4eb1edsm717409plh.55.2022.05.26.00.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 00:30:04 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, kelulanainsley@gmail.com,
        sunliming@kylinos.cn
Subject: [PATCH V2] tracing: fix comments of event_trigger_separate_filter()
Date:   Thu, 26 May 2022 15:29:57 +0800
Message-Id: <20220526072957.165655-1-sunliming@kylinos.cn>
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

The parameter name in comments of event_trigger_separate_filter() is
inconsistent with actual parameter name, fix it.

Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 kernel/trace/trace_events_trigger.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 21592bed2e89..cb866c3141af 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -738,15 +738,15 @@ bool event_trigger_empty_param(const char *param)
 
 /**
  * event_trigger_separate_filter - separate an event trigger from a filter
- * @param: The param string containing trigger and possibly filter
- * @trigger: outparam, will be filled with a pointer to the trigger
+ * @param_and_filter: String containing trigger and possibly filter
+ * @param: outparam, will be filled with a pointer to the trigger
  * @filter: outparam, will be filled with a pointer to the filter
  * @param_required: Specifies whether or not the param string is required
  *
  * Given a param string of the form '[trigger] [if filter]', this
  * function separates the filter from the trigger and returns the
- * trigger in *trigger and the filter in *filter.  Either the *trigger
- * or the *filter may be set to NULL by this function - if not set to
+ * trigger in @param and the filter in @filter.  Either the @param
+ * or the @filter may be set to NULL by this function - if not set to
  * NULL, they will contain strings corresponding to the trigger and
  * filter.
  *
-- 
2.25.1


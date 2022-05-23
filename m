Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5393530ADE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiEWHvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbiEWHvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:51:33 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A5713DE4
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:51:30 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id z7-20020a17090abd8700b001df78c7c209so16770770pjr.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qt7SFmYNvj/PEYDHiTZTk47aq+OlriIV6gUOEB8MUc4=;
        b=kP7yFSRM3piZv3bCbKwIeFmBco6Lmh+zL8t7ESWuOvqE4zoA/T3Fs4XqHqIIdrDC0e
         9O/3IDCH9QS5xrkWAcvjpRyCgQZfBUBZ8iGexyWhgngu2ULW8pd4nO8M6Xy4GviBeERH
         8f6p2kSWnHA62YJoho9J1nx1sK5xYxCI9PQonQAoXAlCj96W7C9I73vN2stSkG+Aa+63
         UcVzF6TDE3rpMfH61ziKQQsUmLJ3sQuKzGuQuGR8EIs9ka0cr81IPPja6DH0jpLGtzo3
         MM3pfrbUj2UCR9NF/ScWmyRrJ275B48Ax/cFcuVbQFUzmoPvQ39U86xl3BzXZ+SpJZHW
         yLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qt7SFmYNvj/PEYDHiTZTk47aq+OlriIV6gUOEB8MUc4=;
        b=2H5PYsfqSIJ8uf1algG0fGgtQOpcdKfQUZxeuiZO4ppZwKascmHPUL27tZSISH8QCN
         qOrG60H8fFP4PvbEszoxK70uWaFq3ec0awMA4mG7umMfCRjH3QbippkNhn/aR80zKu6M
         avcHkCULfILa2D8aK/li1TCABQ8rOjDn72bZGmD5aSv1223Rdl+l/PffXkliwxpIeHiC
         3XQfP+c+a8qUjGnAx8px5xO1VFcseZ88NgvVO9C51aDp/g5GLyRPL4FGIXtmEO0JqSfG
         EjW//TQEpzp3n05u1xHLBranU531MGUwNeHvlwypKrsxt9BN9AAOumVxZCr3WEer5+KG
         QQbA==
X-Gm-Message-State: AOAM531m6tdlUNw5FXxw0ONZwP1ozqyZ682Uk78YrsrkhJOFrHKR+lMF
        RzE+1OuvkorTzAJVvAJyxQ==
X-Google-Smtp-Source: ABdhPJzpdPo0dNciuwrYrbYzPoc23Gg3wgrWbCAYTurYAmChizUxV6msRW58oWMTGwiGBpf5Dn/7PQ==
X-Received: by 2002:a17:90a:191a:b0:1dc:a3d3:f579 with SMTP id 26-20020a17090a191a00b001dca3d3f579mr25590272pjg.30.1653292289923;
        Mon, 23 May 2022 00:51:29 -0700 (PDT)
Received: from localhost.localdomain (ns1003916.ip-51-81-154.us. [51.81.154.37])
        by smtp.gmail.com with ESMTPSA id c13-20020a65420d000000b003c14af5060fsm4163314pgq.39.2022.05.23.00.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 00:51:29 -0700 (PDT)
From:   slm <kelulanainsley@gmail.com>
X-Google-Original-From: slm <sunliming@kylinos.cn>
To:     mingo@redhat.com, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, kelulanainsley@gmail.com,
        sunliming@kylinos.cn
Subject: [PATCH] tracing: fix comments of event_trigger_separate_filter()
Date:   Mon, 23 May 2022 15:51:23 +0800
Message-Id: <20220523075123.1068763-1-sunliming@kylinos.cn>
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

The parameter name in comments of event_trigger_separate_filter()
is inconsistent with actual parameter name, fix it.

Signed-off-by: slm <sunliming@kylinos.cn>
---
 kernel/trace/trace_events_trigger.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 21592bed2e89..c364dc729339 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -738,27 +738,28 @@ bool event_trigger_empty_param(const char *param)
 
 /**
  * event_trigger_separate_filter - separate an event trigger from a filter
- * @param: The param string containing trigger and possibly filter
- * @trigger: outparam, will be filled with a pointer to the trigger
+ * @param_and_filter: The param_and_filter string containing trigger
+ * and possibly filter
+ * @param: outparam, will be filled with a pointer to the trigger
  * @filter: outparam, will be filled with a pointer to the filter
  * @param_required: Specifies whether or not the param string is required
  *
  * Given a param string of the form '[trigger] [if filter]', this
  * function separates the filter from the trigger and returns the
- * trigger in *trigger and the filter in *filter.  Either the *trigger
+ * trigger in *param and the filter in *filter.  Either the *param
  * or the *filter may be set to NULL by this function - if not set to
  * NULL, they will contain strings corresponding to the trigger and
  * filter.
  *
  * There are two cases that need to be handled with respect to the
- * passed-in param: either the param is required, or it is not
- * required.  If @param_required is set, and there's no param, it will
- * return -EINVAL.  If @param_required is not set and there's a param
- * that starts with a number, that corresponds to the case of a
- * trigger with :n (n = number of times the trigger should fire) and
- * the parsing continues normally; otherwise the function just returns
- * and assumes param just contains a filter and there's nothing else
- * to do.
+ * passed-in param_and_filter: either the param is required, or
+ * it is not required.  If @param_required is set, and there's no
+ * param, it will return -EINVAL.  If @param_required is not set
+ * and there's a param_and_filter that starts with a number, that
+ * corresponds to the case of a trigger with :n (n = number of times
+ * the trigger should fire) and the parsing continues normally;
+ * otherwise the function just returns and assumes param_and_filter
+ * just contains a filter and there's nothing else to do.
  *
  * Return: 0 on success, errno otherwise
  */
-- 
2.25.1


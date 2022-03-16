Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E254DBAFB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 00:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343911AbiCPX0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 19:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239382AbiCPX0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 19:26:10 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2E11025;
        Wed, 16 Mar 2022 16:24:55 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r10so5083898wrp.3;
        Wed, 16 Mar 2022 16:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8WfATESKc9wZ3vDF1I0zU+P50+YMVhGX+MWIkNwZFp0=;
        b=mC+JhUGMTk6K077aTs9ZyBUrOafpkJnKrhVECh/ReZmVRiHqSfc6dkYzRCpvUVNfs5
         RyI1d9lmq8QaLdl6hp22zdqgwAGIwyumkDwopOv6OaFOi43dygWG1aELc/+ARpkqBMzC
         MSuMyQfGb+mfclISMYGarT2CNVlIRDcy30rMo+x+H4FVwaCUv6tYutsJkq4XOUhCYXLd
         fNv5hiZZ2awDkNpQzEwk+f4GdSc6JC0Ggr4Puk/8TofGfk1ZQr9eWYlJl2/Bnu0cqys+
         B7coxXEGm8Sgb3LTlF3Z31REmuFWW58BrhZ4aGygf8GFUk4YG7fh2DwKVU7OGyK/cxcx
         uKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8WfATESKc9wZ3vDF1I0zU+P50+YMVhGX+MWIkNwZFp0=;
        b=oR5yc3+OIawtz7J28Ube20QkS5bf7YzFvwZU3Djh/6RREEyDMbjQbi0UJh3J7ULIg/
         CL1vvlwRrTT23Khx7D7RVhtzAq+bY8gh6sVG3aTFeZ7N9wdAap5yeY0Ac0KQACksio+S
         8RE3PfVPkwC6C6lSP5nr9DCBlK1pgYHEVHW3Aml+5wGwpZpfmqhCWsPqhJPDxTIaUM8R
         J2WcSz8sGwYz9N0IJkI4K+OvjTWazdiIbziCft224F7nC2NHEU9zK/H7ak4ab68F5x8P
         fpbHneFz5TYWwe1LesqOk2lli/8yo5ccDcVOfmfqPn6V6fyh+ARnRWizDFfPC4tPsgVV
         Jx6Q==
X-Gm-Message-State: AOAM532GltMey72n+G+pGm1msBvS+MDroMKfNhO8uEAMBb/O8zGGGTBC
        W+BvRewjtw/D+zrxEIcQAow=
X-Google-Smtp-Source: ABdhPJzooinj7/JGm2tOLNhpTMYAdb3IhaEO9nBVNYNrz+PkrGebFsAYtXabQ5RzbnYXjwoDqUPlrg==
X-Received: by 2002:adf:ed50:0:b0:203:da73:e0fd with SMTP id u16-20020adfed50000000b00203da73e0fdmr1700635wro.516.1647473093956;
        Wed, 16 Mar 2022 16:24:53 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id f8-20020adfb608000000b0020229d72a4esm2556780wre.38.2022.03.16.16.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 16:24:53 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf build-id: Fix spelling mistake "Cant" -> "Can't"
Date:   Wed, 16 Mar 2022 23:24:52 +0000
Message-Id: <20220316232452.53062-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in a pr_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/perf/util/build-id.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 7a5821c87f94..82f3d46bea70 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -762,7 +762,7 @@ build_id_cache__add(const char *sbuild_id, const char *name, const char *realnam
 
 		len = readlink(linkname, path, sizeof(path) - 1);
 		if (len <= 0) {
-			pr_err("Cant read link: %s\n", linkname);
+			pr_err("Can't read link: %s\n", linkname);
 			goto out_free;
 		}
 		path[len] = '\0';
-- 
2.35.1


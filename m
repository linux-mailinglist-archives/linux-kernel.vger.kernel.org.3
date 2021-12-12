Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4EA6471E34
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 23:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhLLWV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 17:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbhLLWVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 17:21:25 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30152C06173F;
        Sun, 12 Dec 2021 14:21:25 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id j3so24200708wrp.1;
        Sun, 12 Dec 2021 14:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7eDS74LpyA4frPSMwjjpOHEgUo/4S5rJ+isae+pfC4s=;
        b=bpBy9vGXoqqpZox387Ye5rQni0fMcNgsX/u6iextlwu/sVGNU51eEEXWKPh+Gz4buh
         oKOuN00BXR08mQWUuu8XQblM3iJ5c6cNTXpyA3aqzLuE50LYMyOGR5/N15nYp6DCGtO0
         pmkI+CrL0aCcQNioauCYFrTBSPFRqlKQY0Fpp2Ah0ecEMWFmpSQc88fqpPhEqDHaUN7s
         TH2OAYmIBGyj5jiXHjWea/Fc9nWj7a2M2r8NfZNrbrCYs2ja8j0E9kYt8WnwVZFkp1oD
         cl6fBW25Zya5sTJMphBEXJ+MPo5baxef3ZsankCWTYm6TnVbV1JZCwHn4YP8fQJPaiTS
         wIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7eDS74LpyA4frPSMwjjpOHEgUo/4S5rJ+isae+pfC4s=;
        b=JBvY/6lArinfnv3DaEW3qXStwedokkRufhz/H/H3eT4wUjtGtKNXbOGE9aSPvG4u4j
         2eSAXXt/cW48BavOfsFhz/XJzZeV23YJGlu46FT+tQPKdZ0lQLa/4KxrDqFTPylhPZcv
         DvLN6ZsPSUV69+yV9AiI4tirKTeMkYQD/xXGtplnwGp9dvhWYAVHHeNQVDQdUd9jzWcd
         fHF82k7rvkHggM7rxeZ/6Viua+e9ZzwjreiG1pvf+gdm1r/2mQLEY9kGzBy3au2yTpcS
         RKeBTV15islnIT//q6TKCFU5o8pM8WdZJ3PAfrzGsSVT+Zpt+CXxKUtBgYfAJqV0rB3Y
         duaA==
X-Gm-Message-State: AOAM532akbthPMx69fidJ9hQYb48atDB1mgw50mJSv4jKzj+QKoPwZ4f
        NfVZ4iHgYgMFl435aaS4EW0=
X-Google-Smtp-Source: ABdhPJx6pob1SEOL7xPRpcRuOCpxcFDV6sWdOlb24PyMt32k6FS6/u74LDTUwyYVNU756HLHV2t4Sw==
X-Received: by 2002:adf:e0c7:: with SMTP id m7mr28507060wri.530.1639347683811;
        Sun, 12 Dec 2021 14:21:23 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id a198sm6202105wme.1.2021.12.12.14.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 14:21:23 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] libperf tests: Fix a spelling mistake "Runnnig" -> "Running"
Date:   Sun, 12 Dec 2021 22:21:22 +0000
Message-Id: <20211212222122.478537-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in a __T_VERBOSE message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/lib/perf/tests/test-evlist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
index 520a78267743..e7afff12c35a 100644
--- a/tools/lib/perf/tests/test-evlist.c
+++ b/tools/lib/perf/tests/test-evlist.c
@@ -535,7 +535,7 @@ static int test_stat_multiplexing(void)
 				    (double)counts[i].run / (double)counts[i].ena * 100.0,
 				    counts[i].run, counts[i].ena);
 		} else if (scaled == -1) {
-			__T_VERBOSE("\t Not Runnnig\n");
+			__T_VERBOSE("\t Not Running\n");
 		} else {
 			__T_VERBOSE("\t Not Scaling\n");
 		}
-- 
2.33.1


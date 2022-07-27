Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D873C5826DA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 14:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbiG0Mle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 08:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbiG0Mlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 08:41:31 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2023C8F7;
        Wed, 27 Jul 2022 05:41:30 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v13so16207284wru.12;
        Wed, 27 Jul 2022 05:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VaMuq5v+o4NuavIgBNulbU08tx+K6cDqBuz9Lk6sg3w=;
        b=iBVIyJur5/3VjBIx9JFnuj322HvaRegxfGLuIapfGP85ujs4yKv0jS3rueb08HIiLE
         21Bho22PyTObSxBDXl5WaWkidE/DC4j1dzofLrMFk8rnaGWWTf0aou/E3bKVKxyx00lC
         Od1ZFaFi1F5eN7iAiRfoUSuh2wQfJlZKrZl7zd8AAk5wxFjqd+YojMaTzqo83s3rv6Gg
         8FfuMWhLDRmKlppEcnFq9Qu7TioucpDirRn60Nk2C7ZL0HjKCMX02IsXtQjBfOQ4NTPx
         MT9Ja/2RUkQBaDuQjwPYBTGGgsE65fGbeiZwRpWT/k5kBH3U4NEwWyPOWrSsM2A7qxCz
         JYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VaMuq5v+o4NuavIgBNulbU08tx+K6cDqBuz9Lk6sg3w=;
        b=7sIlCisQOoaO30hEHaClm9SRHoUNgBHi5o6wJirbOSLpZegofI45axGFzGnZT2qOxS
         ktZ8sZmAoazKc8mUrgbyKcPXjUJMY6+ONlzsyPMcmHMj+Ur8WfmNv2hdDp0Q/tFD0m5d
         rkWO0UbkYRtiZyMFCZe/uyCni6YHN3K1XcZBfbFDZorJIUYjr82edrzZxtoJD4LzqkHj
         Y5zX55v1Gl62CjcRFgvUMbgHIZjfBxpPEYlnnlFOkMt+oF0IIx0j+EMVskdn9dlMJKd7
         VSiVJ+yIZkRa5jWWAluug6eGhez/PZQUfWz8KkR7X2/gW9UXDFsA2XZljXDkZF2i2DEh
         TuZw==
X-Gm-Message-State: AJIora8Qh3x7cR5st4Hzwy/DvA6iVv0mHVRkr93SS+6+l74i87Pnrdmw
        Q+Kh03UHrD6mGrVTzRbY4rk=
X-Google-Smtp-Source: AGRyM1uFCE3S+KoaOaBbuQX61YGuW4CbxHkK6tDvNgw2AJH6uwb6fk3KdJEDqtIQoY+Z2qXEezpZhw==
X-Received: by 2002:adf:cd86:0:b0:21e:b245:9556 with SMTP id q6-20020adfcd86000000b0021eb2459556mr4243024wrj.151.1658925688731;
        Wed, 27 Jul 2022 05:41:28 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b003a2fb1224d9sm2562153wms.19.2022.07.27.05.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 05:41:27 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] perf kwork: Fix spelling mistake "Captuer" -> "Capture"
Date:   Wed, 27 Jul 2022 13:41:26 +0100
Message-Id: <20220727124126.222137-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in a pr_debug message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/perf/builtin-kwork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index fb8c63656ad8..d5906e939756 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -1447,7 +1447,7 @@ static void sig_handler(int sig)
 	 * Simply capture termination signal so that
 	 * the program can continue after pause returns
 	 */
-	pr_debug("Captuer signal %d\n", sig);
+	pr_debug("Capture signal %d\n", sig);
 }
 
 static int perf_kwork__report_bpf(struct perf_kwork *kwork)
-- 
2.35.3


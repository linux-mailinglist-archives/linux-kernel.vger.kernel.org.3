Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451AF4B46BD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 10:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244318AbiBNJlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 04:41:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244489AbiBNJk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 04:40:29 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F0FAE54;
        Mon, 14 Feb 2022 01:35:51 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id i14so25711225wrc.10;
        Mon, 14 Feb 2022 01:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/4o0Sh/HDw28K29dhWptIQG7sJvv6LA5ikZvkukruHE=;
        b=MwgSTZgnHotojaZgn5Sp7lQFJP83AHlDASXB7/1KYjjda8kjGHs9bIYBCcAmML8x0e
         PwKf8EV+q6zr7osLYlY0/qeHeNvcXePbtftCPgMcLsQiAwM6ZK40uLL8S1ylRg5kVXBs
         M64EDQrvp1cjYZxftr2qaYjcciNKBHWGvsdx49ZBjlDsFTf7yvP2b0RPBJW5+gD6c42e
         sQkj1pjWEcUuVgjLzvKw7obGVyx0u7/lNS66TilSdahadgfbd1mvTwZ9EuNeUUWTze1s
         IrdoPMGfsdrHt18T9ZFUFVmxlLdezW1qmmmbv1YjMWkRNTHkHwRm2pvj/Y/TrQQ37+iV
         UINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/4o0Sh/HDw28K29dhWptIQG7sJvv6LA5ikZvkukruHE=;
        b=FXHBUR3yUkkX0XioPZUWarWS/3exYqSG2H7gJ43pO/8OXwUa1yoktP/iknHAEEU6wz
         AdrDIA8Mhd2PJ7ZugChwhz1MaYjD8sJFPILGDs5dDSWTV4Mh2ZkriDyrzNram2rxlOLD
         /EItDwIhCXILjHGh3hd1LtYkauzifeU8KDh4zVxTzPXYdAtuHD27LwW5Abg11Fsor3kt
         rwcJb7dP7qH+DozOGnZTfshqci7kFpXVYg54GpvmAfrMJHQdoLYWahuxQuOhKad1vIdP
         8g42TBMjQyRfj0GURo9QuzmjAuWQrec1QLnYzSDHUrWhDJBcD2J1PpNAYJuJtSPyKldh
         DnIQ==
X-Gm-Message-State: AOAM532J3ADagDmXjg7cphojc4bWYPX3CYTRdbFeAKhphjMC/E+EFuPE
        ZyVIErB63tH8e6mtkJQDVW8=
X-Google-Smtp-Source: ABdhPJwXHkfo0LVYpx7SEv6O1F58w6UNsO73U42vtQ17B2CQMPqe4CDwDvgTvyspI1UeUCCcFqjjxg==
X-Received: by 2002:a5d:4fc4:: with SMTP id h4mr10734960wrw.481.1644831348777;
        Mon, 14 Feb 2022 01:35:48 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id u16sm3192017wmq.41.2022.02.14.01.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 01:35:48 -0800 (PST)
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
Subject: [PATCH][next] perf tools: Fix spelling mistake "commpressor" -> "compressor"
Date:   Mon, 14 Feb 2022 09:35:47 +0000
Message-Id: <20220214093547.44590-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.34.1
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

There is a spelling mistake in a debug message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/perf/util/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 4cb5f2f159cc..50502b4a7ca4 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -298,7 +298,7 @@ int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, struct perf_cpu
 	map->comp_level = mp->comp_level;
 #ifndef PYTHON_PERF
 	if (zstd_init(&map->zstd_data, map->comp_level)) {
-		pr_debug2("failed to init mmap commpressor, error %d\n", errno);
+		pr_debug2("failed to init mmap compressor, error %d\n", errno);
 		return -1;
 	}
 #endif
-- 
2.34.1


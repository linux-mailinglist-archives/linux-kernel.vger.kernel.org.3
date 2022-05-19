Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2808552D0CC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 12:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbiESKpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 06:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbiESKpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 06:45:17 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9D3AF1C3;
        Thu, 19 May 2022 03:45:16 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id nr2-20020a17090b240200b001df2b1bfc40so8411772pjb.5;
        Thu, 19 May 2022 03:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kU+uY/vnjoCqracvCzMxUblA/upfeTjjU/V00N5As9s=;
        b=dmTulPLRuUGX/7gTQjBwrSIzaVfMIDjN//zFrei6hDzYnKTTRQTmVnRXaPUNHlWYWF
         HK+onBGX5Q4jNQaOk9c8UBqq2e6qs8v0a0rXys93FKXYozrYyOXo5NvET1+oc9Dzo74w
         oEq4uTNPPvc6+AkS8+Ta7bFzRt7DmXSoznU5z97pp15GStkfPALE7RKO+vfo75N6sCxt
         Jq3W6Y+4Njpkz2opwEZPyGNviQkBRpv/fZh+citwaEa7wCugegBtzmrkjNsBWWG7EmyI
         Tlx0WMP5/ypA7shGHuEBgKxGcvGCVAlTihzH1cBkntdzYh7/yQ5CZANDAsiqjoIOG0Fp
         HqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kU+uY/vnjoCqracvCzMxUblA/upfeTjjU/V00N5As9s=;
        b=ElcSQcpgyyj7h8qfcNbp3A26vdImQZsZiNA1tpis71vxbwB7alJLUlfVFV/lRb0hsM
         0nAWHZQ1bcTS9S4f8uKZrn6BHFmI8JWz3aEDv79UoX8TEeE26qaGuEsufVss0OQ0sUQO
         hleXExkBYLBxMNzs3YTrdteBaOsClCe9pDnIsgT/UWijJxS0x3n668cc3eCsCMnWY10D
         cFqm7wyaemhZcRfzulnPRFmlPuDYWUGwV/KeH5b7VZgqdJc2hukzp+qQmbPMc5eK5nel
         uW53HswmkispVNLiV8Iu0YTgrCSAVX5qVJq8XHyWWwvdXicT1nDf8/+sG1Cds+NoqdSd
         aL6Q==
X-Gm-Message-State: AOAM5303ZNUFcMKsj/uS99b8P/ell/ZZWzoL78O6YDkIIBNnSYCPVRNj
        0TDAi9JwTLzO9mp/gU1F22FhXiTp1Mku5g==
X-Google-Smtp-Source: ABdhPJz1YeGQCGZAdh0qKsrefI3VsajkXceQXSW2Z9ljNyJhqZZA1638ROCGpPbCjn/52HS8MDZZbA==
X-Received: by 2002:a17:90b:4c4d:b0:1df:a164:7055 with SMTP id np13-20020a17090b4c4d00b001dfa1647055mr5104201pjb.180.1652957115835;
        Thu, 19 May 2022 03:45:15 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.80])
        by smtp.gmail.com with ESMTPSA id m16-20020a62a210000000b0050dc7628142sm3753768pff.28.2022.05.19.03.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 03:45:15 -0700 (PDT)
From:   Like Xu <like.xu.linux@gmail.com>
X-Google-Original-From: Like Xu <likexu@tencent.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/events/intel/ds: Enable large PEBS for PERF_SAMPLE_WEIGHT type
Date:   Thu, 19 May 2022 18:45:09 +0800
Message-Id: <20220519104509.51847-1-likexu@tencent.com>
X-Mailer: git-send-email 2.36.1
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

From: Like Xu <likexu@tencent.com>

Large PEBS could be enabled for the generic PERF_SAMPLE_WEIGHT sample
type until other non-compatible flags such as PERF_SAMPLE_DATA_PAGE_SIZE
(due to lack of munmap tracking) finally stop it.

Add PERF_SAMPLE_WEIGHT to LARGE_PEBS_FLAGS to save PMIs overhead.

Tested it with:

$ perf mem record -c 1000 workload
Before: Captured and wrote 0.126 MB perf.data (958 samples) [958 PMIs]
After: Captured and wrote 0.313 MB perf.data (4859 samples) [3 PMIs]

Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Reported-by: Yongchao Duan <yongduan@tencent.com>
Signed-off-by: Like Xu <likexu@tencent.com>
---
 arch/x86/events/perf_event.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 21a5482bcf84..1ed0970d67e6 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -136,7 +136,8 @@ struct amd_nb {
 	PERF_SAMPLE_DATA_SRC | PERF_SAMPLE_IDENTIFIER | \
 	PERF_SAMPLE_TRANSACTION | PERF_SAMPLE_PHYS_ADDR | \
 	PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER | \
-	PERF_SAMPLE_PERIOD | PERF_SAMPLE_CODE_PAGE_SIZE)
+	PERF_SAMPLE_PERIOD | PERF_SAMPLE_CODE_PAGE_SIZE | \
+	PERF_SAMPLE_WEIGHT)
 
 #define PEBS_GP_REGS			\
 	((1ULL << PERF_REG_X86_AX)    | \
-- 
2.36.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C5D494ECE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 14:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344483AbiATNUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 08:20:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52007 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245046AbiATNUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 08:20:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642684831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/5fYqDR4K3w+AjAWeSrlvwJLCguQHLmILiYWDQ2tnZs=;
        b=EeYYQbc+OD4+6wwhU5uD3mU3VrI3PN6JdnhdMScmg+sBpo7rf2DOfgZXozpcOL96b09j5e
        yo1wnaivwnkP7vUKU8jeUatC4Qbs4K1yFKIwWssqhysYgWO000aVjGwxFCfsG5q0na8uPI
        rRNeQTFVe2uUSYpvUcpPFP31k4majrY=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-2V01-nUrMKacCLpRMzHCSQ-1; Thu, 20 Jan 2022 08:20:30 -0500
X-MC-Unique: 2V01-nUrMKacCLpRMzHCSQ-1
Received: by mail-ot1-f72.google.com with SMTP id m12-20020a9d400c000000b00594516a42efso3694960ote.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 05:20:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/5fYqDR4K3w+AjAWeSrlvwJLCguQHLmILiYWDQ2tnZs=;
        b=e2sUky2zSkzR07mUP2m2DqAPDZoTyeDTlHbuMPqnaLS3FqcE/zvhG3VHnjIW6JLhlp
         RWloMVwVn8S4Yzpi9YJLOnnwNwRbAk+2z5+dJedi256pibtgviZFkKbjUUkWzPydUorT
         7Dvmi8eczeIosIi1jrpBAdx6bn6nagfqehctjmduqlQpSal1n6zKwPncMXU409E0kTTg
         0gNGAnj6FhKq/SurF5uvpTKNsVW2zdjOzjW5uU6Jy6g8pZVMFwa2AEzGLSnNC7eqZe+a
         UGlBYREEsWpAc9YahhqQTyYwCsjS4lO8GAjsLqGTttWY+PS0j2zDdACYSem/siam63pU
         eerQ==
X-Gm-Message-State: AOAM531UebpqfjQy5SSVdfQcfzK2uWH25fEH/YmWPGs/9n9kJy45jKw0
        D53Hhp2fmxqUTJ72vuYz36OgCcQOMKmZaCJ28WqZix/weTtCZHRZqdOxx6g5QOB+OIlQzwN5BP6
        ocrlTZ/MEjVs8IiPtDMP81FMo
X-Received: by 2002:a05:6830:1356:: with SMTP id r22mr22281283otq.218.1642684829504;
        Thu, 20 Jan 2022 05:20:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJylpr0/TK8P11II/qKaSND0R1Qa2Y5NrHHTE5JhirMOAh9iCauuONNNtnmuNBYj1F0tyCv5+Q==
X-Received: by 2002:a05:6830:1356:: with SMTP id r22mr22281273otq.218.1642684829287;
        Thu, 20 Jan 2022 05:20:29 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id w13sm1610967oik.52.2022.01.20.05.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 05:20:28 -0800 (PST)
From:   trix@redhat.com
To:     terrelln@fb.com
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] lib: zstd: clean up double word in comment.
Date:   Thu, 20 Jan 2022 05:20:06 -0800
Message-Id: <20220120132006.749016-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Remove the second 'a' and 'into'.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 include/linux/zstd_lib.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/zstd_lib.h b/include/linux/zstd_lib.h
index b8c7dbf98390f..6b91758b61af9 100644
--- a/include/linux/zstd_lib.h
+++ b/include/linux/zstd_lib.h
@@ -1330,7 +1330,7 @@ ZSTDLIB_API size_t ZSTD_generateSequences(ZSTD_CCtx* zc, ZSTD_Sequence* outSeqs,
 
 /*! ZSTD_mergeBlockDelimiters() :
  * Given an array of ZSTD_Sequence, remove all sequences that represent block delimiters/last literals
- * by merging them into into the literals of the next sequence.
+ * by merging them into the literals of the next sequence.
  *
  * As such, the final generated result has no explicit representation of block boundaries,
  * and the final last literals segment is not represented in the sequences.
@@ -1377,7 +1377,7 @@ ZSTDLIB_API size_t ZSTD_compressSequences(ZSTD_CCtx* const cctx, void* dst, size
 /*! ZSTD_writeSkippableFrame() :
  * Generates a zstd skippable frame containing data given by src, and writes it to dst buffer.
  *
- * Skippable frames begin with a a 4-byte magic number. There are 16 possible choices of magic number,
+ * Skippable frames begin with a 4-byte magic number. There are 16 possible choices of magic number,
  * ranging from ZSTD_MAGIC_SKIPPABLE_START to ZSTD_MAGIC_SKIPPABLE_START+15.
  * As such, the parameter magicVariant controls the exact skippable frame magic number variant used, so
  * the magic number used will be ZSTD_MAGIC_SKIPPABLE_START + magicVariant.
-- 
2.26.3


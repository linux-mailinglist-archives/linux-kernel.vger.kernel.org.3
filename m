Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FBD5086D2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 13:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377987AbiDTLWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 07:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377976AbiDTLWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 07:22:07 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D9F41323
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:19:22 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id l9-20020a056830268900b006054381dd35so878848otu.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WJG5F1c9fqj/wr2Dm5wuFgifS3sDXKnnxqiizhaJF0U=;
        b=laEs3ezzoHrm2mhqQ4zQL+tuZDbvzdp0DafFdDV7kD5WAw4e3oUFbD1V/b/VPe8Rzi
         FWvn9ufLGFddMcIAzzEJD8OeDlKPPeVCJ41dfzq9PyudWaZ/fIvW4se8Z2xe8FCWWIaN
         PGZCD9Er2l0f9YBfxDXIzPpbCptpOpR7tiTTSjbb5mJab00RzfTDcnI1SEkRqicE/VFC
         aQqOknlPryXvEt9BKWNViURa/uFNFoJBom9tfRuT5IhvBoCAKY0oDjrqNWTeGGDayV17
         L1piqNSwJ+TMUoi0JGxoCUsCOvU1X/vU23KdJRs3kIyQk/R9R56eYutqPM2dj6bd0pMA
         +SvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WJG5F1c9fqj/wr2Dm5wuFgifS3sDXKnnxqiizhaJF0U=;
        b=Hp+OJSmhRKVFNKM5iH4f7939SHs5dILlMxstd9YqAeXM3JYrxt24/pzs69PmLGctFM
         gHISmYOuokLw+f5G1P31ipZ8jXi5PV0B7g3MO4qtwesWpx2xAZLjcKDqx4/cmA2P2ZC0
         EbWRl4JFgH61n3jM0nqmekZsdUkttm8HexW9cBk0U7/P8MJrnLWh5Hc+LFWoN3zGvlMW
         agZN5UE2q2+X0E9EYqurf9ECcW/yzSxN/sDSD6JNxWzspI0vjE4hs1iWa2Pcg6Gu7uQA
         malKwBrEKMknIKEMlly4IRO2Aw0ivUihSu36wtvpYgk7FhlUgXnkAJWc8SztKHgIcIi9
         mhAw==
X-Gm-Message-State: AOAM533mykYitbgF2HqWi8S7q/Mw/7M4FbHJZ4/eDxV2iZ2eQuUWZ0qZ
        ZCQd9LJEogRdXRBFlW06C/jbXTYrWpnQIQ==
X-Google-Smtp-Source: ABdhPJwxuQMY51Jcaz7rr8ou9omcP5is25BMVkmakQYtTMJyJqDYCJiRTght2PD1SomP8c4CVdY+wA==
X-Received: by 2002:a05:6830:616:b0:605:46c5:8356 with SMTP id w22-20020a056830061600b0060546c58356mr6616549oti.81.1650453561509;
        Wed, 20 Apr 2022 04:19:21 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id k22-20020a056870959600b000d277c48d18sm6508551oao.3.2022.04.20.04.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 04:19:21 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 3/3] memblock tests: remove extra column of spaces in block comment
Date:   Wed, 20 Apr 2022 06:19:02 -0500
Message-Id: <663c930475c3c0a32965024c1094d3288629a3af.1650452552.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1650452552.git.remckee0@gmail.com>
References: <cover.1650452552.git.remckee0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove extra space at the beginning of each line in block comment
for consistency and to conform to Linux kernel coding style.

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/tests/basic_api.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
index 834d8705ff8a..05448a25f1f9 100644
--- a/tools/testing/memblock/tests/basic_api.c
+++ b/tools/testing/memblock/tests/basic_api.c
@@ -303,12 +303,12 @@ static int memblock_add_checks(void)
 	return 0;
 }
 
- /*
-  * A simple test that marks a memory block of a specified base address
-  * and size as reserved and to the collection of reserved memory regions
-  * (memblock.reserved). Expect to create a new entry. The region counter
-  * and total memory size are updated.
-  */
+/*
+ * A simple test that marks a memory block of a specified base address
+ * and size as reserved and to the collection of reserved memory regions
+ * (memblock.reserved). Expect to create a new entry. The region counter
+ * and total memory size are updated.
+ */
 static int memblock_reserve_simple_check(void)
 {
 	struct memblock_region *rgn;
-- 
2.32.0


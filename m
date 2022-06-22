Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6845A5548D3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357151AbiFVJMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357276AbiFVJLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:11:53 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEE12E9DB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:10:07 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id k24so20378293oij.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hDwC4vjOEjWZbqEneYaa93PfkH0X3bD2FesquY/4DR0=;
        b=ddZYRh2uAovuksEfFl7wy9zFfuql6B07z7ikh2xe2UtbGuFc/XNawArqOsKDkIZbyj
         UvZ0wnXkQou25YTsm/Ir/kIwdu94Rxds8xg/GVjZ83+6OUjOhvteX2gV90AG/Ow6DM8U
         4j5dDlsbBshgGX5koklMr7Jy+CTkY/1dtPoq6wPwHfNdn6QYLLRwXm20jY0ELh4hKW2m
         Oy/moDJIsMjrZoP5JIKqOfS5gKpI7JN+wlYV/kOSfavmoe9H86AOvIzHMU4frOH1FdD6
         SfVdjI3TLdI+MhiB8wVcfMshu2q0ci/icMKYnsrOw/usVV/THitbrw3iCZAdviux55fc
         MpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hDwC4vjOEjWZbqEneYaa93PfkH0X3bD2FesquY/4DR0=;
        b=pEf9H/vUctdyOFDEyHtTRkFN9rSHmRagDx2ZHcwIbt+SCw4HyDahUX5v+SX9UBxQ9f
         SPNNRKYGhxwY+dVcAGe0KryKor1pJbcqB6A84kP9IW1QifQzF9eGP0ll+sSQjLFICbG7
         y1g+3KCeBvroj7mVd2bM7jdZNaS5MWWRBUDzMq2o4iAxfn9NICBu+isFXhAxg6S8zh0O
         3itTnWULzh5MUf0A4Su8JqRrLJnLpU3wVKXDPnh0m/MnuX6EuYSmL4wL3jhqIfD0FjtK
         wzwdinYmBLD9Zx6dVbGpSu8Svlmj4Hrm1FEC0beIiQ9Do7sKkqYHDqLP47HTPVhpYXhR
         vI9Q==
X-Gm-Message-State: AJIora9W/o/S2PrwXeflgNbV0eHEAIRLvr8sR/5/MqRXsw26pJxBeC7r
        OvudCvAi8iaRCEZESGmJaTU=
X-Google-Smtp-Source: AGRyM1t2DR76KMK8Vkhp+YPhAZzxBiKAqnhljXSOyhF9iE+TI/WtTQFkNO7kwRRYXe15zOViiKptrg==
X-Received: by 2002:a05:6808:1145:b0:333:28e0:ea2a with SMTP id u5-20020a056808114500b0033328e0ea2amr9674413oiu.184.1655889007096;
        Wed, 22 Jun 2022 02:10:07 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id q13-20020a056870e60d00b001048b819e13sm2185207oag.8.2022.06.22.02.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 02:10:06 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v2 4/4] memblock tests: remove completed TODO items
Date:   Wed, 22 Jun 2022 04:09:46 -0500
Message-Id: <2d360d0a1f824e67c9209f631c62fdd65f5a5c70.1655887571.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1655887571.git.remckee0@gmail.com>
References: <cover.1655887571.git.remckee0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove completed items from TODO list.

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/TODO | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/tools/testing/memblock/TODO b/tools/testing/memblock/TODO
index cd1a30d5acc9..33044c634ea7 100644
--- a/tools/testing/memblock/TODO
+++ b/tools/testing/memblock/TODO
@@ -1,25 +1,17 @@
 TODO
 =====
 
-1. Add verbose output (e.g., what is being tested and how many tests cases are
-   passing)
-
-2. Add flags to Makefile:
-   + verbosity level
-   + enable memblock_dbg() messages (i.e. pass "-D CONFIG_DEBUG_MEMORY_INIT"
-     flag)
-
-3. Add tests trying to memblock_add() or memblock_reserve() 129th region.
+1. Add tests trying to memblock_add() or memblock_reserve() 129th region.
    This will trigger memblock_double_array(), make sure it succeeds.
    *Important:* These tests require valid memory ranges, use dummy physical
                 memory block from common.c to implement them. It is also very
                 likely that the current MEM_SIZE won't be enough for these
                 test cases. Use realloc to adjust the size accordingly.
 
-4. Add test cases using this functions (implement them for both directions):
+2. Add test cases using this functions (implement them for both directions):
    + memblock_alloc_raw()
    + memblock_alloc_exact_nid_raw()
    + memblock_alloc_try_nid_raw()
 
-5. Add tests for memblock_alloc_node() to check if the correct NUMA node is set
+3. Add tests for memblock_alloc_node() to check if the correct NUMA node is set
    for the new region
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBDB5542A4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 08:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345555AbiFVGUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbiFVGUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:20:18 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BECDE1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 23:20:17 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id v143so19909371oie.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 23:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hDwC4vjOEjWZbqEneYaa93PfkH0X3bD2FesquY/4DR0=;
        b=V2/CV8aKDk9sr8ejKluPY9R1KLGH8onIXqGVqKEYXKo8eXEhzMgn45JJsR8E5lE/4w
         VxuUbDpexiHGCLt629SMyNOH4Eu7tFAMpxw6M1qu4Z5iopUIWjknCCdhBE6BOfZcLXza
         8Vb4v23S1u6kfbnEbJcNiuSzF0OYQ4QKScr9GrsIFx9ouubyA7Q1nrRkWTNEMdomvZ7v
         qg/TEuEnlu+VAptdyA7VIZdp8YdvaJSll9AxKym0OiX0v+IRydKOOF9ixycdVH1rH6SJ
         LqCT5qCa4OLe8i67w+KSx00Op3Nxqa9F4fGlRgUiEZXCOCSCpgnxqArhCV1jA7OQgRPn
         kICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hDwC4vjOEjWZbqEneYaa93PfkH0X3bD2FesquY/4DR0=;
        b=zGMJcgCPalBldNGsGIyY0L7W/s6gQL9qNOVlSTVokMhj50pb14offuv2CFv3S94gWC
         L6hdXZlWhOaliSCbZSub2dZOzdX2dj/JUu3zy6na6xb2Wx1s4kR0Q7Su1jBfvO+zg/eW
         VTqeUYByIRFiHjpjq+spYOpDk5y6I6woVUxf0djPeT1G8Z8iZI89UF3i8RArBwpNDhqL
         6a/jR+RNrmDIMH0evGzz/HWYuQMrfTwGOfFRkpUNTk3fzeWQcXIA+PpD3OGSxr9PlkMY
         nroJAO7FY4uz6AcLvhNdqNqsrwjLUlGsFL4AQVFwM+dcBvVIScnzZMEPsTRy+CUJc2ww
         2M6A==
X-Gm-Message-State: AJIora/mB7NuS0znu47nWkpA5mrWWW3BFJTzmweZEotCpmyL5AGXb8s0
        qHUh2Xb5Yd9d2EYjea3+y+I=
X-Google-Smtp-Source: AGRyM1u/D80v3UnLdx+c+4cEviLDziy0ZfA5UJETq0k0P3+88F1/bSFwpaEC1bH6BaLqjaAvvj5IqA==
X-Received: by 2002:a05:6808:1801:b0:330:4385:81c5 with SMTP id bh1-20020a056808180100b00330438581c5mr991506oib.151.1655878816822;
        Tue, 21 Jun 2022 23:20:16 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id g9-20020a4ab809000000b004255ed1b6d9sm579398oop.27.2022.06.21.23.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 23:20:16 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 4/4] memblock tests: remove completed TODO items
Date:   Wed, 22 Jun 2022 01:19:32 -0500
Message-Id: <4a8915ef399c5778d31eab9466d2373b43b3e61a.1655878337.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1655878337.git.remckee0@gmail.com>
References: <cover.1655878337.git.remckee0@gmail.com>
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


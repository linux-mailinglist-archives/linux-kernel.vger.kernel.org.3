Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C464591E85
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 07:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiHNFu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 01:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiHNFug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 01:50:36 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C745CD9
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 22:50:35 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id 10so352775iou.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 22:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=bHF1qU1K8oPySqGK4H4mpwBhgWlt+EC9cbyhAsQNyOY=;
        b=G9MtmCAuXjNNS6MswrmaN6NLEE2Vb36ZEX/bzNlZw2/vYBnhHQUbkP9bFftur1VbCM
         YCywk1mja22zKZ0mOCJreTLaD1J2hVgojIjFPAlgSpmC5C696cwx2VuOIENmfhOO5Fu1
         APEavwAGj9BRkau8Hy66X/juTsLtIsb7U//5mr1LaVq102gkiOK90RsKR2DvkwBFoTkm
         dvM5Y5S/JU0JSRlroYVrRZ1tWQyoxj+BN8cKztclwX5SJO2kkkY/xLw9x7bL60hESIbp
         gxpwKXLxo1G/IkqnBHtQldEYQ3gzA9U5zAkE7cKRm7PT4mtpIogfmvTqO/pM94YstjeY
         RxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=bHF1qU1K8oPySqGK4H4mpwBhgWlt+EC9cbyhAsQNyOY=;
        b=p0uBjDYdr4VVv3wVMMjz1xCS+snlZMRx6AvV67d3xELUTYoNQ9OaWeHeRaRwf8pvYA
         2T5+1HvZsf3Mypl0tsBmqxj8jwM+pTdCOw7jTV2BHReFkOwJWyBnNVt3ijA+hJ4nU2JV
         mCevGCk1dus/WVVq8NEeGPdu96AvwV2SMWR7zqGRppYstRBMbhTrQnpPQMYvnSX8kU0N
         SzJOAMode8A8uFciWyuswZK9TNUif/0nUZUmMiy6Fj8cQLfbjwGdYCoeGrPFdKji2BNH
         4nt5ai7+9CUsicjlT4IP2gHinDByaRIGaWARdaO1sxu5+eOFA+/Ba6EXwPwY8qBswhMl
         tm6g==
X-Gm-Message-State: ACgBeo06KrvRBKVYPP8LGj4wV42OhVnKn9ouqgAD5a5g1XItqk9+V/ec
        DJD770rgubFTD+eRjtnTi2k=
X-Google-Smtp-Source: AA6agR4eXL4rEp1/3eEHMKt2idV9HRsHO3kC+tRBt2WdlRRdUGSCw/RcqdNxM1yZOOe6UaeOGd1/aw==
X-Received: by 2002:a6b:c343:0:b0:67c:6033:a682 with SMTP id t64-20020a6bc343000000b0067c6033a682mr4380707iof.148.1660456234435;
        Sat, 13 Aug 2022 22:50:34 -0700 (PDT)
Received: from sophie (static-198-54-128-70.cust.tzulo.com. [198.54.128.70])
        by smtp.gmail.com with ESMTPSA id y16-20020a92c990000000b002e31bb49f6esm2615862iln.81.2022.08.13.22.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 22:50:34 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 2/2] memblock tests: update reference to obsolete build option in comments
Date:   Sun, 14 Aug 2022 00:50:20 -0500
Message-Id: <5f8a4c2bde34cc029282c68d47eda982d950f421.1660451025.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660451025.git.remckee0@gmail.com>
References: <cover.1660451025.git.remckee0@gmail.com>
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

The VERBOSE build option was replaced with the --verbose runtime option,
but the comments describing the ASSERT_*() macros still refer to the
VERBOSE build option. Update these comments so that they refer to the
--verbose runtime option.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/tests/common.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
index 3e7f23d341d7..d396e5423a8e 100644
--- a/tools/testing/memblock/tests/common.h
+++ b/tools/testing/memblock/tests/common.h
@@ -16,7 +16,8 @@
  * ASSERT_EQ():
  * Check the condition
  * @_expected == @_seen
- * If false, print failed test message (if in VERBOSE mode) and then assert
+ * If false, print failed test message (if running with --verbose) and then
+ * assert.
  */
 #define ASSERT_EQ(_expected, _seen) do { \
 	if ((_expected) != (_seen)) \
@@ -28,7 +29,8 @@
  * ASSERT_NE():
  * Check the condition
  * @_expected != @_seen
- * If false, print failed test message (if in VERBOSE mode) and then assert
+ * If false, print failed test message (if running with --verbose) and then
+ * assert.
  */
 #define ASSERT_NE(_expected, _seen) do { \
 	if ((_expected) == (_seen)) \
@@ -40,7 +42,8 @@
  * ASSERT_LT():
  * Check the condition
  * @_expected < @_seen
- * If false, print failed test message (if in VERBOSE mode) and then assert
+ * If false, print failed test message (if running with --verbose) and then
+ * assert.
  */
 #define ASSERT_LT(_expected, _seen) do { \
 	if ((_expected) >= (_seen)) \
-- 
2.25.1


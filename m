Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F924E7F2E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 06:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiCZFrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 01:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiCZFrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 01:47:06 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69391D59CC
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 22:45:26 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j6-20020a25ec06000000b00633c6f3e072so7613636ybh.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 22:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=qN7PPyAD3cWtp7y6x5pkKRSnvoKWxjZvZ2QYdbya07E=;
        b=TBCh0di89ZfALXGMXBpUVGg0fAv8Gy28zwNUD40Z/FornCimph1nfwEBUOwacbauv+
         kx61OsjhyZ/p36DoE4AsfEitgcSnqkEr4kA6VTJzesYYVlKlKXYuctOdJ8e8b9TeVqmW
         RVCPRQ7vXbD8+sZzSkpBlA+4Nly/MjAcR24AsaQnRTTrmvkCh8/FAw/uM+43us8h8W8A
         hICFKPfG7+ZkMPHnLBEFfpwGDu4/ka47padYJsCH95Mdt6gnrZNXVY2OEL7mNqOIy7mL
         QaUd+uJJhJ8NfG01kqd9r6qQqpZUNhcDfWyC011g59bKk/pJ3ErgSlvquP3Ri4nIdfUK
         07tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=qN7PPyAD3cWtp7y6x5pkKRSnvoKWxjZvZ2QYdbya07E=;
        b=pYW29zitbCPR38nnEyoabBFdSIZo4Xk6uwTGFlRloUt25Qg0oWiR6xRn6A4zuxpd/I
         6d5cvgzuQlx5buey/M5bGb5/RV54CP/Z2J1/NfHY7WRElJ2hyEV3bY3EJEoo0ANhh2Hr
         FYiE2gqtOPp6K1J9ML8On1q4HQzXxYoRA0NHdzih8BrUmzN2njiGhvohhbEx5f5OPamc
         rAZi+oD8qd3fcpisTTgRMt5i8GAjeHqfJV+hEDstbW/ASimWP7jTtmf9YReYoFRG04gj
         xfexl53IsEjIMP0rQWWwG6A1k9vYcYXbZ6ggXGV4CFag8otCu45gpfY493cQxX06mDgD
         fkOA==
X-Gm-Message-State: AOAM530Uj0fukN3n8icumOkwXPQqa/QpuJpf+47MEmrcbtOjMD/T66pf
        3USoYeUMGfBMUrf6/Q+OhhqFrHdUPNBLaw==
X-Google-Smtp-Source: ABdhPJytqTjPcEOZKK8Jgisj6nVlpurdGAlE5lcmf6T7OizSCc+ZaskC6et3Ca5PiLgrITBG5Yeui84nb2VLbg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a81:3756:0:b0:2e3:3db4:7de1 with SMTP id
 e83-20020a813756000000b002e33db47de1mr15199705ywa.458.1648273525753; Fri, 25
 Mar 2022 22:45:25 -0700 (PDT)
Date:   Sat, 26 Mar 2022 13:44:15 +0800
Message-Id: <20220326054414.637293-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH] Documentation: kunit: Fix cross-referencing warnings
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     David Gow <davidgow@google.com>, Marco Elver <elver@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Architecture chapter of the KUnit documentation tried to include
copies of the kernel-doc for a couple of things, despite these already
existing in the API documentation. This lead to some warnings:

architecture:31: ./include/kunit/test.h:3: WARNING: Duplicate C declaration, also defined at dev-tools/kunit/api/test:66.
Declaration is '.. c:struct:: kunit_case'.
architecture:163: ./include/kunit/test.h:1217: WARNING: Duplicate C declaration, also defined at dev-tools/kunit/api/test:1217.
Declaration is '.. c:macro:: KUNIT_ARRAY_PARAM'.
architecture.rst:3: WARNING: Duplicate C declaration, also defined at dev-tools/kunit/api/test:66.
Declaration is '.. c:struct:: kunit_case'.
architecture.rst:1217: WARNING: Duplicate C declaration, also defined at dev-tools/kunit/api/test:1217.
Declaration is '.. c:macro:: KUNIT_ARRAY_PARAM'.

Get rid of these, and cleanup the mentions of the struct and macro in
question so that sphinx generates a link to the existing copy of the
documentation in the api/test document.

Fixes: bc145b370c ("Documentation: KUnit: Added KUnit Architecture")
Signed-off-by: David Gow <davidgow@google.com>
---
 Documentation/dev-tools/kunit/architecture.rst | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/Documentation/dev-tools/kunit/architecture.rst b/Documentation/dev-tools/kunit/architecture.rst
index aa2cea821e25..ff9c85a0bff2 100644
--- a/Documentation/dev-tools/kunit/architecture.rst
+++ b/Documentation/dev-tools/kunit/architecture.rst
@@ -26,10 +26,7 @@ The fundamental unit in KUnit is the test case. The KUnit test cases are
 grouped into KUnit suites. A KUnit test case is a function with type
 signature ``void (*)(struct kunit *test)``.
 These test case functions are wrapped in a struct called
-``struct kunit_case``. For code, see:
-
-.. kernel-doc:: include/kunit/test.h
-	:identifiers: kunit_case
+struct kunit_case.
 
 .. note:
 	``generate_params`` is optional for non-parameterized tests.
@@ -152,18 +149,12 @@ Parameterized Tests
 Each KUnit parameterized test is associated with a collection of
 parameters. The test is invoked multiple times, once for each parameter
 value and the parameter is stored in the ``param_value`` field.
-The test case includes a ``KUNIT_CASE_PARAM()`` macro that accepts a
+The test case includes a KUNIT_CASE_PARAM() macro that accepts a
 generator function.
 The generator function is passed the previous parameter and returns the next
 parameter. It also provides a macro to generate common-case generators based on
 arrays.
 
-For code, see:
-
-.. kernel-doc:: include/kunit/test.h
-	:identifiers: KUNIT_ARRAY_PARAM
-
-
 kunit_tool (Command Line Test Harness)
 ======================================
 
-- 
2.35.1.1021.g381101b075-goog


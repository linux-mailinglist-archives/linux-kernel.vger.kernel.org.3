Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93C9563E9D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 07:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbiGBFMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 01:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGBFML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 01:12:11 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132DA2A71B
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 22:12:11 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id i5-20020a170902c94500b0016a644a6008so2415297pla.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 22:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=FXDOVHKKv/Ct7G63am591KJ/jKCBJOElGG/6AF1hRUk=;
        b=eU5E1IkJFySb7qvJXe/F66qE6Yptt3fhfs21I6wv55+iaHhTIjXIwgoz35qqySdolW
         y2JuQQMS1QMZ6H4g3x94gKz2R7DvMKcQRga6Ap2PlI3cDtZs5QjYakUuggtCzrDckmsG
         q/Cmi+3F6Tmk7gLL2p3IuXtf5FfgRXGIHg3RpL/0WdA2sapBrl2g1Rr/7PZ2gV7sz7lm
         T7higJi3LrLZASEkQF7rJNgXBlSkFlO554ljvCm4yfwPx4jjEtmR8u5pW18X4pt+6uVk
         KqEaeW46hHRCQwPVDSbSp3Ux02E5LQq3KOLaCL+i8JSlyeYYA8oUcb3eNYBiJT2N8gN4
         /gcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=FXDOVHKKv/Ct7G63am591KJ/jKCBJOElGG/6AF1hRUk=;
        b=N2GouUFPMMrnjsNoTF4lELiGkB0U8Zi5Bh645GPkJSjMsOWkt42a8tGvfctHNb5oFM
         bDZXU6VpxMRsQmq+jan2robpXzETbbrbdMWfJgV7jq/1J0xoaY0dkEY0h31fo20RPQMu
         CfU3jTF7rOGFIaofvtjo4YYKmnuXgmbbvGt2NnCbItiaGax3HYh0tnOJvcqNI3UTd4q8
         97Daw9IWZr2GCtree9T1jSld5eiRxaU/kk4/jZJtKf+/q3GzUSUIzMPDPGrg0X6SUbDR
         T5VkSu0cGLHwLg+wWRgv3oGUUnNBDcVWYArppAIAzTeKJ4+C6He54GgzlmExLOoDHFdW
         EdYg==
X-Gm-Message-State: AJIora/dkycjELUAfNyQXr8+R9qCslJNc2ufSyILB42EWsrZK8cqMe22
        mFcc5fnsTOTj/5QyQlQGA2aQUr/MfMwAQA==
X-Google-Smtp-Source: AGRyM1uwlYtREUfsnXJSILU7FARqbS45lJAy3QlG+aJqOmgN42PdfzGJN/rFRYnT1YjzbPR+yfoME+fR+4z97Q==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:903:1c4:b0:16a:73fd:3c6c with SMTP id
 e4-20020a17090301c400b0016a73fd3c6cmr23401813plh.115.1656738730290; Fri, 01
 Jul 2022 22:12:10 -0700 (PDT)
Date:   Sat,  2 Jul 2022 13:12:05 +0800
Message-Id: <20220702051205.3292468-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH] kunit: Documentation: Fix a kernel-doc reference
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Martin Fernandez <martin.fernandez@eclypsium.com>,
        Kees Cook <keescook@chromium.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

When building the KUnit documentation, the reference to
kunit_test_suites in the kunit_test_init_section_suites kernel-doc
comment gives an error:
Documentation/dev-tools/kunit/api/test:9: ./include/kunit/test.h:323: WARNING: Inline interpreted text or phrase reference start-string without end-string.

This is because the reference is mixing two function reference styles:
adding an '&' to the front, and "()" to the end. The latter is neater,
so get rid of the '&'.

Fixes: 9bf2eed995f9 ("kunit: add support for kunit_suites that reference init code")
Signed-off-by: David Gow <davidgow@google.com>
---

(As a KUnit patch, we'll accept this via the KUnit tree.)

---
 include/kunit/test.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 8ffcd7de9607..f1c1a95df9b8 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -320,7 +320,7 @@ static inline int kunit_run_all_tests(void)
  *
  * @__suites: a statically allocated list of &struct kunit_suite.
  *
- * This functions identically as &kunit_test_suites() except that it suppresses
+ * This functions identically as kunit_test_suites() except that it suppresses
  * modpost warnings for referencing functions marked __init or data marked
  * __initdata; this is OK because currently KUnit only runs tests upon boot
  * during the init phase or upon loading a module during the init phase.
-- 
2.37.0.rc0.161.g10f37bed90-goog


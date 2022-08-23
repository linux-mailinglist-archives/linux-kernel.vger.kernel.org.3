Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4053659EF6A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 00:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbiHWWsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 18:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiHWWsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 18:48:20 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A202F8B2E1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 15:48:16 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id a21-20020a62bd15000000b005360da6b25aso5249218pff.23
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 15:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=YHBqbQM3NMY0cCrSntfkljesc8TAC/U4AG8R+VgzY3A=;
        b=O6VMZWlXVxl9lfPpxPjKWilGV07sUHi4GKZV0gZX1Gi2ZF7dN+73ZJ/PK0Sa1jwLCk
         tWszWgO9rxX+fbVFHqYkehQqb2wrkVqGRUty1VpJFrJ1VttT3vVIWTh8cWd2TMVD4pVi
         ZZ3V0qE4frtaEiKuUAymKgGXB3tpSxUqf7oeCG3oy+9iq1VH2RWR1y+IOD1n7hOsbeTb
         UKbmIX5Feo7H7ML7Wkk8jFv3IyTcmmR3TeTlTlycH3AE1ZYIi2L+aJj2b74i96zn0VUn
         qfk1zDrcVxMUDFm3hbvH/6ZJJR1XzhvTzG7x7uVCM0r/mSn/m11MqrlXpCdVdBPgHEhv
         Hu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=YHBqbQM3NMY0cCrSntfkljesc8TAC/U4AG8R+VgzY3A=;
        b=lUo8ce0gbUf8Or2HoqZyfvo+MqiLMOXtgxGZqCkPiuEbutM1lavhnJzUhXqZxqzev9
         c4u9PELurioFH4QpECivoBA+nc1UkNjXrI++M/LrkL01GP5ttyagCNL1Lizo0VhvsiL3
         s9Kcpf7T8Z1XKV7lb5nkqnwxD8iJRUUG/H82aTX4ZDigSa7jsx9THI7A+jXWM5lfF7bE
         Y1+YsTN+bbvFCt4JnO+1YMsgIKk1epN3dlfIar85aSufsVpp3PrvhJjFbd8SGQ7HxHI0
         ckCD7Q4V+8Xlf0Ge1yIvc3H4OnaBIRKfo+druYYNgMywuDwT0vVqSWC9XcLaMC5Bd54D
         it4Q==
X-Gm-Message-State: ACgBeo3LnDFkHC4Ct0mYaJUdjPNa1RwG89Tn8Sez4c+6e0jw2M+Q3smR
        m4MVlJgLYi+vFkz9Jlm9pnaUAobkkw==
X-Google-Smtp-Source: AA6agR4/Tw3x1nc5MgOSIj9wYmOp31p/sL5WQ6wQTxMTGs1JLO43iiGd6CU2gmPX6d61M3Y0Ckx07mWGfQ==
X-Received: from adelg-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:d1f])
 (user=adelg job=sendgmr) by 2002:a05:6a00:10c2:b0:4f7:5af4:47b6 with SMTP id
 d2-20020a056a0010c200b004f75af447b6mr22564043pfu.6.1661294895970; Tue, 23 Aug
 2022 15:48:15 -0700 (PDT)
Date:   Tue, 23 Aug 2022 22:48:11 +0000
Message-Id: <20220823224811.12758-1-adelg@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH] selftests: remove unused variable in close_range test
From:   Andrew Delgadilo <adelg@google.com>
To:     Shuah Khan <shuah@kernel.org>, Andrew Delgadillo <adelg@google.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Delgadillo <adelg@google.com>

commit 2c5db60e46ad ("tests: add close_range() tests") adds the
close_range test under the core namespace. In its current form, the
close_range test has an unused variable, namely, ret. For those building
with -Werror,-Wall, this breaks the build.

Without this patch:
$ make -C tools/testing/selftests/ TARGETS=core V=1 CFLAGS="-Werror -Wall"
> make: Entering directory '/.../kernel-src/tools/testing/selftests'
> make[1]: Entering directory '/.../kernel-src/tools/testing/selftests/core'
> gcc -Werror -Wall    close_range_test.c  -o /.../kernel-src/tools/testing/selftests/core/close_range_test
> close_range_test.c: In function 'core_close_range':
> close_range_test.c:55:16: error: unused variable 'ret' [-Werror=unused-variable]
>   55 |         int i, ret;
>      |                ^~~
> cc1: all warnings being treated as errors
> make[1]: *** [../lib.mk:135: /.../kernel-src/tools/testing/selftests/core/close_range_test] Error 1
> make[1]: Leaving directory '/.../kernel-src/tools/testing/selftests/core'
> make: *** [Makefile:155: all] Error 2
> make: Leaving directory '/.../kernel-src/tools/testing/selftests'

With this patch:
$ make -C tools/testing/selftests/ TARGETS=core V=1 CFLAGS="-Werror -Wall"
> make: Entering directory '/.../kernel-src/tools/testing/selftests'
> make[1]: Entering directory '/.../kernel-src/tools/testing/selftests/core'
> gcc -Werror -Wall    close_range_test.c  -o /.../kernel-src/tools/testing/selftests/core/close_range_test
> make[1]: Leaving directory '/.../kernel-src/tools/testing/selftests/core'
> make: Leaving directory '/.../kernel-src/tools/testing/selftests'

Fixes: 2c5db60e46ad ("tests: add close_range() tests")
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Delgadillo <adelg@google.com>
---
 tools/testing/selftests/core/close_range_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
index 749239930ca83..17c76c6c13cb9 100644
--- a/tools/testing/selftests/core/close_range_test.c
+++ b/tools/testing/selftests/core/close_range_test.c
@@ -52,7 +52,7 @@ static inline int sys_close_range(unsigned int fd, unsigned int max_fd,
 
 TEST(core_close_range)
 {
-	int i, ret;
+	int i;
 	int open_fds[101];
 
 	for (i = 0; i < ARRAY_SIZE(open_fds); i++) {
-- 
2.37.1.595.g718a3a8f04-goog


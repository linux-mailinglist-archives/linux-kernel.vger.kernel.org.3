Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4442F4DA980
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 06:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353579AbiCPFKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 01:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiCPFKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 01:10:01 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6729FD7;
        Tue, 15 Mar 2022 22:08:48 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id qa43so1750702ejc.12;
        Tue, 15 Mar 2022 22:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=TYMzVJwHrkXu2HIyh0HGbyp3jpaDgUy5zW81BF3Qd30=;
        b=FQOB+XjHJHMj4Oo+Pt8qytWOzHWGk1cOeQ/T5Jly+Zw+ZDYo+uS1z7omOSphWdX3He
         H4oxBbNOFQrOsfjouOoitynIT1zACmHKxKkBZ0YWs4F74SD6p/EMO4Iu9+cMU1Y5fjoE
         ClHKZX0jj+TQwOjwPTidWcEk8D98JWO6BVMIQTlzBqF47I6bTudxIfudnNOEEd8K3etw
         ejto33Whlrrirn+W79+x6nEnGsrbft2u+OW5i5c+HQmlmky7iPu1ZKjIpNlrrepBohpp
         cCYdvto7rpTfjKDz8CymbVEdzCHdBYG/abbAMYYjFcUxZfpIxMZm24nAmrokUBbw3p8+
         HMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TYMzVJwHrkXu2HIyh0HGbyp3jpaDgUy5zW81BF3Qd30=;
        b=2OoziRUWBFLcP8xwkS79ljGOJPIf7rRkPNEmmnFY9EMMEf8EsR1269nOCCoG+a7UbR
         +VXsST8DmAHJhvC72/FoWZGJ+wdDqvqm2Q52jX1+gwEuP/D5v6KjkXQie3i5jv9gkOhg
         XR0z9R/rLTx7UA55wYl4j09Y7bzit4PKJKZUUlbgKptrmwttnUrz0tBwua9qKBtuglbP
         8+5V2ydcBJKB3JK7lDlmlfKUvMdF6VFjm7xYSOtkH8urpq5k1uzxXzKC1NFeJdQo8DeC
         JKzUKWIcUcrodpGhVj+d6h4fAkXyDcIgjjaDlZCI6cf7r6onm+jrSyrwQnejVw83lbY2
         kB3Q==
X-Gm-Message-State: AOAM5314w445B/vWAjJoLc4Es3sDiQc5ISyQxJbPQoId8AgnJcmIzUXq
        brAUx6Bw45G1u0AhboiQwkc=
X-Google-Smtp-Source: ABdhPJzkOdUjwmOskoUASUCvBP2RXwbF06L1RFocyA7nRnmnKRkwBcY0MMbYCBOz9ePQJrBmBvF1/A==
X-Received: by 2002:a17:906:5804:b0:6ce:3f17:bf35 with SMTP id m4-20020a170906580400b006ce3f17bf35mr25106475ejq.346.1647407326404;
        Tue, 15 Mar 2022 22:08:46 -0700 (PDT)
Received: from felia.fritz.box (200116b826783100351493f9f729970f.dip.versatel-1u1.de. [2001:16b8:2678:3100:3514:93f9:f729:970f])
        by smtp.gmail.com with ESMTPSA id dd6-20020a1709069b8600b006dbb5266bb3sm414339ejc.1.2022.03.15.22.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 22:08:46 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Borislav Petkov <bp@alien8.de>, x86@kernel.org
Cc:     linux-mm@kvack.org, Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: drop entry to removed file in EXEC & BINFMT API
Date:   Wed, 16 Mar 2022 06:08:28 +0100
Message-Id: <20220316050828.17255-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f9444ea5e208 ("x86: Remove a.out support") removes
arch/x86/ia32/ia32_aout.c, but misses a reference to that file in
MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Drop the file entry to the removed file in EXEC & BINFMT API.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Borislav, please pick this minor clean-up patch on your -next tree on top
of the commit above.

 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f5d5fb7cdde..faa5e53db1dd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7365,7 +7365,6 @@ L:	linux-mm@kvack.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/execve
 F:	arch/alpha/kernel/binfmt_loader.c
-F:	arch/x86/ia32/ia32_aout.c
 F:	fs/*binfmt_*.c
 F:	fs/exec.c
 F:	include/linux/binfmts.h
-- 
2.17.1


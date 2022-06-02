Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9AD53B226
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 05:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiFBDlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 23:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiFBDlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 23:41:17 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B874910EA62
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 20:41:15 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-30cb80ee75cso32414317b3.15
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 20:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=0TP45ri2Rm0IThufZmYq3gqP6Oy9O8gtuE5Zzf1fHAI=;
        b=og8WzEFivR8Aec/KX7BrbGLQQPelHY3Yy/jjiXxB2vK6lARri6hHWfheQdsdX6Hy6+
         UHkebTYJ0qp18z95eOavjJWjeFd9wrgOTICLUx08bZLN4T+Nw7DayipbRPSPqLonsZIy
         LfyKCq5QkurwvGpFQ68jTCsxSbKHJ83VfcI4cTYeO/IDIro7YAbm7oWThRUJVI6Ol91e
         Nil3SjjT2fa8WsD30Yhyv+1YPMmAwgbv/biePE5kQRa9arJJz4TR+O6IOXN5ZCXK1+CV
         MfeQ8Pb9IO+WR1iAhApAHbXrerk5zm5EWLFIH5vePQiROln4wZmFC3sq7pndZ7dxbjof
         lt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=0TP45ri2Rm0IThufZmYq3gqP6Oy9O8gtuE5Zzf1fHAI=;
        b=bjOcSN5UgZ5j0n80JCri9DAEDSFLe54kyRHHrmfAWL866UdXlLbk5jPPrIwaZsnS+C
         Y3JBqixpgaTwGTUIitPd/9sUyEz2swmkUfQRZryXjp2Vtz+SISJbkrVr73l/3V77HJT/
         cg0Mc9KGHx7LqGaqL1W3EJs+WsNhhzDF8wOnpoZADVMxFGg9nXKDF4EIZ1tGxDlz6OM5
         VC5U3FZiXn3nN7eCy4HPw9UwwGkPVos95c55a4J0yoEfXOKGuW+CcoQJMLG1Xn03HLIm
         3feXq/854FyvEeqYYHZo9qEFLf+Q5d2A7anRYbM60HLjarv7nilyPnti3nSQmRbjztxW
         CFvQ==
X-Gm-Message-State: AOAM532kdYrpOLhAmHvVCBl4Usj67Wt1RU+3CyxZSibPqT92DYkqnsSa
        n4e9am/4tzRjZruH47JRQttx3DnF2GbVyS4=
X-Google-Smtp-Source: ABdhPJyMQ1uPP0a6d0b+oQI3447LUskffZDUTKA0VTs1kzreaAXTeiomm5PVbRJ1j6J5zQ+3c6k/pZutNDYYZO0=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:f3aa:cafe:c20a:e136])
 (user=saravanak job=sendgmr) by 2002:a81:5512:0:b0:30c:398d:61d4 with SMTP id
 j18-20020a815512000000b0030c398d61d4mr3350296ywb.58.1654141274869; Wed, 01
 Jun 2022 20:41:14 -0700 (PDT)
Date:   Wed,  1 Jun 2022 20:41:11 -0700
In-Reply-To: <20220322140344.556474-2-atomlin@redhat.com>
Message-Id: <20220602034111.4163292-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: Re: [PATCH v12 01/14] module: Move all into module/
From:   Saravana Kannan <saravanak@google.com>
To:     Aaron Tomlin <atomlin@redhat.com>, mcgrof@kernel.org,
        christophe.leroy@csgroup.eu
Cc:     cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com,
        daniel.thompson@linaro.org, hch@infradead.org,
        kernel-team@android.com
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

Aaron Tomlin <atomlin@redhat.com> wrote:
> No functional changes.

I could be mistaken, but I think this has a functional change and could
break module signature enforcement in some cases.

> 
> This patch moves all module related code into a separate directory,
> modifies each file name and creates a new Makefile. Note: this effort
> is in preparation to refactor core module code.
> 
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> ---
>  MAINTAINERS                                         |  2 +-
>  kernel/Makefile                                     |  5 +----
>  kernel/module/Makefile                              | 12 ++++++++++++
>  kernel/{module_decompress.c => module/decompress.c} |  2 +-
>  kernel/{module-internal.h => module/internal.h}     |  0
>  kernel/{module.c => module/main.c}                  |  2 +-
>  kernel/{module_signing.c => module/signing.c}       |  2 +-

I spent at least an hour trying to figure out how the code below in
module/signing.c (was moved from module/main.c in a later patch in this
series) managed to have a "module" prefix for "module.sig_enforce" kernel
cmdline param and for the /sys/module/module/parameters/sig_enforce file.

static bool sig_enforce = IS_ENABLED(CONFIG_MODULE_SIG_FORCE);
module_param(sig_enforce, bool_enable_only, 0644);

I thought I was missing something until I realized this was a very recent
change and might actually be a bug. If I'm not mistaken, the prefix will
now become "signing". So the kernel cmdline param would get ignore and any
userspace writes to /sys/module/module/parameters/sig_enforce will start
failing.

I don't have a device to boot 5.19-rcX in, but I think I'm right. Can
someone confirm?

If my code analysis is right, then the fix seems to be adding this code
before the module_param() line.

diff --git a/kernel/module/signing.c b/kernel/module/signing.c
index 85c8999dfecf..6b0672e4417b 100644
--- a/kernel/module/signing.c
+++ b/kernel/module/signing.c
@@ -16,6 +16,11 @@
 #include <uapi/linux/module.h>
 #include "internal.h"
 
+#ifdef MODULE_PARAM_PREFIX
+#undef MODULE_PARAM_PREFIX
+#endif
+#define MODULE_PARAM_PREFIX "module."
+
 static bool sig_enforce = IS_ENABLED(CONFIG_MODULE_SIG_FORCE);
 module_param(sig_enforce, bool_enable_only, 0644);

-Saravana

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3F65334B1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 03:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243196AbiEYB2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 21:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233885AbiEYB2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 21:28:39 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4FD719E3;
        Tue, 24 May 2022 18:28:38 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z25so5228198pfr.1;
        Tue, 24 May 2022 18:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J/O7QHB/83qp0R6uAeHC9GzIW1KgB7sgS2PTCnjrXA8=;
        b=Y/KejWZjl/qnMwHs1oYTYrwTlKeFkQxA7jiUh+uO9Ib12Cv0aMkjHuid4wRSqGmK9v
         +oXZCBC+KeNq6xIv8/OWMuS6bqBWQa5S3JaP/Tl7Tn9COzMto1ZpDLIalqP6gpOZnXGn
         bwVmtWAeJ4aWvrO6iHqX3hZ0EFf8bwr3IxQjnxJXi3RjgYwRDhaM8OljALdrzF/Qo0eS
         NVMqoIU/0y2R2Ut8yW9Iy6G5qS4IpdWXK8agaPFea9X8zZ13vspfOGeQDcdcOokLz3fX
         33h1srwRbqzkG55OwCReaU3WeyuC1cm27U2UYBhi55jPhtB/Ct30gn+gBEXptDmhvApH
         LLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J/O7QHB/83qp0R6uAeHC9GzIW1KgB7sgS2PTCnjrXA8=;
        b=8EJn/E/zNEeTykYlmZVEzQhyg6mU5iPOuQ3WOGvAV05rru7iGT/9gpzfnMluJ+IBAh
         S3iX6/BjVMk+Yz7tsCLp6RwAfQdBROLX6FILH8f3/ML30lYi342iyrggXBv4s0ZVguvl
         +sRHLtjhi3LItGiNITW4b/GQrDlK3hnmrLBwBrq3H235lIMBDjJ1pEtBE//aKDjtAl8A
         zOQw13e3JUT5BKzYEazHsYbW+O3D3Kn5lYgeN6XQYJLC4yb4O2zxuTEZIqou8/wL8PCq
         VSloIK72HAruiZfm3+bXuK34LcIIpK/rqwfIU0CY/M2zbZq93o+LP2ocXyDTh7vcXkUc
         0lqQ==
X-Gm-Message-State: AOAM532e3sJ9CqMTmmct7c0y9x4UN9RCiJHp0SA0keONz11GfYYOMpr0
        +G0I+XDJ3rQocxrjAa4i0EBy0RR8Uw==
X-Google-Smtp-Source: ABdhPJxz1cpWGjZGtiQ+7Iib1gqWTaFhSN8JSkPhITcv0rxNQGbpVSKLwXdHZow5fUYR/38JDdZDXw==
X-Received: by 2002:a63:9dc7:0:b0:3f6:17f0:f310 with SMTP id i190-20020a639dc7000000b003f617f0f310mr25982468pgd.285.1653442118027;
        Tue, 24 May 2022 18:28:38 -0700 (PDT)
Received: from localhost.localdomain (ns1003916.ip-51-81-154.us. [51.81.154.37])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902c1cd00b0015e8d4eb21asm7878285plc.100.2022.05.24.18.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 18:28:37 -0700 (PDT)
From:   sunliming <kelulanainsley@gmail.com>
X-Google-Original-From: sunliming <sunliming@kylinos.cn>
To:     mingo@redhat.com, rostedt@goodmis.org, tglx@linutronix.de,
        bp@alien8.de, dave.hansen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        x86@kernel.org, linux-trace-devel@vger.kernel.org,
        sunliming@kylinos.cn
Subject: [PATCH v2 RESEND] x86,trace: Remove unused headers
Date:   Wed, 25 May 2022 09:28:27 +0800
Message-Id: <20220525012827.93464-1-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4b9a8dca0e58 ("x86/idt: Remove the tracing IDT completely")
removed the tracing IDT from the file arch/x86/kernel/tracepoint.c,
but left the related headers unused, remove it.

Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 arch/x86/kernel/tracepoint.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/tracepoint.c b/arch/x86/kernel/tracepoint.c
index fcfc077afe2d..f39aad69fb64 100644
--- a/arch/x86/kernel/tracepoint.c
+++ b/arch/x86/kernel/tracepoint.c
@@ -8,10 +8,7 @@
 #include <linux/jump_label.h>
 #include <linux/atomic.h>
 
-#include <asm/hw_irq.h>
-#include <asm/desc.h>
 #include <asm/trace/exceptions.h>
-#include <asm/trace/irq_vectors.h>
 
 DEFINE_STATIC_KEY_FALSE(trace_pagefault_key);
 
-- 
2.25.1


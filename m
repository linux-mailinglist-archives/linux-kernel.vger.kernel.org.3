Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046B3517147
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 16:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352279AbiEBOOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 10:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385495AbiEBOO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 10:14:27 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FCD15A09;
        Mon,  2 May 2022 07:10:57 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y21so16774088edo.2;
        Mon, 02 May 2022 07:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=joK5j7ew5SKN/cHxslItBx63j5PdrPIBK5veE/G0SHQ=;
        b=HoTx0fI9k/wNi8rf31TR+bf9CBgvi+XlcN26lQIR2oH50DFX3uY8EjYs8+G9Ly2AX6
         VPiXuWl7g1L+R+0+J1tpVhf4zprGMtz4C9LDN/Qc721rO0peoxWUrcKYLl0kciA4tqxQ
         1KowbweQSYEX5KdI3o8/+qh+R7PyJ3OccMWbBK10okckN8R3Q0gY6c3EkRMJegBaKMZI
         936Msgv+6Au0TlDpcEAoY7o80jMmf/3NxXozY4m+iJ2RyuL0MOCa1VWtSr08jqiE4A6L
         C73Sp9OLZalQdJcEQEHzDVNfcQs9a/u0xbXkxTGFvEY5Oul2MsuNymLbIj8SGyfqGbeK
         T0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=joK5j7ew5SKN/cHxslItBx63j5PdrPIBK5veE/G0SHQ=;
        b=dRuV5eaY38O+aBx4w8/pMtLlw4RYWLJsyvc0uoIp3vRHTUukHqby9dlyFX7NFwqNTC
         r0MjWk77d1G5OqdutR5It+hPQmcyfys/3S+Yht4IzMWa7EAvd/6vB8KBvb1NWx0NAGhS
         nuDtvPEeYgksizkJ81JgYXaTjEkaAcngN7EqPMESU75LQacZIqTiHWWcCJGkDWVGjpdC
         bXsYkGhdLNoyTkgmjj1Bx+KBz9GiG2NGp4fy1CctgHGWeaAAj1pcD5U1rYXpo9sOtJYt
         vUZc19Bj5Ccpv1nN0t3k9CpjObUGcpkolu1LFGwOK3Pxx3eGfANaQpsDBfYwmmEmhmcY
         qiLA==
X-Gm-Message-State: AOAM532eYFKBZKDHUQySsbJpvucyRd59mWSOw5wu+29cgQiCAAnY/1aW
        uay2MEKn8RR78mW1Ph0i9mXdBuMHsjY=
X-Google-Smtp-Source: ABdhPJz6NFDvTejbV7HnVzqZN55zXR3cWNJXtPu/IPMmkDmCdKUEg/L8wi7+Q3qw3YfQxCG1r7+jBA==
X-Received: by 2002:aa7:dd91:0:b0:427:b2c4:1c7a with SMTP id g17-20020aa7dd91000000b00427b2c41c7amr9825791edv.91.1651500655633;
        Mon, 02 May 2022 07:10:55 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-135-067.77.1.pool.telefonica.de. [77.1.135.67])
        by smtp.gmail.com with ESMTPSA id s23-20020a056402037700b0042617ba639bsm6732338edw.37.2022.05.02.07.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 07:10:55 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] selinux: avoid extra semicolon
Date:   Mon,  2 May 2022 16:10:51 +0200
Message-Id: <20220502141052.34413-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Wrap macro into `do { } while (0)` to avoid Clang emitting warnings
about extra semicolons.
Similar to userspace commit
https://github.com/SELinuxProject/selinux/commit/9d85aa60d12e468e7fd510c2b5475b5299b71622

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/avtab.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index cfdae20792e1..6178af5fedbe 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -40,7 +40,7 @@ static inline int avtab_hash(const struct avtab_key *keyp, u32 mask)
 
 	u32 hash = 0;
 
-#define mix(input) { \
+#define mix(input) do { \
 	u32 v = input; \
 	v *= c1; \
 	v = (v << r1) | (v >> (32 - r1)); \
@@ -48,7 +48,7 @@ static inline int avtab_hash(const struct avtab_key *keyp, u32 mask)
 	hash ^= v; \
 	hash = (hash << r2) | (hash >> (32 - r2)); \
 	hash = hash * m + n; \
-}
+} while (0)
 
 	mix(keyp->target_class);
 	mix(keyp->target_type);
-- 
2.36.0


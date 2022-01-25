Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7508A49B5F2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578335AbiAYOSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:18:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387141AbiAYOPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:15:05 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACC7C06176D;
        Tue, 25 Jan 2022 06:15:04 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id c24so60972409edy.4;
        Tue, 25 Jan 2022 06:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H9/P79kiby3ifcGF4ip7/7rtet6erkFjsvjE42zBKRU=;
        b=g0ZB4NrYFVrd/WYH7ctuevAirrvpwDP6WewyqP8iLA5TJZ9S32T7sJEVeC1/2V/0vm
         ZXp6ee9KLS6q5LnOkK6DBhFx+CkeABY+t3sR9oTFcpGFD2vxqMJ/rSGJk4YHIhby5yWs
         +z93ue/wXHT11wg9ngrDU4xe5EMEynkRR3YECFkG5vQPnhdLVET9YL3Xblt8E+Y+Rsl9
         J9k8ZyfhARU3vnoqXl4f27OOmRiQswqZOLIC0fem2Lw2lIh3kgmwgV0k/o/YfDZ8327a
         tvoQLu7L4tMUeTlTVWGkBe4NxIj7TCWkkU2LUS0L7rMyHwCdtMjS2w9ABY4AWqf7HUOx
         iZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H9/P79kiby3ifcGF4ip7/7rtet6erkFjsvjE42zBKRU=;
        b=zOAPFuMEbf265N9Y+IE1s+OL+wSu1669bQ1IfOSWErQveUA+k9rCVCL9gJzslgijGw
         7FAytQmNkxcNNm4XAUxDsdK9z0kUvKiBkU9Ac5hHrBLftYheWS1K4E15436beII76QJx
         12g+uSltIlzXjjX0hzUsEOjqAaFtswEz/rjd+yHadipZW0ZRLDp1d6+3Izj2uDZnW+vg
         oxVZEBvK6Xur/2ukiWO4bzwfXKAb8q4cbHCWWSgDQuCwctOKHQi7gqd/oBekbpPnvoiq
         3nbKE30+/jWVrZ+EOfrvxBQX6rpeIOe/EqRPcfotkoTqTlW28mcokiSi5DOu81ZrZVXN
         RbKw==
X-Gm-Message-State: AOAM532VVXLSiIs8S6qnRM+Ns/7Ol5vDe6gLybWnbR1rlPMejKmrkRVz
        FhFuRFbi8bXM8QNiDIH6OJzsJiBqnm5UYg==
X-Google-Smtp-Source: ABdhPJw63jKmaufKwl+6xsqdHxA1qMi+zig//jba8c/9KgLYXmArZdqp6VLdgUybsiJ4IxiYK6ceMg==
X-Received: by 2002:a17:906:7953:: with SMTP id l19mr16763178ejo.36.1643120102557;
        Tue, 25 Jan 2022 06:15:02 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-010-144-044.77.10.pool.telefonica.de. [77.10.144.44])
        by smtp.gmail.com with ESMTPSA id lu44sm6292929ejb.145.2022.01.25.06.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 06:15:02 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH 9/9] selinux: drop unused macro
Date:   Tue, 25 Jan 2022 15:14:19 +0100
Message-Id: <20220125141422.32655-8-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125141422.32655-1-cgzones@googlemail.com>
References: <20220125141422.32655-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro _DEBUG_HASHES is nowhere used. The configuration DEBUG_HASHES
enables debugging of the SELinux hash tables, but the with an underscore
prefixed macro definition has no direct impact or any documentation.

Reported by clang [-Wunused-macros]

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/policydb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 67e03f6e8966..d036e1238e77 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -41,8 +41,6 @@
 #include "mls.h"
 #include "services.h"
 
-#define _DEBUG_HASHES
-
 #ifdef DEBUG_HASHES
 static const char *symtab_name[SYM_NUM] = {
 	"common prefixes",
-- 
2.34.1


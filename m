Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2335526B20
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384142AbiEMUWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384122AbiEMUWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:22:10 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D3A158F96
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:22:09 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id g129-20020a25db87000000b0064b0d671050so8179115ybf.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IxHEer1R7aVI+23m0/FmYa+I+TASlrgBBKCjzC35/is=;
        b=OxMA8KuHb8XyzEjNcQew0ArZPh+FVcPLuUudPe8Jic4JWJ2qN0iVlwiAZZSV9Gtzwv
         7HrYwsvduCROdph8yijbuUGSiOimDaejwPHZbVJ1M734lxldw057vMrtMmT4JDtTWicN
         LFtVcyF/iv6fifWYUO8WReZUA0eigVeQwl1sgTgmQEQ2c5FaP2Mr+ePC13K4wuaZayO1
         d8+lzT59gwHtCXP+id4mRPGTa9D7RNmpX55+YjUZbLnUUDJp3++JVBGJgL1r3FL1rFgD
         9c/LZv5mImy0vO1Qkn8xvEDuDTkaHE5SP9oiguHQSFWAB0RU+W3gKv3DkAA64d0G0jNq
         TI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IxHEer1R7aVI+23m0/FmYa+I+TASlrgBBKCjzC35/is=;
        b=HY3BxwiHx02u7+Nxt6ggte5RpMUGLKf2y6oIhgqbKM4/cwJI2RcJ0oliYjK0qr6NK3
         b7ZMqIChxvjX9ALZo570K3GWpLtz/O/fZBkuqgBVk3R+A5Np80xlWmNKLJlJlgD2Y5Ry
         Ld8OrArb5Pr2RDV+R8UvzchpJnJQHDAcgy+PKbQ094GdqDYMQYddn8AHNYzwnVlzQ/0c
         FwB6EzZU+LjKblsFrmfaHfSS7MRI6q0TxlE50XLZ8mqQ1BaXWa//waD65QpgUhCLkpWt
         rvucGqjNFe6QM1KewXPfhCOFVPj+d9Jfdt42pjEJK2O5fWWpYH2EGpxXwYP3PRoJ6TyW
         JHYg==
X-Gm-Message-State: AOAM531sDk8VAHFs+Rw5XE7FEQbwKah+CDjgsC5lqZasgSBHbJotEap5
        VtIydWr6uWixGLykBIxOU3PpSV/txXCx5fMvfy/QF6S8eG0Kz1+rgA8hrHd9Nyntf9pJzXoglBl
        uwCEjpd0ZjmOuQ7hmQcvroHXA7Dm51HY9xFZ+lnSJvM9cL+U4Q45dYAVNiQmh4gB8r74BYN0/IP
        /rC+eXEP3KMQ==
X-Google-Smtp-Source: ABdhPJzUS09TySpKZNXM6m4ea8HNMDMOfILnzeEqlsd04WIi/iMakGhB41x1yNg+3tqOE5zhpyksH9HH+6A5s0pmUMM=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e0:c17e:c2dc:13eb])
 (user=samitolvanen job=sendgmr) by 2002:a81:5607:0:b0:2db:c245:5ff4 with SMTP
 id k7-20020a815607000000b002dbc2455ff4mr7860740ywb.244.1652473328452; Fri, 13
 May 2022 13:22:08 -0700 (PDT)
Date:   Fri, 13 May 2022 13:21:41 -0700
In-Reply-To: <20220513202159.1550547-1-samitolvanen@google.com>
Message-Id: <20220513202159.1550547-4-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=669; h=from:subject;
 bh=nqUrm2wetpzQHlcH5NE19NaoXqu5E22beF1fMMwNKYU=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBifr3iMv7g14dMbgfDCXDLb8bbUgmfd0gW8V9AeL1O
 zzXtTTuJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYn694gAKCRBMtfaEi7xW7iEdDA
 CI6z4FnJ7PlqvcN6HOYf/c+XXnT7MWbgCS2HoVv2P8QoFQ7TpgbvN9zIdJ2RqY6xEuuz3emRk6Ah6L
 m3BDCj8zH2JvuDhGU8CvazPYASgz94v/HBmS7NVikbjwkqCaqgwWglXdD2apJxu5anZhqnCpft8QPP
 bsIYUu1URvNbcxZKEGTmZ+CfaHo8s7SG6cXjrxevYWrVVsTwtujQ9JyLn0OoTcm/Fz7e+vQTkJ8h83
 tVq2x9/I247t3sHmmcB9KPidgRSvcn1f9jJq0P1G7rSEDpVyZu2g0xj0mridXoViXt4rnsB3q1jmCE
 BVikAZnVI/yfasdkpS9g3uH/FygOBkKSfIT27/K+DLNc7XcLJJfDlhBepjYoQ2RwC0/vfOhr+7iq8Z
 S6gs/HjMHr5L+Y77qMjwRSwMNE2rdV+mTed4i9qBwlRWYaCWx3uwygO/JhgxJmegZ36M5eaQI+mxtd
 OYZMFi5iejcuHT5TOPjKY0v8Ia7ODn5SOlEwOFOqDPNMs=
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [RFC PATCH v2 03/21] kallsyms: Ignore __kcfi_typeid_
From:   Sami Tolvanen <samitolvanen@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        Sami Tolvanen <samitolvanen@google.com>
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

The compiler generates CFI type identifier symbols for annotating
assembly functions at link time. Ignore them in kallsyms.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 scripts/kallsyms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 8caabddf817c..eebd02e4b832 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -118,6 +118,7 @@ static bool is_ignored_symbol(const char *name, char type)
 		"__ThumbV7PILongThunk_",
 		"__LA25Thunk_",		/* mips lld */
 		"__microLA25Thunk_",
+		"__kcfi_typeid_",	/* CFI type identifiers */
 		NULL
 	};
 
-- 
2.36.0.550.gb090851708-goog


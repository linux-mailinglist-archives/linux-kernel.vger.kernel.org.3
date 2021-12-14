Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAB34747B2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbhLNQWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235775AbhLNQWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:22:33 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022E7C061747
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:22:33 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id p3-20020a056000018300b00186b195d4ddso4861430wrx.15
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=v27suEImYCH1RWXe/1ZFLgxZ+ZgAGIliQ0KnY8gXJkw=;
        b=S+neo1BC67KP01dukd8NNmSIdQmnHn24FhUGscdevRCdK/42TvHClIY3O5ml7Quo0U
         BPRKv50AiEGkEyZO4VY8Ng2Q3AsHH/9n5YZMpXK3nOBS1PMJ+Rv012vrceW90vT3rOnT
         1M8jdsL0QHxtwu2/qODH4gqnvQ2l6bDZDTyoQoPw980LzWS0pyxejw6CfpJD6bFTxjxn
         OlxHBThm13zT0CZcBBkFLgBqf7/tkopsGYLF9i4Jpsy70Vdh+Xs5morzyT2tI1qfhjgI
         HMPN0CtrKqzm5YSzy+Lij9L/18UpwAXbipEO21jBLUpDlIRUX8MhC/zlI+FVqlmtEmOq
         Y4Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=v27suEImYCH1RWXe/1ZFLgxZ+ZgAGIliQ0KnY8gXJkw=;
        b=KrIb0uP0xouHej8dvaYRxpTfUAJ4PXt1OJ8fG+eNZ7zKwjyimPlNtW7QqsiCgjQcyD
         xQhuZE9SwTP7UlqomS9vdqL5GY9I/FcOfoBqBTq23K7Hw4bi9HL4GoySKaxTmO6LqSll
         yEOmGWAq/O4to/Th804jYW9Fws4p2S8VJllglXStfm6neXtMCSx+phrz9XBSwUddQcs3
         bRHBOMdTByLmkrH0dB8oV+Q2707lKxBi0qo2G2hEs5o6tZTIgPZbJ2Glm13/Vq/pWnbF
         HSQ00dV3R4nnddF9POFvtGxnxNCztDcfRUKFiP6mrtm1yrO1dYPzyCFQYyUo2nMxgnZN
         ua4Q==
X-Gm-Message-State: AOAM530WXXZ5GobpJxqctBy5bB0jfeZWuzX++B3p9fUNS8gFwExvpiF0
        TPaKs0i2W6Udsg8/HykfQx+TO0Bytug=
X-Google-Smtp-Source: ABdhPJwWpA7c1G+q3WbDfvjyQeS9ZstbuSBGtacVhYhTANMjcKvuP3bS1lPvI1M15XVB7V7hiKxTaFSM7ac=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:357e:2b9d:5b13:a652])
 (user=glider job=sendgmr) by 2002:a1c:43c2:: with SMTP id q185mr36440wma.30.1639498951456;
 Tue, 14 Dec 2021 08:22:31 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:20:21 +0100
In-Reply-To: <20211214162050.660953-1-glider@google.com>
Message-Id: <20211214162050.660953-15-glider@google.com>
Mime-Version: 1.0
References: <20211214162050.660953-1-glider@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH 14/43] MAINTAINERS: add entry for KMSAN
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entry for KMSAN maintainers/reviewers.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/Ic5836c2bceb6b63f71a60d3327d18af3aa3dab77
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 13f9a84a617e3..94add5a5404e4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10615,6 +10615,18 @@ F:	kernel/kmod.c
 F:	lib/test_kmod.c
 F:	tools/testing/selftests/kmod/
 
+KMSAN
+M:	Alexander Potapenko <glider@google.com>
+R:	Marco Elver <elver@google.com>
+R:	Dmitry Vyukov <dvyukov@google.com>
+L:	kasan-dev@googlegroups.com
+S:	Maintained
+F:	Documentation/dev-tools/kmsan.rst
+F:	include/linux/kmsan*.h
+F:	lib/Kconfig.kmsan
+F:	mm/kmsan/
+F:	scripts/Makefile.kmsan
+
 KPROBES
 M:	Naveen N. Rao <naveen.n.rao@linux.ibm.com>
 M:	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
-- 
2.34.1.173.g76aa8bc2d0-goog


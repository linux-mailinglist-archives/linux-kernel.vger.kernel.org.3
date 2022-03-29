Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974814EAD66
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 14:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236456AbiC2MoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 08:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236546AbiC2MnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 08:43:00 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A27E220FDA
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 05:41:14 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id gx12-20020a1709068a4c00b006df7e8181ceso8122582ejc.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 05:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=17K480cFHZmjgZnEKs0kvaSf6Wt6+7fFqZhB6I4ek4M=;
        b=RSDNW7nZXrX14ECEyw7iYD8PmPG9kTQkYLbWQ7qMATA0/b6xXjIDXSHO98HP2EtZKs
         lhAoCw7gzmWs/rvYGDw/eTGXSRrJlJh6DUibcUhZyQhiQH6E63/DD0cNXhwbf8sHDm1W
         k8DlOA7/CM9UnHu1KQJYWBvxHNHY5VbXChFuhjmADE4ZsvBWU5u5hHrXpd+CNyWFkine
         L34oSIh5HCj7mFNxyr5ujACe/1SMjwIg4y0zKxsN8e+BwlG9OCcKTrKsNaEfTRS+Hsmn
         uKtH1oVpOBVYoMma60yhuXibPqsneRA9ZLArVfhZgEkVmZVR70UWp2VL4AZQRC8m6TIs
         gR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=17K480cFHZmjgZnEKs0kvaSf6Wt6+7fFqZhB6I4ek4M=;
        b=qn7M1g2wwvGVXiDR8k8Nr12F0EOMi5dWRtxHPBXTCnXlrbXbKLWx0ua9AUamvi63ON
         yUGGDytDchrWObJ5JYmQjbA0ArAPF9wvcQ5Y7QJZJRKCS3DwSigq4YG8xrWVcHRbRber
         F+FuMVb/Ly/dnkmCLgTyA8hZbWQrKbz45ByhHsB6TPVBywcAdETiXGYY6u3jtB4yoE60
         tY6QEC5R7ru2wJsbOfxt06DXBAme/ULmhp4bbDC8P98njN9RL8kY+feyJJ4w+PcMhWtf
         5YOPWBcjqh2N+nQd8TG4X2JJR80yCKOyVUgpjpd1YEnEvyi8PGE108Z1xyHJACBPrku9
         LY6Q==
X-Gm-Message-State: AOAM532g7ZHRZWWylO+l1dyJ6lmWp0TaauhPleFfEiowYsKjuP2kifQh
        W1Ti16zASiupP8wyirHDp09YEY6Fraw=
X-Google-Smtp-Source: ABdhPJw7IcXW/4bj+dfFYbcSuDH6uP+LYtDkdrlnTYVetr1ku4F+UEshV4bZLv/czt62R1ghVW3NtkuMjeM=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:36eb:759:798f:98c3])
 (user=glider job=sendgmr) by 2002:a50:baa1:0:b0:418:849a:c66a with SMTP id
 x30-20020a50baa1000000b00418849ac66amr4402991ede.234.1648557672349; Tue, 29
 Mar 2022 05:41:12 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:39:45 +0200
In-Reply-To: <20220329124017.737571-1-glider@google.com>
Message-Id: <20220329124017.737571-17-glider@google.com>
Mime-Version: 1.0
References: <20220329124017.737571-1-glider@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2 16/48] MAINTAINERS: add entry for KMSAN
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
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
        Mark Rutland <mark.rutland@arm.com>,
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index cd0f68d4a34a6..4053523a1e890 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10721,6 +10721,18 @@ F:	kernel/kmod.c
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
2.35.1.1021.g381101b075-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950E34E5B13
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 23:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345140AbiCWWL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 18:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345119AbiCWWL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 18:11:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985B98EB70;
        Wed, 23 Mar 2022 15:10:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3218A61743;
        Wed, 23 Mar 2022 22:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F128DC340E8;
        Wed, 23 Mar 2022 22:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1648073425;
        bh=xLoUSyyy7Fd4dqBNWHmtBAmPuHFOs/nkqaCLBf8yfFY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RaHLN8VRUw4CEvhzzrVUPpesktBspYHdxkXxAeg8BnI/U76ilSgZ7iWC5lE/qvUEL
         hYbW/B6Sy+sjBvRbXfnk5cbb7ENgIkeqcGHqxyaEmDtJxpRqhk4o+h64mIrKeNAa1U
         6bUC1z0LIUfHkmtzDx5Et4oG817etle8+NTbhkPM=
Date:   Wed, 23 Mar 2022 15:10:24 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Maninder Singh <maninder1.s@samsung.com>, pmladek@suse.com,
        rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        wangkefeng.wang@huawei.com, v.narang@samsung.com,
        swboyd@chromium.org, ojeda@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        avimalin@gmail.com, atomlin@redhat.com, keescook@chromium.org,
        ndesaulniers@google.com, rdunlap@infradead.org, void@manifault.com
Subject: Re: [PATCH 1/1 module-testing] kallsyms: enhance %pS/s/b printing
 when KALLSYSMS is disabled
Message-Id: <20220323151024.84eb56bb87964a6e5522b1c4@linux-foundation.org>
In-Reply-To: <YjuZa8Jd2+gpiM3J@bombadil.infradead.org>
References: <CGME20220323164758epcas5p2d98f696230aaa5e2d6a8820bc2f13f0c@epcas5p2.samsung.com>
        <20220323164742.2984281-1-maninder1.s@samsung.com>
        <YjuZa8Jd2+gpiM3J@bombadil.infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Mar 2022 15:04:27 -0700 Luis Chamberlain <mcgrof@kernel.org> wrote:

> On Wed, Mar 23, 2022 at 10:17:42PM +0530, Maninder Singh wrote:
> > ---
> > module-next -> module-testing: Petr's review and test tag is picked from previous version,
> > current version has slight changes (module.c -> module/main.c). No functional change in patch,
> > only init_build_id() function is moved to module/main.c as it can be independent of
> > kallsyms.
> 
> Andrew,
> 
> I see this patch is merged on your tree, any chance we can yield until
> the next release and I can then take it under modules-next ? It would
> help given the slew of changes I now have queued up not for v5.18 but
> for v5.19. I'm delaying the modules changes for v5.19 given the timing,
> it is too soon to merge for v5.18 as I want tons of testing on this
> all on linux-next after v5.18-rc1 is out.
> 

I don't actually have this patch in -mm.  What I do have is the below,
which I shall now drop.  All yours to deal with as you see fit!



From: Maninder Singh <maninder1.s@samsung.com>
Subject: kallsyms: print module name in %ps/S case when KALLSYMS is disabled

original:
With KALLSYMS
                   %pS                               %ps
[16.4200]  hello_init+0x0/0x24 [crash]        hello_init [crash]

Without KALLSYMS:
[16.2200]      0xbe200040                         0xbe200040

With Patch (Without KALLSYMS:) load address + current offset [Module Name]

[13.5993]  0xbe200000+0x40 [crash]           0xbe200000+0x40 [crash]

It will help in better debugging and checking when KALLSYMS is disabled,
user will get information about module name and load address of module.

verified for arm64:
/ # insmod /crash.ko

[   19.263556] 0xffff800000ec0000+0x38 [crash]

..

[   19.276023] Call trace:
[   19.276277]  0xffff800000ec0000+0x28 [crash]
[   19.276567]  0xffff800000ec0000+0x58 [crash]
[   19.276727]  0xffff800000ec0000+0x74 [crash]
[   19.276866]  0xffff8000080127d0
[   19.276978]  0xffff80000812d95c
[   19.277085]  0xffff80000812f554

Link: https://lkml.kernel.org/r/20220201040044.1528568-1-maninder1.s@samsung.com
Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Co-developed-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: Stephen Boyd <swboyd@chromium.org>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/kallsyms.h |   27 +++++++++++++++++++++++++++
 lib/vsprintf.c           |    5 +++--
 2 files changed, 30 insertions(+), 2 deletions(-)

--- a/include/linux/kallsyms.h~kallsyms-print-module-name-in-%ps-s-case-when-kallsyms-is-disabled
+++ a/include/linux/kallsyms.h
@@ -163,6 +163,33 @@ static inline bool kallsyms_show_value(c
 	return false;
 }
 
+#ifdef CONFIG_MODULES
+static inline int fill_minimal_module_info(char *sym, int size, unsigned long value)
+{
+	struct module *mod;
+	unsigned long offset;
+	int ret = 0;
+
+	preempt_disable();
+	mod = __module_address(value);
+	if (mod) {
+		offset = value - (unsigned long)mod->core_layout.base;
+		snprintf(sym, size - 1, "0x%lx+0x%lx [%s]",
+				(unsigned long)mod->core_layout.base, offset, mod->name);
+
+		sym[size - 1] = '\0';
+		ret = 1;
+	}
+
+	preempt_enable();
+	return ret;
+}
+#else
+static inline int fill_minimal_module_info(char *sym, int size, unsigned long value)
+{
+	return 0;
+}
+#endif /*CONFIG_MODULES*/
 #endif /*CONFIG_KALLSYMS*/
 
 static inline void print_ip_sym(const char *loglvl, unsigned long ip)
--- a/lib/vsprintf.c~kallsyms-print-module-name-in-%ps-s-case-when-kallsyms-is-disabled
+++ a/lib/vsprintf.c
@@ -984,9 +984,7 @@ char *symbol_string(char *buf, char *end
 		    struct printf_spec spec, const char *fmt)
 {
 	unsigned long value;
-#ifdef CONFIG_KALLSYMS
 	char sym[KSYM_SYMBOL_LEN];
-#endif
 
 	if (fmt[1] == 'R')
 		ptr = __builtin_extract_return_addr(ptr);
@@ -1006,6 +1004,9 @@ char *symbol_string(char *buf, char *end
 
 	return string_nocheck(buf, end, sym, spec);
 #else
+	if (fill_minimal_module_info(sym, KSYM_SYMBOL_LEN, value))
+		return string_nocheck(buf, end, sym, spec);
+
 	return special_hex_number(buf, end, value, sizeof(void *));
 #endif
 }
_


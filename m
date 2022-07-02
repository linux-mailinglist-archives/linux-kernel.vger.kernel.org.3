Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC14A5642B3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 22:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiGBU0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 16:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGBU0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 16:26:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B41BC0C
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 13:26:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D643C61009
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 20:26:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04FF2C34114;
        Sat,  2 Jul 2022 20:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1656793593;
        bh=3OoY7Srww1hi9JObmYGCZE+0AZQRIiLLqeNFDNJh9WY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n/bWNW802Y6Mg7webWqE6J7lFup5McRn6EQ16CX898CrVVN3Z+AvE4wTciuGXZHMJ
         VJjhoBCd5fCshrXhWVFvlxECvmMkixh/McorVqjtCzJNWcinEZARuUens4taZT1eFo
         /oJt9qG4a7AuJNOUAku/HBc+oi8i3rQptmHlJezE=
Date:   Sat, 2 Jul 2022 13:26:32 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [akpm-mm:mm-unstable 302/323] arch/x86/mm/pgprot.c:26:6:
 warning: no previous prototype for 'add_encrypt_protection_map'
Message-Id: <20220702132632.5df1965aa1aec0318c9f90ff@linux-foundation.org>
In-Reply-To: <202207021647.Jb0wNWF5-lkp@intel.com>
References: <202207021647.Jb0wNWF5-lkp@intel.com>
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

On Sat, 2 Jul 2022 16:32:52 +0800 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-unstable
> head:   706370e5c2ea7bb4544eee6e1172c4d68117a526
> commit: d845587c05fd4ae52aaa0cd5c8939e8f4793301f [302/323] x86/mm: move protection_map[] inside the platform
> config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220702/202207021647.Jb0wNWF5-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?id=d845587c05fd4ae52aaa0cd5c8939e8f4793301f
>         git remote add akpm-mm https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
>         git fetch --no-tags akpm-mm mm-unstable
>         git checkout d845587c05fd4ae52aaa0cd5c8939e8f4793301f
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/mm/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> arch/x86/mm/pgprot.c:26:6: warning: no previous prototype for 'add_encrypt_protection_map' [-Wmissing-prototypes]
>       26 | void add_encrypt_protection_map(void)
>          |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> 
> vim +/add_encrypt_protection_map +26 arch/x86/mm/pgprot.c
> 
>     25	
>   > 26	void add_encrypt_protection_map(void)
>     27	{
>     28		unsigned int i;
>     29	
>     30		for (i = 0; i < ARRAY_SIZE(protection_map); i++)
>     31			protection_map[i] = pgprot_encrypted(protection_map[i]);
>     32	}
>     33	

Something like this?


 arch/x86/include/asm/mem_encrypt.h |    2 ++
 arch/x86/mm/mem_encrypt_amd.c      |    3 +--
 arch/x86/mm/pgprot.c               |    1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/mem_encrypt.h~x86-mm-move-protection_map-inside-the-platform-fix
+++ a/arch/x86/include/asm/mem_encrypt.h
@@ -89,6 +89,8 @@ static inline void mem_encrypt_free_decr
 /* Architecture __weak replacement functions */
 void __init mem_encrypt_init(void);
 
+void add_encrypt_protection_map(void);
+
 /*
  * The __sme_pa() and __sme_pa_nodebug() macros are meant for use when
  * writing to or comparing values from the cr3 register.  Having the
--- a/arch/x86/mm/mem_encrypt_amd.c~x86-mm-move-protection_map-inside-the-platform-fix
+++ a/arch/x86/mm/mem_encrypt_amd.c
@@ -26,6 +26,7 @@
 #include <asm/tlbflush.h>
 #include <asm/fixmap.h>
 #include <asm/setup.h>
+#include <asm/mem_encrypt.h>
 #include <asm/bootparam.h>
 #include <asm/set_memory.h>
 #include <asm/cacheflush.h>
@@ -484,8 +485,6 @@ void __init early_set_mem_enc_dec_hyperc
 	enc_dec_hypercall(vaddr, npages, enc);
 }
 
-void add_encrypt_protection_map(void);
-
 void __init sme_early_init(void)
 {
 	if (!sme_me_mask)
--- a/arch/x86/mm/pgprot.c~x86-mm-move-protection_map-inside-the-platform-fix
+++ a/arch/x86/mm/pgprot.c
@@ -3,6 +3,7 @@
 #include <linux/export.h>
 #include <linux/mm.h>
 #include <asm/pgtable.h>
+#include <asm/mem_encrypt.h>
 
 static pgprot_t protection_map[16] __ro_after_init = {
 	[VM_NONE]					= PAGE_NONE,
_


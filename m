Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E414507AD7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354319AbiDSUUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238495AbiDSUUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:20:09 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B51041306
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 13:17:25 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id x80so751636pfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 13:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=pEwCdWEWqL+Jx2LgFmD8moSwwMabmuP70B2nj25k/lY=;
        b=vZ1GZf3pJHpMiWTwiFrHVKKs0wqWDMYvwJ3z9UIQv9h525GyTJvR7lgq6BuGP/IOYn
         tUbArxZezVcVEjfrXRPVrT6DErDQaxqGtFbDBjccmIvbUU6hqn2NkuZtytGj5U+wkXpi
         6iqXoXpI8I8qpTM/NOwLNF3HsgL+Qi9sRcYVuS0+Bb3p9IeicW61Y1sGQvaIJrFZrFOq
         q8C/civPxaSOfX4gR8rOCxc711DhaKeSafn1T4E9NIdpc2mf4lm6+Rs6wiPIO5arfJLv
         MWUGB1Gy0vbPm0Qwog8YRRADHufS6BBHjFCe0TizWYX3VB6+GS4ty9iTg1FQ0BJZQJiD
         6pqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=pEwCdWEWqL+Jx2LgFmD8moSwwMabmuP70B2nj25k/lY=;
        b=Vdx2F3fosi6m/l+oVzMRENqQTMWxge6sYx5d9qS8jIiuSRrzXhA9Gdo8Z3NlRDfr6D
         2FGdr2QuLRWkiy900QT4I+NQu7T6M7ByMe11DMnezFmi+obW0nvY+NQxNmo6Ha1LLH4l
         HpCkdo4RziVrOlq+mfO1x+HD9OIUWQaL37Xrb3g+z50Hr8ETrEQgJbce8dzoXoV+/jvP
         p59T5iaVz+O3FnyPgWX7Lg12SVPcrwrg059UEp8eNeEZPrq2rWsTXM+c7wOks7fLio0c
         PMlpWzv9rtZEBumZeudAhpXYpQNtft7nSutdac7tZM02iWOw5hBbf/0EhItd/foixmb8
         rHzg==
X-Gm-Message-State: AOAM531x3i85TLwWCYnBfYMiSP+pusMOKDM0ZOiOrGiIqETPWG7pOnii
        FkuiuyA7BFGtQe6VjOKnSJAb/A==
X-Google-Smtp-Source: ABdhPJxSXkQ09aAPi5iJno6Axef/nrklQ2CxtFHd46yWfEnrNhAPreScQDcm0F8SuUp0G05nmXpVeA==
X-Received: by 2002:a63:5041:0:b0:39d:cbe3:79b9 with SMTP id q1-20020a635041000000b0039dcbe379b9mr15848828pgl.574.1650399445149;
        Tue, 19 Apr 2022 13:17:25 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id j13-20020a17090a840d00b001ca89db9e6esm17738724pjn.19.2022.04.19.13.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 13:17:24 -0700 (PDT)
Date:   Tue, 19 Apr 2022 13:17:24 -0700 (PDT)
X-Google-Original-Date: Tue, 19 Apr 2022 13:17:16 PDT (-0700)
Subject:     Re: arch/riscv/mm/init.c:782:83: warning: suggest braces around empty body in an 'if' statement
In-Reply-To: <202203280003.jGKBNwrv-lkp@intel.com>
CC:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     lkp@intel.com, panqinglin2020@iscas.ac.cn
Message-ID: <mhng-0a500fb4-ce93-4d52-bfda-2dc600286267@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Mar 2022 09:05:03 PDT (-0700), lkp@intel.com wrote:
> Hi Qinglin,
>
> FYI, the error/warning still remains.

Thanks.  I'm not sure if I missed a patch for this, I can't find 
anything that looks relevant in my inbox.  I just sent one of my own to 
fix the issue, but if there's one I missed then happy to take that 
instead.

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   f022814633e1c600507b3a99691b4d624c2813f0
> commit: 677b9eb8810edc6c616a699018a83e24ed0cccab riscv: mm: Prepare pt_ops helper functions for sv57
> date:   6 weeks ago
> config: riscv-rv32_defconfig (https://download.01.org/0day-ci/archive/20220328/202203280003.jGKBNwrv-lkp@intel.com/config)
> compiler: riscv32-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=677b9eb8810edc6c616a699018a83e24ed0cccab
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 677b9eb8810edc6c616a699018a83e24ed0cccab
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/mm/
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>    arch/riscv/mm/init.c: In function 'create_fdt_early_page_table':
>>> arch/riscv/mm/init.c:782:83: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
>      782 |                                    (uintptr_t)early_dtb_pud, P4D_SIZE, PAGE_TABLE);
>          |                                                                                   ^
>    arch/riscv/mm/init.c:786:83: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
>      786 |                                    (uintptr_t)early_dtb_pmd, PUD_SIZE, PAGE_TABLE);
>          |                                                                                   ^
>    arch/riscv/mm/init.c: At top level:
>    arch/riscv/mm/init.c:813:13: warning: no previous prototype for 'pt_ops_set_early' [-Wmissing-prototypes]
>      813 | void __init pt_ops_set_early(void)
>          |             ^~~~~~~~~~~~~~~~
>    arch/riscv/mm/init.c:835:13: warning: no previous prototype for 'pt_ops_set_fixmap' [-Wmissing-prototypes]
>      835 | void __init pt_ops_set_fixmap(void)
>          |             ^~~~~~~~~~~~~~~~~
>    arch/riscv/mm/init.c:853:13: warning: no previous prototype for 'pt_ops_set_late' [-Wmissing-prototypes]
>      853 | void __init pt_ops_set_late(void)
>          |             ^~~~~~~~~~~~~~~
>
>
> vim +/if +782 arch/riscv/mm/init.c
>
>    764
>    765	/*
>    766	 * Setup a 4MB mapping that encompasses the device tree: for 64-bit kernel,
>    767	 * this means 2 PMD entries whereas for 32-bit kernel, this is only 1 PGDIR
>    768	 * entry.
>    769	 */
>    770	static void __init create_fdt_early_page_table(pgd_t *pgdir, uintptr_t dtb_pa)
>    771	{
>    772	#ifndef CONFIG_BUILTIN_DTB
>    773		uintptr_t pa = dtb_pa & ~(PMD_SIZE - 1);
>    774
>    775		create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA,
>    776				   IS_ENABLED(CONFIG_64BIT) ? early_dtb_pgd_next : pa,
>    777				   PGDIR_SIZE,
>    778				   IS_ENABLED(CONFIG_64BIT) ? PAGE_TABLE : PAGE_KERNEL);
>    779
>    780		if (pgtable_l5_enabled)
>    781			create_p4d_mapping(early_dtb_p4d, DTB_EARLY_BASE_VA,
>  > 782					   (uintptr_t)early_dtb_pud, P4D_SIZE, PAGE_TABLE);
>    783
>    784		if (pgtable_l4_enabled)
>    785			create_pud_mapping(early_dtb_pud, DTB_EARLY_BASE_VA,
>    786					   (uintptr_t)early_dtb_pmd, PUD_SIZE, PAGE_TABLE);
>    787
>    788		if (IS_ENABLED(CONFIG_64BIT)) {
>    789			create_pmd_mapping(early_dtb_pmd, DTB_EARLY_BASE_VA,
>    790					   pa, PMD_SIZE, PAGE_KERNEL);
>    791			create_pmd_mapping(early_dtb_pmd, DTB_EARLY_BASE_VA + PMD_SIZE,
>    792					   pa + PMD_SIZE, PMD_SIZE, PAGE_KERNEL);
>    793		}
>    794
>    795		dtb_early_va = (void *)DTB_EARLY_BASE_VA + (dtb_pa & (PMD_SIZE - 1));
>    796	#else
>    797		/*
>    798		 * For 64-bit kernel, __va can't be used since it would return a linear
>    799		 * mapping address whereas dtb_early_va will be used before
>    800		 * setup_vm_final installs the linear mapping. For 32-bit kernel, as the
>    801		 * kernel is mapped in the linear mapping, that makes no difference.
>    802		 */
>    803		dtb_early_va = kernel_mapping_pa_to_va(XIP_FIXUP(dtb_pa));
>    804	#endif
>    805
>    806		dtb_early_pa = dtb_pa;
>    807	}
>    808

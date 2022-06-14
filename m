Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA95B54A761
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 05:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353824AbiFNDGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 23:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349712AbiFNDF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 23:05:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA92529826
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 20:05:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B6ED23A;
        Mon, 13 Jun 2022 20:05:56 -0700 (PDT)
Received: from [10.162.40.17] (unknown [10.162.40.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 965623F792;
        Mon, 13 Jun 2022 20:05:54 -0700 (PDT)
Message-ID: <94c9de11-8838-53db-5c1b-2e059d11282e@arm.com>
Date:   Tue, 14 Jun 2022 08:35:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V2 2/2] mm/mmap: Drop generic protection_map[] array
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, linux-mm@kvack.org
Cc:     kbuild-all@lists.01.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20220613053354.553579-3-anshuman.khandual@arm.com>
 <202206131931.ZJuanaBo-lkp@intel.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <202206131931.ZJuanaBo-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/13/22 16:43, kernel test robot wrote:
> Hi Anshuman,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on akpm-mm/mm-everything]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Anshuman-Khandual/mm-mmap-Drop-__SXXX-__PXXX-macros-from-across-platforms/20220613-133456
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> config: powerpc64-randconfig-r016-20220613 (https://download.01.org/0day-ci/archive/20220613/202206131931.ZJuanaBo-lkp@intel.com/config)
> compiler: powerpc64le-linux-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/696f81b49f7b6316f652d795da4c0008efef4487
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Anshuman-Khandual/mm-mmap-Drop-__SXXX-__PXXX-macros-from-across-platforms/20220613-133456
>         git checkout 696f81b49f7b6316f652d795da4c0008efef4487
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/mm/book3s64/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from arch/powerpc/include/asm/page.h:306,
>                     from arch/powerpc/include/asm/mmu.h:149,
>                     from arch/powerpc/include/asm/lppaca.h:46,
>                     from arch/powerpc/include/asm/paca.h:18,
>                     from arch/powerpc/include/asm/current.h:13,
>                     from include/linux/sched.h:12,
>                     from arch/powerpc/mm/book3s64/pgtable.c:6:
>    arch/powerpc/mm/book3s64/pgtable.c: In function 'vm_get_page_prot':
>>> arch/powerpc/mm/book3s64/pgtable.c:557:41: error: 'protection_map' undeclared (first use in this function)
>      557 |         unsigned long prot = pgprot_val(protection_map[vm_flags &
>          |                                         ^~~~~~~~~~~~~~

Adding an extern declaration fixes the problem. The problem is generic declaration
in include/linux/mm.h is not available for platforms with ARCH_HAS_VM_GET_PAGE_PROT.
protection_map[] has to be moved into arch/powerpc/mm/pgtable.c to be used by both
32 bit and 64 bit platforms.

diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c                                                                                                                                                                                              
index 260b0cc6d3a1..99c794ab253d 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c                        
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -551,6 +551,8 @@ unsigned long memremap_compat_align(void)
 EXPORT_SYMBOL_GPL(memremap_compat_align);
 #endif
                                                                
+extern pgprot_t protection_map[16];
+                 
 /* Note due to the way vm flags are laid out, the bits are XWR */
 pgprot_t vm_get_page_prot(unsigned long vm_flags)
 {                                


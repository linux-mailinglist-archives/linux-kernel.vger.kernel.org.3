Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9397D564205
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 20:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbiGBSRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 14:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiGBSRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 14:17:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E00B1CC
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 11:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656785828; x=1688321828;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/KJMbz1NoOnQ1M9aHPgAv2tqUcq7ou5VdcXzGezIFLw=;
  b=K1OBtPQLi53ns6Ir+qVhUE2HOLB8yayKKRvCK801PGmCN1oUWJadpFri
   XOzKd1fC0oM3/oRhEPolszGGvlB9SjMbejD7l504NJcXcq63gGAuIxa0h
   6jc4KZhKdYByLyz3rEo1LWd+GhkIPB9QPC34lgz/M7VXUYNEzYjsHrd/E
   gSjlXcd5gVP2Bsk0RTaQRovDQj/1zW9V2hPoElZLzxtj0v6BnPWGDpBAL
   dAtc00jMnCt/IOA5nLOJHavKCMQ8iwqYCDE8ScHft7lYQsBfgArRYuUkP
   VoadezZ2GLyLRQY5SCbbYzma6uKPyOOr89s4cntUMB3irMFCt3VrA8j7x
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10396"; a="265889113"
X-IronPort-AV: E=Sophos;i="5.92,240,1650956400"; 
   d="scan'208";a="265889113"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 11:17:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,240,1650956400"; 
   d="scan'208";a="768813249"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 02 Jul 2022 11:17:06 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o7hg2-000FWS-5A;
        Sat, 02 Jul 2022 18:17:06 +0000
Date:   Sun, 3 Jul 2022 02:16:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [akpm-mm:mm-unstable 321/323] include/linux/pgtable.h:1713:10:
 error: redefinition of 'vm_get_page_prot'
Message-ID: <202207030224.tqi3q1Wh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-unstable
head:   706370e5c2ea7bb4544eee6e1172c4d68117a526
commit: 5b0de55b24615b5f5f600e2a61c297a0432a5e82 [321/323] sh/mm: enable ARCH_HAS_VM_GET_PAGE_PROT
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220703/202207030224.tqi3q1Wh-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?id=5b0de55b24615b5f5f600e2a61c297a0432a5e82
        git remote add akpm-mm https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
        git fetch --no-tags akpm-mm mm-unstable
        git checkout 5b0de55b24615b5f5f600e2a61c297a0432a5e82
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/sh/include/asm/io.h:21,
                    from include/linux/io.h:13,
                    from arch/sh/mm/mmap.c:10:
>> include/linux/pgtable.h:1713:10: error: redefinition of 'vm_get_page_prot'
    1713 | pgprot_t vm_get_page_prot(unsigned long vm_flags)                       \
         |          ^~~~~~~~~~~~~~~~
   arch/sh/mm/mmap.c:184:1: note: in expansion of macro 'DECLARE_VM_GET_PAGE_PROT'
     184 | DECLARE_VM_GET_PAGE_PROT
         | ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/sh/mm/mmap.c:11:
   include/linux/mm.h:2864:24: note: previous definition of 'vm_get_page_prot' with type 'pgprot_t(long unsigned int)'
    2864 | static inline pgprot_t vm_get_page_prot(unsigned long vm_flags)
         |                        ^~~~~~~~~~~~~~~~


vim +/vm_get_page_prot +1713 include/linux/pgtable.h

c0f8aa4fa815da Daniel Axtens     2021-06-28  1691  
d3af9262355115 Anshuman Khandual 2022-06-30  1692  /* description of effects of mapping type and prot in current implementation.
d3af9262355115 Anshuman Khandual 2022-06-30  1693   * this is due to the limited x86 page protection hardware.  The expected
d3af9262355115 Anshuman Khandual 2022-06-30  1694   * behavior is in parens:
d3af9262355115 Anshuman Khandual 2022-06-30  1695   *
d3af9262355115 Anshuman Khandual 2022-06-30  1696   * map_type	prot
d3af9262355115 Anshuman Khandual 2022-06-30  1697   *		PROT_NONE	PROT_READ	PROT_WRITE	PROT_EXEC
d3af9262355115 Anshuman Khandual 2022-06-30  1698   * MAP_SHARED	r: (no) no	r: (yes) yes	r: (no) yes	r: (no) yes
d3af9262355115 Anshuman Khandual 2022-06-30  1699   *		w: (no) no	w: (no) no	w: (yes) yes	w: (no) no
d3af9262355115 Anshuman Khandual 2022-06-30  1700   *		x: (no) no	x: (no) yes	x: (no) yes	x: (yes) yes
d3af9262355115 Anshuman Khandual 2022-06-30  1701   *
d3af9262355115 Anshuman Khandual 2022-06-30  1702   * MAP_PRIVATE	r: (no) no	r: (yes) yes	r: (no) yes	r: (no) yes
d3af9262355115 Anshuman Khandual 2022-06-30  1703   *		w: (no) no	w: (no) no	w: (copy) copy	w: (no) no
d3af9262355115 Anshuman Khandual 2022-06-30  1704   *		x: (no) no	x: (no) yes	x: (no) yes	x: (yes) yes
d3af9262355115 Anshuman Khandual 2022-06-30  1705   *
d3af9262355115 Anshuman Khandual 2022-06-30  1706   * On arm64, PROT_EXEC has the following behaviour for both MAP_SHARED and
d3af9262355115 Anshuman Khandual 2022-06-30  1707   * MAP_PRIVATE (with Enhanced PAN supported):
d3af9262355115 Anshuman Khandual 2022-06-30  1708   *								r: (no) no
d3af9262355115 Anshuman Khandual 2022-06-30  1709   *								w: (no) no
d3af9262355115 Anshuman Khandual 2022-06-30  1710   *								x: (yes) yes
d3af9262355115 Anshuman Khandual 2022-06-30  1711   */
d3af9262355115 Anshuman Khandual 2022-06-30  1712  #define DECLARE_VM_GET_PAGE_PROT					\
d3af9262355115 Anshuman Khandual 2022-06-30 @1713  pgprot_t vm_get_page_prot(unsigned long vm_flags)			\
d3af9262355115 Anshuman Khandual 2022-06-30  1714  {									\
d3af9262355115 Anshuman Khandual 2022-06-30  1715  		return protection_map[vm_flags &			\
d3af9262355115 Anshuman Khandual 2022-06-30  1716  			(VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)];	\
d3af9262355115 Anshuman Khandual 2022-06-30  1717  }									\
d3af9262355115 Anshuman Khandual 2022-06-30  1718  EXPORT_SYMBOL(vm_get_page_prot);
d3af9262355115 Anshuman Khandual 2022-06-30  1719  

:::::: The code at line 1713 was first introduced by commit
:::::: d3af92623551153853497bf6434b9b4843ab78e1 mm/mmap: define DECLARE_VM_GET_PAGE_PROT

:::::: TO: Anshuman Khandual <anshuman.khandual@arm.com>
:::::: CC: akpm <akpm@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

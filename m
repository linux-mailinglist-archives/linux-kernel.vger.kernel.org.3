Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333E04E885B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 17:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbiC0PPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 11:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbiC0PPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 11:15:50 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33584EF71
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 08:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648394051; x=1679930051;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=miylXDcvB50cC7HJQyQcZZE78lqoMQ3oC3bV0lCkIgc=;
  b=nn2cyfPrbam7p8lfMliUuXaY91pwmzxKQUWkWJrbNMF9pDOlqSYN+752
   F9eOOL+hxmk0RScKqRxlnGk0aEbBQKBFqiA5gZ35Azfy6MUFWoi2rzyYV
   v303szHEs22Y+wyjp4zTLfKQfIkl0wUzO+7VQvyFVKeNTCNs5uZkLHgTG
   it6oJQ0LY/LAen5AzMGDIDIsWcZ6puMy4V09NgILZFYNSNQ5oCiowrcrp
   ZYCkv5msgJcHwvkU6Vjz1P/aznLqnv+UnSPA5FDQ/zMGP7lq3vI2l8jHF
   lGpL9kqNOkyJy4xRH4a1RDFYXN/0GP1dagUTFc29/WTWP8OYJvAMcmbDo
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="345293908"
X-IronPort-AV: E=Sophos;i="5.90,215,1643702400"; 
   d="scan'208";a="345293908"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2022 08:14:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,215,1643702400"; 
   d="scan'208";a="617553158"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 27 Mar 2022 08:14:09 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYUan-00019Q-86; Sun, 27 Mar 2022 15:14:09 +0000
Date:   Sun, 27 Mar 2022 23:13:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: mm/kasan/shadow.c:496:15: sparse: sparse: restricted
 kasan_vmalloc_flags_t degrades to integer
Message-ID: <202203272343.oME5HaYV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f022814633e1c600507b3a99691b4d624c2813f0
commit: f6e39794f4b6da7ca9b77f2f9ad11fd6f0ac83e5 kasan, vmalloc: only tag normal vmalloc allocations
date:   3 days ago
config: s390-randconfig-s031-20220327 (https://download.01.org/0day-ci/archive/20220327/202203272343.oME5HaYV-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f6e39794f4b6da7ca9b77f2f9ad11fd6f0ac83e5
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f6e39794f4b6da7ca9b77f2f9ad11fd6f0ac83e5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash mm/kasan/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> mm/kasan/shadow.c:496:15: sparse: sparse: restricted kasan_vmalloc_flags_t degrades to integer

vim +496 mm/kasan/shadow.c

   477	
   478	void *__kasan_unpoison_vmalloc(const void *start, unsigned long size,
   479				       kasan_vmalloc_flags_t flags)
   480	{
   481		/*
   482		 * Software KASAN modes unpoison both VM_ALLOC and non-VM_ALLOC
   483		 * mappings, so the KASAN_VMALLOC_VM_ALLOC flag is ignored.
   484		 * Software KASAN modes can't optimize zeroing memory by combining it
   485		 * with setting memory tags, so the KASAN_VMALLOC_INIT flag is ignored.
   486		 */
   487	
   488		if (!is_vmalloc_or_module_addr(start))
   489			return (void *)start;
   490	
   491		/*
   492		 * Don't tag executable memory with the tag-based mode.
   493		 * The kernel doesn't tolerate having the PC register tagged.
   494		 */
   495		if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) &&
 > 496		    !(flags & KASAN_VMALLOC_PROT_NORMAL))
   497			return (void *)start;
   498	
   499		start = set_tag(start, kasan_random_tag());
   500		kasan_unpoison(start, size, false);
   501		return (void *)start;
   502	}
   503	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

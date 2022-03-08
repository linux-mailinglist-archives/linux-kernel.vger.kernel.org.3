Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34604D2449
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 23:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350734AbiCHWas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 17:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350466AbiCHWam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 17:30:42 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCD458E7F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 14:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646778583; x=1678314583;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TRk1Eo2gZCKV8fdQW9OF45md6CZCd/z2S0GQ6FUa5AQ=;
  b=g02wO9P1O1DIbyBlcBsKjqe0rNzVtUWeb6ab8KQTF7TSP3KEAYStfTOj
   pWO3HjvnUleucQCagYkQRhtRB80HlV6phW//FsKK8zuoDybQEpzcBaT5E
   srZOCR1DtTzArYMaDo83I+7OpQfKwUGwkUzSV5avUgFejl+rPOHd9xFJH
   oqnFC1Kbnnz1qzLOk5aQZuT2xiRuJK2Hq+zaqGTmlVfqV4lU0MCxkwxoa
   JLPpv7TwtrU8DOm7vWKPa5FxcCw6e9F15QSHidXW+Or8//sUKO6srRoRF
   j/TjjhA78WmIsXRifcRwLn+KeAQI1p6yOYqzzLdULGSC6yBieyRTJYpt0
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="318058486"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="318058486"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 14:29:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="547428345"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 08 Mar 2022 14:29:41 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRiKq-00026T-BU; Tue, 08 Mar 2022 22:29:40 +0000
Date:   Wed, 9 Mar 2022 06:29:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: fs/proc/vmcore.c:161:34: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202203090609.4qZ5Wzhq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   92f90cc9fe0e7a984ea3d4bf3d120e30ba8a2118
commit: c1e63117711977cc4295b2ce73de29dd17066c82 proc/vmcore: fix clearing user buffer by properly using clear_user()
date:   4 months ago
config: sh-allyesconfig (https://download.01.org/0day-ci/archive/20220309/202203090609.4qZ5Wzhq-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c1e63117711977cc4295b2ce73de29dd17066c82
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c1e63117711977cc4295b2ce73de29dd17066c82
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sh SHELL=/bin/bash fs/proc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/proc/vmcore.c:161:34: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __user *__cl_addr @@     got char *buf @@
   fs/proc/vmcore.c:161:34: sparse:     expected void [noderef] __user *__cl_addr
   fs/proc/vmcore.c:161:34: sparse:     got char *buf

vim +161 fs/proc/vmcore.c

   133	
   134	/* Reads a page from the oldmem device from given offset. */
   135	ssize_t read_from_oldmem(char *buf, size_t count,
   136				 u64 *ppos, int userbuf,
   137				 bool encrypted)
   138	{
   139		unsigned long pfn, offset;
   140		size_t nr_bytes;
   141		ssize_t read = 0, tmp;
   142	
   143		if (!count)
   144			return 0;
   145	
   146		offset = (unsigned long)(*ppos % PAGE_SIZE);
   147		pfn = (unsigned long)(*ppos / PAGE_SIZE);
   148	
   149		down_read(&vmcore_cb_rwsem);
   150		do {
   151			if (count > (PAGE_SIZE - offset))
   152				nr_bytes = PAGE_SIZE - offset;
   153			else
   154				nr_bytes = count;
   155	
   156			/* If pfn is not ram, return zeros for sparse dump files */
   157			if (!pfn_is_ram(pfn)) {
   158				tmp = 0;
   159				if (!userbuf)
   160					memset(buf, 0, nr_bytes);
 > 161				else if (clear_user(buf, nr_bytes))
   162					tmp = -EFAULT;
   163			} else {
   164				if (encrypted)
   165					tmp = copy_oldmem_page_encrypted(pfn, buf,
   166									 nr_bytes,
   167									 offset,
   168									 userbuf);
   169				else
   170					tmp = copy_oldmem_page(pfn, buf, nr_bytes,
   171							       offset, userbuf);
   172			}
   173			if (tmp < 0) {
   174				up_read(&vmcore_cb_rwsem);
   175				return tmp;
   176			}
   177	
   178			*ppos += nr_bytes;
   179			count -= nr_bytes;
   180			buf += nr_bytes;
   181			read += nr_bytes;
   182			++pfn;
   183			offset = 0;
   184		} while (count);
   185	
   186		up_read(&vmcore_cb_rwsem);
   187		return read;
   188	}
   189	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

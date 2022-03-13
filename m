Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF284D75ED
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 15:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbiCMOrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 10:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbiCMOrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 10:47:09 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FDD74611
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 07:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647182762; x=1678718762;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KKwtRSWVnFwNSS506od+1D99JOfTfSDCk7eL3HhUI2M=;
  b=CGOIE+1r8W4PP815vPMnPRXIfJ5BMWQPkOhqJc5VaUuG54wwJ4ol2Fyg
   xUvBZ1bbBUDPc0ekfgs/Aw9mw7vmQBgKTsVnP7yndAwY9LNbCD3TNW6xt
   nQxXZ+PZQtmzbyDNtZ+0d6VGX/DP2sS+vHH0oEJSiO3LsYfn1AF0dSFmk
   rOUTNK5oV43/CkN12wqPS5P9u3YIWSg8jt9X9syZApdFpxuEsleYGoJVN
   mwRU/fqZXvqDYhPq/N0e/seuXsev5bxYyn4mc6Syk0VcfuAa0As/LejUy
   oKmpIVg3g4MEFLBoLzWsU6Mr0njM+A9ZJ+C38jxk5w6L1WdKfxrmJbbAb
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="235822602"
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="235822602"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 07:46:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="579851676"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 13 Mar 2022 07:45:59 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTPTq-00092M-AY; Sun, 13 Mar 2022 14:45:58 +0000
Date:   Sun, 13 Mar 2022 22:45:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hare-scsi-devel:tls-upcall.v4 155/156] lib/iov_iter.c:1782:46:
 sparse: sparse: incorrect type in argument 2 (different address spaces)
Message-ID: <202203132257.6GlVo2BL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git tls-upcall.v4
head:   d2416ecdb6b03fc2e4aa40b20cdf919322713224
commit: 921f6399790df513118d6c1aa829d4e9fab5131c [155/156] lib/iov_iter: add hash_iov_iter()
config: microblaze-randconfig-s032-20220313 (https://download.01.org/0day-ci/archive/20220313/202203132257.6GlVo2BL-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=921f6399790df513118d6c1aa829d4e9fab5131c
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel tls-upcall.v4
        git checkout 921f6399790df513118d6c1aa829d4e9fab5131c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=microblaze SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> lib/iov_iter.c:1782:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got void [noderef] __user * @@
   lib/iov_iter.c:1782:46: sparse:     expected void const *
   lib/iov_iter.c:1782:46: sparse:     got void [noderef] __user *
   lib/iov_iter.c: note: in included file:
   include/net/checksum.h:31:39: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __wsum [usertype] sum @@     got unsigned int @@
   include/net/checksum.h:31:39: sparse:     expected restricted __wsum [usertype] sum
   include/net/checksum.h:31:39: sparse:     got unsigned int
   include/net/checksum.h:39:45: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __wsum [usertype] sum @@     got unsigned int @@
   include/net/checksum.h:39:45: sparse:     expected restricted __wsum [usertype] sum
   include/net/checksum.h:39:45: sparse:     got unsigned int

vim +1782 lib/iov_iter.c

  1767	
  1768	size_t hash_iov_iter(void *hashp, const struct iov_iter *i)
  1769	{
  1770	#ifdef CONFIG_CRYPTO_HASH
  1771		struct ahash_request *hash = hashp;
  1772		size_t skip = i->iov_offset, size = i->count;
  1773		const struct iovec *p;
  1774	
  1775		for (p = i->iov; size; skip = 0, p++) {
  1776			struct scatterlist sg;
  1777			unsigned offs = offset_in_page(p->iov_base + skip);
  1778			size_t len = min(p->iov_len - skip, size);
  1779	
  1780			if (!len)
  1781				continue;
> 1782			sg_init_one(&sg, p->iov_base + offs, len);
  1783			ahash_request_set_crypt(hash, &sg, NULL, len);
  1784			crypto_ahash_update(hash);
  1785			size -= len;
  1786		}
  1787		return i->count;
  1788	#else
  1789		return 0;
  1790	#endif
  1791	}
  1792	EXPORT_SYMBOL(hash_iov_iter);
  1793	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

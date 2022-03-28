Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF92C4E9A15
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 16:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244059AbiC1OvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 10:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242843AbiC1OvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 10:51:05 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939823ED31
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 07:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648478964; x=1680014964;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HO/Ta6xgsxWlSe1ppAZnjsR7g6TanwH+tQdb+CpTSfA=;
  b=TvzMRvZg3hxxrOoBYomgpqLvvsc+QZMlFqlT+FWuWfhQQVTHo3UxWNGT
   eKIRlv7U7kaoDyl66KbahyejiIhK4+fHELeVdz2LzfmHcjpPohQJo3Wz5
   7OoPyhphctGx6gDR8uPlrz9x9KZMMA6KYFTuisGaw4I+uHjWrWo+r0EkO
   G6xVr2lTf8YqbNFBkzQ4Y8IUtdhTxiYvtSuy8a9hP1rtKrwnSMkvFs7rt
   DoqhwefO9+ogPc2SkDeWybaHPR599YjyIyE/yFDSyVcMYIwdD6J7N90Do
   6dy0SZ+8D6/HJhWPT8t0EF7gBkr++OsboQuNh/V98lHRaIgtaoZ23fN3X
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="258728691"
X-IronPort-AV: E=Sophos;i="5.90,217,1643702400"; 
   d="scan'208";a="258728691"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 07:49:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,217,1643702400"; 
   d="scan'208";a="719136605"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 28 Mar 2022 07:49:22 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYqgL-00026T-OQ; Mon, 28 Mar 2022 14:49:21 +0000
Date:   Mon, 28 Mar 2022 22:48:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/acpi/apei/erst.c:792:9: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202203282235.ONsTh0Y7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ae085d7f9365de7da27ab5c0d16b12d51ea7fca9
commit: f68f2ff91512c199ec24883001245912afc17873 fortify: Detect struct member overflows in memcpy() at compile-time
date:   6 weeks ago
config: i386-randconfig-s001-20220328 (https://download.01.org/0day-ci/archive/20220328/202203282235.ONsTh0Y7-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f68f2ff91512c199ec24883001245912afc17873
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f68f2ff91512c199ec24883001245912afc17873
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/acpi/apei/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/acpi/apei/erst.c:272:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *src @@     got void [noderef] __iomem * @@
   drivers/acpi/apei/erst.c:272:13: sparse:     expected void *src
   drivers/acpi/apei/erst.c:272:13: sparse:     got void [noderef] __iomem *
   drivers/acpi/apei/erst.c:275:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *dst @@     got void [noderef] __iomem * @@
   drivers/acpi/apei/erst.c:275:13: sparse:     expected void *dst
   drivers/acpi/apei/erst.c:275:13: sparse:     got void [noderef] __iomem *
   drivers/acpi/apei/erst.c:277:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *src @@
   drivers/acpi/apei/erst.c:277:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/acpi/apei/erst.c:277:25: sparse:     got void *src
   drivers/acpi/apei/erst.c:283:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *src @@
   drivers/acpi/apei/erst.c:283:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/acpi/apei/erst.c:283:17: sparse:     got void *src
   drivers/acpi/apei/erst.c:284:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *dst @@
   drivers/acpi/apei/erst.c:284:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/acpi/apei/erst.c:284:17: sparse:     got void *dst
>> drivers/acpi/apei/erst.c:792:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *static [toplevel] vaddr @@
   drivers/acpi/apei/erst.c:792:9: sparse:     expected void const *
   drivers/acpi/apei/erst.c:792:9: sparse:     got void [noderef] __iomem *static [toplevel] vaddr
>> drivers/acpi/apei/erst.c:792:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *static [toplevel] vaddr @@
   drivers/acpi/apei/erst.c:792:9: sparse:     expected void const *
   drivers/acpi/apei/erst.c:792:9: sparse:     got void [noderef] __iomem *static [toplevel] vaddr
   drivers/acpi/apei/erst.c:792:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *static [toplevel] vaddr @@
   drivers/acpi/apei/erst.c:792:9: sparse:     expected void *
   drivers/acpi/apei/erst.c:792:9: sparse:     got void [noderef] __iomem *static [toplevel] vaddr
   drivers/acpi/apei/erst.c:793:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cper_record_header *rcd_erange @@     got void [noderef] __iomem *static [toplevel] vaddr @@
   drivers/acpi/apei/erst.c:793:20: sparse:     expected struct cper_record_header *rcd_erange
   drivers/acpi/apei/erst.c:793:20: sparse:     got void [noderef] __iomem *static [toplevel] vaddr
   drivers/acpi/apei/erst.c:830:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cper_record_header *rcd_tmp @@     got void [noderef] __iomem * @@
   drivers/acpi/apei/erst.c:830:17: sparse:     expected struct cper_record_header *rcd_tmp
   drivers/acpi/apei/erst.c:830:17: sparse:     got void [noderef] __iomem *

vim +792 drivers/acpi/apei/erst.c

a08f82d08053fb Huang Ying 2010-05-18  766  
a08f82d08053fb Huang Ying 2010-05-18  767  int erst_write(const struct cper_record_header *record)
a08f82d08053fb Huang Ying 2010-05-18  768  {
a08f82d08053fb Huang Ying 2010-05-18  769  	int rc;
a08f82d08053fb Huang Ying 2010-05-18  770  	unsigned long flags;
a08f82d08053fb Huang Ying 2010-05-18  771  	struct cper_record_header *rcd_erange;
a08f82d08053fb Huang Ying 2010-05-18  772  
a08f82d08053fb Huang Ying 2010-05-18  773  	if (erst_disable)
a08f82d08053fb Huang Ying 2010-05-18  774  		return -ENODEV;
a08f82d08053fb Huang Ying 2010-05-18  775  
a08f82d08053fb Huang Ying 2010-05-18  776  	if (memcmp(record->signature, CPER_SIG_RECORD, CPER_SIG_SIZE))
a08f82d08053fb Huang Ying 2010-05-18  777  		return -EINVAL;
a08f82d08053fb Huang Ying 2010-05-18  778  
a08f82d08053fb Huang Ying 2010-05-18  779  	if (erst_erange.attr & ERST_RANGE_NVRAM) {
3b38bb5f7f0635 Huang Ying 2010-12-02  780  		if (!raw_spin_trylock_irqsave(&erst_lock, flags))
a08f82d08053fb Huang Ying 2010-05-18  781  			return -EBUSY;
a08f82d08053fb Huang Ying 2010-05-18  782  		rc = __erst_write_to_nvram(record);
3b38bb5f7f0635 Huang Ying 2010-12-02  783  		raw_spin_unlock_irqrestore(&erst_lock, flags);
a08f82d08053fb Huang Ying 2010-05-18  784  		return rc;
a08f82d08053fb Huang Ying 2010-05-18  785  	}
a08f82d08053fb Huang Ying 2010-05-18  786  
a08f82d08053fb Huang Ying 2010-05-18  787  	if (record->record_length > erst_erange.size)
a08f82d08053fb Huang Ying 2010-05-18  788  		return -EINVAL;
a08f82d08053fb Huang Ying 2010-05-18  789  
3b38bb5f7f0635 Huang Ying 2010-12-02  790  	if (!raw_spin_trylock_irqsave(&erst_lock, flags))
a08f82d08053fb Huang Ying 2010-05-18  791  		return -EBUSY;
a08f82d08053fb Huang Ying 2010-05-18 @792  	memcpy(erst_erange.vaddr, record, record->record_length);
a08f82d08053fb Huang Ying 2010-05-18  793  	rcd_erange = erst_erange.vaddr;
a08f82d08053fb Huang Ying 2010-05-18  794  	/* signature for serialization system */
a08f82d08053fb Huang Ying 2010-05-18  795  	memcpy(&rcd_erange->persistence_information, "ER", 2);
a08f82d08053fb Huang Ying 2010-05-18  796  
a08f82d08053fb Huang Ying 2010-05-18  797  	rc = __erst_write_to_storage(0);
3b38bb5f7f0635 Huang Ying 2010-12-02  798  	raw_spin_unlock_irqrestore(&erst_lock, flags);
a08f82d08053fb Huang Ying 2010-05-18  799  
a08f82d08053fb Huang Ying 2010-05-18  800  	return rc;
a08f82d08053fb Huang Ying 2010-05-18  801  }
a08f82d08053fb Huang Ying 2010-05-18  802  EXPORT_SYMBOL_GPL(erst_write);
a08f82d08053fb Huang Ying 2010-05-18  803  

:::::: The code at line 792 was first introduced by commit
:::::: a08f82d08053fb6e3aa3635c2c26456d96337c8b ACPI, APEI, Error Record Serialization Table (ERST) support

:::::: TO: Huang Ying <ying.huang@intel.com>
:::::: CC: Len Brown <len.brown@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

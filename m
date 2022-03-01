Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB2D4C8724
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 09:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbiCAIxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 03:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiCAIxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:53:49 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069254990A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 00:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646124787; x=1677660787;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=c8/sIm6fc7U1kkTUXfw+1nD3JapE3ktEr9Pg6yxNBG4=;
  b=Zt9Baau301n60jYtHPtq/vs2bEJFPvAyZESzcr9zlX5xy8HXRXsjovW0
   RtzxNje/p4PW1MMQj3iWreiJ4+U1zTY48tQ1SIOuf9AXQ45GZeonKRNKF
   Nthg9UjMh/7KlEiNi6C0mMyUX2RTt3uEerwRibCdU3EfX9xCQjgcQhXJP
   injYzgafQ1L2kc3B9Ajec9jrtVRCUv5IdMZhGiKx6dAgupH8j6dBBF7vy
   TiqvdhR6IK/DdfTzFc31J+V0SgFjKn08OBmXjOC3xRQPuL7WBVGGX083U
   Q653YOJ0uFgyazpjnn/e2e3yuesvEab/HfsDd0cF80JwqnSGSWbxdf6m3
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="313811736"
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="313811736"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 00:53:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="575628442"
Received: from lkp-server01.sh.intel.com (HELO 2146afe809fb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 01 Mar 2022 00:53:06 -0800
Received: from kbuild by 2146afe809fb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOyFl-0000CX-DG; Tue, 01 Mar 2022 08:53:05 +0000
Date:   Tue, 1 Mar 2022 16:52:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [mcgrof:modules-testing 7/14] security/integrity/ima/ima_main.c:799:
 undefined reference to `is_module_sig_enforced'
Message-ID: <202203011657.jvIKXd3v-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git modules-testing
head:   8ca5e1dab7c3e51c63f07cd86e004a4df9ac7e76
commit: 6fbb12ccf3a340cf8bbd224e36106d1eccfcc54c [7/14] module: Move extra signature support out of core code
config: i386-randconfig-c001 (https://download.01.org/0day-ci/archive/20220301/202203011657.jvIKXd3v-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?id=6fbb12ccf3a340cf8bbd224e36106d1eccfcc54c
        git remote add mcgrof https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git
        git fetch --no-tags mcgrof modules-testing
        git checkout 6fbb12ccf3a340cf8bbd224e36106d1eccfcc54c
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: security/integrity/ima/ima_main.o: in function `ima_load_data':
>> security/integrity/ima/ima_main.c:799: undefined reference to `is_module_sig_enforced'


vim +799 security/integrity/ima/ima_main.c

5a9196d715607f Mimi Zohar          2014-07-22  759  
16c267aac86b46 Mimi Zohar          2018-07-13  760  /**
16c267aac86b46 Mimi Zohar          2018-07-13  761   * ima_load_data - appraise decision based on policy
16c267aac86b46 Mimi Zohar          2018-07-13  762   * @id: kernel load data caller identifier
b64fcae74b6d69 Kees Cook           2020-10-02  763   * @contents: whether the full contents will be available in a later
b64fcae74b6d69 Kees Cook           2020-10-02  764   *	      call to ima_post_load_data().
16c267aac86b46 Mimi Zohar          2018-07-13  765   *
16c267aac86b46 Mimi Zohar          2018-07-13  766   * Callers of this LSM hook can not measure, appraise, or audit the
16c267aac86b46 Mimi Zohar          2018-07-13  767   * data provided by userspace.  Enforce policy rules requring a file
16c267aac86b46 Mimi Zohar          2018-07-13  768   * signature (eg. kexec'ed kernel image).
16c267aac86b46 Mimi Zohar          2018-07-13  769   *
16c267aac86b46 Mimi Zohar          2018-07-13  770   * For permission return 0, otherwise return -EACCES.
16c267aac86b46 Mimi Zohar          2018-07-13  771   */
b64fcae74b6d69 Kees Cook           2020-10-02  772  int ima_load_data(enum kernel_load_data_id id, bool contents)
16c267aac86b46 Mimi Zohar          2018-07-13  773  {
b5ca117365d960 Nayna Jain          2018-10-09  774  	bool ima_enforce, sig_enforce;
c77b8cdf745d91 Mimi Zohar          2018-07-13  775  
b5ca117365d960 Nayna Jain          2018-10-09  776  	ima_enforce =
b5ca117365d960 Nayna Jain          2018-10-09  777  		(ima_appraise & IMA_APPRAISE_ENFORCE) == IMA_APPRAISE_ENFORCE;
16c267aac86b46 Mimi Zohar          2018-07-13  778  
16c267aac86b46 Mimi Zohar          2018-07-13  779  	switch (id) {
16c267aac86b46 Mimi Zohar          2018-07-13  780  	case LOADING_KEXEC_IMAGE:
99d5cadfde2b1a Jiri Bohac          2019-08-19  781  		if (IS_ENABLED(CONFIG_KEXEC_SIG)
b5ca117365d960 Nayna Jain          2018-10-09  782  		    && arch_ima_get_secureboot()) {
b5ca117365d960 Nayna Jain          2018-10-09  783  			pr_err("impossible to appraise a kernel image without a file descriptor; try using kexec_file_load syscall.\n");
b5ca117365d960 Nayna Jain          2018-10-09  784  			return -EACCES;
b5ca117365d960 Nayna Jain          2018-10-09  785  		}
b5ca117365d960 Nayna Jain          2018-10-09  786  
b5ca117365d960 Nayna Jain          2018-10-09  787  		if (ima_enforce && (ima_appraise & IMA_APPRAISE_KEXEC)) {
16c267aac86b46 Mimi Zohar          2018-07-13  788  			pr_err("impossible to appraise a kernel image without a file descriptor; try using kexec_file_load syscall.\n");
16c267aac86b46 Mimi Zohar          2018-07-13  789  			return -EACCES;	/* INTEGRITY_UNKNOWN */
16c267aac86b46 Mimi Zohar          2018-07-13  790  		}
fed2512a7ccc8f Mimi Zohar          2018-07-13  791  		break;
fed2512a7ccc8f Mimi Zohar          2018-07-13  792  	case LOADING_FIRMWARE:
4f2d99b06b7380 Kees Cook           2020-10-02  793  		if (ima_enforce && (ima_appraise & IMA_APPRAISE_FIRMWARE) && !contents) {
fed2512a7ccc8f Mimi Zohar          2018-07-13  794  			pr_err("Prevent firmware sysfs fallback loading.\n");
fed2512a7ccc8f Mimi Zohar          2018-07-13  795  			return -EACCES;	/* INTEGRITY_UNKNOWN */
fed2512a7ccc8f Mimi Zohar          2018-07-13  796  		}
c77b8cdf745d91 Mimi Zohar          2018-07-13  797  		break;
c77b8cdf745d91 Mimi Zohar          2018-07-13  798  	case LOADING_MODULE:
c77b8cdf745d91 Mimi Zohar          2018-07-13 @799  		sig_enforce = is_module_sig_enforced();
c77b8cdf745d91 Mimi Zohar          2018-07-13  800  
b5ca117365d960 Nayna Jain          2018-10-09  801  		if (ima_enforce && (!sig_enforce
b5ca117365d960 Nayna Jain          2018-10-09  802  				    && (ima_appraise & IMA_APPRAISE_MODULES))) {
c77b8cdf745d91 Mimi Zohar          2018-07-13  803  			pr_err("impossible to appraise a module without a file descriptor. sig_enforce kernel parameter might help\n");
c77b8cdf745d91 Mimi Zohar          2018-07-13  804  			return -EACCES;	/* INTEGRITY_UNKNOWN */
c77b8cdf745d91 Mimi Zohar          2018-07-13  805  		}
28073eb09c5aa2 Gustavo A. R. Silva 2020-11-20  806  		break;
16c267aac86b46 Mimi Zohar          2018-07-13  807  	default:
16c267aac86b46 Mimi Zohar          2018-07-13  808  		break;
16c267aac86b46 Mimi Zohar          2018-07-13  809  	}
16c267aac86b46 Mimi Zohar          2018-07-13  810  	return 0;
16c267aac86b46 Mimi Zohar          2018-07-13  811  }
16c267aac86b46 Mimi Zohar          2018-07-13  812  

:::::: The code at line 799 was first introduced by commit
:::::: c77b8cdf745d91eca138e7bfa430dc6640b604a0 module: replace the existing LSM hook in init_module

:::::: TO: Mimi Zohar <zohar@linux.vnet.ibm.com>
:::::: CC: James Morris <james.morris@microsoft.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

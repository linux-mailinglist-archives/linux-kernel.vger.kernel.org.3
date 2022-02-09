Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECEC4AFBCA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 19:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240960AbiBISuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 13:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241012AbiBIStW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 13:49:22 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB965C1DC73E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 10:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644432306; x=1675968306;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NTKBgItqon3PHpzAhmJ9GKn354TNjgrjBMYjIi+U0GE=;
  b=D1fa/Cyg77a1JFAewHB4JA/J/wV3PEzilEia9u6uMyXosHqBR/uUpUFg
   jX23zihozNT1gqiSjwJwcLzpO/lTeJ3b6O7ct25m66PJBtHf++XHrL5O8
   rp8+qU0iFYfOR7HRrXdT9cu7pYxHQjxnMcUTmZluZfGDtqO3sf5CZslJg
   UgAoU4Bgccfy3nFoEqAkquC4Mti2rMdZQeyDmH0F8278USN7lkhYOEvy4
   55usmpnJ8PKOquEh2TIjMxB//82mhpMz8WGGpEGTubfT7Pf91VMuxr8Lo
   R7RhJ2YScjyxtLRXgIkKXvYJSQL10wSIHbah7bUwrIWVEnwe5L4cYh4L6
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="229274598"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="229274598"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 10:45:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="701368970"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 09 Feb 2022 10:45:04 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHrxf-0002B0-VJ; Wed, 09 Feb 2022 18:45:03 +0000
Date:   Thu, 10 Feb 2022 02:44:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ardb:efi-psci 2/3] include/linux/efi.h:1190:9: error: implicit
 declaration of function 'arch_efi_call_virt_setup'
Message-ID: <202202100235.AZGXkf7b-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git efi-psci
head:   bd0da69cbeaed7490a6f8e3df789fe72645cd37f
commit: 2f97f24371a482f0273be1de7164eb59cd427cf9 [2/3] efi: arm: implement PSCI method backed by EFI runtime code
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20220210/202202100235.AZGXkf7b-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=2f97f24371a482f0273be1de7164eb59cd427cf9
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb efi-psci
        git checkout 2f97f24371a482f0273be1de7164eb59cd427cf9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/firmware/psci/psci.c:12:
   drivers/firmware/psci/psci.c: In function '__invoke_psci_fn_efi':
>> include/linux/efi.h:1190:9: error: implicit declaration of function 'arch_efi_call_virt_setup' [-Werror=implicit-function-declaration]
    1190 |         arch_efi_call_virt_setup();                                     \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/firmware/psci/psci.c:139:16: note: in expansion of macro 'efi_call_virt_pointer'
     139 |         return efi_call_virt_pointer((&efi_psci), psci_handler, function_id,
         |                ^~~~~~~~~~~~~~~~~~~~~
>> include/linux/efi.h:1193:15: error: implicit declaration of function 'arch_efi_call_virt' [-Werror=implicit-function-declaration]
    1193 |         __s = arch_efi_call_virt(p, f, args);                           \
         |               ^~~~~~~~~~~~~~~~~~
   drivers/firmware/psci/psci.c:139:16: note: in expansion of macro 'efi_call_virt_pointer'
     139 |         return efi_call_virt_pointer((&efi_psci), psci_handler, function_id,
         |                ^~~~~~~~~~~~~~~~~~~~~
>> drivers/firmware/psci/psci.c:139:51: error: 'psci_handler' undeclared (first use in this function); did you mean 'proc_handler'?
     139 |         return efi_call_virt_pointer((&efi_psci), psci_handler, function_id,
         |                                                   ^~~~~~~~~~~~
   include/linux/efi.h:1193:37: note: in definition of macro 'efi_call_virt_pointer'
    1193 |         __s = arch_efi_call_virt(p, f, args);                           \
         |                                     ^
   drivers/firmware/psci/psci.c:139:51: note: each undeclared identifier is reported only once for each function it appears in
     139 |         return efi_call_virt_pointer((&efi_psci), psci_handler, function_id,
         |                                                   ^~~~~~~~~~~~
   include/linux/efi.h:1193:37: note: in definition of macro 'efi_call_virt_pointer'
    1193 |         __s = arch_efi_call_virt(p, f, args);                           \
         |                                     ^
>> include/linux/efi.h:1196:9: error: implicit declaration of function 'arch_efi_call_virt_teardown' [-Werror=implicit-function-declaration]
    1196 |         arch_efi_call_virt_teardown();                                  \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/firmware/psci/psci.c:139:16: note: in expansion of macro 'efi_call_virt_pointer'
     139 |         return efi_call_virt_pointer((&efi_psci), psci_handler, function_id,
         |                ^~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/arch_efi_call_virt_setup +1190 include/linux/efi.h

0d95981438c3bdb Dominik Brodowski 2019-11-06  1164  
80e75596079f0a4 Alex Thorlton     2016-06-25  1165  /*
80e75596079f0a4 Alex Thorlton     2016-06-25  1166   * Arch code can implement the following three template macros, avoiding
80e75596079f0a4 Alex Thorlton     2016-06-25  1167   * reptition for the void/non-void return cases of {__,}efi_call_virt():
80e75596079f0a4 Alex Thorlton     2016-06-25  1168   *
80e75596079f0a4 Alex Thorlton     2016-06-25  1169   *  * arch_efi_call_virt_setup()
80e75596079f0a4 Alex Thorlton     2016-06-25  1170   *
80e75596079f0a4 Alex Thorlton     2016-06-25  1171   *    Sets up the environment for the call (e.g. switching page tables,
80e75596079f0a4 Alex Thorlton     2016-06-25  1172   *    allowing kernel-mode use of floating point, if required).
80e75596079f0a4 Alex Thorlton     2016-06-25  1173   *
80e75596079f0a4 Alex Thorlton     2016-06-25  1174   *  * arch_efi_call_virt()
80e75596079f0a4 Alex Thorlton     2016-06-25  1175   *
80e75596079f0a4 Alex Thorlton     2016-06-25  1176   *    Performs the call. The last expression in the macro must be the call
80e75596079f0a4 Alex Thorlton     2016-06-25  1177   *    itself, allowing the logic to be shared by the void and non-void
80e75596079f0a4 Alex Thorlton     2016-06-25  1178   *    cases.
80e75596079f0a4 Alex Thorlton     2016-06-25  1179   *
80e75596079f0a4 Alex Thorlton     2016-06-25  1180   *  * arch_efi_call_virt_teardown()
80e75596079f0a4 Alex Thorlton     2016-06-25  1181   *
80e75596079f0a4 Alex Thorlton     2016-06-25  1182   *    Restores the usual kernel environment once the call has returned.
80e75596079f0a4 Alex Thorlton     2016-06-25  1183   */
80e75596079f0a4 Alex Thorlton     2016-06-25  1184  
80e75596079f0a4 Alex Thorlton     2016-06-25  1185  #define efi_call_virt_pointer(p, f, args...)				\
80e75596079f0a4 Alex Thorlton     2016-06-25  1186  ({									\
80e75596079f0a4 Alex Thorlton     2016-06-25  1187  	efi_status_t __s;						\
80e75596079f0a4 Alex Thorlton     2016-06-25  1188  	unsigned long __flags;						\
80e75596079f0a4 Alex Thorlton     2016-06-25  1189  									\
80e75596079f0a4 Alex Thorlton     2016-06-25 @1190  	arch_efi_call_virt_setup();					\
80e75596079f0a4 Alex Thorlton     2016-06-25  1191  									\
13b210ddf474d9f Julien Thierry    2019-01-31  1192  	__flags = efi_call_virt_save_flags();				\
80e75596079f0a4 Alex Thorlton     2016-06-25 @1193  	__s = arch_efi_call_virt(p, f, args);				\
80e75596079f0a4 Alex Thorlton     2016-06-25  1194  	efi_call_virt_check_flags(__flags, __stringify(f));		\
80e75596079f0a4 Alex Thorlton     2016-06-25  1195  									\
80e75596079f0a4 Alex Thorlton     2016-06-25 @1196  	arch_efi_call_virt_teardown();					\
80e75596079f0a4 Alex Thorlton     2016-06-25  1197  									\
80e75596079f0a4 Alex Thorlton     2016-06-25  1198  	__s;								\
80e75596079f0a4 Alex Thorlton     2016-06-25  1199  })
80e75596079f0a4 Alex Thorlton     2016-06-25  1200  

:::::: The code at line 1190 was first introduced by commit
:::::: 80e75596079f0a41f905836ad0ccaac68ba33612 efi: Convert efi_call_virt() to efi_call_virt_pointer()

:::::: TO: Alex Thorlton <athorlton@sgi.com>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

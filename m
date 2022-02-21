Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2632F4BEB8F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 21:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbiBUUHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 15:07:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbiBUUHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 15:07:07 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F135F3BC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 12:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645474001; x=1677010001;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SnZdKRUGIwFMxCAE+z1wkh4G7uVr71yCss8FGuCQ9BY=;
  b=C49rT14YPyHgruQQWutnkamRdxqBauRhhpYO11p46h//HkI0zzqrYo9O
   6wM1caWDh+mEgOwOQgwtTvt5qtWTf2sRytAK0yS6VItmFMcCxQ5+lkzFd
   geGlQipXQKlNqFpC8u5d4HsV4hzreTUgjXo3ayzebuWTfPhLNMqVMBjOj
   ioZmtwdIaqRNkXhG5ZT7FeGOkxjTxh8X3K1bBUAJp6jhNAudMZzLui9g4
   jRsNXBm3sHZk9EvxdgVZeyNMid2VidEhtY9w0/v8ej5jrx5ZUpYp0fr/8
   PRkYL0R2wR3umVpEMzbL3SgRlaT0CQggx9rnQz7aZ6lYa9/lzBYcmN5zn
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="235103631"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="235103631"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 12:06:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="591063019"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 21 Feb 2022 12:06:39 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMExC-0001w8-MW; Mon, 21 Feb 2022 20:06:38 +0000
Date:   Tue, 22 Feb 2022 04:06:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: drivers/firmware/efi/test/efi_test.c:157:13: sparse: sparse:
 incorrect type in initializer (different address spaces)
Message-ID: <202202220425.F6EQP4rw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Atish,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cfb92440ee71adcc2105b0890bb01ac3cddb8507
commit: d7071743db31b4f6898b1c742e4b451bb4bc4b02 RISC-V: Add EFI stub support.
date:   1 year, 5 months ago
config: riscv-randconfig-s032-20220221 (https://download.01.org/0day-ci/archive/20220222/202202220425.F6EQP4rw-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d7071743db31b4f6898b1c742e4b451bb4bc4b02
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d7071743db31b4f6898b1c742e4b451bb4bc4b02
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash drivers/firmware/efi/test/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/firmware/efi/test/efi_test.c:157:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__p @@     got unsigned long *[addressable] data_size @@
   drivers/firmware/efi/test/efi_test.c:157:13: sparse:     expected unsigned long const [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:157:13: sparse:     got unsigned long *[addressable] data_size
   drivers/firmware/efi/test/efi_test.c:160:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct guid_t [usertype] *[addressable] vendor_guid @@
   drivers/firmware/efi/test/efi_test.c:160:61: sparse:     expected void const [noderef] __user *from
   drivers/firmware/efi/test/efi_test.c:160:61: sparse:     got struct guid_t [usertype] *[addressable] vendor_guid
   drivers/firmware/efi/test/efi_test.c:167:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected unsigned short [noderef] [usertype] __user *src @@     got unsigned short [usertype] *[addressable] variable_name @@
   drivers/firmware/efi/test/efi_test.c:167:60: sparse:     expected unsigned short [noderef] [usertype] __user *src
   drivers/firmware/efi/test/efi_test.c:167:60: sparse:     got unsigned short [usertype] *[addressable] variable_name
>> drivers/firmware/efi/test/efi_test.c:187:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__p @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:187:13: sparse:     expected unsigned long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:187:13: sparse:     got unsigned long [usertype] *[addressable] status
>> drivers/firmware/efi/test/efi_test.c:194:35: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__p @@     got unsigned long *[addressable] data_size @@
   drivers/firmware/efi/test/efi_test.c:194:35: sparse:     expected unsigned long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:194:35: sparse:     got unsigned long *[addressable] data_size
   drivers/firmware/efi/test/efi_test.c:209:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got void *[addressable] data @@
   drivers/firmware/efi/test/efi_test.c:209:45: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:209:45: sparse:     got void *[addressable] data
>> drivers/firmware/efi/test/efi_test.c:215:19: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__p @@     got unsigned int [usertype] *[addressable] attributes @@
   drivers/firmware/efi/test/efi_test.c:215:19: sparse:     expected unsigned int [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:215:19: sparse:     got unsigned int [usertype] *[addressable] attributes
   drivers/firmware/efi/test/efi_test.c:220:19: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__p @@     got unsigned long *[addressable] data_size @@
   drivers/firmware/efi/test/efi_test.c:220:19: sparse:     expected unsigned long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:220:19: sparse:     got unsigned long *[addressable] data_size
   drivers/firmware/efi/test/efi_test.c:243:53: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct guid_t [usertype] *[addressable] vendor_guid @@
   drivers/firmware/efi/test/efi_test.c:243:53: sparse:     expected void const [noderef] __user *from
   drivers/firmware/efi/test/efi_test.c:243:53: sparse:     got struct guid_t [usertype] *[addressable] vendor_guid
   drivers/firmware/efi/test/efi_test.c:248:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected unsigned short [noderef] [usertype] __user *src @@     got unsigned short [usertype] *[addressable] variable_name @@
   drivers/firmware/efi/test/efi_test.c:248:60: sparse:     expected unsigned short [noderef] [usertype] __user *src
   drivers/firmware/efi/test/efi_test.c:248:60: sparse:     got unsigned short [usertype] *[addressable] variable_name
   drivers/firmware/efi/test/efi_test.c:253:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __user * @@     got void *[addressable] data @@
   drivers/firmware/efi/test/efi_test.c:253:39: sparse:     expected void const [noderef] __user *
   drivers/firmware/efi/test/efi_test.c:253:39: sparse:     got void *[addressable] data
   drivers/firmware/efi/test/efi_test.c:263:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__p @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:263:13: sparse:     expected unsigned long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:263:13: sparse:     got unsigned long [usertype] *[addressable] status
   drivers/firmware/efi/test/efi_test.c:292:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__p @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:292:13: sparse:     expected unsigned long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:292:13: sparse:     got unsigned long [usertype] *[addressable] status
   drivers/firmware/efi/test/efi_test.c:301:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct efi_time_cap_t [noderef] [usertype] __user *cap_local @@     got struct efi_time_cap_t [usertype] * @@
   drivers/firmware/efi/test/efi_test.c:301:27: sparse:     expected struct efi_time_cap_t [noderef] [usertype] __user *cap_local
   drivers/firmware/efi/test/efi_test.c:301:27: sparse:     got struct efi_time_cap_t [usertype] *
   drivers/firmware/efi/test/efi_test.c:308:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got struct efi_time_t [usertype] *[addressable] time @@
   drivers/firmware/efi/test/efi_test.c:308:41: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:308:41: sparse:     got struct efi_time_t [usertype] *[addressable] time
   drivers/firmware/efi/test/efi_test.c:325:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct efi_time_t [usertype] *[addressable] time @@
   drivers/firmware/efi/test/efi_test.c:325:46: sparse:     expected void const [noderef] __user *from
   drivers/firmware/efi/test/efi_test.c:325:46: sparse:     got struct efi_time_t [usertype] *[addressable] time
   drivers/firmware/efi/test/efi_test.c:330:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__p @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:330:13: sparse:     expected unsigned long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:330:13: sparse:     got unsigned long [usertype] *[addressable] status
   drivers/firmware/efi/test/efi_test.c:354:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__p @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:354:13: sparse:     expected unsigned long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:354:13: sparse:     got unsigned long [usertype] *[addressable] status
>> drivers/firmware/efi/test/efi_test.c:360:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char [noderef] __user *__p @@     got unsigned char [usertype] *[addressable] enabled @@
   drivers/firmware/efi/test/efi_test.c:360:38: sparse:     expected unsigned char [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:360:38: sparse:     got unsigned char [usertype] *[addressable] enabled
   drivers/firmware/efi/test/efi_test.c:365:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got struct efi_time_t [usertype] *[addressable] time @@
   drivers/firmware/efi/test/efi_test.c:365:47: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:365:47: sparse:     got struct efi_time_t [usertype] *[addressable] time
   drivers/firmware/efi/test/efi_test.c:389:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct efi_time_t [usertype] *[addressable] time @@
   drivers/firmware/efi/test/efi_test.c:389:60: sparse:     expected void const [noderef] __user *from
   drivers/firmware/efi/test/efi_test.c:389:60: sparse:     got struct efi_time_t [usertype] *[addressable] time
   drivers/firmware/efi/test/efi_test.c:397:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__p @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:397:13: sparse:     expected unsigned long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:397:13: sparse:     got unsigned long [usertype] *[addressable] status
>> drivers/firmware/efi/test/efi_test.c:421:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__p @@     got unsigned long *[addressable] variable_name_size @@
   drivers/firmware/efi/test/efi_test.c:421:21: sparse:     expected unsigned long const [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:421:21: sparse:     got unsigned long *[addressable] variable_name_size
   drivers/firmware/efi/test/efi_test.c:429:52: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct guid_t [usertype] *[addressable] vendor_guid @@
   drivers/firmware/efi/test/efi_test.c:429:52: sparse:     expected void const [noderef] __user *from
   drivers/firmware/efi/test/efi_test.c:429:52: sparse:     got struct guid_t [usertype] *[addressable] vendor_guid
   drivers/firmware/efi/test/efi_test.c:439:52: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short [noderef] [usertype] __user *src @@     got unsigned short [usertype] *[addressable] variable_name @@
   drivers/firmware/efi/test/efi_test.c:439:52: sparse:     expected unsigned short [noderef] [usertype] __user *src
   drivers/firmware/efi/test/efi_test.c:439:52: sparse:     got unsigned short [usertype] *[addressable] variable_name
   drivers/firmware/efi/test/efi_test.c:452:52: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected unsigned short [noderef] [usertype] __user *src @@     got unsigned short [usertype] *[addressable] variable_name @@
   drivers/firmware/efi/test/efi_test.c:452:52: sparse:     expected unsigned short [noderef] [usertype] __user *src
   drivers/firmware/efi/test/efi_test.c:452:52: sparse:     got unsigned short [usertype] *[addressable] variable_name
   drivers/firmware/efi/test/efi_test.c:461:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__p @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:461:13: sparse:     expected unsigned long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:461:13: sparse:     got unsigned long [usertype] *[addressable] status
>> drivers/firmware/efi/test/efi_test.c:468:35: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__p @@     got unsigned long *[addressable] variable_name_size @@
   drivers/firmware/efi/test/efi_test.c:468:35: sparse:     expected unsigned long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:468:35: sparse:     got unsigned long *[addressable] variable_name_size
   drivers/firmware/efi/test/efi_test.c:479:62: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short [noderef] [usertype] __user *dst @@     got unsigned short [usertype] *[addressable] variable_name @@
   drivers/firmware/efi/test/efi_test.c:479:62: sparse:     expected unsigned short [noderef] [usertype] __user *dst
   drivers/firmware/efi/test/efi_test.c:479:62: sparse:     got unsigned short [usertype] *[addressable] variable_name
   drivers/firmware/efi/test/efi_test.c:487:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__p @@     got unsigned long *[addressable] variable_name_size @@
   drivers/firmware/efi/test/efi_test.c:487:21: sparse:     expected unsigned long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:487:21: sparse:     got unsigned long *[addressable] variable_name_size
   drivers/firmware/efi/test/efi_test.c:494:53: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got struct guid_t [usertype] *[addressable] vendor_guid @@
   drivers/firmware/efi/test/efi_test.c:494:53: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:494:53: sparse:     got struct guid_t [usertype] *[addressable] vendor_guid
   drivers/firmware/efi/test/efi_test.c:522:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__p @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:522:13: sparse:     expected unsigned long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:522:13: sparse:     got unsigned long [usertype] *[addressable] status
>> drivers/firmware/efi/test/efi_test.c:529:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__p @@     got unsigned int [usertype] *[addressable] high_count @@
   drivers/firmware/efi/test/efi_test.c:529:13: sparse:     expected unsigned int [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:529:13: sparse:     got unsigned int [usertype] *[addressable] high_count
   drivers/firmware/efi/test/efi_test.c:546:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __user * @@     got void * @@
   drivers/firmware/efi/test/efi_test.c:546:37: sparse:     expected void const [noderef] __user *
   drivers/firmware/efi/test/efi_test.c:546:37: sparse:     got void *
   drivers/firmware/efi/test/efi_test.c:575:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__p @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:575:13: sparse:     expected unsigned long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:575:13: sparse:     got unsigned long [usertype] *[addressable] status
>> drivers/firmware/efi/test/efi_test.c:581:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__p @@     got unsigned long long [usertype] *[addressable] maximum_variable_storage_size @@
   drivers/firmware/efi/test/efi_test.c:581:13: sparse:     expected unsigned long long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:581:13: sparse:     got unsigned long long [usertype] *[addressable] maximum_variable_storage_size
>> drivers/firmware/efi/test/efi_test.c:585:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__p @@     got unsigned long long [usertype] *[addressable] remaining_variable_storage_size @@
   drivers/firmware/efi/test/efi_test.c:585:13: sparse:     expected unsigned long long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:585:13: sparse:     got unsigned long long [usertype] *[addressable] remaining_variable_storage_size
   drivers/firmware/efi/test/efi_test.c:589:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__p @@     got unsigned long long [usertype] *[addressable] maximum_variable_size @@
   drivers/firmware/efi/test/efi_test.c:589:13: sparse:     expected unsigned long long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:589:13: sparse:     got unsigned long long [usertype] *[addressable] maximum_variable_size
>> drivers/firmware/efi/test/efi_test.c:625:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct efi_capsule_header_t [usertype] *const [noderef] __user *__p @@     got struct efi_capsule_header_t [usertype] ** @@
   drivers/firmware/efi/test/efi_test.c:625:21: sparse:     expected struct efi_capsule_header_t [usertype] *const [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:625:21: sparse:     got struct efi_capsule_header_t [usertype] **
>> drivers/firmware/efi/test/efi_test.c:625:21: sparse: sparse: Using plain integer as NULL pointer
   drivers/firmware/efi/test/efi_test.c:629:50: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct efi_capsule_header_t [usertype] *[assigned] c @@
   drivers/firmware/efi/test/efi_test.c:629:50: sparse:     expected void const [noderef] __user *from
   drivers/firmware/efi/test/efi_test.c:629:50: sparse:     got struct efi_capsule_header_t [usertype] *[assigned] c
>> drivers/firmware/efi/test/efi_test.c:643:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__p @@     got unsigned long [usertype] *[addressable] [assigned] status @@
   drivers/firmware/efi/test/efi_test.c:643:13: sparse:     expected unsigned long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:643:13: sparse:     got unsigned long [usertype] *[addressable] [assigned] status
>> drivers/firmware/efi/test/efi_test.c:653:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__p @@     got unsigned long long [usertype] *[addressable] [assigned] maximum_capsule_size @@
   drivers/firmware/efi/test/efi_test.c:653:13: sparse:     expected unsigned long long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:653:13: sparse:     got unsigned long long [usertype] *[addressable] [assigned] maximum_capsule_size
>> drivers/firmware/efi/test/efi_test.c:658:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__p @@     got int *[addressable] [assigned] reset_type @@
   drivers/firmware/efi/test/efi_test.c:658:13: sparse:     expected int [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:658:13: sparse:     got int *[addressable] [assigned] reset_type
   drivers/firmware/efi/test/efi_test.c:35:27: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [usertype] *s @@     got unsigned short [noderef] [usertype] __user *str @@
   drivers/firmware/efi/test/efi_test.c:35:27: sparse:     expected unsigned short [usertype] *s
   drivers/firmware/efi/test/efi_test.c:35:27: sparse:     got unsigned short [noderef] [usertype] __user *str
>> drivers/firmware/efi/test/efi_test.c:44:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const [noderef] __user *__p @@     got unsigned short [usertype] * @@
   drivers/firmware/efi/test/efi_test.c:44:13: sparse:     expected unsigned short const [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:44:13: sparse:     got unsigned short [usertype] *
   drivers/firmware/efi/test/efi_test.c:50:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const [noderef] __user *__p @@     got unsigned short [usertype] * @@
   drivers/firmware/efi/test/efi_test.c:50:21: sparse:     expected unsigned short const [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:50:21: sparse:     got unsigned short [usertype] *
   drivers/firmware/efi/test/efi_test.c:35:27: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [usertype] *[assigned] s @@     got unsigned short [noderef] [usertype] __user *str @@
   drivers/firmware/efi/test/efi_test.c:35:27: sparse:     expected unsigned short [usertype] *[assigned] s
   drivers/firmware/efi/test/efi_test.c:35:27: sparse:     got unsigned short [noderef] [usertype] __user *str
>> drivers/firmware/efi/test/efi_test.c:44:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const [noderef] __user *__p @@     got unsigned short [usertype] * @@
   drivers/firmware/efi/test/efi_test.c:44:13: sparse:     expected unsigned short const [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:44:13: sparse:     got unsigned short [usertype] *
   drivers/firmware/efi/test/efi_test.c:50:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const [noderef] __user *__p @@     got unsigned short [usertype] * @@
   drivers/firmware/efi/test/efi_test.c:50:21: sparse:     expected unsigned short const [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:50:21: sparse:     got unsigned short [usertype] *
   drivers/firmware/efi/test/efi_test.c:35:27: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [usertype] *[assigned] s @@     got unsigned short [noderef] [usertype] __user *str @@
   drivers/firmware/efi/test/efi_test.c:35:27: sparse:     expected unsigned short [usertype] *[assigned] s
   drivers/firmware/efi/test/efi_test.c:35:27: sparse:     got unsigned short [noderef] [usertype] __user *str
>> drivers/firmware/efi/test/efi_test.c:44:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const [noderef] __user *__p @@     got unsigned short [usertype] * @@
   drivers/firmware/efi/test/efi_test.c:44:13: sparse:     expected unsigned short const [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:44:13: sparse:     got unsigned short [usertype] *
   drivers/firmware/efi/test/efi_test.c:50:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const [noderef] __user *__p @@     got unsigned short [usertype] * @@
   drivers/firmware/efi/test/efi_test.c:50:21: sparse:     expected unsigned short const [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:50:21: sparse:     got unsigned short [usertype] *

vim +157 drivers/firmware/efi/test/efi_test.c

ff6301dabc3ca2 Ivan Hu      2016-08-25   26  
ff6301dabc3ca2 Ivan Hu      2016-08-25   27  /*
ff6301dabc3ca2 Ivan Hu      2016-08-25   28   * Count the bytes in 'str', including the terminating NULL.
ff6301dabc3ca2 Ivan Hu      2016-08-25   29   *
ff6301dabc3ca2 Ivan Hu      2016-08-25   30   * Note this function returns the number of *bytes*, not the number of
ff6301dabc3ca2 Ivan Hu      2016-08-25   31   * ucs2 characters.
ff6301dabc3ca2 Ivan Hu      2016-08-25   32   */
ff6301dabc3ca2 Ivan Hu      2016-08-25   33  static inline size_t user_ucs2_strsize(efi_char16_t  __user *str)
ff6301dabc3ca2 Ivan Hu      2016-08-25   34  {
ff6301dabc3ca2 Ivan Hu      2016-08-25   35  	efi_char16_t *s = str, c;
ff6301dabc3ca2 Ivan Hu      2016-08-25   36  	size_t len;
ff6301dabc3ca2 Ivan Hu      2016-08-25   37  
ff6301dabc3ca2 Ivan Hu      2016-08-25   38  	if (!str)
ff6301dabc3ca2 Ivan Hu      2016-08-25   39  		return 0;
ff6301dabc3ca2 Ivan Hu      2016-08-25   40  
ff6301dabc3ca2 Ivan Hu      2016-08-25   41  	/* Include terminating NULL */
ff6301dabc3ca2 Ivan Hu      2016-08-25   42  	len = sizeof(efi_char16_t);
ff6301dabc3ca2 Ivan Hu      2016-08-25   43  
ff6301dabc3ca2 Ivan Hu      2016-08-25  @44  	if (get_user(c, s++)) {
ff6301dabc3ca2 Ivan Hu      2016-08-25   45  		/* Can't read userspace memory for size */
ff6301dabc3ca2 Ivan Hu      2016-08-25   46  		return 0;
ff6301dabc3ca2 Ivan Hu      2016-08-25   47  	}
ff6301dabc3ca2 Ivan Hu      2016-08-25   48  
ff6301dabc3ca2 Ivan Hu      2016-08-25   49  	while (c != 0) {
ff6301dabc3ca2 Ivan Hu      2016-08-25   50  		if (get_user(c, s++)) {
ff6301dabc3ca2 Ivan Hu      2016-08-25   51  			/* Can't read userspace memory for size */
ff6301dabc3ca2 Ivan Hu      2016-08-25   52  			return 0;
ff6301dabc3ca2 Ivan Hu      2016-08-25   53  		}
ff6301dabc3ca2 Ivan Hu      2016-08-25   54  		len += sizeof(efi_char16_t);
ff6301dabc3ca2 Ivan Hu      2016-08-25   55  	}
ff6301dabc3ca2 Ivan Hu      2016-08-25   56  	return len;
ff6301dabc3ca2 Ivan Hu      2016-08-25   57  }
ff6301dabc3ca2 Ivan Hu      2016-08-25   58  
ff6301dabc3ca2 Ivan Hu      2016-08-25   59  /*
ff6301dabc3ca2 Ivan Hu      2016-08-25   60   * Allocate a buffer and copy a ucs2 string from user space into it.
ff6301dabc3ca2 Ivan Hu      2016-08-25   61   */
ff6301dabc3ca2 Ivan Hu      2016-08-25   62  static inline int
ff6301dabc3ca2 Ivan Hu      2016-08-25   63  copy_ucs2_from_user_len(efi_char16_t **dst, efi_char16_t __user *src,
ff6301dabc3ca2 Ivan Hu      2016-08-25   64  			size_t len)
ff6301dabc3ca2 Ivan Hu      2016-08-25   65  {
ff6301dabc3ca2 Ivan Hu      2016-08-25   66  	efi_char16_t *buf;
ff6301dabc3ca2 Ivan Hu      2016-08-25   67  
ff6301dabc3ca2 Ivan Hu      2016-08-25   68  	if (!src) {
ff6301dabc3ca2 Ivan Hu      2016-08-25   69  		*dst = NULL;
ff6301dabc3ca2 Ivan Hu      2016-08-25   70  		return 0;
ff6301dabc3ca2 Ivan Hu      2016-08-25   71  	}
ff6301dabc3ca2 Ivan Hu      2016-08-25   72  
5f72cad65cfaac Geliang Tang 2017-06-02   73  	buf = memdup_user(src, len);
5f72cad65cfaac Geliang Tang 2017-06-02   74  	if (IS_ERR(buf)) {
ff6301dabc3ca2 Ivan Hu      2016-08-25   75  		*dst = NULL;
5f72cad65cfaac Geliang Tang 2017-06-02   76  		return PTR_ERR(buf);
ff6301dabc3ca2 Ivan Hu      2016-08-25   77  	}
ff6301dabc3ca2 Ivan Hu      2016-08-25   78  	*dst = buf;
ff6301dabc3ca2 Ivan Hu      2016-08-25   79  
ff6301dabc3ca2 Ivan Hu      2016-08-25   80  	return 0;
ff6301dabc3ca2 Ivan Hu      2016-08-25   81  }
ff6301dabc3ca2 Ivan Hu      2016-08-25   82  
ff6301dabc3ca2 Ivan Hu      2016-08-25   83  /*
ff6301dabc3ca2 Ivan Hu      2016-08-25   84   * Count the bytes in 'str', including the terminating NULL.
ff6301dabc3ca2 Ivan Hu      2016-08-25   85   *
ff6301dabc3ca2 Ivan Hu      2016-08-25   86   * Just a wrap for user_ucs2_strsize
ff6301dabc3ca2 Ivan Hu      2016-08-25   87   */
ff6301dabc3ca2 Ivan Hu      2016-08-25   88  static inline int
ff6301dabc3ca2 Ivan Hu      2016-08-25   89  get_ucs2_strsize_from_user(efi_char16_t __user *src, size_t *len)
ff6301dabc3ca2 Ivan Hu      2016-08-25   90  {
ff6301dabc3ca2 Ivan Hu      2016-08-25   91  	*len = user_ucs2_strsize(src);
ff6301dabc3ca2 Ivan Hu      2016-08-25   92  	if (*len == 0)
ff6301dabc3ca2 Ivan Hu      2016-08-25   93  		return -EFAULT;
ff6301dabc3ca2 Ivan Hu      2016-08-25   94  
ff6301dabc3ca2 Ivan Hu      2016-08-25   95  	return 0;
ff6301dabc3ca2 Ivan Hu      2016-08-25   96  }
ff6301dabc3ca2 Ivan Hu      2016-08-25   97  
ff6301dabc3ca2 Ivan Hu      2016-08-25   98  /*
ff6301dabc3ca2 Ivan Hu      2016-08-25   99   * Calculate the required buffer allocation size and copy a ucs2 string
ff6301dabc3ca2 Ivan Hu      2016-08-25  100   * from user space into it.
ff6301dabc3ca2 Ivan Hu      2016-08-25  101   *
ff6301dabc3ca2 Ivan Hu      2016-08-25  102   * This function differs from copy_ucs2_from_user_len() because it
ff6301dabc3ca2 Ivan Hu      2016-08-25  103   * calculates the size of the buffer to allocate by taking the length of
ff6301dabc3ca2 Ivan Hu      2016-08-25  104   * the string 'src'.
ff6301dabc3ca2 Ivan Hu      2016-08-25  105   *
ff6301dabc3ca2 Ivan Hu      2016-08-25  106   * If a non-zero value is returned, the caller MUST NOT access 'dst'.
ff6301dabc3ca2 Ivan Hu      2016-08-25  107   *
ff6301dabc3ca2 Ivan Hu      2016-08-25  108   * It is the caller's responsibility to free 'dst'.
ff6301dabc3ca2 Ivan Hu      2016-08-25  109   */
ff6301dabc3ca2 Ivan Hu      2016-08-25  110  static inline int
ff6301dabc3ca2 Ivan Hu      2016-08-25  111  copy_ucs2_from_user(efi_char16_t **dst, efi_char16_t __user *src)
ff6301dabc3ca2 Ivan Hu      2016-08-25  112  {
ff6301dabc3ca2 Ivan Hu      2016-08-25  113  	size_t len;
ff6301dabc3ca2 Ivan Hu      2016-08-25  114  
ff6301dabc3ca2 Ivan Hu      2016-08-25  115  	len = user_ucs2_strsize(src);
ff6301dabc3ca2 Ivan Hu      2016-08-25  116  	if (len == 0)
ff6301dabc3ca2 Ivan Hu      2016-08-25  117  		return -EFAULT;
ff6301dabc3ca2 Ivan Hu      2016-08-25  118  	return copy_ucs2_from_user_len(dst, src, len);
ff6301dabc3ca2 Ivan Hu      2016-08-25  119  }
ff6301dabc3ca2 Ivan Hu      2016-08-25  120  
ff6301dabc3ca2 Ivan Hu      2016-08-25  121  /*
ff6301dabc3ca2 Ivan Hu      2016-08-25  122   * Copy a ucs2 string to a user buffer.
ff6301dabc3ca2 Ivan Hu      2016-08-25  123   *
ff6301dabc3ca2 Ivan Hu      2016-08-25  124   * This function is a simple wrapper around copy_to_user() that does
ff6301dabc3ca2 Ivan Hu      2016-08-25  125   * nothing if 'src' is NULL, which is useful for reducing the amount of
ff6301dabc3ca2 Ivan Hu      2016-08-25  126   * NULL checking the caller has to do.
ff6301dabc3ca2 Ivan Hu      2016-08-25  127   *
ff6301dabc3ca2 Ivan Hu      2016-08-25  128   * 'len' specifies the number of bytes to copy.
ff6301dabc3ca2 Ivan Hu      2016-08-25  129   */
ff6301dabc3ca2 Ivan Hu      2016-08-25  130  static inline int
ff6301dabc3ca2 Ivan Hu      2016-08-25  131  copy_ucs2_to_user_len(efi_char16_t __user *dst, efi_char16_t *src, size_t len)
ff6301dabc3ca2 Ivan Hu      2016-08-25  132  {
ff6301dabc3ca2 Ivan Hu      2016-08-25  133  	if (!src)
ff6301dabc3ca2 Ivan Hu      2016-08-25  134  		return 0;
ff6301dabc3ca2 Ivan Hu      2016-08-25  135  
ff6301dabc3ca2 Ivan Hu      2016-08-25  136  	return copy_to_user(dst, src, len);
ff6301dabc3ca2 Ivan Hu      2016-08-25  137  }
ff6301dabc3ca2 Ivan Hu      2016-08-25  138  
ff6301dabc3ca2 Ivan Hu      2016-08-25  139  static long efi_runtime_get_variable(unsigned long arg)
ff6301dabc3ca2 Ivan Hu      2016-08-25  140  {
ff6301dabc3ca2 Ivan Hu      2016-08-25  141  	struct efi_getvariable __user *getvariable_user;
ff6301dabc3ca2 Ivan Hu      2016-08-25  142  	struct efi_getvariable getvariable;
46b9b7135332d1 Ivan Hu      2016-10-18  143  	unsigned long datasize = 0, prev_datasize, *dz;
ff6301dabc3ca2 Ivan Hu      2016-08-25  144  	efi_guid_t vendor_guid, *vd = NULL;
ff6301dabc3ca2 Ivan Hu      2016-08-25  145  	efi_status_t status;
ff6301dabc3ca2 Ivan Hu      2016-08-25  146  	efi_char16_t *name = NULL;
ff6301dabc3ca2 Ivan Hu      2016-08-25  147  	u32 attr, *at;
ff6301dabc3ca2 Ivan Hu      2016-08-25  148  	void *data = NULL;
ff6301dabc3ca2 Ivan Hu      2016-08-25  149  	int rv = 0;
ff6301dabc3ca2 Ivan Hu      2016-08-25  150  
ff6301dabc3ca2 Ivan Hu      2016-08-25  151  	getvariable_user = (struct efi_getvariable __user *)arg;
ff6301dabc3ca2 Ivan Hu      2016-08-25  152  
ff6301dabc3ca2 Ivan Hu      2016-08-25  153  	if (copy_from_user(&getvariable, getvariable_user,
ff6301dabc3ca2 Ivan Hu      2016-08-25  154  			   sizeof(getvariable)))
ff6301dabc3ca2 Ivan Hu      2016-08-25  155  		return -EFAULT;
ff6301dabc3ca2 Ivan Hu      2016-08-25  156  	if (getvariable.data_size &&
ff6301dabc3ca2 Ivan Hu      2016-08-25 @157  	    get_user(datasize, getvariable.data_size))
ff6301dabc3ca2 Ivan Hu      2016-08-25  158  		return -EFAULT;
ff6301dabc3ca2 Ivan Hu      2016-08-25  159  	if (getvariable.vendor_guid) {
ff6301dabc3ca2 Ivan Hu      2016-08-25  160  		if (copy_from_user(&vendor_guid, getvariable.vendor_guid,
ff6301dabc3ca2 Ivan Hu      2016-08-25  161  					sizeof(vendor_guid)))
ff6301dabc3ca2 Ivan Hu      2016-08-25  162  			return -EFAULT;
ff6301dabc3ca2 Ivan Hu      2016-08-25  163  		vd = &vendor_guid;
ff6301dabc3ca2 Ivan Hu      2016-08-25  164  	}
ff6301dabc3ca2 Ivan Hu      2016-08-25  165  
ff6301dabc3ca2 Ivan Hu      2016-08-25  166  	if (getvariable.variable_name) {
ff6301dabc3ca2 Ivan Hu      2016-08-25  167  		rv = copy_ucs2_from_user(&name, getvariable.variable_name);
ff6301dabc3ca2 Ivan Hu      2016-08-25  168  		if (rv)
ff6301dabc3ca2 Ivan Hu      2016-08-25  169  			return rv;
ff6301dabc3ca2 Ivan Hu      2016-08-25  170  	}
ff6301dabc3ca2 Ivan Hu      2016-08-25  171  
ff6301dabc3ca2 Ivan Hu      2016-08-25  172  	at = getvariable.attributes ? &attr : NULL;
ff6301dabc3ca2 Ivan Hu      2016-08-25  173  	dz = getvariable.data_size ? &datasize : NULL;
ff6301dabc3ca2 Ivan Hu      2016-08-25  174  
ff6301dabc3ca2 Ivan Hu      2016-08-25  175  	if (getvariable.data_size && getvariable.data) {
ff6301dabc3ca2 Ivan Hu      2016-08-25  176  		data = kmalloc(datasize, GFP_KERNEL);
ff6301dabc3ca2 Ivan Hu      2016-08-25  177  		if (!data) {
ff6301dabc3ca2 Ivan Hu      2016-08-25  178  			kfree(name);
ff6301dabc3ca2 Ivan Hu      2016-08-25  179  			return -ENOMEM;
ff6301dabc3ca2 Ivan Hu      2016-08-25  180  		}
ff6301dabc3ca2 Ivan Hu      2016-08-25  181  	}
ff6301dabc3ca2 Ivan Hu      2016-08-25  182  
ff6301dabc3ca2 Ivan Hu      2016-08-25  183  	prev_datasize = datasize;
ff6301dabc3ca2 Ivan Hu      2016-08-25  184  	status = efi.get_variable(name, vd, at, dz, data);
ff6301dabc3ca2 Ivan Hu      2016-08-25  185  	kfree(name);
ff6301dabc3ca2 Ivan Hu      2016-08-25  186  
ff6301dabc3ca2 Ivan Hu      2016-08-25 @187  	if (put_user(status, getvariable.status)) {
ff6301dabc3ca2 Ivan Hu      2016-08-25  188  		rv = -EFAULT;
ff6301dabc3ca2 Ivan Hu      2016-08-25  189  		goto out;
ff6301dabc3ca2 Ivan Hu      2016-08-25  190  	}
ff6301dabc3ca2 Ivan Hu      2016-08-25  191  
ff6301dabc3ca2 Ivan Hu      2016-08-25  192  	if (status != EFI_SUCCESS) {
ff6301dabc3ca2 Ivan Hu      2016-08-25  193  		if (status == EFI_BUFFER_TOO_SMALL) {
ff6301dabc3ca2 Ivan Hu      2016-08-25 @194  			if (dz && put_user(datasize, getvariable.data_size)) {
ff6301dabc3ca2 Ivan Hu      2016-08-25  195  				rv = -EFAULT;
ff6301dabc3ca2 Ivan Hu      2016-08-25  196  				goto out;
ff6301dabc3ca2 Ivan Hu      2016-08-25  197  			}
ff6301dabc3ca2 Ivan Hu      2016-08-25  198  		}
ff6301dabc3ca2 Ivan Hu      2016-08-25  199  		rv = -EINVAL;
ff6301dabc3ca2 Ivan Hu      2016-08-25  200  		goto out;
ff6301dabc3ca2 Ivan Hu      2016-08-25  201  	}
ff6301dabc3ca2 Ivan Hu      2016-08-25  202  
ff6301dabc3ca2 Ivan Hu      2016-08-25  203  	if (prev_datasize < datasize) {
ff6301dabc3ca2 Ivan Hu      2016-08-25  204  		rv = -EINVAL;
ff6301dabc3ca2 Ivan Hu      2016-08-25  205  		goto out;
ff6301dabc3ca2 Ivan Hu      2016-08-25  206  	}
ff6301dabc3ca2 Ivan Hu      2016-08-25  207  
ff6301dabc3ca2 Ivan Hu      2016-08-25  208  	if (data) {
ff6301dabc3ca2 Ivan Hu      2016-08-25  209  		if (copy_to_user(getvariable.data, data, datasize)) {
ff6301dabc3ca2 Ivan Hu      2016-08-25  210  			rv = -EFAULT;
ff6301dabc3ca2 Ivan Hu      2016-08-25  211  			goto out;
ff6301dabc3ca2 Ivan Hu      2016-08-25  212  		}
ff6301dabc3ca2 Ivan Hu      2016-08-25  213  	}
ff6301dabc3ca2 Ivan Hu      2016-08-25  214  
ff6301dabc3ca2 Ivan Hu      2016-08-25 @215  	if (at && put_user(attr, getvariable.attributes)) {
ff6301dabc3ca2 Ivan Hu      2016-08-25  216  		rv = -EFAULT;
ff6301dabc3ca2 Ivan Hu      2016-08-25  217  		goto out;
ff6301dabc3ca2 Ivan Hu      2016-08-25  218  	}
ff6301dabc3ca2 Ivan Hu      2016-08-25  219  
ff6301dabc3ca2 Ivan Hu      2016-08-25  220  	if (dz && put_user(datasize, getvariable.data_size))
ff6301dabc3ca2 Ivan Hu      2016-08-25  221  		rv = -EFAULT;
ff6301dabc3ca2 Ivan Hu      2016-08-25  222  
ff6301dabc3ca2 Ivan Hu      2016-08-25  223  out:
ff6301dabc3ca2 Ivan Hu      2016-08-25  224  	kfree(data);
ff6301dabc3ca2 Ivan Hu      2016-08-25  225  	return rv;
ff6301dabc3ca2 Ivan Hu      2016-08-25  226  

:::::: The code at line 157 was first introduced by commit
:::::: ff6301dabc3ca20ab8f50f8d0252ac05da610d89 efi: Add efi_test driver for exporting UEFI runtime service interfaces

:::::: TO: Ivan Hu <ivan.hu@canonical.com>
:::::: CC: Matt Fleming <matt@codeblueprint.co.uk>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776E64CB6D9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 07:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiCCGSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 01:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiCCGSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 01:18:21 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997C512AB4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 22:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646288256; x=1677824256;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7ATYsTKZkf8iHIlnFQYrV/vNKqs7/zUucjy1S/foEcs=;
  b=mY45ltnyv0+bev7A4jICm/yJ1zy7wPFM8Tk/4WPzPbR6n/ukGyEKn6eG
   QtTl8Z+NhQjp8D6ckF2zLgZJrCRGyj7Bd64dbF+TV1vJ6Gd74BSLPPMz5
   tPOGHSC8OiBBUrzjcgmXRP+7+/KAEfSf7DRetuDsKTP6tmZ+YnO+DIHS0
   Kjbav6erILuWdvfgqpLaN3eLKdsd/S9fq7nN+cohTxLYZBk1fLIXE4mYe
   2aL2CI0VXHAi9MSIf8VWu9AQS9vT6fCQdIYgAgruzDpZX593x8jltJ/S1
   2j7YnQ27eELefcliPSE66KNWcfaVTRKtFLiH6YZjUzlzUbWdxVT94ZJeY
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="340021847"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="340021847"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 22:15:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="551610213"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 02 Mar 2022 22:15:46 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPekb-0000E3-RO; Thu, 03 Mar 2022 06:15:45 +0000
Date:   Thu, 3 Mar 2022 14:15:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Amit Pundir <amit.pundir@linaro.org>
Subject: [ammarfaizi2-block:google/android/kernel/common/deprecated/android-4.14-p-release
 137/6167] security/commoncap.c:75:5: sparse: sparse: symbol '__cap_capable'
 was not declared. Should it be static?
Message-ID: <202203031440.TcuCrT9t-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/deprecated/android-4.14-p-release
head:   0ca5d5ac9152d01b3494fb2efb5390319eb9904a
commit: 2b02b4ab89b9cba5aec936046d8538962c5142fc [137/6167] ANDROID: net: paranoid: commoncap: Begin to warn users of implicit PARANOID_NETWORK capability grants
config: i386-randconfig-s001-20211019 (https://download.01.org/0day-ci/archive/20220303/202203031440.TcuCrT9t-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/2b02b4ab89b9cba5aec936046d8538962c5142fc
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/deprecated/android-4.14-p-release
        git checkout 2b02b4ab89b9cba5aec936046d8538962c5142fc
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> security/commoncap.c:75:5: sparse: sparse: symbol '__cap_capable' was not declared. Should it be static?
   security/commoncap.c:474:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] magic @@     got int @@
   security/commoncap.c:474:31: sparse:     expected restricted __le32 [usertype] magic
   security/commoncap.c:474:31: sparse:     got int
   security/commoncap.c:475:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] nsmagic @@     got unsigned int [usertype] @@
   security/commoncap.c:475:33: sparse:     expected restricted __le32 [usertype] nsmagic
   security/commoncap.c:475:33: sparse:     got unsigned int [usertype]
   security/commoncap.c:476:29: sparse: sparse: restricted __le32 degrades to integer
   security/commoncap.c:477:39: sparse: sparse: invalid assignment: |=
   security/commoncap.c:477:39: sparse:    left side has type restricted __le32
   security/commoncap.c:477:39: sparse:    right side has type int
   security/commoncap.c:479:42: sparse: sparse: cast from restricted __le32
   security/commoncap.c:1226:41: sparse: sparse: dubious: !x | y
   security/commoncap.c:1307:27: sparse: sparse: symbol 'capability_hooks' was not declared. Should it be static?
   security/commoncap.c:75:5: warning: no previous declaration for '__cap_capable' [-Wmissing-declarations]
    int __cap_capable(const struct cred *cred, struct user_namespace *targ_ns,
        ^~~~~~~~~~~~~
   In file included from include/linux/capability.h:16:0,
                    from security/commoncap.c:10:
   security/commoncap.c: In function 'cap_prctl_drop':
   include/uapi/linux/capability.h:372:27: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
    #define cap_valid(x) ((x) >= 0 && (x) <= CAP_LAST_CAP)
                              ^
   security/commoncap.c:1112:7: note: in expansion of macro 'cap_valid'
     if (!cap_valid(cap))
          ^~~~~~~~~
   security/commoncap.c: In function 'cap_task_prctl':
   include/uapi/linux/capability.h:372:27: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
    #define cap_valid(x) ((x) >= 0 && (x) <= CAP_LAST_CAP)
                              ^
   security/commoncap.c:1142:8: note: in expansion of macro 'cap_valid'
      if (!cap_valid(arg2))
           ^~~~~~~~~
   include/uapi/linux/capability.h:372:27: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
    #define cap_valid(x) ((x) >= 0 && (x) <= CAP_LAST_CAP)
                              ^
   security/commoncap.c:1226:10: note: in expansion of macro 'cap_valid'
      if (((!cap_valid(arg3)) | arg4 | arg5))
             ^~~~~~~~~

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

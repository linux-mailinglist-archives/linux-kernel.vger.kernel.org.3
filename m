Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E920A59682F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 06:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiHQE32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 00:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiHQE30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 00:29:26 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90D44A104
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 21:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660710565; x=1692246565;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cVdC4bjVi8/suUsEqf4xy7IKvNzHo3N9lIbSBBoch5Q=;
  b=UFnvGzc1NfslzQrbF4TKDsDevbDGVmhXtwUHmG0v9kbAVrmoUjA2snQT
   I+GxL4dfeqxqkWCJOwPE6HzYb+ll5R1ZDaJgNQBir6vqprz6oQlmdpwhV
   rteC9wjLlkHgaMW+O7oBs1+LV4mw+oMOP5KzhtvSkpDv1mWJ6+5f40YPV
   TC38rEJxPEZ8aqbd7G/7HwxXu1a8E9cm1pNOu8lTkyF0roNqTZz+0QZ6/
   VseAnU1CdocVb1vgNrw0UfL8v7K9GjuuHS7IT7u9oGEIDuXrdfTTbRfCs
   NIJ9R3PLiFVQLucwDxCDGYio6jfEm9G1aRCFIc5/LwHLyU9+vu71hifBv
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="292392599"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="292392599"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 21:29:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="636199232"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 16 Aug 2022 21:29:10 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOAg2-0000Zk-0u;
        Wed, 17 Aug 2022 04:29:10 +0000
Date:   Wed, 17 Aug 2022 12:28:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [intel-tdx:guest-unaccepted-memory 11/14] kexec.c:undefined
 reference to `arch_kexec_load'
Message-ID: <202208171215.jkRKSdKE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-unaccepted-memory
head:   86fb61d5824802e1b7c4c8eb1b34029024f52ee6
commit: 820c5c338451079677510d4183ba5d5dc314c030 [11/14] x86: Disable kexec if system has unaccepted memory
config: x86_64-randconfig-a004-20220815 (https://download.01.org/0day-ci/archive/20220817/202208171215.jkRKSdKE-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/820c5c338451079677510d4183ba5d5dc314c030
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-unaccepted-memory
        git checkout 820c5c338451079677510d4183ba5d5dc314c030
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: kernel/kexec.o: in function `__x64_sys_kexec_load':
>> kexec.c:(.text+0x1cf): undefined reference to `arch_kexec_load'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

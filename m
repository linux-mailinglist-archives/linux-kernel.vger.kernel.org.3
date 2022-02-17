Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3FC4B9779
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 05:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbiBQEOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 23:14:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiBQEOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 23:14:16 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E63E23BF15
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 20:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645071242; x=1676607242;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wrvAXSqA4m7vddYjUfMHkBtnDE7gjSQf3zl8IaPbKlQ=;
  b=F/oydi5Vi+230+dWyo7oOImP7QZ5kjpHk2HWEIeUKwOHWpntsZCve+9P
   v/sfa9HqjCPN87WFQgeheHACQKXeCBLwmZ3GAm3q5avLv+KxS3VB8nQpf
   vBsHRd0wsPhABoF9ULd1G9A598VDPwgB+EHZnkeTataBNxQwiLcU0Hv5q
   hE/W5l5/DgdmuILXfVjr6Dl/4RQ9uwJjeDJUnj7ZoWav1w+z9JEVELM/g
   Lq91hw7A/QSTAZXh4d5jzut8dhL9+x8AVC056hZmHJQ43NcGtlY6lOpC/
   UjKmksK+atr9fu9TXxfIpIfkxbU/ZybxI/Ql0+2e5UsROaBRfN/0+aXOn
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="249621033"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="249621033"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 20:14:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="704596857"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 16 Feb 2022 20:14:00 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKYB5-000BRi-TJ; Thu, 17 Feb 2022 04:13:59 +0000
Date:   Thu, 17 Feb 2022 12:13:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [rppt:cet/kvm 32/49] <stdin>:1565:2: warning: syscall
 map_shadow_stack not implemented
Message-ID: <202202171218.HfuxKGxm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git cet/kvm
head:   e2f9808bd7530f44cd5d95332036bb660b66b8db
commit: 987299ad58376fc09a3bc884b55c07c2e5d80245 [32/49] x86/cet/shstk: Introduce map_shadow_stack syscall
config: hexagon-buildonly-randconfig-r005-20220216 (https://download.01.org/0day-ci/archive/20220217/202202171218.HfuxKGxm-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0bad7cb56526f2572c74449fcf97c1fcda42b41d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/commit/?id=987299ad58376fc09a3bc884b55c07c2e5d80245
        git remote add rppt https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git
        git fetch --no-tags rppt cet/kvm
        git checkout 987299ad58376fc09a3bc884b55c07c2e5d80245
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   <stdin>:1517:2: warning: syscall clone3 not implemented [-W#warnings]
   #warning syscall clone3 not implemented
    ^
>> <stdin>:1565:2: warning: syscall map_shadow_stack not implemented [-W#warnings]
   #warning syscall map_shadow_stack not implemented
    ^
   2 warnings generated.
--
   <stdin>:1517:2: warning: syscall clone3 not implemented [-W#warnings]
   #warning syscall clone3 not implemented
    ^
>> <stdin>:1565:2: warning: syscall map_shadow_stack not implemented [-W#warnings]
   #warning syscall map_shadow_stack not implemented
    ^
   2 warnings generated.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

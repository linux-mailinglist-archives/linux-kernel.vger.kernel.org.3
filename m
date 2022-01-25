Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E85649BF9E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 00:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234849AbiAYXdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 18:33:45 -0500
Received: from mga14.intel.com ([192.55.52.115]:31636 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234841AbiAYXd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 18:33:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643153607; x=1674689607;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EU2b9JrQJH1OK/v9lhZZ3ztptNc+djvb662UR9+9vBo=;
  b=aoZXed9oVmJnAUzq7DTVO3rv+vJeqdOMbGCYQV16tEr4i5kIYwS4NHJH
   SeB9Evk9HTnMeCC4ETWZAJj+P+UpbLSdAxd5cRRkSE3W31dNicepuMm4S
   jSgSck/t4VRlMPPCVQleBdj9oPpr7g5xwcE1nYdR0wGOWy9drBzZixlpi
   JexyDSSXMIHV+yVHIU2LvdDXCxKIf21HPEz4rQnI9SMd2BFwMehGaONtX
   w6Fmr/wRXpWnEmApcQpHc50+Uj/E3DVDmrWXzvSYIoGsLWqOvRRhqUBJf
   KW0BtDMJo23P6oX4SgEiKFNiFFrJItjc9WVnh5J4cEjaxPaZb/Iz5kJSJ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="246657989"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="246657989"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 15:33:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="479691392"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 25 Jan 2022 15:33:25 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCVJU-000KYR-RR; Tue, 25 Jan 2022 23:33:24 +0000
Date:   Wed, 26 Jan 2022 07:32:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [morse:mpam/snapshot/v5.16 4/137]
 arch/x86/kernel/cpu/resctrl/core.c:417:6: warning: no previous prototype for
 function 'domain_free'
Message-ID: <202201260732.58wp6s70-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v5.16
head:   364c1c42b229912132e1615c2ce15be7154e2156
commit: 22965510f006f9207f1615ffb3543c9314ac6d01 [4/137] x86/resctrl: Group struct rdt_hw_domain cleanup
config: i386-randconfig-a011-20220124 (https://download.01.org/0day-ci/archive/20220126/202201260732.58wp6s70-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 997e128e2a78f5a5434fc75997441ae1ee76f8a4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?id=22965510f006f9207f1615ffb3543c9314ac6d01
        git remote add morse https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
        git fetch --no-tags morse mpam/snapshot/v5.16
        git checkout 22965510f006f9207f1615ffb3543c9314ac6d01
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/cpu/resctrl/core.c:417:6: warning: no previous prototype for function 'domain_free' [-Wmissing-prototypes]
   void domain_free(struct rdt_hw_domain *hw_dom)
        ^
   arch/x86/kernel/cpu/resctrl/core.c:417:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void domain_free(struct rdt_hw_domain *hw_dom)
   ^
   static 
   1 warning generated.


vim +/domain_free +417 arch/x86/kernel/cpu/resctrl/core.c

   416	
 > 417	void domain_free(struct rdt_hw_domain *hw_dom)
   418	{
   419		kfree(hw_dom->ctrl_val);
   420		kfree(hw_dom->mbps_val);
   421		kfree(hw_dom);
   422	}
   423	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

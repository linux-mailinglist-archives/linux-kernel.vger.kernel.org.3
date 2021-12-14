Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F1D473A87
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 03:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243632AbhLNCEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 21:04:04 -0500
Received: from mga09.intel.com ([134.134.136.24]:24977 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231303AbhLNCED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 21:04:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639447443; x=1670983443;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jw37mo9vphMUAvXIWIO6jvUlFXjmot1bb+nI7Y/R83I=;
  b=Ep0ZZY79aYc8+IgdTE1k1jA2iTPwQtZbapL6kaoEpjADqUk1IxAXRZfv
   /QDbMUJP9E8UzpPZjKlYX03ouUM60+KG/qV7qVi47bh0deu9K5JHTcVJD
   dGrrpJuGf5HCZvwVbkc7/QGlAPBERcwT2p23gIw/6MjTQEb5CksJHYWLd
   PLb0juzFHTFS2RycUnem+EKknmEqkD96jF4s7XOp8H3kOT8s/HeQbqz6L
   SluPlI+4FPhUQIUA1CzO1iGX6W/ZtLpFAbV9+9/Xa3fYj1PhVE1Wusvht
   cwfRQvqQPb7dvOCuY9+aGPL4s3AMdN4f4qple92azGgm57jSoPg4isvyx
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="238688182"
X-IronPort-AV: E=Sophos;i="5.88,204,1635231600"; 
   d="scan'208";a="238688182"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 18:04:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,204,1635231600"; 
   d="scan'208";a="505166202"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 13 Dec 2021 18:04:02 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mwxAf-0007Ii-Ha; Tue, 14 Dec 2021 02:04:01 +0000
Date:   Tue, 14 Dec 2021 10:03:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ebiederm-user-namespace:signal-for-v5.17 4/12]
 arch/x86/kernel/dumpstack.o: warning: objtool: oops_end() falls through to
 next function show_opcodes()
Message-ID: <202112140949.Uq5sFKR1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git signal-for-v5.17
head:   6b1248798eb6f6d5285db214299996ecc5dc1e6b
commit: 0e25498f8cd43c1b5aa327f373dd094e9a006da7 [4/12] exit: Add and use make_task_dead.
config: x86_64-randconfig-a011-20211213 (https://download.01.org/0day-ci/archive/20211214/202112140949.Uq5sFKR1-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git/commit/?id=0e25498f8cd43c1b5aa327f373dd094e9a006da7
        git remote add ebiederm-user-namespace https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git
        git fetch --no-tags ebiederm-user-namespace signal-for-v5.17
        git checkout 0e25498f8cd43c1b5aa327f373dd094e9a006da7
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/ kernel/ lib/kunit/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> lib/kunit/kunit-example-test.o: warning: objtool: .text.unlikely: unexpected end of section
--
>> arch/x86/kernel/dumpstack.o: warning: objtool: oops_end() falls through to next function show_opcodes()

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

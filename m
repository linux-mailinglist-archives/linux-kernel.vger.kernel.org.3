Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A34149EFEA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 01:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236399AbiA1Apr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 19:45:47 -0500
Received: from mga18.intel.com ([134.134.136.126]:1690 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231846AbiA1Apq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 19:45:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643330746; x=1674866746;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=N8fchvdjVzKlilzPoXhU5FDKlw8TzcSmaML0nNAKCmk=;
  b=kr2Lj6VxWbRhD/YMN+G5KDBHJCvx53pypSX6doAXXJXkiqxeFu0wYg5b
   Rrx+xPYkA2h0MwZEVGzP8FvraQG5pvKrSc371hMnaBwB6Re4ZJeh3HQnn
   RtxmJLjtDxBSuyMhJ43sV3iJUAdedgxxymIr+a107+ljZ0OJqMMfUKS8y
   3ULvRkqwQbgrgY+8BTU4QxTSIA5rtd8OGMlY3XJhhRDR9zHx2JV5a0hbs
   fXQ0tJ6DKcUC3AnFt+RFFnodw8i0SyqO5fmFl7DbDT6zkUjtw49oDbNqe
   CDsmD2IBVZoZ/fql5iPB8jGr5WJ/qkneUscWTfbaJvVVeC9ZMofVXG9Vc
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="230582475"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="230582475"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:45:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="628917021"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 27 Jan 2022 16:45:45 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDFOa-000NER-HY; Fri, 28 Jan 2022 00:45:44 +0000
Date:   Fri, 28 Jan 2022 08:44:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chenjieqin <Jessica.Chen@starfivetech.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: [esmil:visionfive 36/74] pwm-sifive-ptc.c:undefined reference to
 `__udivdi3'
Message-ID: <202201280855.Boip1DFz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   31606e93b454de33cd75c74d622f35eee020dc5b
commit: d8f87b24049876b29ade8ed4e49f975d32eeec79 [36/74] drivers/pwm: Add SiFive PWM PTC driver
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220128/202201280855.Boip1DFz-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/esmil/linux/commit/d8f87b24049876b29ade8ed4e49f975d32eeec79
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout d8f87b24049876b29ade8ed4e49f975d32eeec79
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   m68k-linux-ld: drivers/pwm/pwm-sifive-ptc.o: in function `sifive_pwm_ptc_apply':
>> pwm-sifive-ptc.c:(.text+0x1c2): undefined reference to `__udivdi3'
   `.exit.text' referenced in section `.data' of sound/soc/codecs/tlv320adc3xxx.o: defined in discarded section `.exit.text' of sound/soc/codecs/tlv320adc3xxx.o

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

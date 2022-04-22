Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9C750B02D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 08:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351464AbiDVGEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 02:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbiDVGEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:04:45 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77F94FC5C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 23:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650607311; x=1682143311;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/7/X2Xu5wAZbEmSaHggI7TB/m5IhDaEQ1Acsr5zEP+Y=;
  b=YOwhJZ5YRZLo+MdBdl9Rhw0cz/C13RNalDoziS+YfZeW1zYGcX0MwHS1
   qgNfOC/oz8TCebAe1cr3wOOmZn7x9EeG2XNEI39URRYIM2OqhoRoBqwrD
   zt0EjoVRT32Jnr4RD+jilG9mreIKS0sjgdg58DWQnyKaZf0gzZkgR+p1C
   /St3KPLnxNz4EBnxkCWHZQqwbHXBXfJLujJUFDpMmZI1JLMvhw+OIDSuP
   o0WgJevEpGdZ7hjCVXxumeSnOzhzjAQnpAzTpuCRjFWGBu91O9xh8fdAl
   D1CPg9ROK7dbT6gV/njL6eLHxIKKWGPrNWLnIipHP5JAEcT88r+BNh9Xl
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="351024958"
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="351024958"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 23:01:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="533982782"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 21 Apr 2022 23:01:49 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhmMX-0009IM-51;
        Fri, 22 Apr 2022 06:01:49 +0000
Date:   Fri, 22 Apr 2022 14:01:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [rt-devel:linux-5.18.y-rt-rebase 17/78] printk.c:undefined reference
 to `console_emit_next_record'
Message-ID: <202204221359.DTcaIZnW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git linux-5.18.y-rt-rebase
head:   03e7725ddbfb0ffd7f3d7b257bfa504c6f795f6b
commit: 72b5c1227b73b2cde1452cfc58717cff442ed473 [17/78] serial: 8250: implement write_atomic
config: openrisc-randconfig-r022-20220421 (https://download.01.org/0day-ci/archive/20220422/202204221359.DTcaIZnW-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?id=72b5c1227b73b2cde1452cfc58717cff442ed473
        git remote add rt-devel https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
        git fetch --no-tags rt-devel linux-5.18.y-rt-rebase
        git checkout 72b5c1227b73b2cde1452cfc58717cff442ed473
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=openrisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   or1k-linux-ld: kernel/printk/printk.o: in function `console_flush_on_panic':
>> printk.c:(.text+0x1020): undefined reference to `console_emit_next_record'
   printk.c:(.text+0x1020): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `console_emit_next_record'
   `.exit.text' referenced in section `.data' of sound/soc/codecs/tlv320adc3xxx.o: defined in discarded section `.exit.text' of sound/soc/codecs/tlv320adc3xxx.o

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

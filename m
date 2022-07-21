Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F31B57D5F1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 23:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbiGUV36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 17:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiGUV34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:29:56 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF8092866
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 14:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658438996; x=1689974996;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aMxvkGMJu6fCt2UWyIFq5/6sZUpxfeN7gqoy7RUtUeE=;
  b=Hd6Ue/QAjhwv9raXbmShQrTwnOOC851ofkD4PKX2MEYfo/NQmHYi60yp
   G3ivuLg5ZDWi2rFYbGLZ6D0UfoHXqNGbMQ9rA1GTq19EafT8U9Xc3QL7y
   +KV7A0pg1wsfAduqEdx90ZibTcYLDdAjDlrn4JKzBU4peZDbrIv7XGMD+
   VxCqLNC8eHlT67GYM5N1Kh2UUtcLgdtlrQ6QK02DWfoQtBVkb8bxsb+MZ
   sz5SUjVjOe49Vn/WFieWgwup5O26owwai3ordf3TPtPd1C80XAFaVbi7A
   IdJo75e5Yfz8Io+hMpBgM5HJC1nUupeVySZR1ZvnXU1/PvgqA3858Ot+F
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="285939240"
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="285939240"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 14:29:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="573914727"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 21 Jul 2022 14:29:54 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oEdk1-0000Zu-1t;
        Thu, 21 Jul 2022 21:29:53 +0000
Date:   Fri, 22 Jul 2022 05:29:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: /tmp/ccs3nHmO.s:32: Error: invalid literal constant: pool needs to
 be closer
Message-ID: <202207220517.URy8IkEJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   68e77ffbfd06ae3ef8f2abf1c3b971383c866983
commit: 7e9bf33b812471ee57a03ec7f9b544ca437cc706 ARM: kprobes: Make a frame pointer on __kretprobe_trampoline
date:   9 months ago
config: arm-randconfig-r013-20220721 (https://download.01.org/0day-ci/archive/20220722/202207220517.URy8IkEJ-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7e9bf33b812471ee57a03ec7f9b544ca437cc706
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 7e9bf33b812471ee57a03ec7f9b544ca437cc706
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/arm/probes/kprobes/core.c:236:16: warning: no previous prototype for 'kprobe_handler' [-Wmissing-prototypes]
     236 | void __kprobes kprobe_handler(struct pt_regs *regs)
         |                ^~~~~~~~~~~~~~
   arch/arm/probes/kprobes/core.c: In function 'arch_init_kprobes':
   arch/arm/probes/kprobes/core.c:465:12: warning: old-style function definition [-Wold-style-definition]
     465 | int __init arch_init_kprobes()
         |            ^~~~~~~~~~~~~~~~~
   /tmp/ccs3nHmO.s: Assembler messages:
>> /tmp/ccs3nHmO.s:32: Error: invalid literal constant: pool needs to be closer

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

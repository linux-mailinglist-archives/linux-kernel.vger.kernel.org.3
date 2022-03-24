Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8697A4E5DDA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 05:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242080AbiCXEoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 00:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbiCXEoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 00:44:07 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F828954A9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 21:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648096956; x=1679632956;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Y2qY/2VdzQuaRCi35sga6XF1Tgp0P18OCacrK88VzNI=;
  b=SCmBrXnSFqH139cFDfayPeolhm+hhIwasBaSeRNAqaDJhfUsLy4/maI5
   oXCzubB//LRd8FL7BRsyHZYZQ/axW+IBb2udNw1elobT10lC9GXYJ3i7H
   6nqduab9Hst/0HCMcHXYCHTRzt2a2VamNCNEMQ+VGi98pz+n/xkwv1zjU
   LO8aXt60fMsiTVEvo0a7Eg12ttOBSsNIPZ4dgPrGu5/Cm76bDjE3wVYSC
   RDkp1jvqnF2o1hO3pJw4+JfNuJ+4TC6MBYH4MBlc07dZiKsDzko8ISOX1
   8jSxA3ywg/vtbQ19ieBzDALC4Q60Q7RSU844q5KdfynAGntj1z6cznf47
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="245762622"
X-IronPort-AV: E=Sophos;i="5.90,206,1643702400"; 
   d="scan'208";a="245762622"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 21:42:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,206,1643702400"; 
   d="scan'208";a="649709414"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 23 Mar 2022 21:42:33 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXFIv-000KhM-2U; Thu, 24 Mar 2022 04:42:33 +0000
Date:   Thu, 24 Mar 2022 12:41:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: /tmp/ccMaTzSc.s:32: Error: invalid literal constant: pool needs to
 be closer
Message-ID: <202203241246.45yFfYOW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d51b1b33c51d147b757f042b4d336603b699f362
commit: 7e9bf33b812471ee57a03ec7f9b544ca437cc706 ARM: kprobes: Make a frame pointer on __kretprobe_trampoline
date:   5 months ago
config: arm-randconfig-r003-20220323 (https://download.01.org/0day-ci/archive/20220324/202203241246.45yFfYOW-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7e9bf33b812471ee57a03ec7f9b544ca437cc706
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 7e9bf33b812471ee57a03ec7f9b544ca437cc706
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/arm/probes/kprobes/core.c:236:16: warning: no previous prototype for 'kprobe_handler' [-Wmissing-prototypes]
     236 | void __kprobes kprobe_handler(struct pt_regs *regs)
         |                ^~~~~~~~~~~~~~
   arch/arm/probes/kprobes/core.c: In function 'arch_init_kprobes':
   arch/arm/probes/kprobes/core.c:465:12: warning: old-style function definition [-Wold-style-definition]
     465 | int __init arch_init_kprobes()
         |            ^~~~~~~~~~~~~~~~~
   /tmp/ccMaTzSc.s: Assembler messages:
>> /tmp/ccMaTzSc.s:32: Error: invalid literal constant: pool needs to be closer

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

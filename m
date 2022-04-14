Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3121C5017B4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359393AbiDNPog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352601AbiDNPRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:17:40 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89872E9979
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649948524; x=1681484524;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TgkPZshN5hDEklQlrl5b3Kc0wb0nYhlnABPZbUPVVos=;
  b=nzBwpwiem7SK8h6T3BEBe8hEwo4l86Q8tmyjOJDVjPdA0IZw4ZK6dDp9
   h3z9KbE+cTb6vEKeDzXhLt/073TRCCnuEBNvs3GSupXYPC46Kfg9HBEWa
   I0QQSpS1aWBHqPnYTbL6rtGhd8L6RC6BMkCWgZwUrtZ0DTmdZMtebYhUP
   9vNQ1x4F98pF8x6O4p6IvjxuvL8F67CqBjzNngiVhw5erDrq4q5g0nBhc
   pvOppqAbHxHVwIcaz2L28nsh3kRDT8F7kPd/IRCgyuUpQkRj66p6M5D9i
   SJTedUjgvgkPg+oyoAH6d/XkbxxRphxOqRYFNBuOwPDpFw0f3PZzJApbP
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="262392969"
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="262392969"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 08:02:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="527424783"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 14 Apr 2022 08:02:02 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nf0yv-00012f-PK;
        Thu, 14 Apr 2022 15:02:01 +0000
Date:   Thu, 14 Apr 2022 23:01:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jpoimboe:objtool-run 11/29] arch/powerpc/kernel/smp.c:1781:1:
 warning: 'noreturn' function does return
Message-ID: <202204142253.7Hya9r42-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git objtool-run
head:   47d3f4f7a72524799c1f646713e2377e3c4e239f
commit: 685d8d205c29aa853326bd2bb27dcee2ba1f5ef4 [11/29] sched: Convert arch_cpu_idle_dead() to proper __noreturn
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220414/202204142253.7Hya9r42-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/commit/?id=685d8d205c29aa853326bd2bb27dcee2ba1f5ef4
        git remote add jpoimboe https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git
        git fetch --no-tags jpoimboe objtool-run
        git checkout 685d8d205c29aa853326bd2bb27dcee2ba1f5ef4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/powerpc/kernel/smp.c: In function 'arch_cpu_idle_dead':
>> arch/powerpc/kernel/smp.c:1781:1: warning: 'noreturn' function does return
    1781 | }
         | ^


vim +/noreturn +1781 arch/powerpc/kernel/smp.c

d0174c721900ff8 Nathan Fontenot        2010-01-14  1767  
1ea21ba231f2480 Michael Ellerman       2020-08-19  1768  void arch_cpu_idle_dead(void)
1ea21ba231f2480 Michael Ellerman       2020-08-19  1769  {
424ef0160f439fe Naveen N. Rao          2018-04-19  1770  	/*
424ef0160f439fe Naveen N. Rao          2018-04-19  1771  	 * Disable on the down path. This will be re-enabled by
424ef0160f439fe Naveen N. Rao          2018-04-19  1772  	 * start_secondary() via start_secondary_resume() below
424ef0160f439fe Naveen N. Rao          2018-04-19  1773  	 */
424ef0160f439fe Naveen N. Rao          2018-04-19  1774  	this_cpu_disable_ftrace();
424ef0160f439fe Naveen N. Rao          2018-04-19  1775  
39f87561454dc33 Michael Ellerman       2020-08-19  1776  	if (smp_ops->cpu_offline_self)
39f87561454dc33 Michael Ellerman       2020-08-19  1777  		smp_ops->cpu_offline_self();
fa3f82c8bb7acbe Benjamin Herrenschmidt 2011-02-10  1778  
fa3f82c8bb7acbe Benjamin Herrenschmidt 2011-02-10  1779  	/* If we return, we re-enter start_secondary */
fa3f82c8bb7acbe Benjamin Herrenschmidt 2011-02-10  1780  	start_secondary_resume();
abb17f9c3a92c5a Milton Miller          2010-05-19 @1781  }
fa3f82c8bb7acbe Benjamin Herrenschmidt 2011-02-10  1782  

:::::: The code at line 1781 was first introduced by commit
:::::: abb17f9c3a92c5acf30e749efdf0419b7f50a5b8 powerpc: Use common cpu_die (fixes SMP+SUSPEND build)

:::::: TO: Milton Miller <miltonm@bga.com>
:::::: CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

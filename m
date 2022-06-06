Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C62153F160
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 23:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbiFFVHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 17:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235570AbiFFVFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 17:05:40 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7E59EB5E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654549110; x=1686085110;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dC3Ijlonh40gJE6pA0Lcmy82WfPWUbyE9GYZgPSu0AQ=;
  b=QQtdHXYPbMd+7P35xVjJyqAN2n9HvbY/nB6ECy1+RNXaGKdSgqBFJpUk
   yn0Up9kg6NvVJHNXBkIlpgGCMdavCB/LyHoz8j3LGjxaNTg9gJYSzKSu3
   Zu4Xog6RGPWF55iP5AX2hJE4eGSTj0bh3eEbs9B0yzbyGORYWRHwuNdlb
   rbCgbWsKmGz+4nSDPMZm1UvkR8XafiRB+38n4M98X7TBwfLCJ1VtBz6HL
   8mXJT8lR7SVU95TSIAYg+QY5EhqtdcIqZsJ2Qy3Fsb3i6wOf5owFSDNGA
   D2rnTmJHKp2cYK2VVCxryhgGz5E/r6uOU+yy/FUjIfENl2Y2R6ac+fsVU
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="257135140"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="257135140"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 13:58:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="647735647"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jun 2022 13:58:29 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nyJnw-000D2v-Do;
        Mon, 06 Jun 2022 20:58:28 +0000
Date:   Tue, 7 Jun 2022 04:58:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mark:arm64/ftrace/per-callsite-ops 2/4]
 drivers/parisc/eisa_eeprom.c:101:1: warning: 'text_section' attribute
 directive ignored
Message-ID: <202206070415.5WlkjwGl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/ftrace/per-callsite-ops
head:   7f0d1ffaab77795e4ca97db4a901cc347c850ff7
commit: efc001292934b744fa4c8147668fa4bd0ee909bf [2/4] WIP: incomplete alignment hacks
config: parisc-defconfig (https://download.01.org/0day-ci/archive/20220607/202206070415.5WlkjwGl-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=efc001292934b744fa4c8147668fa4bd0ee909bf
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark arm64/ftrace/per-callsite-ops
        git checkout efc001292934b744fa4c8147668fa4bd0ee909bf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> drivers/parisc/eisa_eeprom.c:101:1: warning: 'text_section' attribute directive ignored [-Wattributes]
101 | module_init(eisa_eeprom_init);
| ^~~~~~~~~~~
--
>> drivers/parisc/led.c:145:1: warning: 'text_section' attribute directive ignored [-Wattributes]
145 | device_initcall(start_task);
| ^~~~~~~~~~~~~~~
drivers/parisc/led.c:776:1: warning: 'text_section' attribute directive ignored [-Wattributes]
776 | module_init(led_create_procfs)
| ^~~~~~~~~~~
--
drivers/parisc/pdc_stable.c: In function 'pdc_stable_init':
drivers/parisc/pdc_stable.c:1029:21: warning: variable 'error' set but not used [-Wunused-but-set-variable]
1029 |         int rc = 0, error = 0;
|                     ^~~~~
drivers/parisc/pdc_stable.c: At top level:
>> drivers/parisc/pdc_stable.c:1093:1: warning: 'text_section' attribute directive ignored [-Wattributes]
1093 | module_init(pdc_stable_init);
| ^~~~~~~~~~~
--
>> drivers/parisc/power.c:249:1: warning: 'text_section' attribute directive ignored [-Wattributes]
249 | arch_initcall(power_init);
| ^~~~~~~~~~~~~
--
>> kernel/time/sched_clock.c:296:1: warning: 'text_section' attribute directive ignored [-Wattributes]
296 | device_initcall(sched_clock_syscore_init);
| ^~~~~~~~~~~~~~~
--
>> drivers/video/console/sticon.c:407:1: warning: 'text_section' attribute directive ignored [-Wattributes]
407 | module_init(sticonsole_init);
| ^~~~~~~~~~~
--
>> drivers/video/logo/logo.c:38:1: warning: 'text_section' attribute directive ignored [-Wattributes]
38 | late_initcall_sync(fb_logo_late_init);
| ^~~~~~~~~~~~~~~~~~
--
net/socket.c: In function '__sys_getsockopt':
net/socket.c:2285:13: warning: variable 'max_optlen' set but not used [-Wunused-but-set-variable]
2285 |         int max_optlen;
|             ^~~~~~~~~~
net/socket.c: At top level:
>> net/socket.c:3219:1: warning: 'text_section' attribute directive ignored [-Wattributes]
3219 | core_initcall(sock_init);       /* early initcall */
| ^~~~~~~~~~~~~
--
>> net/core/sock.c:3690:1: warning: 'text_section' attribute directive ignored [-Wattributes]
3690 | core_initcall(net_inuse_init);
| ^~~~~~~~~~~~~
net/core/sock.c:4003:1: warning: 'text_section' attribute directive ignored [-Wattributes]
4003 | subsys_initcall(proto_init);
| ^~~~~~~~~~~~~~~
--
>> net/core/net_namespace.c:378:1: warning: 'text_section' attribute directive ignored [-Wattributes]
378 | core_initcall(net_defaults_init);
| ^~~~~~~~~~~~~
--
>> net/core/flow_dissector.c:1891:1: warning: 'text_section' attribute directive ignored [-Wattributes]
1891 | core_initcall(init_default_flow_dissectors);
| ^~~~~~~~~~~~~
..


vim +/text_section +101 drivers/parisc/eisa_eeprom.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  100  
^1da177e4c3f41 Linus Torvalds 2005-04-16 @101  module_init(eisa_eeprom_init);

:::::: The code at line 101 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

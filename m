Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37BEC49F1A5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 04:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241963AbiA1DHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 22:07:53 -0500
Received: from mga11.intel.com ([192.55.52.93]:9240 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237367AbiA1DHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 22:07:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643339272; x=1674875272;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gFys88Ras/M0GvUvSWtNndTF06hqIqj+FzN0F3BrYyg=;
  b=ZA9FsGWT1SWk+IVmi/vFrEDYDXjA4lCwVw42/E8Lg0qvfsljYdi/hcxJ
   QyMWOo+Bp4svxk/yl7+1nytjNR2Tw0hYkp3jJ3d8PQXbGlWOEU2VeQnOn
   JUuqBNxIPyNzKbIhS4gG5hRWzB8w/4TUwsWGdIeLlT+6upW+lFJY2USHz
   a2UJuOYA2nxVqbNr34P0RAxzzy3MLFgd8FiZmRNZn4aWUqhOAaX4Xm5BJ
   Yuiq3dCBzchzedPOqIhh54UgN29f12mMHPVjLd0baOwTZO5b5kYmVyZ1n
   GZq3zhdVFqL0QFLeUqb5MvVn0YsQRfkkmRXi170UBb+tl8gZTQZO0q7CW
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="244632205"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="244632205"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 19:07:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="618576061"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Jan 2022 19:07:51 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDHc6-000NMx-Cs; Fri, 28 Jan 2022 03:07:50 +0000
Date:   Fri, 28 Jan 2022 11:07:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [zanussi-trace:ftrace/misc-bugfixes-v1 7/7]
 kernel/trace/trace_events_synth.c:65:9: warning: 'strncpy' output truncated
 before terminating nul copying as many bytes from a string as its length
Message-ID: <202201281113.KBRwLvOv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/misc-bugfixes-v1
head:   a291c672d6e1d7f557d9e15a5ac3f0b446e29dcd
commit: a291c672d6e1d7f557d9e15a5ac3f0b446e29dcd [7/7] tracing: Remove size restriction on synthetic event cmd error logging
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20220128/202201281113.KBRwLvOv-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git/commit/?id=a291c672d6e1d7f557d9e15a5ac3f0b446e29dcd
        git remote add zanussi-trace https://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git
        git fetch --no-tags zanussi-trace ftrace/misc-bugfixes-v1
        git checkout a291c672d6e1d7f557d9e15a5ac3f0b446e29dcd
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc SHELL=/bin/bash kernel/trace/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/trace/trace_events_synth.c: In function 'last_cmd_set':
>> kernel/trace/trace_events_synth.c:65:9: warning: 'strncpy' output truncated before terminating nul copying as many bytes from a string as its length [-Wstringop-truncation]
      65 |         strncpy(last_cmd, str, strlen(str));
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/strncpy +65 kernel/trace/trace_events_synth.c

    54	
    55	static void last_cmd_set(const char *str)
    56	{
    57		if (!str)
    58			return;
    59	
    60		kfree(last_cmd);
    61		last_cmd = kzalloc(strlen(str) + 1, GFP_KERNEL);
    62		if (!last_cmd)
    63			return;
    64	
  > 65		strncpy(last_cmd, str, strlen(str));
    66	}
    67	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

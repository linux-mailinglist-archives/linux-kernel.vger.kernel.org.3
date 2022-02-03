Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2044D4A7E50
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 04:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349192AbiBCDVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 22:21:43 -0500
Received: from mga11.intel.com ([192.55.52.93]:7798 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231626AbiBCDVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 22:21:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643858502; x=1675394502;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JsjU3287yui3q4ZvISai0jO0+LoBy56Z2Yj+bgDEGWM=;
  b=F5N5kdBuwTQLz5Gi4Ujh8ZgExwpfWMo60/b29qGdi5NYyQpxmjSIiRD1
   3AvntKuSXEsGi0+tlghVhLzLtJFlimPCxW1aZK2qp8azONtM0P+ocAV3i
   /0kmzyLtoKjz/D89ZZ2SW8H6VwKWHosjGSOzlpcAvCFLnpiu/EIRgGfgF
   mucMLqzx1mbUs3Nhf+zddBI90bKJwSRqj5NwHHjGHnegmjcZv9Jo6fH23
   K26IY8SaLgviyxjzz49pqtMDShLCexBKr/R5ewDbvU6w0cZzVNlKfqByN
   DD5kqPozHke0TOG3KbeZafdn7qTZjxAwu6Hh/4WMmx+wJb1E6P3u8xQxP
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="245664422"
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="245664422"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 19:21:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="497996772"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 02 Feb 2022 19:21:40 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFSgl-000VUk-AM; Thu, 03 Feb 2022 03:21:39 +0000
Date:   Thu, 3 Feb 2022 11:20:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [jolsa-perf:bpf/fprobe_link 3/10] include/linux/fprobe.h:20:33:
 error: field 'ops' has incomplete type
Message-ID: <202202031105.OEGj0FZz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/fprobe_link
head:   f35f5b111d32e11c2201dcbfa5e3c8c0560a0a43
commit: 5292dedae3df76ecaa8b83f3a440172a78fff570 [3/10] bpf: Add support to attach kprobe program with fprobe
config: arc-randconfig-r043-20220130 (https://download.01.org/0day-ci/archive/20220203/202202031105.OEGj0FZz-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=5292dedae3df76ecaa8b83f3a440172a78fff570
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/fprobe_link
        git checkout 5292dedae3df76ecaa8b83f3a440172a78fff570
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/bpf/syscall.c:35:
>> include/linux/fprobe.h:20:33: error: field 'ops' has incomplete type
      20 |         struct ftrace_ops       ops;
         |                                 ^~~


vim +/ops +20 include/linux/fprobe.h

8249a1c232ade1 Masami Hiramatsu 2022-01-26   9  
8249a1c232ade1 Masami Hiramatsu 2022-01-26  10  /**
8249a1c232ade1 Masami Hiramatsu 2022-01-26  11   * struct fprobe - ftrace based probe.
8249a1c232ade1 Masami Hiramatsu 2022-01-26  12   * @ops: The ftrace_ops.
8249a1c232ade1 Masami Hiramatsu 2022-01-26  13   * @nmissed: The counter for missing events.
8249a1c232ade1 Masami Hiramatsu 2022-01-26  14   * @flags: The status flag.
806149decce8b0 Masami Hiramatsu 2022-01-26  15   * @rethook: The rethook data structure. (internal data)
8249a1c232ade1 Masami Hiramatsu 2022-01-26  16   * @entry_handler: The callback function for function entry.
806149decce8b0 Masami Hiramatsu 2022-01-26  17   * @exit_handler: The callback function for function exit.
8249a1c232ade1 Masami Hiramatsu 2022-01-26  18   */
8249a1c232ade1 Masami Hiramatsu 2022-01-26  19  struct fprobe {
8249a1c232ade1 Masami Hiramatsu 2022-01-26 @20  	struct ftrace_ops	ops;
8249a1c232ade1 Masami Hiramatsu 2022-01-26  21  	unsigned long		nmissed;
8249a1c232ade1 Masami Hiramatsu 2022-01-26  22  	unsigned int		flags;
806149decce8b0 Masami Hiramatsu 2022-01-26  23  	struct rethook		*rethook;
806149decce8b0 Masami Hiramatsu 2022-01-26  24  
8249a1c232ade1 Masami Hiramatsu 2022-01-26  25  	void (*entry_handler)(struct fprobe *fp, unsigned long entry_ip, struct pt_regs *regs);
806149decce8b0 Masami Hiramatsu 2022-01-26  26  	void (*exit_handler)(struct fprobe *fp, unsigned long entry_ip, struct pt_regs *regs);
8249a1c232ade1 Masami Hiramatsu 2022-01-26  27  };
8249a1c232ade1 Masami Hiramatsu 2022-01-26  28  

:::::: The code at line 20 was first introduced by commit
:::::: 8249a1c232ade17392af10f640a79a5200744474 fprobe: Add ftrace based probe APIs

:::::: TO: Masami Hiramatsu <mhiramat@kernel.org>
:::::: CC: Masami Hiramatsu <mhiramat@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

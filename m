Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC329484DC8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 06:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236238AbiAEFsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 00:48:30 -0500
Received: from mga11.intel.com ([192.55.52.93]:59008 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237554AbiAEFs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 00:48:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641361708; x=1672897708;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0pGBLO99Zp/Ln6sPDu4w0Nqf0gXluODzyukMD2LS1KU=;
  b=T3KIZucxxJpWBeAuT7rxYVQbSaPk8y36OXATIunNY1BwA7fmLh5wrYX2
   TsQnWpBT83CWcBX9jdRar5WFWFfdf7PAUQXvF+5dxQPxiCrPq+yF0PumZ
   Wl6BbRTROtEhsvDoKJhi0e+l6YskQkHaolsm/k3jmSMiW4vRSMzwxNeoN
   4pzIBHoHHQTse/2WBI2sXh7Yrcn4iZnIcP0iQLmSdeLGjt72E6+vz8pn9
   FNf1akqKTTRDfDBJwaHq8gNcpL5NYum3M0FLUwai26mSy3GL47SGs6TJo
   c8r/9lbyNvFH/+oAvGtWQkwneun5XmyMQlw5kkW4JOSlFXIVHJ9J0OR9w
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="239915241"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="239915241"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 21:48:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="556414905"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 04 Jan 2022 21:48:27 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n4z9u-000GJ7-JL; Wed, 05 Jan 2022 05:48:26 +0000
Date:   Wed, 5 Jan 2022 13:47:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jolsa-perf:kprobe/multi 9/14] kernel/bpf/syscall.c:3101:25: error:
 implicit declaration of function 'get_kretprobe'; did you mean 'get_kprobe'?
Message-ID: <202201051354.QjvAtGDv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git kprobe/multi
head:   27d253a29de023f664387fcc049edeeaadf23c8e
commit: b8b03607ea9875a92ea20941ebe6813fb052aeff [9/14] bpf: Add kprobe link for attaching raw kprobes
config: x86_64-buildonly-randconfig-r001-20220105 (https://download.01.org/0day-ci/archive/20220105/202201051354.QjvAtGDv-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=b8b03607ea9875a92ea20941ebe6813fb052aeff
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf kprobe/multi
        git checkout b8b03607ea9875a92ea20941ebe6813fb052aeff
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/bpf/syscall.c: In function 'kretprobe_dispatcher':
>> kernel/bpf/syscall.c:3101:25: error: implicit declaration of function 'get_kretprobe'; did you mean 'get_kprobe'? [-Werror=implicit-function-declaration]
    3101 |  struct kretprobe *rp = get_kretprobe(ri);
         |                         ^~~~~~~~~~~~~
         |                         get_kprobe
   kernel/bpf/syscall.c:3101:25: warning: initialization of 'struct kretprobe *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   cc1: some warnings being treated as errors


vim +3101 kernel/bpf/syscall.c

  3097	
  3098	static int
  3099	kretprobe_dispatcher(struct kretprobe_instance *ri, struct pt_regs *regs)
  3100	{
> 3101		struct kretprobe *rp = get_kretprobe(ri);
  3102		struct bpf_kprobe_link *kprobe_link;
  3103	
  3104		kprobe_link = container_of(rp, struct bpf_kprobe_link, rp);
  3105		return kprobe_link_prog_run(kprobe_link, regs);
  3106	}
  3107	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

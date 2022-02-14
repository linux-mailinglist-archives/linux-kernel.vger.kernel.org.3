Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DE84B5E26
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 00:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbiBNXRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 18:17:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiBNXRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 18:17:32 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC24C11ACE5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 15:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644880643; x=1676416643;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=h58TGqMYYScHpHkX1cS/n0upCHHRwSUwIeZYk3KFmlY=;
  b=WmkSsEIZm9uC8tnlvoDpIfPJ9Bsp6MUkp/Bli0mJFqdf/AAhNFIojkjz
   eA8W0BSiLdaD1lsAohfksfe4iG/kQagmvIiKI0tEZgPUz6cwMHsIvWV5z
   2FImo+kD9v8pjF3znEU11nbX8klt+4oIGCn0To/HUfyjad5pu1E2YYlmQ
   Rh5RuOBDIg7sjdkD9eylMNCC4MLU+x5AC/Jh7y13PacpMtwegljjl9AUV
   fa4O1sZHl8S9lCgAlD+L5RzrZfr/vJrbVCPpJheeB4PUgawc+QgEWMD1C
   3Nc7NvtAf/5A+os/tLrkU1RNhAidmuN4ABrqZrvKsdcrjeHidotsw8C+W
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="230844100"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="230844100"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 15:17:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="624488965"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Feb 2022 15:17:22 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJkav-00091Z-Oq; Mon, 14 Feb 2022 23:17:21 +0000
Date:   Tue, 15 Feb 2022 07:17:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [jolsa-perf:bpf/fprobe_link_6 3/11]
 include/linux/trace_events.h:781:47: warning: declaration of 'union
 bpf_attr' will not be visible outside of this function
Message-ID: <202202150707.pEsVvhSW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/fprobe_link_6
head:   bb2f8cf233977d40c029e2f718e95f637980e350
commit: 00327b2f7c60bd84d8c5e887003987b2e688d159 [3/11] bpf: Add support to attach kprobe program with fprobe
config: hexagon-randconfig-r041-20220214 (https://download.01.org/0day-ci/archive/20220215/202202150707.pEsVvhSW-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project ea071884b0cc7210b3cc5fe858f0e892a779a23b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=00327b2f7c60bd84d8c5e887003987b2e688d159
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/fprobe_link_6
        git checkout 00327b2f7c60bd84d8c5e887003987b2e688d159
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/base/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/base/syscore.c:12:
   In file included from include/trace/events/power.h:12:
>> include/linux/trace_events.h:781:47: warning: declaration of 'union bpf_attr' will not be visible outside of this function [-Wvisibility]
   static int bpf_fprobe_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
                                                 ^
   include/linux/trace_events.h:781:12: warning: unused function 'bpf_fprobe_link_attach' [-Wunused-function]
   static int bpf_fprobe_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
              ^
   2 warnings generated.


vim +781 include/linux/trace_events.h

   753	
   754	static inline int
   755	perf_event_query_prog_array(struct perf_event *event, void __user *info)
   756	{
   757		return -EOPNOTSUPP;
   758	}
   759	static inline int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *p)
   760	{
   761		return -EOPNOTSUPP;
   762	}
   763	static inline int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_prog *p)
   764	{
   765		return -EOPNOTSUPP;
   766	}
   767	static inline struct bpf_raw_event_map *bpf_get_raw_tracepoint(const char *name)
   768	{
   769		return NULL;
   770	}
   771	static inline void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
   772	{
   773	}
   774	static inline int bpf_get_perf_event_info(const struct perf_event *event,
   775						  u32 *prog_id, u32 *fd_type,
   776						  const char **buf, u64 *probe_offset,
   777						  u64 *probe_addr)
   778	{
   779		return -EOPNOTSUPP;
   780	}
 > 781	static int bpf_fprobe_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
   782	{
   783		return -EOPNOTSUPP;
   784	}
   785	#endif
   786	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

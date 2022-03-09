Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A734D3D86
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 00:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238674AbiCIXZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 18:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiCIXZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 18:25:25 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD96D5B3CC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 15:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646868265; x=1678404265;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1p/C3MVtcxwPEFM3eCisO7SmBppSnzUo/AzwN86sCNs=;
  b=iWb6VSw/XyBy/kVH2mxLh6xiWy05O7qXI/S2tHwp2/9OKHzBkSlxd2OZ
   /hZD1Dniy0aWvM5oeGRX8MT3/x669DaenIDTGLYiDlZXqGqnxoE9gkWEm
   zxQnQD7HaXjKB8sTm29R0TldoY/lKOvKphV6RDK7XK9jo663pEVukwz/9
   Y6YPWZZCdFs35j4lgjJi67p19tjPwRylG+cfmvdNGfpm4Gbgv6kChGVZ4
   g1GQG6irAr1CptwOEF5co1FttmZ4AlwwXm4R/hvE8SXnHmhpsZUE3Fclt
   7Id67dWk3UJXS7v110EziMz9XI1HvZEpK7ZmuJCYqdYY7RkdogZBsZi0E
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="315831070"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="315831070"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 15:24:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="513731464"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 09 Mar 2022 15:24:23 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nS5fK-0003xG-V6; Wed, 09 Mar 2022 23:24:22 +0000
Date:   Thu, 10 Mar 2022 07:23:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [jolsa-perf:bpf/kprobe_multi_4 3/11]
 include/linux/trace_events.h:784:42: warning: 'union bpf_attr' declared
 inside parameter list will not be visible outside of this definition or
 declaration
Message-ID: <202203100753.ca2Tl49i-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/kprobe_multi_4
head:   02731d567ee31d7c7f012e9c5930f114ed1e2478
commit: c330e21ba4633cb075ce0c4c5f936b16ed722666 [3/11] bpf: Add multi kprobe link
config: arm-buildonly-randconfig-r003-20220309 (https://download.01.org/0day-ci/archive/20220310/202203100753.ca2Tl49i-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=c330e21ba4633cb075ce0c4c5f936b16ed722666
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/kprobe_multi_4
        git checkout c330e21ba4633cb075ce0c4c5f936b16ed722666
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/usb/typec/tipd/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/trace/trace_events.h:21,
                    from include/trace/define_trace.h:102,
                    from drivers/usb/typec/tipd/trace.h:306,
                    from drivers/usb/typec/tipd/trace.c:9:
>> include/linux/trace_events.h:784:42: warning: 'union bpf_attr' declared inside parameter list will not be visible outside of this definition or declaration
     784 | bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
         |                                          ^~~~~~~~


vim +784 include/linux/trace_events.h

   755	
   756	static inline int
   757	perf_event_query_prog_array(struct perf_event *event, void __user *info)
   758	{
   759		return -EOPNOTSUPP;
   760	}
   761	static inline int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *p)
   762	{
   763		return -EOPNOTSUPP;
   764	}
   765	static inline int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_prog *p)
   766	{
   767		return -EOPNOTSUPP;
   768	}
   769	static inline struct bpf_raw_event_map *bpf_get_raw_tracepoint(const char *name)
   770	{
   771		return NULL;
   772	}
   773	static inline void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
   774	{
   775	}
   776	static inline int bpf_get_perf_event_info(const struct perf_event *event,
   777						  u32 *prog_id, u32 *fd_type,
   778						  const char **buf, u64 *probe_offset,
   779						  u64 *probe_addr)
   780	{
   781		return -EOPNOTSUPP;
   782	}
   783	static inline int
 > 784	bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
   785	{
   786		return -EOPNOTSUPP;
   787	}
   788	#endif
   789	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

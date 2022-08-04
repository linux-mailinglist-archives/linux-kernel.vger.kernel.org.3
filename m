Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C4358A112
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 21:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239199AbiHDTGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 15:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbiHDTGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 15:06:33 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175DD6C11D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 12:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659639993; x=1691175993;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rAn/9kIyfOTVUOwrvRDr23WkgtE1eVnKkPjs3NRkAJ0=;
  b=VgusdLtIoBc8O6czyIKBJUp8HrmPt5qbUtQ++EPvzw5KCnT2p2phLkI4
   +7OLPG1Ml5hIdzYGgqRBB2gAqKNKafVwZykB5+wSBUywfLPzQ6j5Vz2iY
   nkexGWOEyAmH8NhCLk6fCTBplfrgU2043QaoXDtC6TUDWL14znHtD4ww0
   CCyurG2Km6tGMV3N6NbuOvGfXOCzdPPicjYntAE5ryCPeNCviI6WCNw/+
   IWz83RfCf4Ot/iWVuaqQ6pvnWkT/65892bcnidXJAkkEDxo4Cg5GA0Tcr
   J8W1kxISba0SPRDnUoBJHcYP0gS/Cae8LG9GK3Tv7r19OBiSRPzED0N3W
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="270405043"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="270405043"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 12:06:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="671385225"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 04 Aug 2022 12:06:31 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJgAx-000IkC-0l;
        Thu, 04 Aug 2022 19:06:31 +0000
Date:   Fri, 5 Aug 2022 03:05:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/tracing_multi 12/18]
 include/linux/trace_events.h:797:5: error: no previous prototype for
 'bpf_tracing_multi_attach'
Message-ID: <202208050220.aexUPtTV-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/tracing_multi
head:   3f77a2c51293ea19f1ce6a9b06b9fa394beecd13
commit: e005380dc118dbc67a921f1797c50541f4c3f1e5 [12/18] bpf: Add support to create tracing multi link
config: i386-defconfig (https://download.01.org/0day-ci/archive/20220805/202208050220.aexUPtTV-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=e005380dc118dbc67a921f1797c50541f4c3f1e5
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/tracing_multi
        git checkout e005380dc118dbc67a921f1797c50541f4c3f1e5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/trace/trace_events.h:21,
                    from include/trace/define_trace.h:102,
                    from drivers/gpu/drm/i915/i915_trace.h:770,
                    from drivers/gpu/drm/i915/i915_trace_points.c:13:
>> include/linux/trace_events.h:797:5: error: no previous prototype for 'bpf_tracing_multi_attach' [-Werror=missing-prototypes]
     797 | int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/bpf_tracing_multi_attach +797 include/linux/trace_events.h

   764	
   765	static inline int
   766	perf_event_query_prog_array(struct perf_event *event, void __user *info)
   767	{
   768		return -EOPNOTSUPP;
   769	}
   770	static inline int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *p)
   771	{
   772		return -EOPNOTSUPP;
   773	}
   774	static inline int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_prog *p)
   775	{
   776		return -EOPNOTSUPP;
   777	}
   778	static inline struct bpf_raw_event_map *bpf_get_raw_tracepoint(const char *name)
   779	{
   780		return NULL;
   781	}
   782	static inline void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
   783	{
   784	}
   785	static inline int bpf_get_perf_event_info(const struct perf_event *event,
   786						  u32 *prog_id, u32 *fd_type,
   787						  const char **buf, u64 *probe_offset,
   788						  u64 *probe_addr)
   789	{
   790		return -EOPNOTSUPP;
   791	}
   792	static inline int
   793	bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
   794	{
   795		return -EOPNOTSUPP;
   796	}
 > 797	int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
   798	{
   799		return -EOPNOTSUPP;
   800	}
   801	#endif
   802	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

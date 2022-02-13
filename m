Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54ABC4B3E70
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 00:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbiBMXp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 18:45:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiBMXp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 18:45:27 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD93517F7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 15:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644795920; x=1676331920;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vIq7wEEw5zoRjUTLNHWIpi58XC+y52FiLKBokLABMmo=;
  b=aicD1hd1V+LiPbztlixmhEk3b1kmOF+3r3EzBoqayEXp6wiaz8OfZ0Hc
   nngFuEP0V/xiyxDLRt7qaM/cQMvQpPdolONSHE7LxthIFlz+CtbC4H97z
   p6y6OvBX+y5nOXJThGqTprzRqvO/G6TMZM/SFbASvEbO3kpDEjnnEjcIf
   olGZ0A2PqG0uErJxFCYlaxJvIyFI670Y0zKmScvVGfBU+NrUYpMwDulT1
   Uuv3Lgt4pzURb+IV/dLZP7pl519FHVBdFGeH7Qy3MzVDit6J+xYuyvuiV
   JXrIME8KAWMcQZKWZ0W6ZYWg/wi/WcVWWFTLvskEoPQO7BwyrmoEhgFPm
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="313263694"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="313263694"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 15:45:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="702801604"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 13 Feb 2022 15:45:19 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJOYQ-00080Q-Ez; Sun, 13 Feb 2022 23:45:18 +0000
Date:   Mon, 14 Feb 2022 07:44:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [jolsa-perf:bpf/fprobe_link_5 3/10] kernel/bpf/syscall.c:4337:
 undefined reference to `bpf_fprobe_link_attach'
Message-ID: <202202140713.Pklmh3QR-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/fprobe_link_5
head:   9149abfa25286fdf715525babec5150939c9ac96
commit: 32adbf1760d4cccb9702863371d50b625ae7ee1d [3/10] bpf: Add support to attach kprobe program with fprobe
config: i386-randconfig-c021 (https://download.01.org/0day-ci/archive/20220214/202202140713.Pklmh3QR-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=32adbf1760d4cccb9702863371d50b625ae7ee1d
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/fprobe_link_5
        git checkout 32adbf1760d4cccb9702863371d50b625ae7ee1d
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: kernel/bpf/syscall.o: in function `link_create':
>> kernel/bpf/syscall.c:4337: undefined reference to `bpf_fprobe_link_attach'


vim +4337 kernel/bpf/syscall.c

  4258	
  4259	#define BPF_LINK_CREATE_LAST_FIELD link_create.fprobe.flags
  4260	static int link_create(union bpf_attr *attr, bpfptr_t uattr)
  4261	{
  4262		enum bpf_prog_type ptype;
  4263		struct bpf_prog *prog;
  4264		int ret;
  4265	
  4266		if (CHECK_ATTR(BPF_LINK_CREATE))
  4267			return -EINVAL;
  4268	
  4269		prog = bpf_prog_get(attr->link_create.prog_fd);
  4270		if (IS_ERR(prog))
  4271			return PTR_ERR(prog);
  4272	
  4273		ret = bpf_prog_attach_check_attach_type(prog,
  4274							attr->link_create.attach_type);
  4275		if (ret)
  4276			goto out;
  4277	
  4278		switch (prog->type) {
  4279		case BPF_PROG_TYPE_EXT:
  4280			ret = tracing_bpf_link_attach(attr, uattr, prog);
  4281			goto out;
  4282		case BPF_PROG_TYPE_PERF_EVENT:
  4283		case BPF_PROG_TYPE_TRACEPOINT:
  4284			if (attr->link_create.attach_type != BPF_PERF_EVENT) {
  4285				ret = -EINVAL;
  4286				goto out;
  4287			}
  4288			ptype = prog->type;
  4289			break;
  4290		case BPF_PROG_TYPE_KPROBE:
  4291			if (attr->link_create.attach_type != BPF_PERF_EVENT &&
  4292			    attr->link_create.attach_type != BPF_TRACE_FPROBE) {
  4293				ret = -EINVAL;
  4294				goto out;
  4295			}
  4296			ptype = prog->type;
  4297			break;
  4298		default:
  4299			ptype = attach_type_to_prog_type(attr->link_create.attach_type);
  4300			if (ptype == BPF_PROG_TYPE_UNSPEC || ptype != prog->type) {
  4301				ret = -EINVAL;
  4302				goto out;
  4303			}
  4304			break;
  4305		}
  4306	
  4307		switch (ptype) {
  4308		case BPF_PROG_TYPE_CGROUP_SKB:
  4309		case BPF_PROG_TYPE_CGROUP_SOCK:
  4310		case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
  4311		case BPF_PROG_TYPE_SOCK_OPS:
  4312		case BPF_PROG_TYPE_CGROUP_DEVICE:
  4313		case BPF_PROG_TYPE_CGROUP_SYSCTL:
  4314		case BPF_PROG_TYPE_CGROUP_SOCKOPT:
  4315			ret = cgroup_bpf_link_attach(attr, prog);
  4316			break;
  4317		case BPF_PROG_TYPE_TRACING:
  4318			ret = tracing_bpf_link_attach(attr, uattr, prog);
  4319			break;
  4320		case BPF_PROG_TYPE_FLOW_DISSECTOR:
  4321		case BPF_PROG_TYPE_SK_LOOKUP:
  4322			ret = netns_bpf_link_create(attr, prog);
  4323			break;
  4324	#ifdef CONFIG_NET
  4325		case BPF_PROG_TYPE_XDP:
  4326			ret = bpf_xdp_link_attach(attr, prog);
  4327			break;
  4328	#endif
  4329		case BPF_PROG_TYPE_PERF_EVENT:
  4330		case BPF_PROG_TYPE_TRACEPOINT:
  4331			ret = bpf_perf_link_attach(attr, prog);
  4332			break;
  4333		case BPF_PROG_TYPE_KPROBE:
  4334			if (attr->link_create.attach_type == BPF_PERF_EVENT)
  4335				ret = bpf_perf_link_attach(attr, prog);
  4336			else
> 4337				ret = bpf_fprobe_link_attach(attr, prog);
  4338			break;
  4339		default:
  4340			ret = -EINVAL;
  4341		}
  4342	
  4343	out:
  4344		if (ret < 0)
  4345			bpf_prog_put(prog);
  4346		return ret;
  4347	}
  4348	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

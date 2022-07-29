Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5854258516E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 16:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236538AbiG2OUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 10:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236948AbiG2OUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 10:20:05 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42197AC26
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 07:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659104404; x=1690640404;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4gWrcWrWJgBokdA2N9hWZFx05zXm2QPBsuNfQ/ZPmL0=;
  b=TGdnGNU2ev4s/7oUaRcHTOn+Ua2HCo6iGR6Se8m1815aw0u4f5caxU3C
   3TzeTJX6dANdTof4/gf77ZYVIng2jQBQkhnL1u6YFd5MsftYT/eMwlb+2
   04hw4yfapdtWH5pK9EtdXZ9Ru9ugYrMPDOMc2hA07CoIV1ggZEUmloyc2
   0yjy3Ws1+a3UjblRyve4aeNX87iAMaiOIEbsgApFDJEFPMWwuEWYqikkv
   m3HnDd+HYX9M8FZlS+H6FfoF6+dhybWfykzr+1dTEmQpvPqEr/U/U0C3j
   LoUHWm/8ZTuu76OoAgbRdF9j4LSv6hAhI1GFod9Odrpi65hMifqKCaJPQ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="289544058"
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="289544058"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 07:20:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="629391553"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 29 Jul 2022 07:20:03 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHQqQ-000Bht-1z;
        Fri, 29 Jul 2022 14:20:02 +0000
Date:   Fri, 29 Jul 2022 22:19:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/tracing_multi_4 23/35]
 kernel/bpf/trampoline.c:1074:16: error: implicit declaration of function
 'ftrace_hash_alloc'
Message-ID: <202207292200.qt0ol0Ov-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/tracing_multi_4
head:   a63fc296e166a76b3f7250a966df4651e3a846f1
commit: 8544251d2b26ab91f208df1c72259b909968b9a8 [23/35] bpf: Add support to attach multi trampolines
config: x86_64-randconfig-a006 (https://download.01.org/0day-ci/archive/20220729/202207292200.qt0ol0Ov-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=8544251d2b26ab91f208df1c72259b909968b9a8
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/tracing_multi_4
        git checkout 8544251d2b26ab91f208df1c72259b909968b9a8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/bpf/trampoline.c: In function 'bpf_tramp_update_set':
>> kernel/bpf/trampoline.c:1074:16: error: implicit declaration of function 'ftrace_hash_alloc' [-Werror=implicit-function-declaration]
    1074 |         hash = ftrace_hash_alloc(FTRACE_HASH_MAX_BITS);
         |                ^~~~~~~~~~~~~~~~~
>> kernel/bpf/trampoline.c:1074:34: error: 'FTRACE_HASH_MAX_BITS' undeclared (first use in this function)
    1074 |         hash = ftrace_hash_alloc(FTRACE_HASH_MAX_BITS);
         |                                  ^~~~~~~~~~~~~~~~~~~~
   kernel/bpf/trampoline.c:1074:34: note: each undeclared identifier is reported only once for each function it appears in
>> kernel/bpf/trampoline.c:1101:33: error: implicit declaration of function 'ftrace_hash_add_entry' [-Werror=implicit-function-declaration]
    1101 |                                 ftrace_hash_add_entry(hash, entry);
         |                                 ^~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/trampoline.c:1115:15: error: implicit declaration of function 'set_ftrace_direct'; did you mean 'modify_ftrace_direct'? [-Werror=implicit-function-declaration]
    1115 |         err = set_ftrace_direct(hash);
         |               ^~~~~~~~~~~~~~~~~
         |               modify_ftrace_direct
>> kernel/bpf/trampoline.c:1117:9: error: implicit declaration of function 'ftrace_hash_free' [-Werror=implicit-function-declaration]
    1117 |         ftrace_hash_free(hash);
         |         ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/ftrace_hash_alloc +1074 kernel/bpf/trampoline.c

  1067	
  1068	static int bpf_tramp_update_set(struct list_head *upd)
  1069	{
  1070		struct bpf_trampoline *tr;
  1071		struct ftrace_hash *hash;
  1072		int i, err;
  1073	
> 1074		hash = ftrace_hash_alloc(FTRACE_HASH_MAX_BITS);
  1075		if (!hash)
  1076			return -ENOMEM;
  1077	
  1078		list_for_each_entry(tr, upd, update.list) {
  1079			struct ftrace_func_entry *entry;
  1080			unsigned long direct;
  1081	
  1082			switch (tr->update.action) {
  1083			case BPF_TRAMP_UPDATE_REG:
  1084			case BPF_TRAMP_UPDATE_MODIFY:
  1085				direct = (unsigned long) tr->update.im->image;
  1086				break;
  1087			case BPF_TRAMP_UPDATE_UNREG:
  1088				direct = 0;
  1089				break;
  1090			}
  1091	
  1092			if (tr->multi.id_multi) {
  1093				for (i = 0; i < tr->multi.id_multi->cnt; i++) {
  1094					entry = kmalloc(sizeof(*entry), GFP_KERNEL);
  1095					if (!entry) {
  1096						err = -ENOMEM;
  1097						goto out_free;
  1098					}
  1099					entry->ip = (unsigned long) tr->multi.id_multi->addr[i];
  1100					entry->direct = direct;
> 1101					ftrace_hash_add_entry(hash, entry);
  1102				}
  1103			} else {
  1104				entry = kmalloc(sizeof(*entry), GFP_KERNEL);
  1105				if (!entry) {
  1106					err = -ENOMEM;
  1107					goto out_free;
  1108				}
  1109				entry->ip = (unsigned long) tr->func.addr;
  1110				entry->direct = direct;
  1111				ftrace_hash_add_entry(hash, entry);
  1112			}
  1113		}
  1114	
  1115		err = set_ftrace_direct(hash);
  1116	out_free:
> 1117		ftrace_hash_free(hash);
  1118		return err;
  1119	}
  1120	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

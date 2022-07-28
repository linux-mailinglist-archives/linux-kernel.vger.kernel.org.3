Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D474583E87
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbiG1MSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238198AbiG1MSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:18:16 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCA7691CB
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 05:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659010690; x=1690546690;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=T9Bg2hHoHiLetjhY2EL+ufYLDmbp6OAojK1pZBfDiMQ=;
  b=QsrYCeepjXMsa/LIWIFHrDZklEu66PO/4mN7n85lxx/bkgnN37uoGAn+
   fyC4W3kLJfVkh0N6cDmNjySXOp1yLSjuO67aFFekN4REXb4NeSKUR9CJ2
   ZQ6eAW6lPHnQmtpPKvXIdmAsBUHLJmJ+rIp2RPnEEe/GsUfGEuMc2xdGt
   3C9pvh8arRLpPXQtSfQbW1Vwx1Vu9HoBPWZur/1OSMRzQcbmgk1/kFBWL
   PQuAQlSShqjjFfsELS8h2EsfqVb6wQIPc5h6mKc8SwI9LxXy9jzkusxW8
   z0dzYYSe2BUxKBtFLbYOjEQ91XgYNvTYdLt+3yE8li6B3Zs3kHPTdGzov
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="314286131"
X-IronPort-AV: E=Sophos;i="5.93,198,1654585200"; 
   d="scan'208";a="314286131"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 05:18:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,198,1654585200"; 
   d="scan'208";a="628868757"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 28 Jul 2022 05:18:08 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oH2Su-0009y6-0a;
        Thu, 28 Jul 2022 12:18:08 +0000
Date:   Thu, 28 Jul 2022 20:17:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/tracing_multi_4 23/34]
 kernel/bpf/trampoline.c:1115:15: error: implicit declaration of function
 'set_ftrace_direct'; did you mean 'modify_ftrace_direct'?
Message-ID: <202207282008.dkbWC7Qx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/tracing_multi_4
head:   1637b6b5bec11596e52cdc0a6eadfa45a15276c3
commit: d2c85068156e7ef00b9748982859a332d50398cb [23/34] bpf: Add support to attach multi trampolines
config: x86_64-randconfig-a006 (https://download.01.org/0day-ci/archive/20220728/202207282008.dkbWC7Qx-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=d2c85068156e7ef00b9748982859a332d50398cb
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/tracing_multi_4
        git checkout d2c85068156e7ef00b9748982859a332d50398cb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/bpf/trampoline.c: In function 'bpf_tramp_update_set':
   kernel/bpf/trampoline.c:1074:16: error: implicit declaration of function 'ftrace_hash_alloc' [-Werror=implicit-function-declaration]
    1074 |         hash = ftrace_hash_alloc(FTRACE_HASH_MAX_BITS);
         |                ^~~~~~~~~~~~~~~~~
   kernel/bpf/trampoline.c:1074:34: error: 'FTRACE_HASH_MAX_BITS' undeclared (first use in this function)
    1074 |         hash = ftrace_hash_alloc(FTRACE_HASH_MAX_BITS);
         |                                  ^~~~~~~~~~~~~~~~~~~~
   kernel/bpf/trampoline.c:1074:34: note: each undeclared identifier is reported only once for each function it appears in
   kernel/bpf/trampoline.c:1101:33: error: implicit declaration of function 'ftrace_hash_add_entry' [-Werror=implicit-function-declaration]
    1101 |                                 ftrace_hash_add_entry(hash, entry);
         |                                 ^~~~~~~~~~~~~~~~~~~~~
>> kernel/bpf/trampoline.c:1115:15: error: implicit declaration of function 'set_ftrace_direct'; did you mean 'modify_ftrace_direct'? [-Werror=implicit-function-declaration]
    1115 |         err = set_ftrace_direct(hash);
         |               ^~~~~~~~~~~~~~~~~
         |               modify_ftrace_direct
   kernel/bpf/trampoline.c:1117:9: error: implicit declaration of function 'ftrace_hash_free' [-Werror=implicit-function-declaration]
    1117 |         ftrace_hash_free(hash);
         |         ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +1115 kernel/bpf/trampoline.c

  1067	
  1068	static int bpf_tramp_update_set(struct list_head *upd)
  1069	{
  1070		struct bpf_trampoline *tr;
  1071		struct ftrace_hash *hash;
  1072		int i, err;
  1073	
  1074		hash = ftrace_hash_alloc(FTRACE_HASH_MAX_BITS);
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
  1101					ftrace_hash_add_entry(hash, entry);
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
> 1115		err = set_ftrace_direct(hash);
  1116	out_free:
  1117		ftrace_hash_free(hash);
  1118		return err;
  1119	}
  1120	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

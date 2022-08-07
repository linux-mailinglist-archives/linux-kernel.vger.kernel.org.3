Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A607458B965
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 06:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiHGElZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 00:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiHGElX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 00:41:23 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49432B7E5
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 21:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659847282; x=1691383282;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0RLAcJZKcj5Ev8qcvaUNpH5gX8I77jEtdKsQF95hi54=;
  b=D2vyrTt4C82GxuWg3fDqodOEpy4p/b1v/P8M1G6fwutKiht7Bn7ohyrc
   Osv97KZIkQRhJcwcQJIwr6StRjAfCdnRG3y4RwOncpoq6tQYwkqqNw50x
   R4mWeyGFEmO7hYFEwXEPrMfXL8kFtl4AvWr/PeSSuhEsjNDShwytSuO73
   VDWcLydOsWKG25vlkh85BG5gIkFX6MPw1jXrRHTHHRMc7WOdU+gc3e3n3
   v63zUOzNKMExKE83AIP5s6ge+Hv2e9h6fruNkTzeRUS+R9pkYcA8Y7/zD
   Hvri2Iy8azXGSzOXqOMt8RG8p9hSylu2Dw4gbqCr86lVmzhITVizFwg5H
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="287974180"
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="287974180"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 21:41:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="554544487"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 06 Aug 2022 21:41:20 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKY6J-000KyP-1o;
        Sun, 07 Aug 2022 04:41:19 +0000
Date:   Sun, 7 Aug 2022 12:41:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/tracing_multi_new_2 14/21]
 kernel/bpf/trampoline.c:1075:16: warning: variable 'ip' set but not used
Message-ID: <202208071225.24zEKaj6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/tracing_multi_new_2
head:   c0620f064b5146578de80c7bb00febc697cc4890
commit: 4d3060dcb11c6c79779105d68c1fd8e0efdbef5a [14/21] bpf: Add support to attach multi trampolines
config: riscv-randconfig-r042-20220804 (https://download.01.org/0day-ci/archive/20220807/202208071225.24zEKaj6-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 26dd42705c2af0b8f6e5d6cdb32c9bd5ed9524eb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=4d3060dcb11c6c79779105d68c1fd8e0efdbef5a
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/tracing_multi_new_2
        git checkout 4d3060dcb11c6c79779105d68c1fd8e0efdbef5a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/bpf/trampoline.c:1075:16: warning: variable 'ip' set but not used [-Wunused-but-set-variable]
           unsigned long ip, image_new, image_old;
                         ^
>> kernel/bpf/trampoline.c:1074:9: warning: variable 'rollback_cnt' set but not used [-Wunused-but-set-variable]
           int i, rollback_cnt = 0, err = -EINVAL;
                  ^
   2 warnings generated.


vim +/ip +1075 kernel/bpf/trampoline.c

  1070	
  1071	static int bpf_tramp_update_set(struct list_head *upd)
  1072	{
  1073		struct bpf_trampoline *tr, *trm = NULL;
> 1074		int i, rollback_cnt = 0, err = -EINVAL;
> 1075		unsigned long ip, image_new, image_old;
  1076	
  1077		list_for_each_entry(tr, upd, update.list) {
  1078			if (tr->multi.id_multi) {
  1079				trm = tr;
  1080				continue;
  1081			}
  1082	
  1083			ip = (unsigned long) tr->func.addr;
  1084			image_new = tr->update.im ? (unsigned long) tr->update.im->image : 0;
  1085			image_old = tr->cur_image ? (unsigned long) tr->cur_image->image : 0;
  1086	
  1087			switch (tr->update.action) {
  1088			case BPF_TRAMP_UPDATE_REG:
  1089				err = register_ftrace_direct_multi(tr->fops, image_new);
  1090				break;
  1091			case BPF_TRAMP_UPDATE_MODIFY:
  1092				err = modify_ftrace_direct_multi(tr->fops, image_new);
  1093				break;
  1094			case BPF_TRAMP_UPDATE_UNREG:
  1095				err = unregister_ftrace_direct_multi(tr->fops, image_old);
  1096				break;
  1097			}
  1098			if (err)
  1099				goto out_rollback;
  1100			rollback_cnt++;
  1101		}
  1102	
  1103		if (!trm)
  1104			return 0;
  1105	
  1106		if (trm->update.action == BPF_TRAMP_UPDATE_REG) {
  1107			for (i = 0; i < trm->multi.id_multi->cnt; i++) {
  1108				ip = (unsigned long) trm->multi.id_multi->addr[i];
  1109				err = ftrace_set_filter_ip(trm->fops, ip, 0, 0);
  1110				if (err)
  1111					goto out_rollback;
  1112			}
  1113		}
  1114	
  1115		image_new = trm->update.im ? (unsigned long) trm->update.im->image : 0;
  1116		image_old = trm->cur_image ? (unsigned long) trm->cur_image->image : 0;
  1117	
  1118		switch (trm->update.action) {
  1119		case BPF_TRAMP_UPDATE_REG:
  1120			err = register_ftrace_direct_multi(trm->fops, image_new);
  1121			break;
  1122		case BPF_TRAMP_UPDATE_MODIFY:
  1123			err = modify_ftrace_direct_multi(trm->fops, image_new);
  1124			break;
  1125		case BPF_TRAMP_UPDATE_UNREG:
  1126			err = unregister_ftrace_direct_multi(trm->fops, image_old);
  1127			break;
  1128		default:
  1129			break;
  1130		}
  1131	
  1132		if (!err)
  1133			return 0;
  1134	
  1135	out_rollback:
  1136		list_for_each_entry(tr, upd, update.list) {
  1137			if (tr->multi.id_multi)
  1138				continue;
  1139	
  1140			ip = (unsigned long) tr->func.addr;
  1141			image_new = tr->update.im ? (unsigned long) tr->update.im->image : 0;
  1142			image_old = tr->cur_image ? (unsigned long) tr->cur_image->image : 0;
  1143	
  1144			switch (tr->update.action) {
  1145			case BPF_TRAMP_UPDATE_REG:
  1146				err = unregister_ftrace_direct_multi(tr->fops, image_new);
  1147				break;
  1148			case BPF_TRAMP_UPDATE_MODIFY:
  1149				err = modify_ftrace_direct_multi(tr->fops, image_old);
  1150				break;
  1151			case BPF_TRAMP_UPDATE_UNREG:
  1152				err = register_ftrace_direct_multi(tr->fops, image_old);
  1153				break;
  1154			}
  1155			i++;
  1156		}
  1157	
  1158		return err;
  1159	}
  1160	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

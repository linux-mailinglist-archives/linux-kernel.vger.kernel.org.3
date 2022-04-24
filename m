Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6B450D575
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 23:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239704AbiDXWAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 18:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239689AbiDXWAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 18:00:06 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4626393E1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 14:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650837424; x=1682373424;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Fe3LiujnA8YfarQ1OwGBgpnChKUAdW9nUkCdIS58zo0=;
  b=j5aC1lIenKVpV8wyX+vGrlK0jXyNLRINVqJrF2DLxME+Nln7WTPPutm0
   s8n0AaDNfKi7PrM5x1DmCkY62ImYcjawmHTrMP7nZjvWH5gyCG/j6kOI9
   8hG+eoDyAm48Mud7ktiY1yuNuol8Wsh42kqf1SPL15okgVI3erHPTIaeh
   Q9VGrFQ7YeiYFW/eXcd3LNiDR5CalEu6vo0b6zTBivzEaxCep8f4vnzbE
   iBtFb/0AGYte7AntuYEumNat0fr5CWRV2F/tc8/pOpnkqfxWW8ow9+CcF
   NLdEuRLR9nuVotdAbuFMgGgUn3g9pqljiHPazIm0TxqBJmYDPRXvf6gkA
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="245656820"
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="245656820"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2022 14:57:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="729431358"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 24 Apr 2022 14:57:02 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nikE2-0001oj-6M;
        Sun, 24 Apr 2022 21:57:02 +0000
Date:   Mon, 25 Apr 2022 05:56:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 456/2579] net/sched/cls_api.c:3057:1:
 sparse: sparse: function 'tcf_exts_hw_stats_update' with external linkage
 has definition
Message-ID: <202204250557.gOEhsXfK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: 5b9c6520f729954a730cd549a22775a58758b9f1 [456/2579] headers/uninline: Uninline multi-use function: tcf_exts_stats_update() and tcf_exts_exec()
config: i386-randconfig-s002 (https://download.01.org/0day-ci/archive/20220425/202204250557.gOEhsXfK-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=5b9c6520f729954a730cd549a22775a58758b9f1
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 5b9c6520f729954a730cd549a22775a58758b9f1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash net/sched/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> net/sched/cls_api.c:3057:1: sparse: sparse: function 'tcf_exts_hw_stats_update' with external linkage has definition
   net/sched/cls_api.c:286:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] protocol @@     got unsigned int [usertype] protocol @@
   net/sched/cls_api.c:286:22: sparse:     expected restricted __be16 [usertype] protocol
   net/sched/cls_api.c:286:22: sparse:     got unsigned int [usertype] protocol
   net/sched/cls_api.c:1691:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/sched/cls_api.c:1691:16: sparse:    struct tcf_proto *
   net/sched/cls_api.c:1691:16: sparse:    struct tcf_proto [noderef] __rcu *
   net/sched/cls_api.c:1791:20: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/sched/cls_api.c:1791:20: sparse:    struct tcf_proto [noderef] __rcu *
   net/sched/cls_api.c:1791:20: sparse:    struct tcf_proto *
   net/sched/cls_api.c:1753:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/sched/cls_api.c:1753:25: sparse:    struct tcf_proto [noderef] __rcu *
   net/sched/cls_api.c:1753:25: sparse:    struct tcf_proto *
   net/sched/cls_api.c:1773:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/sched/cls_api.c:1773:16: sparse:    struct tcf_proto *
   net/sched/cls_api.c:1773:16: sparse:    struct tcf_proto [noderef] __rcu *
   net/sched/cls_api.c:1838:25: sparse: sparse: restricted __be16 degrades to integer
   net/sched/cls_api.c:2514:50: sparse: sparse: restricted __be16 degrades to integer

vim +/tcf_exts_hw_stats_update +3057 net/sched/cls_api.c

  3054	
  3055	#ifdef CONFIG_NET_CLS_ACT
  3056	extern void
> 3057	tcf_exts_hw_stats_update(const struct tcf_exts *exts,
  3058				 u64 bytes, u64 packets, u64 drops, u64 lastuse,
  3059				 u8 used_hw_stats, bool used_hw_stats_valid)
  3060	{
  3061		int i;
  3062	
  3063		for (i = 0; i < exts->nr_actions; i++) {
  3064			struct tc_action *a = exts->actions[i];
  3065	
  3066			/* if stats from hw, just skip */
  3067			if (tcf_action_update_hw_stats(a)) {
  3068				preempt_disable();
  3069				tcf_action_stats_update(a, bytes, packets, drops,
  3070							lastuse, true);
  3071				preempt_enable();
  3072	
  3073				a->used_hw_stats = used_hw_stats;
  3074				a->used_hw_stats_valid = used_hw_stats_valid;
  3075			}
  3076		}
  3077	}
  3078	EXPORT_SYMBOL(tcf_exts_hw_stats_update);
  3079	#endif
  3080	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

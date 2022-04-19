Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83529506C7C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242716AbiDSMei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiDSMeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:34:37 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7008205C6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650371514; x=1681907514;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RSQprlSvtYQNGWJUSLaKGnQD7G/CUuysy1HG8q/aEjk=;
  b=fbojuR9nLGTavbWqBS4zYZAFmhbmVv2M1JXS9MA87U/iLtAYrOHRJcSQ
   VyCMxpZQjIS6ggUj+WNw9ntugDL0wPhOJH/J0dWg71xl8jn196AkgsW2/
   StiVIUwXmbovEWQpc/DnVc8UbAfRJjUvxtLjfZ1s80zKslqvCFuC0EdkX
   nZgUY7GrMTuo8R5KjphhUCHE8p72/uA55+s8HuD2YfDSATSVEwTV6/nBF
   QADJPkHPajLF5hVw+GqCu71UGsRQGDe0jc4FvtpgjtshmPJcPqXFs9mEp
   0hVQfw2OwFwdYn5Nmm6ZpgqWvhhgNHAL9jtDu//+YbuxKFeXjfO+TgbNh
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="263513463"
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="263513463"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 05:31:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="510120830"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 19 Apr 2022 05:31:52 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngn1L-0005lO-JI;
        Tue, 19 Apr 2022 12:31:51 +0000
Date:   Tue, 19 Apr 2022 20:31:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chris Redpath <chris.redpath@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [jsarha:topic/cros-sof-v4.14-rebase 1455/9999]
 kernel/sched/fair.c:6738:1: sparse: sparse: symbol '__pcpu_scope_eenv_cache'
 was not declared. Should it be static?
Message-ID: <202204192047.g1X4yydR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jsarha/linux topic/cros-sof-v4.14-rebase
head:   18a233f3f676a98dde00947535d99ab1a54da340
commit: 0d2a194c54348734338a8be17f0860be327eb00d [1455/9999] ANDROID: sched/fair: re-factor energy_diff to use a single (extensible) energy_env
config: i386-randconfig-s002-20220418 (https://download.01.org/0day-ci/archive/20220419/202204192047.g1X4yydR-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/jsarha/linux/commit/0d2a194c54348734338a8be17f0860be327eb00d
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/cros-sof-v4.14-rebase
        git checkout 0d2a194c54348734338a8be17f0860be327eb00d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash kernel/sched/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   kernel/sched/fair.c: note: in included file:
   kernel/sched/sched.h:1106:47: sparse: sparse: duplicate const
   kernel/sched/fair.c:56:14: sparse: sparse: symbol 'normalized_sysctl_sched_latency' was not declared. Should it be static?
   kernel/sched/fair.c:86:14: sparse: sparse: symbol 'normalized_sysctl_sched_min_granularity' was not declared. Should it be static?
   kernel/sched/fair.c:109:14: sparse: sparse: symbol 'normalized_sysctl_sched_wakeup_granularity' was not declared. Should it be static?
   kernel/sched/fair.c:143:14: sparse: sparse: symbol 'capacity_margin' was not declared. Should it be static?
   kernel/sched/fair.c:3547:6: sparse: sparse: symbol 'sync_entity_load_avg' was not declared. Should it be static?
   kernel/sched/fair.c:3560:6: sparse: sparse: symbol 'remove_entity_load_avg' was not declared. Should it be static?
   kernel/sched/fair.c:9606:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:9606:22: sparse:    struct sched_domain [noderef] <asn:4> *
   kernel/sched/fair.c:9606:22: sparse:    struct sched_domain *
   kernel/sched/fair.c:9618:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:9618:9: sparse:    struct sched_domain [noderef] <asn:4> *
   kernel/sched/fair.c:9618:9: sparse:    struct sched_domain *
   kernel/sched/fair.c:5108:1: sparse: sparse: symbol '__pcpu_scope_load_balance_mask' was not declared. Should it be static?
   kernel/sched/fair.c:5109:1: sparse: sparse: symbol '__pcpu_scope_select_idle_mask' was not declared. Should it be static?
   kernel/sched/fair.c:5495:15: sparse: sparse: symbol 'capacity_curr_of' was not declared. Should it be static?
   kernel/sched/fair.c:5812:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:5812:22: sparse:    struct sched_domain [noderef] <asn:4> *
   kernel/sched/fair.c:5812:22: sparse:    struct sched_domain *
   kernel/sched/fair.c:5816:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:5816:17: sparse:    struct sched_domain [noderef] <asn:4> *
   kernel/sched/fair.c:5816:17: sparse:    struct sched_domain *
   kernel/sched/fair.c:6133:1: sparse: sparse: symbol 'boosted_cpu_util' was not declared. Should it be static?
   kernel/sched/fair.c:6531:19: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:6531:19: sparse:    struct sched_domain [noderef] <asn:4> *
   kernel/sched/fair.c:6531:19: sparse:    struct sched_domain *
>> kernel/sched/fair.c:6738:1: sparse: sparse: symbol '__pcpu_scope_eenv_cache' was not declared. Should it be static?
   kernel/sched/fair.c:6949:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:6949:9: sparse:    struct sched_domain [noderef] <asn:4> *
   kernel/sched/fair.c:6949:9: sparse:    struct sched_domain *
   kernel/sched/fair.c:9728:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:9728:9: sparse:    struct sched_domain [noderef] <asn:4> *
   kernel/sched/fair.c:9728:9: sparse:    struct sched_domain *
   kernel/sched/fair.c:9942:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:9942:9: sparse:    struct sched_domain [noderef] <asn:4> *
   kernel/sched/fair.c:9942:9: sparse:    struct sched_domain *
   kernel/sched/fair.c:4833:35: sparse: sparse: marked inline, but without a definition
   kernel/sched/sched.h:2127:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2127:16: sparse:    struct update_util_data [noderef] <asn:4> *
   kernel/sched/sched.h:2127:16: sparse:    struct update_util_data *
   kernel/sched/sched.h:2127:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2127:16: sparse:    struct update_util_data [noderef] <asn:4> *
   kernel/sched/sched.h:2127:16: sparse:    struct update_util_data *
   kernel/sched/sched.h:2127:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2127:16: sparse:    struct update_util_data [noderef] <asn:4> *
   kernel/sched/sched.h:2127:16: sparse:    struct update_util_data *
   kernel/sched/sched.h:2127:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2127:16: sparse:    struct update_util_data [noderef] <asn:4> *
   kernel/sched/sched.h:2127:16: sparse:    struct update_util_data *
   kernel/sched/sched.h:2127:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2127:16: sparse:    struct update_util_data [noderef] <asn:4> *
   kernel/sched/sched.h:2127:16: sparse:    struct update_util_data *
   kernel/sched/sched.h:2127:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2127:16: sparse:    struct update_util_data [noderef] <asn:4> *
   kernel/sched/sched.h:2127:16: sparse:    struct update_util_data *
   kernel/sched/sched.h:2127:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2127:16: sparse:    struct update_util_data [noderef] <asn:4> *
   kernel/sched/sched.h:2127:16: sparse:    struct update_util_data *
   kernel/sched/sched.h:2127:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2127:16: sparse:    struct update_util_data [noderef] <asn:4> *
   kernel/sched/sched.h:2127:16: sparse:    struct update_util_data *
   kernel/sched/sched.h:2127:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2127:16: sparse:    struct update_util_data [noderef] <asn:4> *
   kernel/sched/sched.h:2127:16: sparse:    struct update_util_data *
   kernel/sched/fair.c:4950:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:4950:14: sparse:    struct sched_domain [noderef] <asn:4> *
   kernel/sched/fair.c:4950:14: sparse:    struct sched_domain *
   kernel/sched/sched.h:2127:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2127:16: sparse:    struct update_util_data [noderef] <asn:4> *
   kernel/sched/sched.h:2127:16: sparse:    struct update_util_data *
   kernel/sched/fair.c:6409:15: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:6409:15: sparse:    struct sched_domain_shared [noderef] <asn:4> *
   kernel/sched/fair.c:6409:15: sparse:    struct sched_domain_shared *
   kernel/sched/fair.c:6400:15: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:6400:15: sparse:    struct sched_domain_shared [noderef] <asn:4> *
   kernel/sched/fair.c:6400:15: sparse:    struct sched_domain_shared *
   kernel/sched/fair.c:6409:15: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:6409:15: sparse:    struct sched_domain_shared [noderef] <asn:4> *
   kernel/sched/fair.c:6409:15: sparse:    struct sched_domain_shared *
   kernel/sched/fair.c:6400:15: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:6400:15: sparse:    struct sched_domain_shared [noderef] <asn:4> *
   kernel/sched/fair.c:6400:15: sparse:    struct sched_domain_shared *
   kernel/sched/fair.c:6589:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:6589:14: sparse:    struct sched_domain [noderef] <asn:4> *
   kernel/sched/fair.c:6589:14: sparse:    struct sched_domain *
   kernel/sched/fair.c:6620:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:6620:14: sparse:    struct sched_domain [noderef] <asn:4> *
   kernel/sched/fair.c:6620:14: sparse:    struct sched_domain *
   kernel/sched/fair.c:5880:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:5880:14: sparse:    struct sched_domain [noderef] <asn:4> *
   kernel/sched/fair.c:5880:14: sparse:    struct sched_domain *
   kernel/sched/fair.c:6881:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:6881:14: sparse:    struct sched_domain [noderef] <asn:4> *
   kernel/sched/fair.c:6881:14: sparse:    struct sched_domain *
   kernel/sched/fair.c:6381:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:6381:17: sparse:    struct sched_domain [noderef] <asn:4> *
   kernel/sched/fair.c:6381:17: sparse:    struct sched_domain *
   kernel/sched/sched.h:2127:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2127:16: sparse:    struct update_util_data [noderef] <asn:4> *
   kernel/sched/sched.h:2127:16: sparse:    struct update_util_data *
   kernel/sched/sched.h:2127:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2127:16: sparse:    struct update_util_data [noderef] <asn:4> *
   kernel/sched/sched.h:2127:16: sparse:    struct update_util_data *
   kernel/sched/fair.c:9778:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:9778:16: sparse:    struct sched_domain [noderef] <asn:4> *
   kernel/sched/fair.c:9778:16: sparse:    struct sched_domain *
   kernel/sched/fair.c:4950:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:4950:14: sparse:    struct sched_domain [noderef] <asn:4> *
   kernel/sched/fair.c:4950:14: sparse:    struct sched_domain *
   kernel/sched/sched.h:2127:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2127:16: sparse:    struct update_util_data [noderef] <asn:4> *
   kernel/sched/sched.h:2127:16: sparse:    struct update_util_data *
   kernel/sched/sched.h:2127:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2127:16: sparse:    struct update_util_data [noderef] <asn:4> *
   kernel/sched/sched.h:2127:16: sparse:    struct update_util_data *
   In file included from kernel/sched/fair.c:25:0:
   include/linux/sched/topology.h:196:1: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
    const struct sched_group_energy * const(*sched_domain_energy_f)(int cpu);
    ^~~~~
   In file included from kernel/sched/fair.c:39:0:
   kernel/sched/sched.h:1106:34: warning: duplicate 'const' declaration specifier [-Wduplicate-decl-specifier]
     const struct sched_group_energy const *sge;
                                     ^~~~~

Please review and possibly fold the followup patch.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

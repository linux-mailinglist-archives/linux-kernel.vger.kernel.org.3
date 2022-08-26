Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA385A1E51
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 03:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244548AbiHZBps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 21:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244596AbiHZBpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 21:45:44 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBE261DBF
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 18:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661478344; x=1693014344;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XZJSY4cbgrebLKKDnAQdX4owkNLnig3mFMmrZiJU8ks=;
  b=hSsmp3unMzPoY6F74U2YUROiqSopvIl95K96nFkhMWteBQRQU5phSSPv
   iLowvLQPiV1WUXymx4S0I6H7cHyb58T1qyQFMeqOuV5US1NPQl84fk/++
   x/KEguIIKoDkkPJ9eaOFztKO4nsKgRa/Y06zNtZmfMn5NN13YhVCpxeAA
   qwaJbC1LuvoCbxfzSZv2U1i4q9JbE0Zs3piEN1M484ZeidG+xj8Bcdw8L
   pI/ydQ8suhr8491V+LNJ8V/RgSHvtYtTI6HeVh2s+SqAURgDdodEQc9LB
   50LzkQSQLXC2GrN9t24lMJ4Tpwz2tKpMKJX0RAQYSvm6PqpNrz6/1K2U4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="356116050"
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="356116050"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 18:45:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="587120615"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 25 Aug 2022 18:45:42 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oROPl-0003EI-2q;
        Fri, 26 Aug 2022 01:45:41 +0000
Date:   Fri, 26 Aug 2022 09:44:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [zanussi-trace:ftrace/masami-hitcount-v0 1/3]
 kernel/trace/trace_events_hist.c:4354:9: warning: variable 'n_hitcount' is
 uninitialized when used here
Message-ID: <202208260943.kWLI2lN6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/masami-hitcount-v0
head:   886fe9b6098eddb9d298e8a3f07bbea61acdac16
commit: 2b0a73549f8fb4115c06639c75a4b7abd7825aaa [1/3] tracing: Allow multiple hitcount values in histograms
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220826/202208260943.kWLI2lN6-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git/commit/?id=2b0a73549f8fb4115c06639c75a4b7abd7825aaa
        git remote add zanussi-trace https://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git
        git fetch --no-tags zanussi-trace ftrace/masami-hitcount-v0
        git checkout 2b0a73549f8fb4115c06639c75a4b7abd7825aaa
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/trace/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/trace/trace_events_hist.c:4354:9: warning: variable 'n_hitcount' is uninitialized when used here [-Wuninitialized]
                           if (!n_hitcount++)
                                ^~~~~~~~~~
   kernel/trace/trace_events_hist.c:4335:35: note: initialize the variable 'n_hitcount' to silence this warning
           unsigned int i, j = 1, n_hitcount;
                                            ^
                                             = 0
   1 warning generated.


vim +/n_hitcount +4354 kernel/trace/trace_events_hist.c

  4331	
  4332	static int create_val_fields(struct hist_trigger_data *hist_data,
  4333				     struct trace_event_file *file)
  4334	{
  4335		unsigned int i, j = 1, n_hitcount;
  4336		char *fields_str, *field_str;
  4337		int ret;
  4338	
  4339		ret = create_hitcount_val(hist_data);
  4340		if (ret)
  4341			goto out;
  4342	
  4343		fields_str = hist_data->attrs->vals_str;
  4344		if (!fields_str)
  4345			goto out;
  4346	
  4347		for (i = 0, j = 1; i < TRACING_MAP_VALS_MAX &&
  4348			     j < TRACING_MAP_VALS_MAX; i++) {
  4349			field_str = strsep(&fields_str, ",");
  4350			if (!field_str)
  4351				break;
  4352	
  4353			if (strcmp(field_str, "hitcount") == 0) {
> 4354				if (!n_hitcount++)
  4355					continue;
  4356			}
  4357	
  4358			ret = create_val_field(hist_data, j++, file, field_str);
  4359			if (ret)
  4360				goto out;
  4361		}
  4362	
  4363		if (fields_str && (strcmp(fields_str, "hitcount") != 0))
  4364			ret = -EINVAL;
  4365	 out:
  4366		return ret;
  4367	}
  4368	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C0D591AF9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 16:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239625AbiHMO3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 10:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239390AbiHMO3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 10:29:23 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB6927B2D
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 07:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660400962; x=1691936962;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GXVh2WOuQi2cAGYoNY/G0oOfMDosLA96RIbJCpUYcsU=;
  b=j0c7nGWFk2gJgSuMii6RVa36/md9qcN46IPHpTSnB7cPIKeoyZTLJsRc
   +Osti8uQdFoLSdEcDo9s+8uUhmiw7bNj03irQ9C7DXNvnxz0nCM9A2vmp
   hxJWrPm6/AMpZ4YB3kifMFSTEpg/8TmNOhEGgVPIcQ7C5CjePOdeyFeXi
   wCFBhV7L8LnS3I8BBI7rX68P9ARRONkMNB/ERjzdAiqsslVMdpQ0utIfr
   RefG6I2DhfGrijjmljmJRvf9zP9UmIsp2TdMZ6nEW/VYdtd600Lno5AHF
   ebx2KO/OlwROOy0CBJa+qBIhJEchNliqJoPXrmL/aEqnyuvumDE8btLI2
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="272149315"
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="272149315"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 07:29:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="606205697"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 13 Aug 2022 07:29:20 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMs8e-0001lW-0R;
        Sat, 13 Aug 2022 14:29:20 +0000
Date:   Sat, 13 Aug 2022 22:29:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/tracing_multi_new_1 22/23]
 kernel/bpf/syscall.c:3150:27: error: field 'fops' has incomplete type
Message-ID: <202208132235.CyiLD4fT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/tracing_multi_new_1
head:   e27bb6c0f6805082ef71568985f74dcefe7ff6ff
commit: dc38a65ab46f4ba538353c1eb7c64ac36202eb54 [22/23] fix
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20220813/202208132235.CyiLD4fT-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=dc38a65ab46f4ba538353c1eb7c64ac36202eb54
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/tracing_multi_new_1
        git checkout dc38a65ab46f4ba538353c1eb7c64ac36202eb54
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/bpf/syscall.c:3150:27: error: field 'fops' has incomplete type
    3150 |         struct ftrace_ops fops;
         |                           ^~~~


vim +/fops +3150 kernel/bpf/syscall.c

  3144	
  3145	struct bpf_tracing_multi_link {
  3146		struct bpf_link link;
  3147		enum bpf_attach_type attach_type;
  3148		struct bpf_tramp_prog tp;
  3149		struct bpf_tramp_id *id;
> 3150		struct ftrace_ops fops;
  3151	};
  3152	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

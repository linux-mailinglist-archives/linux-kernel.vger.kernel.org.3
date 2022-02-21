Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9FC44BEA67
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiBUSah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 13:30:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbiBUS0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 13:26:13 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B3DC7E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 10:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645467879; x=1677003879;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mzCGaMqSIKCdL//0sI2JbSojC7b0HtfrzdHg0ku3H2s=;
  b=P69fujhjGYJfEXDZocA7AHfkT98opcGqk5LJTDbs3Gz1VbDnfeN9pzq9
   LqtE/EbWLy7tgxNSTFuoPg9DJqJl5YGFeI2hyJddaUd78jyMbIdTZdXQU
   5efe6kEme+xBzTOXxHXvGc/Yq4b77dczulVjWemEVel6Rmz5geqAzfy+v
   rLRlivLpuI2Bd0ep3ojLuG9H6M/Y2FK5/3tg35sPiax/X+KBHys7RWgQr
   RKofuw1YMdsfqvhpG99XciPswAbWakGE3a4HEjbiSVwrHq3hStKcLgcDc
   3sXS9VMhg0kgtmyIJYzKbvdS9QSeRf7YIcqdlMJh9PYHyIgRuYBDlfNiI
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="251310863"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="251310863"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 10:24:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="627443330"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Feb 2022 10:24:37 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMDMS-0001sW-E2; Mon, 21 Feb 2022 18:24:36 +0000
Date:   Tue, 22 Feb 2022 02:24:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [ammarfaizi2-block:rostedt/linux-trace/for-next 19/32]
 kernel/trace/trace_events_synth.c:65:9: warning: 'strncpy' specified bound
 depends on the length of the source argument
Message-ID: <202202220258.LyXgZyyT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block rostedt/linux-trace/for-next
head:   864ea0e10cc90416a01b46f0d47a6f26dc020820
commit: 27c888da9867725784bad3d6455d6e53b425fa2b [19/32] tracing: Remove size restriction on synthetic event cmd error logging
config: arm-randconfig-r022-20220221 (https://download.01.org/0day-ci/archive/20220222/202202220258.LyXgZyyT-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/27c888da9867725784bad3d6455d6e53b425fa2b
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block rostedt/linux-trace/for-next
        git checkout 27c888da9867725784bad3d6455d6e53b425fa2b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash kernel/trace/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/trace/trace_events_synth.c: In function 'last_cmd_set':
>> kernel/trace/trace_events_synth.c:65:9: warning: 'strncpy' specified bound depends on the length of the source argument [-Wstringop-truncation]
      65 |         strncpy(last_cmd, str, strlen(str) + 1);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace_events_synth.c:65:32: note: length computed here
      65 |         strncpy(last_cmd, str, strlen(str) + 1);
         |                                ^~~~~~~~~~~


vim +/strncpy +65 kernel/trace/trace_events_synth.c

    54	
    55	static void last_cmd_set(const char *str)
    56	{
    57		if (!str)
    58			return;
    59	
    60		kfree(last_cmd);
    61		last_cmd = kzalloc(strlen(str) + 1, GFP_KERNEL);
    62		if (!last_cmd)
    63			return;
    64	
  > 65		strncpy(last_cmd, str, strlen(str) + 1);
    66	}
    67	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

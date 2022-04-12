Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84884FDDDE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiDLLmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 07:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356312AbiDLLkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:40:05 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413AA506DC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649758862; x=1681294862;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qVx1i45O45JHhoPS6qEj+Q9ZWHEANAaDUwS8g38cHBg=;
  b=RPhxUans1MAoYVDzLA2iN/3lQhuvXJWGRrX6YvAb0Ab2sVhhS5/17ABr
   fPvT4NpjVee6FFWP3rfdGUu5W3zFrp4BJJiy1jOZwHa26Fn74aj5vur24
   YXeb2IdoB/WrlzjZWlpDBUEcvIeCbTp1/2S7f8xYE1rgKe6xO7f+L8r7v
   MFfeik70nc6PfrgdblZJM1/VGuECySS9T6jPTF/YBeTxRGM+dvRWxQmCm
   vZn4p5iEtDSpqsPp5nJ07eCopAMHAEkazt716Npt9Vw+GSDM6FrsqtAyQ
   nU66Uym8PqIu7lPGydxA0RdV4zLUckRGwRxqoWIFLoK77DTOvAY6mTg8S
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="261186863"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="261186863"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 03:21:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="572696153"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 12 Apr 2022 03:21:00 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neDdr-0002l0-V3;
        Tue, 12 Apr 2022 10:20:59 +0000
Date:   Tue, 12 Apr 2022 18:20:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [toke:xdp-queueing-04 3/12] syscall.c:undefined reference to
 `pifo_generic_map_ops'
Message-ID: <202204121834.8kA9JXKq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git xdp-queueing-04
head:   3ef13cb90d84cacaecd65fb853dc30cade943524
commit: 4198433a927809216d5fc4793eaa31d2883d1090 [3/12] bpf: Add a PIFO priority queue map type
config: parisc-randconfig-r031-20220411 (https://download.01.org/0day-ci/archive/20220412/202204121834.8kA9JXKq-lkp@intel.com/config)
compiler: hppa64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git/commit/?id=4198433a927809216d5fc4793eaa31d2883d1090
        git remote add toke https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git
        git fetch --no-tags toke xdp-queueing-04
        git checkout 4198433a927809216d5fc4793eaa31d2883d1090
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   hppa64-linux-ld: kernel/bpf/syscall.o: in function `.LC598':
>> syscall.c:(.data.rel.ro+0x13f0): undefined reference to `pifo_generic_map_ops'
   hppa64-linux-ld: kernel/bpf/btf.o: in function `.LC547':
>> btf.c:(.data.rel.ro+0xb38): undefined reference to `pifo_generic_map_ops'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

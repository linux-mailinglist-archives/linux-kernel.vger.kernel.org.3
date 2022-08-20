Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FE159AFF2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 21:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiHTThQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 15:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiHTThN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 15:37:13 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691EC26FB
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 12:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661024232; x=1692560232;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cv2NkN6zY4d4QZTgnRmDpZG9w1iR4MlSe+j4QumdcsQ=;
  b=MZtKox7x4pK9ONwjy08MqS5HsCJtXWvWPKg96CpC9VZbc3geT+Tq1PAG
   sZyrF2LIcmDOSD+OZLsC9c7qD1S+L+sNfTXMgvqrBVmE1LbZVIeI+ClMe
   DmbCyXxwOZdMrqTTOo5aQ+PO39lpQEDSN3WADNFJg5Xfy/rkFeLBmbhum
   IuCFSGiFhisZUjl4d8jAOn3nKl/LSlILHFpPfxAAW5TO7UUGYPItK8YIb
   zCn0I+LQFyZNtQr9rqqKY9Ry98fY6BoPhITA8IZWdOeqhI19Yo3OT/nOC
   J3FF31bALnnw9gQ1BmYL5cvTnY/FqgtRPBDjlCAxBY/0rlCtcxaX6ZT86
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10445"; a="354926748"
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="354926748"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2022 12:37:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="641587487"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 20 Aug 2022 12:37:10 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPUHO-000367-0x;
        Sat, 20 Aug 2022 19:37:10 +0000
Date:   Sun, 21 Aug 2022 03:37:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: kernel/trace/rv/monitors/wwnr/wwnr.c:18:19: sparse: sparse: symbol
 'rv_wwnr' was not declared. Should it be static?
Message-ID: <202208210358.6HH3OrVs-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cc1807b9158a909ffe829a5e222be756c57c9a90
commit: ccc319dcb450d57b7befe924453d06804d83ba73 rv/monitor: Add the wwnr monitor
date:   3 weeks ago
config: sparc64-randconfig-s041-20220820 (https://download.01.org/0day-ci/archive/20220821/202208210358.6HH3OrVs-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ccc319dcb450d57b7befe924453d06804d83ba73
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ccc319dcb450d57b7befe924453d06804d83ba73
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc64 SHELL=/bin/bash kernel/trace/rv/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   kernel/trace/rv/monitors/wwnr/wwnr.c: note: in included file:
   kernel/trace/rv/monitors/wwnr/wwnr.h:30:23: sparse: sparse: symbol 'automaton_wwnr' was not declared. Should it be static?
>> kernel/trace/rv/monitors/wwnr/wwnr.c:18:19: sparse: sparse: symbol 'rv_wwnr' was not declared. Should it be static?

vim +/rv_wwnr +18 kernel/trace/rv/monitors/wwnr/wwnr.c

    17	
  > 18	struct rv_monitor rv_wwnr;
    19	DECLARE_DA_MON_PER_TASK(wwnr, unsigned char);
    20	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

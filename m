Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1F64C93FD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 20:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbiCATLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 14:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiCATLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 14:11:52 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9C063BED
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 11:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646161869; x=1677697869;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JVb+MvusMd1mLU3qe8Ah3br5oqgYIGYjgy41+jNTTWQ=;
  b=Pl2ozjGs0hxBnZgtyCTGEFufITu5AH2XVyYxkCw11G7VwPFVfSk1lfVL
   p8DCVDUIIiHezKj15mVJvEyCbryOU6JVwGpwj2lEJbhBaVov4erXPdmDV
   DJTI+GvjtL7RtAFjpPGl2ZNUpXA5r4CFoVrEDy73uBMvTfqv836QHUDse
   rNR0/BtxylSPe/YbhfMX7SEPJIXqHZz3fbcIAQLvykqzpQos3fU5zgaFb
   zeWADzDGfeMRZbs4njCjR64jGMgBVn0Ktj/hQvfLs8WdcfqgtELYqLo7u
   ehbICtO6Ffkzn/riHw6PKQlS9wzhgIcnopyVbe/FosmoE2vu5LyvCPUwm
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="233186223"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="233186223"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 11:11:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="709177088"
Received: from lkp-server01.sh.intel.com (HELO 2146afe809fb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 01 Mar 2022 11:11:06 -0800
Received: from kbuild by 2146afe809fb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nP7tq-0000ux-2F; Tue, 01 Mar 2022 19:11:06 +0000
Date:   Wed, 2 Mar 2022 03:10:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 13/42] ERROR:
 modpost: "netfs_releasepage" [fs/cifs/cifs.ko] undefined!
Message-ID: <202203020338.QsRlVuBs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   5cb7f190822d09757b30cd9539e57eef72552d1f
commit: 60665769a5330f764ee6d9428f67a6e19f06c67b [13/42] netfs: Provide invalidatepage and releasepage calls
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20220302/202203020338.QsRlVuBs-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/60665769a5330f764ee6d9428f67a6e19f06c67b
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout 60665769a5330f764ee6d9428f67a6e19f06c67b
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "netfs_releasepage" [fs/cifs/cifs.ko] undefined!
>> ERROR: modpost: "netfs_invalidatepage" [fs/cifs/cifs.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

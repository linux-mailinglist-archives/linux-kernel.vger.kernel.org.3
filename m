Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53A756C733
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 07:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiGIFIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 01:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiGIFIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 01:08:40 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD126419B7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 22:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657343318; x=1688879318;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wtuOMyZOkzBCSsW8CQ0ER1Qwt39HNRSKhXgxugr0VEA=;
  b=a56qK/g1NuPfy2Fw/Tb21INUru8CvXjATCkHMQYPZQu8DDkIY2NtrnGG
   4mg02LGJLbqsNzcDFyQI4mZvIwjiznrKUNxqUaSWs6DwPRidAO/7pcNWU
   7O8zgII93dIjUPCk8P8o5HUWU+OVDGuQbv1QU41QMZclvWfrIGOf4s/BG
   g+Z5JHq5X5v36s766SXGEv3MSU9XFnNai7fBfczGDY6Qs2Zs7pKIZZh1p
   Fsa551+M1XatGfnDwo17nS5ZwZFUYEo7jz7e2UyeD+RDUaEs1U/5GvhJV
   C307MyZh861W6x8nCw5RhWzPQHlvgL8cV3NgTzqy5AuXP9fXjhDCpdwpK
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="281961011"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="281961011"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 22:08:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="621471375"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 08 Jul 2022 22:08:34 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oA2hc-000OLG-1f;
        Sat, 09 Jul 2022 05:08:24 +0000
Date:   Sat, 9 Jul 2022 13:08:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-linked-list 54/61] ERROR:
 modpost: "__tracepoint_netfs_dirty_inode" [fs/afs/kafs.ko] undefined!
Message-ID: <202207091311.GTE1zoEm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-linked-list
head:   ce4670495468b797b0c5927fcb661bc0da48b9ab
commit: cff18819f1fb4e28fe8691691de86e9c902abc47 [54/61] Fixes
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20220709/202207091311.GTE1zoEm-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/cff18819f1fb4e28fe8691691de86e9c902abc47
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-linked-list
        git checkout cff18819f1fb4e28fe8691691de86e9c902abc47
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__SCT__tp_func_netfs_write_inode" [fs/afs/kafs.ko] undefined!
>> ERROR: modpost: "__tracepoint_netfs_dirty_inode" [fs/afs/kafs.ko] undefined!
>> ERROR: modpost: "__tracepoint_netfs_write_inode" [fs/afs/kafs.ko] undefined!
>> ERROR: modpost: "__SCT__tp_func_netfs_dirty_inode" [fs/afs/kafs.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

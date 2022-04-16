Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B530A503388
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiDPDdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 23:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiDPDdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 23:33:19 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604C61EADA
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 20:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650079847; x=1681615847;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MpMEz/Plkd6SRzc4IXpMRrkSrQjgucwYusaqTr9fWMQ=;
  b=QHVC80+lCBNs/K9hLIBrdIKItlXb+SB7/QTluQmxttdjiA5TBBE13gnu
   Y5n7AhXgr3GPvRgXviXX7UuNTujPm/UmJNjBXyjL8ouilYAEHc0IF7YCQ
   jtnHzx9XEntQPXPRx1ln+u4ce4K+p493tZmdT8VHmI1Mq++r5d9QZZV5T
   60kK/iNOHoMSqtra2v7cuF6grmnXBd4Pvu8yy9mk5/9QSRBjkLQFa8COm
   NiS7hgBLyGifbnIDFWxXx7uQaojiPee7gh+QOsvOZL+1M6JI8XT1abUL0
   NloMBkhshl9WllYvwpmxBGfoZEbawL9KwAp/PNOkRtVlcou/W/67Jv7ct
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="243195626"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="243195626"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 20:30:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="646264763"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Apr 2022 20:30:46 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfZ93-0002jF-F0;
        Sat, 16 Apr 2022 03:30:45 +0000
Date:   Sat, 16 Apr 2022 11:29:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [bvanassche:scsi-gap-zone 8/8] scsi_debug.c:undefined reference to
 `__udivdi3'
Message-ID: <202204161143.VrWRHaMP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/bvanassche/linux scsi-gap-zone
head:   5531f96720bc0e475e669eb56b7094401c53f928
commit: 5531f96720bc0e475e669eb56b7094401c53f928 [8/8] scsi_debug: Add gap zone support
config: i386-randconfig-a014 (https://download.01.org/0day-ci/archive/20220416/202204161143.VrWRHaMP-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/bvanassche/linux/commit/5531f96720bc0e475e669eb56b7094401c53f928
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche scsi-gap-zone
        git checkout 5531f96720bc0e475e669eb56b7094401c53f928
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: drivers/scsi/scsi_debug.o: in function `sdebug_device_create_zones':
>> scsi_debug.c:(.text+0x15af): undefined reference to `__udivdi3'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

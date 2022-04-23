Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C4250C5E7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 03:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiDWBIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 21:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiDWBI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 21:08:28 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDA71D51A9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 18:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650675933; x=1682211933;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kc6kg15QbSNxV41M8I+VZ7gOa7pCmFyfXdcnqAuD6AY=;
  b=nG9Jt5lUOGYs9GbmP0v4Qg9VqB0vAdA/kZSL4V/EYfSZ6FG0QjSUr6OL
   qN2LnsvktLrxLbiWYQHJs3UaXJr3sQhm9X+0sbwA06t/yWrPRnETqW3DR
   UbJB5NVcXxfCvlm5g9EicvFH/sjAw4uC0XvOy9hxxuJXMR7tRzCnZNCUX
   kfcT5kIvl1NB3QBVCBeDGx2Dcr0eQqPB2Vflv1sHogRaRFG1M1wJyH5CT
   JipQRolU3rQUW8Is4FgFpV7lba/IFj2qjJJGV1ngasD46Pdavtj0oprPX
   lx5mp/7S8Pt5YpSkPphaeMt4ncux/XjpHvffNJZae9ep+J/3DyiEL900s
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="244754267"
X-IronPort-AV: E=Sophos;i="5.90,283,1643702400"; 
   d="scan'208";a="244754267"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 18:05:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,283,1643702400"; 
   d="scan'208";a="672863136"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 22 Apr 2022 18:05:31 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ni4DL-000AkY-4I;
        Sat, 23 Apr 2022 01:05:31 +0000
Date:   Sat, 23 Apr 2022 09:04:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: drivers/nvme/host/fabrics.c:1095:5-8: Unneeded variable: "ret".
 Return "0" on line 1109
Message-ID: <202204230847.xzM1AwY1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   06fb4ecfeac7e00d6704fa5ed19299f2fefb3cc9
commit: f18ee3d988157ebcadc9b7e5fd34811938f50223 nvme-fabrics: print out valid arguments when reading from /dev/nvme-fabrics
date:   4 months ago
config: x86_64-randconfig-c022-20220117 (https://download.01.org/0day-ci/archive/20220423/202204230847.xzM1AwY1-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> drivers/nvme/host/fabrics.c:1095:5-8: Unneeded variable: "ret". Return "0" on line 1109

Please review and possibly fold the followup patch.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

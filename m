Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630474E62FC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 13:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349968AbiCXMOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 08:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbiCXMON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 08:14:13 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C4DA8891
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 05:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648123961; x=1679659961;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=o5DZSEcXBSfapZPtuJt3osrQmUSj5SHfQHgFF2l7BN8=;
  b=BoDO1mKLYJ7BpMRX1Wtf+bTTY86H36K50BWNvG4RmfZk57pOP7sOIj1z
   Zx/IPBYBlqWa4QPPBU68pJDoUWIYddp2vwv4D1ocEAGfqbn4QQ0SKfRP8
   dhet9cfJYNqUIdXk7ocRoJKbSQMYRjqS1QvvV1bo96K+EYpn21bWhws0g
   zA950rDhoaYICs42NjKMGIKbF7GimT3a+MFjUZDf6MGxOMCKtoHRgnFwJ
   uWqO2XelybVvwjWS6EV/QRI3wQKvuN67OkWYGmB2o+D7N/igtYp89g/zy
   m/nyR665aBJ1lHuQRM5b6z+knxWcn0wJ3krwEBx60BzVITo7bzc3QhPxS
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="238966840"
X-IronPort-AV: E=Sophos;i="5.90,207,1643702400"; 
   d="scan'208";a="238966840"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 05:11:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,207,1643702400"; 
   d="scan'208";a="516147844"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 24 Mar 2022 05:11:23 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXMJG-000L3r-SE; Thu, 24 Mar 2022 12:11:22 +0000
Date:   Thu, 24 Mar 2022 20:10:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [bvanassche:ufs-for-next 324/324] drivers/scsi/ufs-core/ufshcd.c:
 scsi/ufs_quirks.h is included more than once.
Message-ID: <202203242041.o36vA24L-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/bvanassche/linux ufs-for-next
head:   b93e987f91a0c037fc4357107f5144110cd84d08
commit: b93e987f91a0c037fc4357107f5144110cd84d08 [324/324] scsi: ufs: Split the drivers/scsi/ufs directory
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


includecheck warnings: (new ones prefixed by >>)
>> drivers/scsi/ufs-core/ufshcd.c: scsi/ufs_quirks.h is included more than once.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

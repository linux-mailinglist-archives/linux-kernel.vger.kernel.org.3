Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B1A4FA538
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 07:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238097AbiDIFqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 01:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiDIFqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 01:46:04 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E7B2A03ED
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 22:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649483038; x=1681019038;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=By0MpIlVHngS6o2onufHLva0kYouUV5umlgSpRk+4ow=;
  b=MmK5idskcQn2HsufP3WwIGtksZ+5IasdJE6fXs/KLU/am01vjDHJZAfU
   E1ZHmeI/fO2FF2VbbZLxwkK057Pu6Qr/9Nl+CVEzWjrf/I9lX54tUqWbL
   HoFb/OEgQnoJnKkWQwcCyh2RxDA8boVR1i0RKlCM9i0j0G5Gciqc7MxfK
   BhId6z9/zKOElTSoOdswycBmJgZbBlDj9VKPJuM8w27S5idEaLF5lbtPG
   I6REzVt6N9WCenxSc+jFBgK2jw+ZB3mV+KOYz3fXU5SWHHe2bqOjsNfTP
   YNIZNXohPbXKlIFKGkjISA2Ud4GicAGwsGsHJ/+0hfHxVG2M5XVciPbDd
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="261942992"
X-IronPort-AV: E=Sophos;i="5.90,247,1643702400"; 
   d="scan'208";a="261942992"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 22:43:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,247,1643702400"; 
   d="scan'208";a="610073255"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 08 Apr 2022 22:43:57 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nd3t6-0000v3-RT;
        Sat, 09 Apr 2022 05:43:56 +0000
Date:   Sat, 9 Apr 2022 13:43:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [morse:mpam/snapshot/v5.17 135/137] fs/resctrl/rdtgroup.c:829:2-3:
 Unneeded semicolon
Message-ID: <202204091338.vxPar47H-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v5.17
head:   fb7499c2de17b6b98e0e3ac5b7b023bfc5a6f3a4
commit: add9f185ed2abdcd1edf0d784e7ece998165a5a5 [135/137] untested: fs/resctrl: Add support for assigning iommu_groups to resctrl groups
config: x86_64-randconfig-c022 (https://download.01.org/0day-ci/archive/20220409/202204091338.vxPar47H-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> fs/resctrl/rdtgroup.c:829:2-3: Unneeded semicolon

Please review and possibly fold the followup patch.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

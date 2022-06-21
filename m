Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9D5552DC6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346652AbiFUJAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 05:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245168AbiFUJAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:00:37 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C80E1C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655802037; x=1687338037;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Pf/6YbHLJ8co/KQOaEDZAh/A6J4z8F3wIA7jYJ7Pb7o=;
  b=TV9kWU6m6o/22y3TQBqNTvDMfUAR1GvZPH7cqkoMtcsFZQay91os5pl9
   yn59GgtTDy1oF3EEiea3AzoJfMQZV/QgNsI4A8St8gi5m8YOZKUXdTvt2
   72eyxV2t/zxFTgmHgZCu6v6FuU84EBKSNrc5oFge0CfzIW8J5J188Se8z
   feZLLC3oE2oHRm3lKInN2C0k9A1xGS2swEL/351i0TJYPWemYgdCEokGN
   bYRl7WDELHBqOwdFlzpFYLhmnwxUo1Bl/DEbEQjjbYeSezhpjiMjQq6x0
   n5ujr+nko0DToNKEYg9aLrf3bPmZombzXBB07uum2bToMMYZzPEFhTXwM
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="280800707"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="280800707"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 02:00:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="676910281"
Received: from lkp-server01.sh.intel.com (HELO e0735e231192) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Jun 2022 02:00:11 -0700
Received: from kbuild by e0735e231192 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3Zk2-00006z-BB;
        Tue, 21 Jun 2022 09:00:10 +0000
Date:   Tue, 21 Jun 2022 16:59:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-5.17.y 765/3797] drivers/iio/accel/mma8452.o:
 warning: objtool: mma8452_read_raw()+0x4c: unreachable instruction
Message-ID: <202206211623.fpXGOLeA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.17.y
head:   eed68052d2016d9f96d6656435099762608120e3
commit: 0646c782086f2a6081186a9898d40ea8886b8ade [765/3797] iio: mma8452: Fix probe failing when an i2c_device_id is used
config: x86_64-randconfig-a003-20220620 (https://download.01.org/0day-ci/archive/20220621/202206211623.fpXGOLeA-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=0646c782086f2a6081186a9898d40ea8886b8ade
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.17.y
        git checkout 0646c782086f2a6081186a9898d40ea8886b8ade
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/iio/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/iio/accel/mma8452.o: warning: objtool: mma8452_read_raw()+0x4c: unreachable instruction

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

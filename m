Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38D453065B
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 23:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351786AbiEVVur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 17:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236788AbiEVVuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 17:50:39 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A360638780
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 14:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653256238; x=1684792238;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YPjUBkExRxUZT4LFZEQlVOxpz0d+wgRfpYYvMZX1HRE=;
  b=BWYZ6FQc7Wosjcvi0+ibf1PFlkDWTtM/KpGJd3g4Zw/STdvzJMNAvkWA
   7enyN/3wBgjtcBvnPvFMDEzTN++pXbHeasNBPlPruVRsiZfAMo3mebHjP
   XGY1ew3BTpUsXz6rLgiKWQLKlVw/UrpKNeWNelGfh6JkNWzYnl/7VT6Xt
   Tna0zx9LJRSzkw3V4+2M2OqWHtCrOQfsW/c7kEgCWqIuU2T9dM6TQe+jZ
   yMGjE6JpfA/MiqhJtyzoaEDHJUTAjHkIFfB+UxOwwi65L84Zv/V/BHD0u
   aBEXSv1zKUq/CnrUSlicsH+NQhMecXTenaVmOVL4kUFusDmQh9JN55rFF
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10355"; a="359444766"
X-IronPort-AV: E=Sophos;i="5.91,244,1647327600"; 
   d="scan'208";a="359444766"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2022 14:50:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,244,1647327600"; 
   d="scan'208";a="577103029"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 22 May 2022 14:50:36 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nstT9-0000dl-M7;
        Sun, 22 May 2022 21:50:35 +0000
Date:   Mon, 23 May 2022 05:50:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-5.17.y 765/2373] drivers/iio/accel/mma8452.o:
 warning: objtool: mma8452_read_raw()+0x71: unreachable instruction
Message-ID: <202205230550.FG5j997T-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.17.y
head:   5c2fc53857eb993952e932da8222b11b063c2581
commit: 0646c782086f2a6081186a9898d40ea8886b8ade [765/2373] iio: mma8452: Fix probe failing when an i2c_device_id is used
config: x86_64-randconfig-a005-20220523 (https://download.01.org/0day-ci/archive/20220523/202205230550.FG5j997T-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
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

>> drivers/iio/accel/mma8452.o: warning: objtool: mma8452_read_raw()+0x71: unreachable instruction

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

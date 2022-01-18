Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F3E492471
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 12:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239324AbiARLPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 06:15:08 -0500
Received: from mga02.intel.com ([134.134.136.20]:47245 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239046AbiARLOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 06:14:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642504476; x=1674040476;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Zj3CHFvIqGa0Sd4q8Ody95DGvKgXhjRf2e5Rx3NVnwc=;
  b=JAJ1rpynSv/KWXHG1NyfSg4kKgEEbNJWfe6Qv4VsTY20pcclX987escv
   3mIkLuQ/pHSu8ioINy+SfA59i0eK9lx/EYGocff4W13ncG4jJf/piilb6
   5n2G7ROav6VGNp2fYuafUyUMklEkCsxJutJissJZdx96D/jZaU0QhTO0L
   egD4c7XcNDTi581GrIcBQ9jT1ep9NHP89ltH+M2GoCUKVjFP/6vngFsdi
   k+Vw4moko+TwLkHl74PFrR9iKZvTMAhr2bjq6ySWzxNJNVCRM2WhYSrH9
   G9x4R1yCH56kocn7DYiEn2Nu5ROf7G/JafB0k0S5PHgOZyW0f3TMJCf8Q
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="232152190"
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="232152190"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 03:14:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="693354405"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 18 Jan 2022 03:14:30 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9mRa-000CVA-0J; Tue, 18 Jan 2022 11:14:30 +0000
Date:   Tue, 18 Jan 2022 19:13:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: drivers/nvme/host/fabrics.c:1095:5-8: Unneeded variable: "ret".
 Return "0" on line 1109
Message-ID: <202201181710.TjfwKXN9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e3a8b6a1e70c37702054ae3c7c07ed828435d8ee
commit: f18ee3d988157ebcadc9b7e5fd34811938f50223 nvme-fabrics: print out valid arguments when reading from /dev/nvme-fabrics
date:   4 weeks ago
config: x86_64-randconfig-c022-20220117 (https://download.01.org/0day-ci/archive/20220118/202201181710.TjfwKXN9-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> drivers/nvme/host/fabrics.c:1095:5-8: Unneeded variable: "ret". Return "0" on line 1109

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

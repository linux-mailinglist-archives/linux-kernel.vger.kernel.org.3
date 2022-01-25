Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1C949BBEB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 20:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiAYTRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 14:17:23 -0500
Received: from mga01.intel.com ([192.55.52.88]:3854 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229706AbiAYTRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 14:17:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643138237; x=1674674237;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SZLEdJsaEXkfj59W5/+kxV+ljm25BFWCkR+qZLFUFGo=;
  b=HlwVjc8vcWODsq2LyvzHZVyIRuYH9q1q+5d7sZyU9Qng69Z99sX71Fy+
   2V7LkDheNZ8qaA+ijcbBedgZWX6MPuw+eHLpUI0n/8i6qSWtLVhvbeTpk
   +6Muw9sHXVd4Z1cxa4Tu0pI8ezrTjbZyY5l1boWOBVE+uuDa3n/pYUK9t
   FxcwYGCcpLqfZ0LMSwx4zzBuj9uzoy6XP1wlhmDQJ7yg4itTehUeKaw+3
   1ZE+mMDq+heRk1U7W2bf6dyknBVGcTC8qySncKidE7xDFITKeGkDs1V8a
   I90kcf14rxgNNzQRMdhQEe9Ggjm+rE7cgJRduWqwr9P7NqKR99wvmO2zk
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="270841710"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="270841710"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 11:17:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="624579287"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jan 2022 11:17:16 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCRJb-000KKv-G9; Tue, 25 Jan 2022 19:17:15 +0000
Date:   Wed, 26 Jan 2022 03:16:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: drivers/nvme/host/fabrics.c:1095:5-8: Unneeded variable: "ret".
 Return "0" on line 1109
Message-ID: <202201260046.otELTDdH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a08b41ab9e2e468647f78eb17c28e29b93006394
commit: f18ee3d988157ebcadc9b7e5fd34811938f50223 nvme-fabrics: print out valid arguments when reading from /dev/nvme-fabrics
date:   5 weeks ago
config: x86_64-randconfig-c022-20220117 (https://download.01.org/0day-ci/archive/20220126/202201260046.otELTDdH-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> drivers/nvme/host/fabrics.c:1095:5-8: Unneeded variable: "ret". Return "0" on line 1109

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

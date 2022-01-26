Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9EC049C91D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 12:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240972AbiAZLy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 06:54:56 -0500
Received: from mga09.intel.com ([134.134.136.24]:26348 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232111AbiAZLyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 06:54:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643198094; x=1674734094;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8cZ0/TMmdu0wNwym0dN59I5PL38YESXalqWuM6TEyeo=;
  b=BHxM4YIKm/Q8cMjvVstrhgz4OTaPMO/JxyyWCwnjGmZxQqHBe5juKecD
   8N/4Jr/jB1jyg/kdtg7IZXDJj1+tC69anAzQRNscj8UrGUbuQ6hq56rJW
   HSER0O9cFvm20XnEc7SKybhrDZfHam3Fe3sU19nRYzbI97XyyVOzcQVlM
   HPTS385d9GpLG0MGDLyt0rwHHQcMxsgxX4Y6HPSQFjiyzKzPRNn7l8EQl
   jkkVgsShUFlV5k4nNNcOZxBah4p9TGPVeOcHTRMN5sBMzKIAjwMiblzt7
   bwbAqhgVvlEwnEbSCOmjUeMW0XJ0bOJLaYbr40JWAoiA+7vTqEAakw2RM
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="246312257"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="246312257"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 03:54:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="563389137"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 26 Jan 2022 03:54:52 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCgt2-000L9f-7R; Wed, 26 Jan 2022 11:54:52 +0000
Date:   Wed, 26 Jan 2022 19:54:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Allison Henderson <allison.henderson@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Chandan Babu R <chandanrlinux@gmail.com>
Subject: [allisonhenderson-xfs-work:delayed_attrs_v26_extended 7/30]
 fs/xfs/libxfs/xfs_attr.c: xfs_attr.h is included more than once.
Message-ID: <202201261927.1WZa0F1S-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/allisonhenderson/xfs_work.git delayed_attrs_v26_extended
head:   19459f5cfa422b0a6a9cd3898892e43ecb49f8f3
commit: 5fad9cb9d34c53dd988d73c1f8141ce2bb828c1a [7/30] xfs: Add xfs_attr_set_deferred and xfs_attr_remove_deferred
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


includecheck warnings: (new ones prefixed by >>)
>> fs/xfs/libxfs/xfs_attr.c: xfs_attr.h is included more than once.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

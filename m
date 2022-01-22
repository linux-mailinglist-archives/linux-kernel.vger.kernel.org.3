Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB22496C78
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 14:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbiAVNNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 08:13:40 -0500
Received: from mga17.intel.com ([192.55.52.151]:34984 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229737AbiAVNNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 08:13:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642857219; x=1674393219;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=V63l6Gahpdxt+Aahnps1nz37cGuHU1SzsL9Es0gLuxg=;
  b=VwC9NlNaRYXfRQ3INCBF27z+y8PqabsnInJNUaWVl7dB/qbGT6htLpBt
   x6mUvFj6akNVhAOxXX2j4Ings4JAOaxgGj6g5XAD4q74rwj1UX8b8IJmY
   JFM5tvXqzRvH1tYOaczpn7qYF2j9JA8iIjFDYUIJmoA9gCOlRNXHq5SQr
   gcsjqip2S6MAZjdOWJ3m8s3uDOYj1ST4aK9VkRpW/7Raea7jZ7civRS3G
   m3w9KC1CZTNFIkGbdrYBX/+d25Gw+cfCQqU1PQQDUxV6LGs03xeKT6ipS
   LaIIxJaRcssPX5eVEIC65OcLK9dehc9t8WGTplcDRMomSRqKqf//Xq6Tt
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="226496064"
X-IronPort-AV: E=Sophos;i="5.88,308,1635231600"; 
   d="scan'208";a="226496064"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2022 05:13:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,308,1635231600"; 
   d="scan'208";a="694929461"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 22 Jan 2022 05:13:38 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBGD3-000GQC-7d; Sat, 22 Jan 2022 13:13:37 +0000
Date:   Sat, 22 Jan 2022 21:13:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Yishai Hadas <yishaih@nvidia.com>
Subject: [jgunthorpe:for-yishai 9/18] ./usr/include/linux/vfio.h:608:37:
 error: expected identifier before '(' token
Message-ID: <202201222149.tYo2QMck-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jgunthorpe/linux for-yishai
head:   578832b9b1266b9c2fa0205513bd7570867bf3e5
commit: 755823a03dd267576194ffe22f6640eca356dfdf [9/18] vfio: Define device migration protocol v2
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220122/202201222149.tYo2QMck-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/jgunthorpe/linux/commit/755823a03dd267576194ffe22f6640eca356dfdf
        git remote add jgunthorpe https://github.com/jgunthorpe/linux
        git fetch --no-tags jgunthorpe for-yishai
        git checkout 755823a03dd267576194ffe22f6640eca356dfdf
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the jgunthorpe/for-yishai HEAD 578832b9b1266b9c2fa0205513bd7570867bf3e5 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   In file included from ./usr/include/linux/vfio_zdev.h:15,
                    from <command-line>:32:
>> ./usr/include/linux/vfio.h:608:37: error: expected identifier before '(' token
     608 | #define VFIO_DEVICE_STATE_STOP      (0)
         |                                     ^
   ./usr/include/linux/vfio.h:1098:2: note: in expansion of macro 'VFIO_DEVICE_STATE_STOP'
    1098 |  VFIO_DEVICE_STATE_STOP = 1,
         |  ^~~~~~~~~~~~~~~~~~~~~~

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

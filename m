Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A3A48EA5E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 14:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235666AbiANNIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 08:08:54 -0500
Received: from mga14.intel.com ([192.55.52.115]:43044 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235182AbiANNIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 08:08:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642165733; x=1673701733;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HuiDkpd1S46KvBZiqcTrE2bs1dpaLcTS39cyhoj3ESQ=;
  b=A03By21yd6nwhLJhmJrTViW9d0asI+Ebw+YAzrD/YkDCzTy1Al9GNlK8
   nV44mp5G88xuLZK0nAbiFrp0GUWsIzWYxpAUwK0Ag/3sSY4hh0Zoz7R46
   8Mba4G2nRm3c76G+Elxz4bOme8JqLL/c5+VXDpmErqaWR2vgfoDlHWjoF
   aEzloynoJDklm1v4AHhJF/v6lzuKYvnnQhuUe0CvVak8ssm+hAE+RNy6+
   +j5bqILpsmrEYUyGKLCHk+7FV7D40mTSSxnmUCvSbLh9NXBVjPPax+eKZ
   gI0fFqB6OjHdsvvtWzgDCWN/g5SYxhwYt0lskxFPzjpjcMUK8KYv7VV7i
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="244442163"
X-IronPort-AV: E=Sophos;i="5.88,288,1635231600"; 
   d="scan'208";a="244442163"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 05:08:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,288,1635231600"; 
   d="scan'208";a="577277462"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 14 Jan 2022 05:08:52 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8MK3-0008Yb-Pa; Fri, 14 Jan 2022 13:08:51 +0000
Date:   Fri, 14 Jan 2022 21:07:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 1559/2382] ./usr/include/linux/socket.h:5:10:
 fatal error: uapi/linux/socket_types.h: No such file or directory
Message-ID: <202201142149.lENf79SU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   1a880941a087613ed42f77001229edfcf75ea8a5
commit: 4d279aea908260eca25d06d817422f7b820a790f [1559/2382] headers/deps: net: Split <linux/socket_types.h> out of <linux/socket.h>
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220114/202201142149.lENf79SU-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=4d279aea908260eca25d06d817422f7b820a790f
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout 4d279aea908260eca25d06d817422f7b820a790f
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from ./usr/include/rdma/rdma_user_cm.h:38,
                    from <command-line>:32:
>> ./usr/include/linux/socket.h:5:10: fatal error: uapi/linux/socket_types.h: No such file or directory
       5 | #include <uapi/linux/socket_types.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

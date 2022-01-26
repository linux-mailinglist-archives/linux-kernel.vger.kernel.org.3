Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADBF49D526
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 23:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbiAZWRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 17:17:51 -0500
Received: from mga06.intel.com ([134.134.136.31]:8826 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229490AbiAZWRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 17:17:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643235470; x=1674771470;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xooQbuHivbMOOs9OpcyfoNfdN4za7A4ATPcdg05Z0lw=;
  b=KgRcHRtNIcVaPRavsJBtjigjXKXJ9q/YvA2AZwJVoedUZ6uj4GSguGc7
   Y4M2ogFkHStyaOpUTcQkX0dea7B/lEx4JTDUui4XKJ0a7qvV8b9mhbR60
   /tSpjhrd+0BnC3qhSsvINFbZ7GSG9lbH0UNB19KEmj9l+EW58bOYXiz/8
   j+VaBW42mVLzSZlRcwBTGQbDt8jwU1CBgSnTa8RB/utTkpOnRCsCG9fRK
   B91awRWPeIJEZEw7CvXZLMJifPDT9RrEZxuKWRMV1a32VMDKjyQzQfDGW
   EQGwIYu16U2OiGpXorfDy4Vi/WyhM1oDrHjdN9+ByQTkLPSqoi8logzw7
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="307379875"
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="307379875"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 14:17:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="480040840"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 Jan 2022 14:17:22 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCqbR-000LiT-W6; Wed, 26 Jan 2022 22:17:21 +0000
Date:   Thu, 27 Jan 2022 06:16:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [hverkuil-media-tree:extron 101/103]
 ./usr/include/linux/cec.h:150:19: error: unknown type name 'bool'
Message-ID: <202201270613.3EEZBJH4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/hverkuil/media_tree.git extron
head:   54377f21d8b2084a9f5993230bdab8e8cd55bb22
commit: d679f6adf24b7fef91e8a3b3584b48587e9cf0a2 [101/103] cec.h: add cec_msg_recv_is_tx_result() helper
config: i386-randconfig-a012-20220124 (https://download.01.org/0day-ci/archive/20220127/202201270613.3EEZBJH4-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 2a1b7aa016c0f4b5598806205bdfbab1ea2d92c4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add hverkuil-media-tree git://linuxtv.org/hverkuil/media_tree.git
        git fetch --no-tags hverkuil-media-tree extron
        git checkout d679f6adf24b7fef91e8a3b3584b48587e9cf0a2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
   In file included from ./usr/include/linux/cec-funcs.h:11:
>> ./usr/include/linux/cec.h:150:19: error: unknown type name 'bool'
   static __inline__ bool cec_msg_recv_is_tx_result(const struct cec_msg *msg)
                     ^
   1 error generated.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

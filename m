Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2F348F343
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 00:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbiANXwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 18:52:35 -0500
Received: from mga03.intel.com ([134.134.136.65]:27944 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229801AbiANXwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 18:52:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642204354; x=1673740354;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7mho6A7CUIR5IT9gDR87/jT/tWNHoagoN1uPQ8gqVQc=;
  b=euWevvkGBzVN5rsHaUZ4LEbtFjrugUSGBjRtRDcC8vizHX2h4r9bBSUq
   pvnza3lKD58em85ZW1drsG6gLTv4hMZEhDY1gSKuiAadF3YjZJGukYYdg
   r7FEB/KQnoEwB+SFFnu3ZbgaFvQ55areLRgDY8ouTJ/VlKXoFdOsiTSMu
   69+IL7FzsvnbE9scZokV7SBAyye/3YGjCD9eo11rgRkHvuL/MKuf3lRwJ
   FOOgkqI1w8mHXkY5I0APyIcHuUFQ/pBgMZpLerTPZexoRsBfwvgp3XyDx
   otx3Gx+CxWq8LquMcfl5ioYa2N2yOsugf2V09G4mBZcKtLvJ1DY7rsjTX
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="244310267"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="244310267"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 15:52:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="516578505"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 14 Jan 2022 15:52:32 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8WMy-00099l-3P; Fri, 14 Jan 2022 23:52:32 +0000
Date:   Sat, 15 Jan 2022 07:52:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1596/2384]
 ./usr/include/linux/netdevice.h:29:10: fatal error: uapi/linux/if.h: No such
 file or directory
Message-ID: <202201150726.6104S4by-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   4c707c1c0de83967079b4e385012fa5b00e2cd11
commit: 5d5fc815f35aee2826c6b83d677576c46132c10c [1596/2384] headers/deps: net: Optimize <uapi/linux/netdevice.h>
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220115/202201150726.6104S4by-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=5d5fc815f35aee2826c6b83d677576c46132c10c
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 5d5fc815f35aee2826c6b83d677576c46132c10c
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from ./usr/include/linux/if_arp.h:27,
                    from <command-line>:32:
>> ./usr/include/linux/netdevice.h:29:10: fatal error: uapi/linux/if.h: No such file or directory
      29 | #include <uapi/linux/if.h>
         |          ^~~~~~~~~~~~~~~~~
   compilation terminated.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

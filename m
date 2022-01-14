Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C2248E2ED
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 04:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239018AbiANDT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 22:19:27 -0500
Received: from mga05.intel.com ([192.55.52.43]:58266 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236311AbiANDTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 22:19:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642130364; x=1673666364;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=a7JQ0KBwAEtbbpizL0DQbuLQ9hdoYMjw3irKRMDaCZM=;
  b=dq4gklLUuhHN9qyjUuNrrLa0I15Y7XP3LAk4zy+gG81/GQroL3v398GY
   tyg/ilpTEwNpnXqTyhxner/fyGx0neABXRQqPC/VsS8W7FxAXSHOdsPQP
   icf2WGdOtHuiQULQNTEydzRj6Qay/WnWI+50TCp0LlrC5SwTfIRJ5KrFB
   MqFrDIre4ScU2RldmojhfkTdF08NKKaqYbfxkcFG3Z/LgRdXSjaX6qWVE
   jFrwGFWzNoGHz4pctoDt/Ttm6/CMYvWGSX+HFa2e67fgR1g3eSiySv3CN
   DEDfQ4pZ1hYm4AHbBO2UpEMMmGmLZ05TJzs0NxtgzEy/KAkJ0HKAxfI48
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="330523233"
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="330523233"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 19:19:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="593597931"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 13 Jan 2022 19:19:23 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8D7Z-00081q-JS; Fri, 14 Jan 2022 03:19:21 +0000
Date:   Fri, 14 Jan 2022 11:19:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 921/2382] ./usr/include/linux/kcm.h:18:10: fatal
 error: uapi/linux/sockios.h: No such file or directory
Message-ID: <202201141112.RQVsmSIR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   1a880941a087613ed42f77001229edfcf75ea8a5
commit: 9242d9709c29db37d2bc947467661f1817d0f8a6 [921/2382] headers/deps: Add header dependencies to .h files: <uapi/linux/sockios.h>
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220114/202201141112.RQVsmSIR-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=9242d9709c29db37d2bc947467661f1817d0f8a6
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout 9242d9709c29db37d2bc947467661f1817d0f8a6
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:32:
>> ./usr/include/linux/kcm.h:18:10: fatal error: uapi/linux/sockios.h: No such file or directory
      18 | #include <uapi/linux/sockios.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.
--
   In file included from <command-line>:32:
>> ./usr/include/linux/x25.h:15:10: fatal error: uapi/linux/sockios.h: No such file or directory
      15 | #include <uapi/linux/sockios.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.
--
   In file included from <command-line>:32:
>> ./usr/include/linux/rds.h:38:10: fatal error: uapi/linux/sockios.h: No such file or directory
      38 | #include <uapi/linux/sockios.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.
--
   In file included from <command-line>:32:
>> ./usr/include/linux/if_tunnel.h:5:10: fatal error: uapi/linux/sockios.h: No such file or directory
       5 | #include <uapi/linux/sockios.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

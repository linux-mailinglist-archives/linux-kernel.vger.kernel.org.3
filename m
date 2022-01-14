Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3FA548E9FE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 13:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241021AbiANMhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 07:37:54 -0500
Received: from mga05.intel.com ([192.55.52.43]:8148 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230379AbiANMhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 07:37:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642163873; x=1673699873;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+tI1YiGuy+svjnvQcW47NrzwkaMl0BBQKleSydyar/U=;
  b=GUbPUynUbeqHUbHx7dqsZwn9AT/aB0JWhMWO7peTi78CThRgv1WyjuGj
   KByYNlo5CsWsyKZT18g9fMHeA+HijIgcFnvY1FuY4FlIGs9FRyLA3tV8t
   DK76qIAoUJsaGbugg1FTAf40AqSE0MwblZPOvD5XhvgZpnYfbPeqe8YUW
   d6abm3wlgu+cDa/iyUrf7UryWY4nbPk5JLTQw0wQHTK0m//7+p5PZraps
   LdynGcgeDG0nV55OJ9C5cr3RE9W5kxqKLe/hhHvFv77LE2K3/i4EyP6fa
   5oOyR2dZO3jSlbszXtQP28lAhG7mq7S5ygZGfnDkQhu9QOwQmudO5rJ3n
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="330586353"
X-IronPort-AV: E=Sophos;i="5.88,288,1635231600"; 
   d="scan'208";a="330586353"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 04:37:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,288,1635231600"; 
   d="scan'208";a="491507519"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 14 Jan 2022 04:37:51 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8Lq2-0008Wq-V6; Fri, 14 Jan 2022 12:37:50 +0000
Date:   Fri, 14 Jan 2022 20:37:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 921/2382] ./usr/include/linux/rds.h:38:10: fatal
 error: 'uapi/linux/sockios.h' file not found
Message-ID: <202201142031.bnR0Yamb-lkp@intel.com>
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
config: i386-randconfig-a006 (https://download.01.org/0day-ci/archive/20220114/202201142031.bnR0Yamb-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d1021978b8e7e35dcc30201ca1731d64b5a602a8)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=9242d9709c29db37d2bc947467661f1817d0f8a6
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout 9242d9709c29db37d2bc947467661f1817d0f8a6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
>> ./usr/include/linux/rds.h:38:10: fatal error: 'uapi/linux/sockios.h' file not found
   #include <uapi/linux/sockios.h>
            ^~~~~~~~~~~~~~~~~~~~~~
   1 error generated.
--
   In file included from <built-in>:1:
>> ./usr/include/linux/kcm.h:18:10: fatal error: 'uapi/linux/sockios.h' file not found
   #include <uapi/linux/sockios.h>
            ^~~~~~~~~~~~~~~~~~~~~~
   1 error generated.
--
   In file included from <built-in>:1:
>> ./usr/include/linux/if_tunnel.h:5:10: fatal error: 'uapi/linux/sockios.h' file not found
   #include <uapi/linux/sockios.h>
            ^~~~~~~~~~~~~~~~~~~~~~
   1 error generated.
--
   In file included from <built-in>:1:
>> ./usr/include/linux/x25.h:15:10: fatal error: 'uapi/linux/sockios.h' file not found
   #include <uapi/linux/sockios.h>
            ^~~~~~~~~~~~~~~~~~~~~~
   1 error generated.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

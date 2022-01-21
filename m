Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859B9495BC9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 09:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349425AbiAUIVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 03:21:06 -0500
Received: from mga12.intel.com ([192.55.52.136]:35591 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1379600AbiAUITm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 03:19:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642753181; x=1674289181;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pMiHjvl84QjMhHNHxc4MDB2pjg1jVB5PbjyIBBA0x0o=;
  b=cMAe2mtqwNxtqWCd9kM5IxNm8flJ4UmEZBAk6vzaTOo83fUVWiIcP/G0
   gnZYeGxn2h7+OuAPRBOLc1xsh6MEv6vH/gBh2S4z3fpuPUN8j1KU1SnNW
   VqNCPiub+Xan2H9YM0OkV0YOwCRiiUL1fV1z4ViiQCc4/KpsVpxWkSW/V
   /4yAx6DHJip7E4QbBwWc5tmjhEeNeXsgbPiVqOMB5fF/Ghlj5eDo9mB87
   2dbH/Qb9lSaqfILjtjP3U0QzIjhW6QJEd0nzh4ruzSvephMNP/bh0hdWn
   D5jWwYY4rk507DYOuh8d21hn7IihlsZ/h3W8D2vVRkupkNI2gNhfJq8+X
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10233"; a="225577999"
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="225577999"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 00:19:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="478165440"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 21 Jan 2022 00:19:39 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nAp90-000F6R-Fu; Fri, 21 Jan 2022 08:19:38 +0000
Date:   Fri, 21 Jan 2022 16:19:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [bvanassche:scsi-move-scsi-pointer 25/45]
 drivers/scsi/megaraid.c:1075:9: warning: variable 'scb' is uninitialized
 when used here
Message-ID: <202201211656.z3YanySW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/bvanassche/linux scsi-move-scsi-pointer
head:   1f9cda056e9fc3b2f08455c8ab1a2d85b52df093
commit: 7f5c4ca6df22ad432a2631b6cdd374f40a249746 [25/45] megaraid: Stop using the SCSI pointer
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220121/202201211656.z3YanySW-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d4baf3b1322b84816aa623d8e8cb45a49cb68b84)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/bvanassche/linux/commit/7f5c4ca6df22ad432a2631b6cdd374f40a249746
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche scsi-move-scsi-pointer
        git checkout 7f5c4ca6df22ad432a2631b6cdd374f40a249746
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/scsi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/scsi/megaraid.c:1075:9: warning: variable 'scb' is uninitialized when used here [-Wuninitialized]
                   if (!(scb->state & SCB_ISSUED) && issue_scb(adapter, scb) != 0)
                         ^~~
   drivers/scsi/megaraid.c:1073:13: note: initialize the variable 'scb' to silence this warning
                   scb_t *scb;
                             ^
                              = NULL
   1 warning generated.


vim +/scb +1075 drivers/scsi/megaraid.c

  1065	
  1066	static void
  1067	__mega_runpendq(adapter_t *adapter)
  1068	{
  1069		struct megaraid_cmd_priv *pos, *next;
  1070	
  1071		/* Issue all pending commands to the card */
  1072		list_for_each_entry_safe(pos, next, &adapter->pending_list, entry) {
  1073			scb_t *scb;
  1074	
> 1075			if (!(scb->state & SCB_ISSUED) && issue_scb(adapter, scb) != 0)
  1076				return;
  1077		}
  1078	}
  1079	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841894D7524
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 13:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbiCMMXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 08:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiCMMXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 08:23:06 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE278301D
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 05:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647174118; x=1678710118;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=khiSBAux5MvI26fxBbh/GyiBBtEkYZ/Xp0fM7I52S+M=;
  b=lllTw/PFw6mOiGVE+j9d1B22AI62kPnF06w5BWdkII/7PLMiMSPuMINp
   aNCyBors5imqKZPTzAZg/We+DLvMj5bD7i8SAgUIeQJIBKlVak2NcETka
   WOJogMKrxbQboUWO1KDzKDMDb1CnJDIU9pS/fFoqSQbuZ5lWSIXzfLMNS
   agZhBZowQlL1KWRdxGmIxiXM4NVv6Wbcp/caa5CvXKHdf9I1vovIRTeqn
   BlbLsKpyFIdOjO3OL61xFOKiQ5fFXeuJf8/ougkD4nBD1W/uJpqOVmHld
   QHcdoZDV3I0o2/yzyglwKRCzRVTYGUhicRe9K2hNQWXxW+mFbk08DgATg
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10284"; a="236468562"
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="236468562"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 05:21:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="539593892"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 13 Mar 2022 05:21:57 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTNES-0008wG-FE; Sun, 13 Mar 2022 12:21:56 +0000
Date:   Sun, 13 Mar 2022 20:21:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hare-scsi-devel:tls-upcall.v4 133/156] core.c:undefined reference
 to `nvme_keyring_init'
Message-ID: <202203132002.Fj2l2nXq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git tls-upcall.v4
head:   d2416ecdb6b03fc2e4aa40b20cdf919322713224
commit: 5c012a33316168af9ff3a20ee1ae0edc60c745ae [133/156] nvme: register .nvme keyring
config: arc-randconfig-r043-20220313 (https://download.01.org/0day-ci/archive/20220313/202203132002.Fj2l2nXq-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=5c012a33316168af9ff3a20ee1ae0edc60c745ae
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel tls-upcall.v4
        git checkout 5c012a33316168af9ff3a20ee1ae0edc60c745ae
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arc-elf-ld: drivers/nvme/host/core.o: in function `nvme_core_init':
>> core.c:(.init.text+0x102): undefined reference to `nvme_keyring_init'
>> arc-elf-ld: core.c:(.init.text+0x102): undefined reference to `nvme_keyring_init'

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

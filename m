Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249A44BF251
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 07:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiBVGxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 01:53:23 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiBVGxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 01:53:21 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2ACC1110A1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 22:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645512776; x=1677048776;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=K2rrUFyOPv0PEnJ0qm/GbQAIYIb8g6XRBX2iDCdbYoE=;
  b=c85TzLpIdQ0L/6Nba+S8RsiUL/wBmb6sl1I4Pd/s91wVNvaO1oloyWFh
   yG70szFuL8V9jzeKCjuqSsieyuNmF4tVqBngWIF8jXuBA/8r8z3VjqztM
   EtaowDChzLFACPfrwfMWUddHNq5KVv31Fq4K1E+MTzL9U2F0ico3MJVH1
   NdpE6Mrxl7iVDd/u9/23Xn0gKsAv9lF4WoSKXI8gHrK8lagQouVTJLoDa
   S24KPmNucqx8uubsXGwezgXt9sxNsCdIm+Cc8yDBDaInCUJuE8X1Dh1in
   Yo50wNlprB9gv2nXQCk5fIXlNZUypRRj7prJnRg1VvG03a1BqjzcdbDky
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="276224040"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="276224040"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 22:52:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="778905213"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 21 Feb 2022 22:52:55 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMP2c-0002QX-QQ; Tue, 22 Feb 2022 06:52:54 +0000
Date:   Tue, 22 Feb 2022 14:52:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Garry <john.garry@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [mkp-scsi:for-next 93/154] hisi_sas_main.c:undefined reference to
 `sas_execute_ata_cmd'
Message-ID: <202202221427.OvZeGfzt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
head:   2988062985d598d6871f47cb8eb70318af5b5b2d
commit: 13685dfbad9831580335dc6e2f7a3be14b769686 [93/154] scsi: libsas: Add sas_execute_ata_cmd()
config: ia64-buildonly-randconfig-r002-20220221 (https://download.01.org/0day-ci/archive/20220222/202202221427.OvZeGfzt-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git/commit/?id=13685dfbad9831580335dc6e2f7a3be14b769686
        git remote add mkp-scsi https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git
        git fetch --no-tags mkp-scsi for-next
        git checkout 13685dfbad9831580335dc6e2f7a3be14b769686
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ia64-linux-ld: drivers/scsi/hisi_sas/hisi_sas_main.o: in function `hisi_sas_softreset_ata_disk':
>> hisi_sas_main.c:(.text+0x42f2): undefined reference to `sas_execute_ata_cmd'
>> ia64-linux-ld: hisi_sas_main.c:(.text+0x44a2): undefined reference to `sas_execute_ata_cmd'
   ia64-linux-ld: hisi_sas_main.c:(.text+0x45e2): undefined reference to `sas_execute_ata_cmd'
   ia64-linux-ld: hisi_sas_main.c:(.text+0x4732): undefined reference to `sas_execute_ata_cmd'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

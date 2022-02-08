Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDF84ADFF6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 18:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384427AbiBHRzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 12:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384412AbiBHRzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 12:55:10 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39490C06129A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 09:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644342905; x=1675878905;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Y4sTN7TwueJtFfnhcW0aa6IWG7MJDn7ZjFeJtWWwxf4=;
  b=Etlh9/ycICNDnU2P+SkPpTclb9If1oEyxYz/87MddKoUduEmProhlj+j
   B1K0lBjPQ1mMX+VLYDEn6hsMZxX+pbbk743ItazlyAbwta+DDOTYxfIwm
   o18jBesPwFWugqwNlUWJGtJGJZqbVjNmnoaMRO5PjD6goy1zQ1xMMQfer
   FPd3MPcrTIysnollgkNOuWHgRSNGPhUEokJzfDlN/YBXTe7zejMdsZ6S6
   ISwy7oFzuFRyQa8TNnhcbDqonpr+xJaq4hQlXuUBIvwHJHjitwWuBF6Uf
   6BR5Wc7+Txr6kA+KLkPmeKvAx1u0XbT9a+i/Bx6sAsNglbKN8pX0TsD27
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="309754488"
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="309754488"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 09:55:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="482022665"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2022 09:55:01 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHUhg-0000Y9-HA; Tue, 08 Feb 2022 17:55:00 +0000
Date:   Wed, 9 Feb 2022 01:54:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Quinn Tran <qutran@marvell.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Larry Wisneski <Larry.Wisneski@marvell.com>,
        Duane Grigsby <duane.grigsby@marvell.com>,
        Rick Hicksted Jr <rhicksted@marvell.com>,
        Nilesh Javali <njavali@marvell.com>
Subject: drivers/scsi/qla2xxx/qla_edif_bsg.h:93:12: warning: field remote_pid
 within 'struct app_pinfo_req' is less aligned than 'port_id_t' and is
 usually due to 'struct app_pinfo_req' being packed, which can lead to
 unaligned accesses
Message-ID: <202202090106.U3d0uaWb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quinn,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   555f3d7be91a873114c9656069f1a9fa476ec41a
commit: 7878f22a2e03b69baf792f74488962981a1c9547 scsi: qla2xxx: edif: Add getfcinfo and statistic bsgs
date:   7 months ago
config: arm-randconfig-r006-20220208 (https://download.01.org/0day-ci/archive/20220209/202202090106.U3d0uaWb-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project e8bff9ae54a55b4dbfeb6ba55f723abbd81bf494)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7878f22a2e03b69baf792f74488962981a1c9547
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 7878f22a2e03b69baf792f74488962981a1c9547
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/scsi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/scsi/qla2xxx/qla_edif.c:6:
   In file included from drivers/scsi/qla2xxx/qla_def.h:34:
   include/uapi/scsi/scsi_bsg_fc.h:280:4: warning: field rqst_data within 'struct fc_bsg_request' is less aligned than 'union (unnamed union at include/uapi/scsi/scsi_bsg_fc.h:271:2)' and is usually due to 'struct fc_bsg_request' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           } rqst_data;
             ^
   In file included from drivers/scsi/qla2xxx/qla_edif.c:6:
   In file included from drivers/scsi/qla2xxx/qla_def.h:74:
   In file included from drivers/scsi/qla2xxx/qla_bsg.h:298:
>> drivers/scsi/qla2xxx/qla_edif_bsg.h:93:12: warning: field remote_pid within 'struct app_pinfo_req' is less aligned than 'port_id_t' and is usually due to 'struct app_pinfo_req' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           port_id_t remote_pid;
                     ^
   2 warnings generated.


vim +93 drivers/scsi/qla2xxx/qla_edif_bsg.h

7ebb336e45ef1c Quinn Tran 2021-06-23  89  
7ebb336e45ef1c Quinn Tran 2021-06-23  90  struct app_pinfo_req {
7ebb336e45ef1c Quinn Tran 2021-06-23  91  	struct app_id app_info;
7ebb336e45ef1c Quinn Tran 2021-06-23  92  	uint8_t	 num_ports;
7ebb336e45ef1c Quinn Tran 2021-06-23 @93  	port_id_t remote_pid;
7ebb336e45ef1c Quinn Tran 2021-06-23  94  	uint8_t	 reserved[VND_CMD_APP_RESERVED_SIZE];
7ebb336e45ef1c Quinn Tran 2021-06-23  95  } __packed;
7ebb336e45ef1c Quinn Tran 2021-06-23  96  

:::::: The code at line 93 was first introduced by commit
:::::: 7ebb336e45ef1ce23462c3bbd03779929008901f scsi: qla2xxx: edif: Add start + stop bsgs

:::::: TO: Quinn Tran <qutran@marvell.com>
:::::: CC: Martin K. Petersen <martin.petersen@oracle.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9A9512A57
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 06:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242620AbiD1ERC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 00:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbiD1EQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 00:16:58 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49957237E7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 21:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651119225; x=1682655225;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=r20K8UmwazErhCOSE6GnVDpTvgM3044GfseREXweZN0=;
  b=H1LjnPDR+qKzeueuO6hN0IstDs9u9KQLnMDd+UADCHjMBm6rob82BXUl
   8FkyQKsLjOka1L0uL1udj4CrUxQqnCXng5hdvH8MsVp/m225QoXFnUjZQ
   Upmu/IRHbNDR1rtjxsLtY4Lk3hyCV6yydhUM8ThrJT+RB+gnJXJMFX/LJ
   mm2WMvRcDZS2p3SDNkM6e0WWExECFSpghYsniRwZuoGKezijlTuPKMpPW
   l1u2MxwY9ax8Kaoy8R8z8phH/batEzBSbbO3J2EqxMUfqO48J/Y4daawF
   7HN4lO0IVqjTuQWr3vNkj9V30g4oB85/Fi7wlTICyO6/U4jqFF6xCs1VC
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="248084279"
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="248084279"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 21:13:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="705862673"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 27 Apr 2022 21:13:37 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njvX6-00052d-8w;
        Thu, 28 Apr 2022 04:13:36 +0000
Date:   Thu, 28 Apr 2022 12:12:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     kbuild-all@lists.01.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/stringop-overflow 1/1]
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c:833:32: warning: 'fcoe_wwn_from_mac'
 accessing 32 bytes in a region of size 6
Message-ID: <202204281235.5QhYdg1I-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/stringop-overflow
head:   841e98dddf647582547543eba0a1e3e8c8f8db9c
commit: 841e98dddf647582547543eba0a1e3e8c8f8db9c [1/1] Makefile: Enable -Wstringop-overflow
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220428/202204281235.5QhYdg1I-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?id=841e98dddf647582547543eba0a1e3e8c8f8db9c
        git remote add gustavoars https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git
        git fetch --no-tags gustavoars testing/stringop-overflow
        git checkout 841e98dddf647582547543eba0a1e3e8c8f8db9c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/scsi/bnx2fc/ drivers/scsi/fcoe/ drivers/scsi/qedf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/scsi/bnx2fc/bnx2fc_fcoe.c: In function 'bnx2fc_net_config':
>> drivers/scsi/bnx2fc/bnx2fc_fcoe.c:833:32: warning: 'fcoe_wwn_from_mac' accessing 32 bytes in a region of size 6 [-Wstringop-overflow=]
     833 |                         wwnn = fcoe_wwn_from_mac(ctlr->ctl_src_addr,
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     834 |                                                  1, 0);
         |                                                  ~~~~~
   drivers/scsi/bnx2fc/bnx2fc_fcoe.c:833:32: note: referencing argument 1 of type 'unsigned char *'
   In file included from drivers/scsi/bnx2fc/bnx2fc.h:53,
                    from drivers/scsi/bnx2fc/bnx2fc_fcoe.c:17:
   include/scsi/libfcoe.h:252:5: note: in a call to function 'fcoe_wwn_from_mac'
     252 | u64 fcoe_wwn_from_mac(unsigned char mac[MAX_ADDR_LEN], unsigned int, unsigned int);
         |     ^~~~~~~~~~~~~~~~~
   drivers/scsi/bnx2fc/bnx2fc_fcoe.c:839:32: warning: 'fcoe_wwn_from_mac' accessing 32 bytes in a region of size 6 [-Wstringop-overflow=]
     839 |                         wwpn = fcoe_wwn_from_mac(ctlr->ctl_src_addr,
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     840 |                                                  2, 0);
         |                                                  ~~~~~
   drivers/scsi/bnx2fc/bnx2fc_fcoe.c:839:32: note: referencing argument 1 of type 'unsigned char *'
   In file included from drivers/scsi/bnx2fc/bnx2fc.h:53,
                    from drivers/scsi/bnx2fc/bnx2fc_fcoe.c:17:
   include/scsi/libfcoe.h:252:5: note: in a call to function 'fcoe_wwn_from_mac'
     252 | u64 fcoe_wwn_from_mac(unsigned char mac[MAX_ADDR_LEN], unsigned int, unsigned int);
         |     ^~~~~~~~~~~~~~~~~
--
   drivers/scsi/fcoe/fcoe.c: In function 'fcoe_netdev_config':
>> drivers/scsi/fcoe/fcoe.c:744:32: warning: 'fcoe_wwn_from_mac' accessing 32 bytes in a region of size 6 [-Wstringop-overflow=]
     744 |                         wwnn = fcoe_wwn_from_mac(ctlr->ctl_src_addr, 1, 0);
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/fcoe/fcoe.c:744:32: note: referencing argument 1 of type 'unsigned char *'
   In file included from drivers/scsi/fcoe/fcoe.c:36:
   include/scsi/libfcoe.h:252:5: note: in a call to function 'fcoe_wwn_from_mac'
     252 | u64 fcoe_wwn_from_mac(unsigned char mac[MAX_ADDR_LEN], unsigned int, unsigned int);
         |     ^~~~~~~~~~~~~~~~~
   drivers/scsi/fcoe/fcoe.c:747:32: warning: 'fcoe_wwn_from_mac' accessing 32 bytes in a region of size 6 [-Wstringop-overflow=]
     747 |                         wwpn = fcoe_wwn_from_mac(ctlr->ctl_src_addr,
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     748 |                                                  2, 0);
         |                                                  ~~~~~
   drivers/scsi/fcoe/fcoe.c:747:32: note: referencing argument 1 of type 'unsigned char *'
   In file included from drivers/scsi/fcoe/fcoe.c:36:
   include/scsi/libfcoe.h:252:5: note: in a call to function 'fcoe_wwn_from_mac'
     252 | u64 fcoe_wwn_from_mac(unsigned char mac[MAX_ADDR_LEN], unsigned int, unsigned int);
         |     ^~~~~~~~~~~~~~~~~
--
   drivers/scsi/qedf/qedf_main.c: In function '__qedf_probe':
>> drivers/scsi/qedf/qedf_main.c:3520:30: warning: 'fcoe_wwn_from_mac' accessing 32 bytes in a region of size 6 [-Wstringop-overflow=]
    3520 |                 qedf->wwnn = fcoe_wwn_from_mac(qedf->mac, 1, 0);
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/qedf/qedf_main.c:3520:30: note: referencing argument 1 of type 'unsigned char *'
   In file included from drivers/scsi/qedf/qedf.h:9,
                    from drivers/scsi/qedf/qedf_main.c:23:
   include/scsi/libfcoe.h:252:5: note: in a call to function 'fcoe_wwn_from_mac'
     252 | u64 fcoe_wwn_from_mac(unsigned char mac[MAX_ADDR_LEN], unsigned int, unsigned int);
         |     ^~~~~~~~~~~~~~~~~
   drivers/scsi/qedf/qedf_main.c:3521:30: warning: 'fcoe_wwn_from_mac' accessing 32 bytes in a region of size 6 [-Wstringop-overflow=]
    3521 |                 qedf->wwpn = fcoe_wwn_from_mac(qedf->mac, 2, 0);
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/qedf/qedf_main.c:3521:30: note: referencing argument 1 of type 'unsigned char *'
   In file included from drivers/scsi/qedf/qedf.h:9,
                    from drivers/scsi/qedf/qedf_main.c:23:
   include/scsi/libfcoe.h:252:5: note: in a call to function 'fcoe_wwn_from_mac'
     252 | u64 fcoe_wwn_from_mac(unsigned char mac[MAX_ADDR_LEN], unsigned int, unsigned int);
         |     ^~~~~~~~~~~~~~~~~


vim +/fcoe_wwn_from_mac +833 drivers/scsi/bnx2fc/bnx2fc_fcoe.c

853e2bd2103aaa9 Bhanu Gollapudi         2011-02-04  803  
5243960777a8d5f Bhanu Prakash Gollapudi 2011-08-04  804  static int bnx2fc_net_config(struct fc_lport *lport, struct net_device *netdev)
853e2bd2103aaa9 Bhanu Gollapudi         2011-02-04  805  {
853e2bd2103aaa9 Bhanu Gollapudi         2011-02-04  806  	struct bnx2fc_hba *hba;
aea71a024914e8b Bhanu Prakash Gollapudi 2011-07-26  807  	struct bnx2fc_interface *interface;
fd8f89027d816cb Robert Love             2012-05-22  808  	struct fcoe_ctlr *ctlr;
853e2bd2103aaa9 Bhanu Gollapudi         2011-02-04  809  	struct fcoe_port *port;
853e2bd2103aaa9 Bhanu Gollapudi         2011-02-04  810  	u64 wwnn, wwpn;
853e2bd2103aaa9 Bhanu Gollapudi         2011-02-04  811  
853e2bd2103aaa9 Bhanu Gollapudi         2011-02-04  812  	port = lport_priv(lport);
aea71a024914e8b Bhanu Prakash Gollapudi 2011-07-26  813  	interface = port->priv;
fd8f89027d816cb Robert Love             2012-05-22  814  	ctlr = bnx2fc_to_ctlr(interface);
aea71a024914e8b Bhanu Prakash Gollapudi 2011-07-26  815  	hba = interface->hba;
853e2bd2103aaa9 Bhanu Gollapudi         2011-02-04  816  
853e2bd2103aaa9 Bhanu Gollapudi         2011-02-04  817  	/* require support for get_pauseparam ethtool op. */
853e2bd2103aaa9 Bhanu Gollapudi         2011-02-04  818  	if (!hba->phys_dev->ethtool_ops ||
853e2bd2103aaa9 Bhanu Gollapudi         2011-02-04  819  	    !hba->phys_dev->ethtool_ops->get_pauseparam)
853e2bd2103aaa9 Bhanu Gollapudi         2011-02-04  820  		return -EOPNOTSUPP;
853e2bd2103aaa9 Bhanu Gollapudi         2011-02-04  821  
1294bfe60960c89 Bhanu Gollapudi         2011-03-17  822  	if (fc_set_mfs(lport, BNX2FC_MFS))
853e2bd2103aaa9 Bhanu Gollapudi         2011-02-04  823  		return -EINVAL;
853e2bd2103aaa9 Bhanu Gollapudi         2011-02-04  824  
853e2bd2103aaa9 Bhanu Gollapudi         2011-02-04  825  	skb_queue_head_init(&port->fcoe_pending_queue);
853e2bd2103aaa9 Bhanu Gollapudi         2011-02-04  826  	port->fcoe_pending_queue_active = 0;
13059106242bc96 Kees Cook               2017-09-21  827  	timer_setup(&port->timer, fcoe_queue_timer, 0);
853e2bd2103aaa9 Bhanu Gollapudi         2011-02-04  828  
0e0f9cd6a80dc88 Yi Zou                  2012-12-06  829  	fcoe_link_speed_update(lport);
853e2bd2103aaa9 Bhanu Gollapudi         2011-02-04  830  
853e2bd2103aaa9 Bhanu Gollapudi         2011-02-04  831  	if (!lport->vport) {
5243960777a8d5f Bhanu Prakash Gollapudi 2011-08-04  832  		if (fcoe_get_wwn(netdev, &wwnn, NETDEV_FCOE_WWNN))
fd8f89027d816cb Robert Love             2012-05-22 @833  			wwnn = fcoe_wwn_from_mac(ctlr->ctl_src_addr,
5243960777a8d5f Bhanu Prakash Gollapudi 2011-08-04  834  						 1, 0);
853e2bd2103aaa9 Bhanu Gollapudi         2011-02-04  835  		BNX2FC_HBA_DBG(lport, "WWNN = 0x%llx\n", wwnn);
853e2bd2103aaa9 Bhanu Gollapudi         2011-02-04  836  		fc_set_wwnn(lport, wwnn);
853e2bd2103aaa9 Bhanu Gollapudi         2011-02-04  837  
5243960777a8d5f Bhanu Prakash Gollapudi 2011-08-04  838  		if (fcoe_get_wwn(netdev, &wwpn, NETDEV_FCOE_WWPN))
fd8f89027d816cb Robert Love             2012-05-22  839  			wwpn = fcoe_wwn_from_mac(ctlr->ctl_src_addr,
5243960777a8d5f Bhanu Prakash Gollapudi 2011-08-04  840  						 2, 0);
5243960777a8d5f Bhanu Prakash Gollapudi 2011-08-04  841  
853e2bd2103aaa9 Bhanu Gollapudi         2011-02-04  842  		BNX2FC_HBA_DBG(lport, "WWPN = 0x%llx\n", wwpn);
853e2bd2103aaa9 Bhanu Gollapudi         2011-02-04  843  		fc_set_wwpn(lport, wwpn);
853e2bd2103aaa9 Bhanu Gollapudi         2011-02-04  844  	}
853e2bd2103aaa9 Bhanu Gollapudi         2011-02-04  845  
853e2bd2103aaa9 Bhanu Gollapudi         2011-02-04  846  	return 0;
853e2bd2103aaa9 Bhanu Gollapudi         2011-02-04  847  }
853e2bd2103aaa9 Bhanu Gollapudi         2011-02-04  848  

:::::: The code at line 833 was first introduced by commit
:::::: fd8f89027d816cb023edf6bfd4c744f194150a05 [SCSI] bnx2fc: Allocate fcoe_ctlr with bnx2fc_interface, not as a member

:::::: TO: Robert Love <robert.w.love@intel.com>
:::::: CC: James Bottomley <JBottomley@Parallels.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

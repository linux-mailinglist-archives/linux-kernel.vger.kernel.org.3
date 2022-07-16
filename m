Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EF6577184
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 23:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbiGPVRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 17:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGPVRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 17:17:41 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1B21CB20
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 14:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658006260; x=1689542260;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=APLq/9l6r9xg6YsHZVSaz5dapp1hRH1W7GStWDPq5rc=;
  b=nGNAjoolBkO9y00wyC5mVstK4DdGqXkgBbsNnRo4dodiz/lK5HWscbzZ
   iBlrgWJNbjIZ9I435T9QQ3RdRE40HZol+bxiIquwvNjFSbUiG79IBtDmV
   9/rRyj1KrymsrLkESKLf08L+BFsNNz8D2dF87LqTL9lLfdEiSSH/8qzjb
   5n3zqBIJKUw1wwEZioA3vCajQLOD6o15aWmkIRYdXiB32Y3wn6KQN9eQR
   b2dDSmXtuU045hHSxdJhIA0r2OVsPnhD9Jw19Ol/a/yR2apwvhk6MkngV
   IxayfIIdW9DzGxVjhUoLgHq7Tk3bc9jFv+3CB/NB8/c+Iw3u7p+0BvfLm
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="347695538"
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="347695538"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 14:17:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="664581616"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 16 Jul 2022 14:17:37 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCpAP-00029v-2X;
        Sat, 16 Jul 2022 21:17:37 +0000
Date:   Sun, 17 Jul 2022 05:17:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [stffrdhrn:or1k-virt 3/5] drivers/scsi/hptiop.c:643:34: sparse:
 sparse: incorrect type in argument 1 (different address spaces)
Message-ID: <202207170513.DW3guXF5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stafford,

First bad commit (maybe != root cause):

tree:   https://github.com/stffrdhrn/linux.git or1k-virt
head:   71e3ab921ee5f03e139b1ad3f617d8324c4f8fb6
commit: 9f9a1d6922936eba5c8b0f14112c5737b26bd625 [3/5] openrisc: Add pci bus support
config: openrisc-randconfig-s041-20220717 (https://download.01.org/0day-ci/archive/20220717/202207170513.DW3guXF5-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/stffrdhrn/linux/commit/9f9a1d6922936eba5c8b0f14112c5737b26bd625
        git remote add stffrdhrn https://github.com/stffrdhrn/linux.git
        git fetch --no-tags stffrdhrn or1k-virt
        git checkout 9f9a1d6922936eba5c8b0f14112c5737b26bd625
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=openrisc SHELL=/bin/bash drivers/scsi/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/scsi/hptiop.c:150:53: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:172:35: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:172:35: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:172:35: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:208:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:208:34: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:208:34: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:209:35: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:209:35: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:209:35: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:244:44: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] result @@     got int @@
   drivers/scsi/hptiop.c:244:44: sparse:     expected restricted __le32 [usertype] result
   drivers/scsi/hptiop.c:244:44: sparse:     got int
   drivers/scsi/hptiop.c:289:35: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:276:32: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:277:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] cur_rptr @@     got restricted __le32 [usertype] outlist_rptr @@
   drivers/scsi/hptiop.c:277:34: sparse:     expected unsigned int [usertype] cur_rptr
   drivers/scsi/hptiop.c:277:34: sparse:     got restricted __le32 [usertype] outlist_rptr
   drivers/scsi/hptiop.c:283:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] _tag @@     got restricted __le32 [usertype] val @@
   drivers/scsi/hptiop.c:283:38: sparse:     expected unsigned int [usertype] _tag
   drivers/scsi/hptiop.c:283:38: sparse:     got restricted __le32 [usertype] val
   drivers/scsi/hptiop.c:288:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] outlist_rptr @@     got unsigned int [assigned] [usertype] cur_rptr @@
   drivers/scsi/hptiop.c:288:52: sparse:     expected restricted __le32 [usertype] outlist_rptr
   drivers/scsi/hptiop.c:288:52: sparse:     got unsigned int [assigned] [usertype] cur_rptr
   drivers/scsi/hptiop.c:369:52: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:369:52: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:369:52: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:370:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:370:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:370:25: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:453:64: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct hpt_iop_request_get_config *info @@     got struct hpt_iop_request_get_config [noderef] __iomem *config @@
   drivers/scsi/hptiop.c:453:64: sparse:     expected struct hpt_iop_request_get_config *info
   drivers/scsi/hptiop.c:453:64: sparse:     got struct hpt_iop_request_get_config [noderef] __iomem *config
   drivers/scsi/hptiop.c:455:25: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:558:27: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:558:27: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:558:27: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:637:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct hpt_iopmv_regs *regs @@     got void [noderef] __iomem * @@
   drivers/scsi/hptiop.c:637:24: sparse:     expected struct hpt_iopmv_regs *regs
   drivers/scsi/hptiop.c:637:24: sparse:     got void [noderef] __iomem *
>> drivers/scsi/hptiop.c:643:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got struct hpt_iopmv_regs *regs @@
   drivers/scsi/hptiop.c:643:34: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/hptiop.c:643:34: sparse:     got struct hpt_iopmv_regs *regs
   drivers/scsi/hptiop.c:667:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got struct hpt_iopmv_regs *regs @@
   drivers/scsi/hptiop.c:667:26: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/hptiop.c:667:26: sparse:     got struct hpt_iopmv_regs *regs
   drivers/scsi/hptiop.c:933:27: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:933:27: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:933:27: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:933:27: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:933:27: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:933:27: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:938:34: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:939:30: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:943:43: sparse: sparse: invalid assignment: &=
   drivers/scsi/hptiop.c:943:43: sparse:    left side has type restricted __le32
   drivers/scsi/hptiop.c:943:43: sparse:    right side has type int
   drivers/scsi/hptiop.c:944:43: sparse: sparse: invalid assignment: ^=
   drivers/scsi/hptiop.c:944:43: sparse:    left side has type restricted __le32
   drivers/scsi/hptiop.c:944:43: sparse:    right side has type int
   drivers/scsi/hptiop.c:949:57: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:949:48: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] intrfc_len @@     got unsigned int @@
   drivers/scsi/hptiop.c:949:48: sparse:     expected restricted __le32 [usertype] intrfc_len
   drivers/scsi/hptiop.c:949:48: sparse:     got unsigned int
   drivers/scsi/hptiop.c:950:29: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] inlist_wptr @@
   drivers/scsi/hptiop.c:950:29: sparse:     expected unsigned int [usertype] value
   drivers/scsi/hptiop.c:950:29: sparse:     got restricted __le32 [usertype] inlist_wptr
   drivers/scsi/hptiop.c:975:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/scsi/hptiop.c:975:16: sparse:     expected unsigned int [usertype] value
   drivers/scsi/hptiop.c:975:16: sparse:     got restricted __le32 [usertype]
   drivers/scsi/hptiop.c:977:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/scsi/hptiop.c:977:16: sparse:     expected unsigned int [usertype] value
   drivers/scsi/hptiop.c:977:16: sparse:     got restricted __le32 [usertype]
   drivers/scsi/hptiop.c:980:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/scsi/hptiop.c:980:16: sparse:     expected unsigned int [usertype] value
   drivers/scsi/hptiop.c:980:16: sparse:     got restricted __le32 [usertype]
   drivers/scsi/hptiop.c:982:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/scsi/hptiop.c:982:16: sparse:     expected unsigned int [usertype] value
   drivers/scsi/hptiop.c:982:16: sparse:     got restricted __le32 [usertype]
   drivers/scsi/hptiop.c:985:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/scsi/hptiop.c:985:16: sparse:     expected unsigned int [usertype] value
   drivers/scsi/hptiop.c:985:16: sparse:     got restricted __le32 [usertype]
   drivers/scsi/hptiop.c:987:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/scsi/hptiop.c:987:16: sparse:     expected unsigned int [usertype] value
   drivers/scsi/hptiop.c:987:16: sparse:     got restricted __le32 [usertype]
   drivers/scsi/hptiop.c:990:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] inlist_wptr @@     got unsigned int @@
   drivers/scsi/hptiop.c:990:35: sparse:     expected restricted __le32 [usertype] inlist_wptr
   drivers/scsi/hptiop.c:990:35: sparse:     got unsigned int
   drivers/scsi/hptiop.c:991:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] @@     got unsigned int @@
   drivers/scsi/hptiop.c:991:37: sparse:     expected restricted __le32 [usertype]
   drivers/scsi/hptiop.c:991:37: sparse:     got unsigned int
   drivers/scsi/hptiop.c:992:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] outlist_rptr @@     got unsigned int @@
   drivers/scsi/hptiop.c:992:36: sparse:     expected restricted __le32 [usertype] outlist_rptr
   drivers/scsi/hptiop.c:992:36: sparse:     got unsigned int
   drivers/scsi/hptiop.c:1534:29: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:1534:29: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:1534:29: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:1535:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:1535:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:1535:25: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:150:51: sparse: sparse: dereference of noderef expression
   drivers/scsi/hptiop.c:150:51: sparse: sparse: dereference of noderef expression
--
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1526:25: sparse: sparse: invalid assignment: |=
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1526:25: sparse:    left side has type unsigned int
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1526:25: sparse:    right side has type restricted __le32
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1531:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sgptr @@     got restricted __le32 [usertype] @@
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1531:34: sparse:     expected unsigned int [usertype] sgptr
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1531:34: sparse:     got restricted __le32 [usertype]
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1541:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sgptr @@     got restricted __le32 [usertype] @@
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1541:34: sparse:     expected unsigned int [usertype] sgptr
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1541:34: sparse:     got restricted __le32 [usertype]
   drivers/scsi/aic7xxx/aic7xxx_osm.c:481:18: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr @@     got restricted __le32 [usertype] @@
   drivers/scsi/aic7xxx/aic7xxx_osm.c:481:18: sparse:     expected unsigned int [usertype] addr
   drivers/scsi/aic7xxx/aic7xxx_osm.c:481:18: sparse:     got restricted __le32 [usertype]
   drivers/scsi/aic7xxx/aic7xxx_osm.c:488:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] len @@     got restricted __le32 [usertype] @@
   drivers/scsi/aic7xxx/aic7xxx_osm.c:488:17: sparse:     expected unsigned int [usertype] len
   drivers/scsi/aic7xxx/aic7xxx_osm.c:488:17: sparse:     got restricted __le32 [usertype]
>> drivers/scsi/aic7xxx/aic7xxx_osm.c:1231:41: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void [noderef] __iomem *addr @@     got unsigned char volatile [noderef] [usertype] __iomem *[usertype] maddr @@
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1231:41: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1231:41: sparse:     got unsigned char volatile [noderef] [usertype] __iomem *[usertype] maddr
--
>> drivers/scsi/aacraid/nark.c:36:28: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void [noderef] __iomem *addr @@     got void volatile [noderef] __iomem *base @@
   drivers/scsi/aacraid/nark.c:36:28: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/aacraid/nark.c:36:28: sparse:     got void volatile [noderef] __iomem *base

vim +643 drivers/scsi/hptiop.c

00f5970193e22c HighPoint Linux Team 2007-12-13  634  
00f5970193e22c HighPoint Linux Team 2007-12-13  635  static int hptiop_map_pci_bar_mv(struct hptiop_hba *hba)
00f5970193e22c HighPoint Linux Team 2007-12-13  636  {
00f5970193e22c HighPoint Linux Team 2007-12-13  637  	hba->u.mv.regs = hptiop_map_pci_bar(hba, 0);
9bcf091083065c Harvey Harrison      2008-05-22  638  	if (hba->u.mv.regs == NULL)
00f5970193e22c HighPoint Linux Team 2007-12-13  639  		return -1;
00f5970193e22c HighPoint Linux Team 2007-12-13  640  
00f5970193e22c HighPoint Linux Team 2007-12-13  641  	hba->u.mv.mu = hptiop_map_pci_bar(hba, 2);
9bcf091083065c Harvey Harrison      2008-05-22  642  	if (hba->u.mv.mu == NULL) {
00f5970193e22c HighPoint Linux Team 2007-12-13 @643  		iounmap(hba->u.mv.regs);
ede1e6f8b43246 HighPoint Linux Team 2006-05-16  644  		return -1;
ede1e6f8b43246 HighPoint Linux Team 2006-05-16  645  	}
ede1e6f8b43246 HighPoint Linux Team 2006-05-16  646  
ede1e6f8b43246 HighPoint Linux Team 2006-05-16  647  	return 0;
ede1e6f8b43246 HighPoint Linux Team 2006-05-16  648  }
ede1e6f8b43246 HighPoint Linux Team 2006-05-16  649  

:::::: The code at line 643 was first introduced by commit
:::::: 00f5970193e22c48f399a2430635d6416b51befe [SCSI] hptiop: add more adapter models and other fixes

:::::: TO: HighPoint Linux Team <linux@highpoint-tech.com>
:::::: CC: James Bottomley <James.Bottomley@HansenPartnership.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

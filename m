Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DF051CFEA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 05:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388870AbiEFEBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 00:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236381AbiEFEBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 00:01:45 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313A37662
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 20:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651809483; x=1683345483;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jqrdA0ssjCDy9Tr530uvuCttUfxwA+67fzeMSQGXudc=;
  b=Z8Fytt/tnDJwrsKNLWbrfndOhyjnGp8UL6eoDPYP/GDrroGwCP8IV0PD
   s2ZeI0KnR5GKM2UX6c/Nl/VXbrcvqZzASjTxEeAmGCoQiBr5Lrt9A9oz0
   HJIhpp2AGF7ZgWtoZlAR9Xw1T0bAOe2Kqt/X0hZIRjC+q8oybbpwfiNtl
   uioCvwn0VJ+47fCkehG2eNASf6TUKvWDauF/RH1BMAq/N/vHVyIm80z1O
   FW0IDifTht7URmoE/e9y9ury7lri3ivdIlBS+id76jRa8XCCbj5yldn6P
   O5KNVlFbKwFXEMEKMPvWjJZdzI5ZG/P7wG2Z+DbztLzZD+bZOCIzltXVl
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="248875826"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="248875826"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 20:58:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="891639841"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 05 May 2022 20:58:01 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmp6P-000D4u-0m;
        Fri, 06 May 2022 03:58:01 +0000
Date:   Fri, 6 May 2022 11:57:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Allison Henderson <allison.henderson@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [allisonhenderson-xfs-work:xfs-5.19-compose_pptrs 32/32]
 fs/xfs/libxfs/xfs_parent.c:38:1: warning: no previous prototype for
 'xfs_init_parent_ptr'
Message-ID: <202205061153.IFAjcpvT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/allisonhenderson/xfs_work.git xfs-5.19-compose_pptrs
head:   74ecccf0e89a132c2490f3a63661c535974c6a08
commit: 74ecccf0e89a132c2490f3a63661c535974c6a08 [32/32] xfs: Add parent pointer ioctl
config: arc-randconfig-r001-20220505 (https://download.01.org/0day-ci/archive/20220506/202205061153.IFAjcpvT-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/allisonhenderson/xfs_work/commit/74ecccf0e89a132c2490f3a63661c535974c6a08
        git remote add allisonhenderson-xfs-work https://github.com/allisonhenderson/xfs_work.git
        git fetch --no-tags allisonhenderson-xfs-work xfs-5.19-compose_pptrs
        git checkout 74ecccf0e89a132c2490f3a63661c535974c6a08
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash fs/xfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/xfs/libxfs/xfs_parent.c:38:1: warning: no previous prototype for 'xfs_init_parent_ptr' [-Wmissing-prototypes]
      38 | xfs_init_parent_ptr(struct xfs_parent_ptr               *xpp,
         | ^~~~~~~~~~~~~~~~~~~
   fs/xfs/libxfs/xfs_parent.c:65:1: warning: no previous prototype for 'xfs_init_parent_name_rec' [-Wmissing-prototypes]
      65 | xfs_init_parent_name_rec(
         | ^~~~~~~~~~~~~~~~~~~~~~~~
   fs/xfs/libxfs/xfs_parent.c:80:1: warning: no previous prototype for 'xfs_init_parent_name_irec' [-Wmissing-prototypes]
      80 | xfs_init_parent_name_irec(
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
--
>> fs/xfs/xfs_parent_utils.c:42:1: warning: no previous prototype for 'xfs_attr_get_parent_pointer' [-Wmissing-prototypes]
      42 | xfs_attr_get_parent_pointer(struct xfs_inode            *ip,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/xfs_init_parent_ptr +38 fs/xfs/libxfs/xfs_parent.c

    35	
    36	/* Initializes a xfs_parent_ptr from an xfs_parent_name_rec */
    37	void
  > 38	xfs_init_parent_ptr(struct xfs_parent_ptr		*xpp,
    39			     struct xfs_parent_name_rec	*rec)
    40	{
    41		xpp->xpp_ino = be64_to_cpu(rec->p_ino);
    42		xpp->xpp_gen = be32_to_cpu(rec->p_gen);
    43		xpp->xpp_diroffset = be32_to_cpu(rec->p_diroffset);
    44	}
    45	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

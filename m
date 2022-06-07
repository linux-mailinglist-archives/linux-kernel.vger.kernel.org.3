Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BF453F56F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 07:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236747AbiFGFCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 01:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236614AbiFGFCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 01:02:46 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7FA27CCA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 22:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654578164; x=1686114164;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lBmFQKGQXxYuQbFyBc4fA5r/IVfztdX221SxuevL+Tw=;
  b=Wr+DA4i5foPSyqA4S3sLUQdjAXymIzUMW1chaZswAPPNm7iMnA21HniC
   PZXM1OUqFV8Qie7KstD5y1ESTO6kp1IPxsBn+Y/V9Y1QHzbIp22Jed4qb
   4hj+9RROgY013Tc48IJvqBRrOhFguku260khCAlSo4RXKSViyKpz+8KVR
   +sGuVPo4IBT6UaLERXy+NM1fO5odXy3pkqfeiOlUS5nSpDr+PmmgMHWJM
   HHuZHtFbDMbNZKX/uR0kjgAepPPOiYuxthZVwjY1U9pU7yYgwt0uQoABF
   KrYQTWwYiFyf0VyfU3Zkhg83CrCB/6sDrW6YfnfF6qvQ6nnhnfIec9Tgd
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="340297219"
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="340297219"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 22:02:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="584009486"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 06 Jun 2022 22:02:42 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nyRMX-000DMv-RK;
        Tue, 07 Jun 2022 05:02:41 +0000
Date:   Tue, 7 Jun 2022 13:01:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     KuoHsiang Chou <kuohsiang_chou@aspeedtech.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: drivers/gpu/drm/ast/ast_dp.c:37:46: sparse: sparse: cast truncates
 bits from constant value (ffffffffffffff00 becomes 0)
Message-ID: <202206071218.LWKSPm1P-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e71e60cd74df9386c3f684c54888f2367050b831
commit: 594e9c04b5864b4b8b151ef4ba9521c59e0f5c54 drm/ast: Create the driver for ASPEED proprietory Display-Port
date:   5 weeks ago
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220607/202206071218.LWKSPm1P-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-18-g56afb504-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=594e9c04b5864b4b8b151ef4ba9521c59e0f5c54
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 594e9c04b5864b4b8b151ef4ba9521c59e0f5c54
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/drm/ast/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/ast/ast_dp.c:37:46: sparse: sparse: cast truncates bits from constant value (ffffffffffffff00 becomes 0)
   drivers/gpu/drm/ast/ast_dp.c:278:66: sparse: sparse: cast truncates bits from constant value (ffffffffffffff00 becomes 0)
   drivers/gpu/drm/ast/ast_dp.c:280:66: sparse: sparse: cast truncates bits from constant value (ffffffffffffff00 becomes 0)
   drivers/gpu/drm/ast/ast_dp.c:281:66: sparse: sparse: cast truncates bits from constant value (ffffffffffffff00 becomes 0)

vim +37 drivers/gpu/drm/ast/ast_dp.c

     9	
    10	int ast_astdp_read_edid(struct drm_device *dev, u8 *ediddata)
    11	{
    12		struct ast_private *ast = to_ast_private(dev);
    13		u8 i = 0, j = 0;
    14	
    15		/*
    16		 * CRD1[b5]: DP MCU FW is executing
    17		 * CRDC[b0]: DP link success
    18		 * CRDF[b0]: DP HPD
    19		 * CRE5[b0]: Host reading EDID process is done
    20		 */
    21		if (!(ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xD1, ASTDP_MCU_FW_EXECUTING) &&
    22			ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xDC, ASTDP_LINK_SUCCESS) &&
    23			ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xDF, ASTDP_HPD) &&
    24			ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xE5,
    25									ASTDP_HOST_EDID_READ_DONE_MASK))) {
    26			goto err_astdp_edid_not_ready;
    27		}
    28	
    29		ast_set_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xE5, (u8) ~ASTDP_HOST_EDID_READ_DONE_MASK,
    30								0x00);
    31	
    32		for (i = 0; i < 32; i++) {
    33			/*
    34			 * CRE4[7:0]: Read-Pointer for EDID (Unit: 4bytes); valid range: 0~64
    35			 */
    36			ast_set_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xE4,
  > 37						(u8) ~ASTDP_EDID_READ_POINTER_MASK, (u8) i);
    38			j = 0;
    39	
    40			/*
    41			 * CRD7[b0]: valid flag for EDID
    42			 * CRD6[b0]: mirror read pointer for EDID
    43			 */
    44			while ((ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xD7,
    45					ASTDP_EDID_VALID_FLAG_MASK) != 0x01) ||
    46				(ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xD6,
    47							ASTDP_EDID_READ_POINTER_MASK) != i)) {
    48				/*
    49				 * Delay are getting longer with each retry.
    50				 * 1. The Delays are often 2 loops when users request "Display Settings"
    51				 *	  of right-click of mouse.
    52				 * 2. The Delays are often longer a lot when system resume from S3/S4.
    53				 */
    54				mdelay(j+1);
    55	
    56				if (!(ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xD1,
    57								ASTDP_MCU_FW_EXECUTING) &&
    58					ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xDC,
    59								ASTDP_LINK_SUCCESS) &&
    60					ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xDF, ASTDP_HPD))) {
    61					goto err_astdp_jump_out_loop_of_edid;
    62				}
    63	
    64				j++;
    65				if (j > 200)
    66					goto err_astdp_jump_out_loop_of_edid;
    67			}
    68	
    69			*(ediddata) = ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT,
    70								0xD8, ASTDP_EDID_READ_DATA_MASK);
    71			*(ediddata + 1) = ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xD9,
    72									ASTDP_EDID_READ_DATA_MASK);
    73			*(ediddata + 2) = ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xDA,
    74									ASTDP_EDID_READ_DATA_MASK);
    75			*(ediddata + 3) = ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xDB,
    76									ASTDP_EDID_READ_DATA_MASK);
    77	
    78			if (i == 31) {
    79				/*
    80				 * For 128-bytes EDID_1.3,
    81				 * 1. Add the value of Bytes-126 to Bytes-127.
    82				 *		The Bytes-127 is Checksum. Sum of all 128bytes should
    83				 *		equal 0	(mod 256).
    84				 * 2. Modify Bytes-126 to be 0.
    85				 *		The Bytes-126 indicates the Number of extensions to
    86				 *		follow. 0 represents noextensions.
    87				 */
    88				*(ediddata + 3) = *(ediddata + 3) + *(ediddata + 2);
    89				*(ediddata + 2) = 0;
    90			}
    91	
    92			ediddata += 4;
    93		}
    94	
    95		ast_set_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xE5, (u8) ~ASTDP_HOST_EDID_READ_DONE_MASK,
    96								ASTDP_HOST_EDID_READ_DONE);
    97	
    98		return 0;
    99	
   100	err_astdp_jump_out_loop_of_edid:
   101		ast_set_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xE5,
   102								(u8) ~ASTDP_HOST_EDID_READ_DONE_MASK,
   103								ASTDP_HOST_EDID_READ_DONE);
   104		return (~(j+256) + 1);
   105	
   106	err_astdp_edid_not_ready:
   107		if (!(ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xD1, ASTDP_MCU_FW_EXECUTING)))
   108			return (~0xD1 + 1);
   109		if (!(ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xDC, ASTDP_LINK_SUCCESS)))
   110			return (~0xDC + 1);
   111		if (!(ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xDF, ASTDP_HPD)))
   112			return (~0xDF + 1);
   113		if (!(ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xE5, ASTDP_HOST_EDID_READ_DONE_MASK)))
   114			return (~0xE5 + 1);
   115	
   116		return	0;
   117	}
   118	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

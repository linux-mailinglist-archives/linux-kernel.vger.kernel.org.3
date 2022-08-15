Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB53592F7E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 15:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242704AbiHONMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 09:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242703AbiHONMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:12:40 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E3713F5A;
        Mon, 15 Aug 2022 06:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660569157; x=1692105157;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gq/fej4FBaML6o3xDYJDCSHN5i7ykUWDL6Znr89C5Yo=;
  b=U4qq/P8r+xZyrt7QgDuO/WFeOFVKWKoE07vvbB/zb+JN71Br8cAMK+/2
   q2dNRkHiNYb+pJG71WZTGctQcxswaARUnPjRq+Cy68OSWW+lag6bUpIcJ
   MWpq22GCtoS/TV2+HxI/CMLNLgOo9QX701fPkSsqjZ0OKEEPVbLjbSqqk
   s4jR7jhiPy9crvxkNdBakAijJJTs+pbM5mIPn0mFle0yE5fPDvg/gVW7/
   VDlahXIeC1OFMpchXW/aEbMPaV4/xg0bA8qImblT5Pjv5r5Qb5fhsJaSy
   tWsW7NIc91qlJHCf2vuW54BODRJ19kRt2++kR5SWw8E9VEgrRfHUSuNpk
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="271725523"
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="271725523"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 06:12:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="609901893"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 15 Aug 2022 06:12:34 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNZtR-00010z-28;
        Mon, 15 Aug 2022 13:12:33 +0000
Date:   Mon, 15 Aug 2022 21:12:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Szuying Chen <chensiying21@gmail.com>, gregkh@linuxfoundation.org,
        mika.westerberg@linux.intel.com, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Yd_Tseng@asmedia.com.tw,
        Chloe_Chen@asmedia.com.tw, Richard_Hsu@asmedia.com.tw
Subject: Re: [PATCH] thunderbolt: thunderbolt: add vendor's NVM formats
Message-ID: <202208152107.P6jLM6te-lkp@intel.com>
References: <20220815041145.35629-1-chensiying21@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815041145.35629-1-chensiying21@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Szuying,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.0-rc1 next-20220815]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Szuying-Chen/thunderbolt-thunderbolt-add-vendor-s-NVM-formats/20220815-121330
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220815/202208152107.P6jLM6te-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/de39c1897bc8c08ddfa4d3019c95314e697b7256
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Szuying-Chen/thunderbolt-thunderbolt-add-vendor-s-NVM-formats/20220815-121330
        git checkout de39c1897bc8c08ddfa4d3019c95314e697b7256
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/thunderbolt/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/thunderbolt/nvm.c:150: warning: Function parameter or member 'mode' not described in 'tb_nvm_validate'
>> drivers/thunderbolt/nvm.c:150: warning: expecting prototype for tb_nvm_vendor_handle(). Prototype was for tb_nvm_validate() instead


vim +150 drivers/thunderbolt/nvm.c

   143	
   144	/**
   145	 * tb_nvm_vendor_handle() - support vendor's NVM format
   146	 * @sw: Thunderbolt switch
   147	 * @handle: 0:NvmUpgradeSuppport, 1:NvmAdd, 2:NvmWrite
   148	 */
   149	int tb_nvm_validate(struct tb_switch *sw, unsigned int mode)
 > 150	{
   151		int res, i;
   152	
   153		for (i = 0; i < ARRAY_SIZE(tb_nvm_vendors); i++) {
   154			const struct tb_nvm_id *id = &tb_nvm_vendors[i];
   155	
   156			if (id->hw_vendor_id && id->hw_vendor_id != sw->config.vendor_id)
   157				continue;
   158	
   159			 res = id->validate(sw, mode);
   160		}
   161		return res;
   162	}
   163	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D100E4F4179
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443928AbiDEUH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573511AbiDETP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:15:29 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838B1E8861
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 12:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649186009; x=1680722009;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=afheeonXdMcIaKpgxhSgZlNFQflMvyoO9IdUDEQ6ZQ0=;
  b=n6AZChhtRlKv4EvIonuM2wGfLvfy+BjjwHoYiTdZKSRJITbyNV/naEjj
   ZOeV4SZwIGKtbT60g5cvzWASP4+fcIOkLDH9g/QbOqbjTkZRaVLyc86DJ
   42Q7riLQYZHgJ9GS2mAfnzLHB3OwTvh5ZQt9GTaUYLgCOpp3HzC81Beh8
   c9BqstTKs5K4+Z2fCNurd/FoRr7b86Poh8QxCF3k47yO9b6AHaI8CpWQr
   hiaomiu9Uzh670Wa8nf2WGn6ccGpFNxoa+3jnpX/jm1XBnKueNEoUOchH
   h7V5gTPHYeeLtjpyvSeZp+rAMYwkztDcnK1arsd42z6L8jnYjLavrypko
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="285803873"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="285803873"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 12:13:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="588053334"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 05 Apr 2022 12:13:27 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbocI-0003gq-Fy;
        Tue, 05 Apr 2022 19:13:26 +0000
Date:   Wed, 6 Apr 2022 03:12:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aditya Bavanari <abavanar@codeaurora.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Alistair Delva <adelva@google.com>,
        Will McVicker <willmcvicker@google.com>
Subject: [tobetter:odroidm1-4.19.y 4348/9999] sound/soc/soc-core.c:761:27:
 warning: no previous prototype for function 'soc_find_component_locked'
Message-ID: <202204060317.N87e8kq1-lkp@intel.com>
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

Hi Aditya,

FYI, the error/warning still remains.

tree:   https://github.com/tobetter/linux odroidm1-4.19.y
head:   9c4982fe4e77325e4d0861cea11b239d8200b585
commit: 75fe91933be2dd4b884ca83bd72e1e0f0d05cfc6 [4348/9999] ANDROID: ASoC: core: add locked version of soc_find_component
config: x86_64-randconfig-a014 (https://download.01.org/0day-ci/archive/20220406/202204060317.N87e8kq1-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c4a1b07d0979e7ff20d7d541af666d822d66b566)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/tobetter/linux/commit/75fe91933be2dd4b884ca83bd72e1e0f0d05cfc6
        git remote add tobetter https://github.com/tobetter/linux
        git fetch --no-tags tobetter odroidm1-4.19.y
        git checkout 75fe91933be2dd4b884ca83bd72e1e0f0d05cfc6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash sound/soc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> sound/soc/soc-core.c:761:27: warning: no previous prototype for function 'soc_find_component_locked' [-Wmissing-prototypes]
   struct snd_soc_component *soc_find_component_locked(
                             ^
   sound/soc/soc-core.c:761:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct snd_soc_component *soc_find_component_locked(
   ^
   static 
   1 warning generated.
   sound/soc/soc-core.c:2971: warning: Excess function parameter 'legacy_dai_naming' description in 'snd_soc_register_dais'
   sound/soc/soc-core.c:3333: warning: Function parameter or member 'online' not described in 'snd_soc_card_change_online_state'


vim +/soc_find_component_locked +761 sound/soc/soc-core.c

   750	
   751	/**
   752	 * soc_find_component_locked: soc_find_component with client lock acquired
   753	 *
   754	 * @of_node: of_node of the component to query.
   755	 * @name: name of the component to query.
   756	 *
   757	 * function to find out if a component is already registered with ASoC core.
   758	 *
   759	 * Returns component handle for success, else NULL error.
   760	 */
 > 761	struct snd_soc_component *soc_find_component_locked(
   762		const struct device_node *of_node, const char *name)
   763	{
   764		struct snd_soc_component *component = NULL;
   765	
   766		mutex_lock(&client_mutex);
   767		component = soc_find_component(of_node, name);
   768		mutex_unlock(&client_mutex);
   769		return component;
   770	}
   771	EXPORT_SYMBOL(soc_find_component_locked);
   772	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

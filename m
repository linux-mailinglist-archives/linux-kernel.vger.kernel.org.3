Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546034D27C2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiCIBYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbiCIBXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:23:01 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E66FCEA35
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 17:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646788836; x=1678324836;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/eJ+XHd1Ms87SKIz1nVImLRpqYsl8GniCmZ7kQua8JA=;
  b=PAU8CMeJzRwA+X9uvz/QlbRl3AOuBf+Td7m7G5xCc2rYWR+v4C+hCZfb
   yUwCqjuAstjjH4UWEqMis5g0AJLM8n+EqY54+UJxJWkPMYif2k017KwGl
   HiFfP41qEZS5hl18eDHIlwq2TSZE/+7CH56B6I4iSDXAkXO7+gKE7wCvl
   V2kQ5l3kmZFqErwMnMJQVFRC60PAOoWUxeJbBoNScQ5Mp9eh20faqgcR4
   paMt0DDR3lMZX4rejDHlS6dSIdqm/Gd6AWyN/xvRkSWPf9RNg3qLGV/3+
   /rB8NOOmmI2ZTpfWV4UsnClRg4TsO3WcT42MCfFqBOcrSFOXr9QbVuwPt
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="253677026"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="253677026"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 16:11:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="495650716"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 08 Mar 2022 16:11:44 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRjvb-0002Ee-Mk; Wed, 09 Mar 2022 00:11:43 +0000
Date:   Wed, 9 Mar 2022 08:11:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aditya Bavanari <abavanar@codeaurora.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Alistair Delva <adelva@google.com>,
        Will McVicker <willmcvicker@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android-4.19-stable
 5226/9999] sound/soc/soc-core.c:761:27: warning: no previous prototype for
 function 'soc_find_component_locked'
Message-ID: <202203090820.wqQmG5sl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aditya,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-4.19-stable
head:   3fba6c6e70994eff4dcc5be475c9d2bd3848b83d
commit: 75fe91933be2dd4b884ca83bd72e1e0f0d05cfc6 [5226/9999] ANDROID: ASoC: core: add locked version of soc_find_component
config: x86_64-randconfig-a014 (https://download.01.org/0day-ci/archive/20220309/202203090820.wqQmG5sl-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a2e9c68fcd4425fbce7380746e916966f00a39a0)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/75fe91933be2dd4b884ca83bd72e1e0f0d05cfc6
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-4.19-stable
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

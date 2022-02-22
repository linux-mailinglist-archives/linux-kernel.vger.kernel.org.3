Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13BD4BF47E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 10:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiBVJQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 04:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiBVJQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 04:16:00 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA7AE38A0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 01:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645521335; x=1677057335;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tO3B7b65zgGhD/1fZ3FxKuMaLdpsJqbQ9EdeiJMWm9w=;
  b=lI/1toMDu562lckL5We5nCHv1mPFhNwMtTMOZz5yQca+Dmq9oZxuPHok
   DeEFFo9dZD1HovtXLw1DL+a1mKPkhTuCYLBnuBD1/2aHeM9t9leqoYRCN
   88C8eDpJshI8fDnboltiqQ2N66CymqXcL84gqpDjb6Tnt3YMPrnfJrqXB
   o3j9qTnjl6vr4vq+GsNV6znc/mStq4ItD+CITbsYipBO+nMYWRj5Frrsq
   Xs+L1etE9ov1dz6BaHVmKXjd92GET6TFrj2OxcvV/jtCWoeGGAV52W+AK
   8hmDKyRdujfrbJBqfogdDWB7/FLTt/SKVpUoOCta6OCvxxG1NFVtyQClx
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="312391822"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="312391822"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 01:15:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="490724647"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 22 Feb 2022 01:15:32 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMRGd-00003p-Bl; Tue, 22 Feb 2022 09:15:31 +0000
Date:   Tue, 22 Feb 2022 17:15:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     kbuild-all@lists.01.org, Vijendar.Mukunda@amd.com,
        Alexander.Deucher@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        V sujith kumar Reddy <vsujithkumar.reddy@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] ASoC: amd: acp-legacy: Add legacy card support for
 new machines
Message-ID: <202202221741.TUA7mZol-lkp@intel.com>
References: <20220222061128.719400-3-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222061128.719400-3-AjitKumar.Pandey@amd.com>
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

Hi Ajit,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on broonie-sound/for-next]
[also build test ERROR on v5.17-rc5 next-20220217]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Ajit-Kumar-Pandey/ASoC-amd-acp-Add-new-machines-and-minor-tweaks/20220222-141552
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
config: x86_64-randconfig-r003-20220221 (https://download.01.org/0day-ci/archive/20220222/202202221741.TUA7mZol-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/ca902de964769c2e605e5b2b7b91e95d1698f5bc
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Ajit-Kumar-Pandey/ASoC-amd-acp-Add-new-machines-and-minor-tweaks/20220222-141552
        git checkout ca902de964769c2e605e5b2b7b91e95d1698f5bc
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> sound/soc/amd/acp/acp-legacy-mach.c:50:18: error: 'EN_SPKR_GPIO_DW' undeclared here (not in a function); did you mean 'EN_SPKR_GPIO_GB'?
      50 |  .gpio_spkr_en = EN_SPKR_GPIO_DW,
         |                  ^~~~~~~~~~~~~~~
         |                  EN_SPKR_GPIO_GB


vim +50 sound/soc/amd/acp/acp-legacy-mach.c

    42	
    43	static struct acp_card_drvdata rt5682s_rt1019_data = {
    44		.hs_cpu_id = I2S_SP,
    45		.amp_cpu_id = I2S_SP,
    46		.dmic_cpu_id = DMIC,
    47		.hs_codec_id = RT5682S,
    48		.amp_codec_id = RT1019,
    49		.dmic_codec_id = DMIC,
  > 50		.gpio_spkr_en = EN_SPKR_GPIO_DW,
    51	};
    52	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

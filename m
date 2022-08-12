Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F0F5915CB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 21:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236639AbiHLTKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 15:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiHLTJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 15:09:58 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A636294EE1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 12:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660331397; x=1691867397;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8jOYdsTjIERgCZgii8GvHSE+RxiWxjjphILTOFIsJA0=;
  b=ETWRVF8qvR5BiC/s6kVFOsu+0eRxqLu657whKBN9X5UoRI0I9Y9KdM6+
   3mh37ZSWR5YyrkCkqTndzFzkuMkrpgcrosqODkOk8n7f3IWCl/pdJf427
   bGRoUBi4rZbtd/773/FsN52BMxDj56HEINEqA+acShA/Jq5NuJ/bEUBDN
   aCPMpabhGr9tK58T82pkyxYDC3xNgIrbb5mF0Z8TdS4LrEcmYHwIGWmul
   lSJaULuJAnfwBf700SoWOYV6mv6Xwi31LMcYQ2ovrJvt5o8QkWmM4sFXn
   8iUTkjASSKzF7pa93nazK8YeaSGnntppr/PzwZf2bMEA26uZpxd12NR5N
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="274725407"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="274725407"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 12:09:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="556628845"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 12 Aug 2022 12:09:52 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMa2a-0000qc-0Q;
        Fri, 12 Aug 2022 19:09:52 +0000
Date:   Sat, 13 Aug 2022 03:09:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sean Hong <sean.hong@quanta.corp-partner.google.com>,
        perex@perex.cz, tiwai@suse.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, broonie@kernel.org,
        brent.lu@intel.com, yong.zhi@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Sean Hong <sean.hong@quanta.corp-partner.google.com>
Subject: Re: [PATCH] ASoC: Intel: sof_rt5682: Add support for
 jsl_rt5682_rt1019
Message-ID: <202208130220.892ZS1bh-lkp@intel.com>
References: <20220812114804.550809-1-sean.hong@quanta.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812114804.550809-1-sean.hong@quanta.corp-partner.google.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on broonie-sound/for-next]
[also build test ERROR on tiwai-sound/for-next linus/master next-20220812]
[cannot apply to v5.19]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sean-Hong/ASoC-Intel-sof_rt5682-Add-support-for-jsl_rt5682_rt1019/20220812-195139
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
config: i386-randconfig-a011 (https://download.01.org/0day-ci/archive/20220813/202208130220.892ZS1bh-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/5ab680d85b9dbcaa1929ab9beace3c9622e46d19
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sean-Hong/ASoC-Intel-sof_rt5682-Add-support-for-jsl_rt5682_rt1019/20220812-195139
        git checkout 5ab680d85b9dbcaa1929ab9beace3c9622e46d19
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash sound/soc/intel/common/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> sound/soc/intel/common/soc-acpi-intel-jsl-match.c:35:2: error: expected ';' after top level declarator
   }
    ^
    ;
>> sound/soc/intel/common/soc-acpi-intel-jsl-match.c:89:4: error: field designator 'sof_fw_filename' does not refer to any field in type 'struct snd_soc_acpi_mach'
                   .sof_fw_filename = "sof-jsl.ri",
                    ^
   2 errors generated.


vim +35 sound/soc/intel/common/soc-acpi-intel-jsl-match.c

    31	
    32	static struct snd_soc_acpi_codecs rt1019p_spk = {
    33		.num_codecs = 1,
    34		.codecs = {"RTL1019"}
  > 35	}
    36	
    37	static const struct snd_soc_acpi_codecs mx98360a_spk = {
    38		.num_codecs = 1,
    39		.codecs = {"MX98360A"}
    40	};
    41	
    42	static const struct snd_soc_acpi_codecs rt5682_rt5682s_hp = {
    43		.num_codecs = 2,
    44		.codecs = {"10EC5682", "RTL5682"},
    45	};
    46	
    47	/*
    48	 * When adding new entry to the snd_soc_acpi_intel_jsl_machines array,
    49	 * use .quirk_data member to distinguish different machine driver,
    50	 * and keep ACPI .id field unchanged for the common codec.
    51	 */
    52	struct snd_soc_acpi_mach snd_soc_acpi_intel_jsl_machines[] = {
    53		{
    54			.id = "DLGS7219",
    55			.drv_name = "sof_da7219_mx98373",
    56			.sof_tplg_filename = "sof-jsl-da7219.tplg",
    57			.machine_quirk = snd_soc_acpi_codec_list,
    58			.quirk_data = &jsl_7219_98373_codecs,
    59		},
    60		{
    61			.id = "DLGS7219",
    62			.drv_name = "sof_da7219_mx98360a",
    63			.sof_tplg_filename = "sof-jsl-da7219-mx98360a.tplg",
    64		},
    65		{
    66			.comp_ids = &rt5682_rt5682s_hp,
    67			.drv_name = "jsl_rt5682_rt1015",
    68			.machine_quirk = snd_soc_acpi_codec_list,
    69			.quirk_data = &rt1015_spk,
    70			.sof_tplg_filename = "sof-jsl-rt5682-rt1015.tplg",
    71		},
    72		{
    73			.comp_ids = &rt5682_rt5682s_hp,
    74			.drv_name = "jsl_rt5682_rt1015p",
    75			.machine_quirk = snd_soc_acpi_codec_list,
    76			.quirk_data = &rt1015p_spk,
    77			.sof_tplg_filename = "sof-jsl-rt5682-rt1015.tplg",
    78		},
    79		{
    80			.comp_ids = &rt5682_rt5682s_hp,
    81			.drv_name = "jsl_rt5682_mx98360",
    82			.machine_quirk = snd_soc_acpi_codec_list,
    83			.quirk_data = &mx98360a_spk,
    84			.sof_tplg_filename = "sof-jsl-rt5682-mx98360a.tplg",
    85		},
    86		{
    87			.comp_ids = &rt5682_rt5682s_hp,
    88			.drv_name = "jsl_rt5682_rt1019",
  > 89			.sof_fw_filename = "sof-jsl.ri",

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46AB50EEF4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 04:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242590AbiDZC5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 22:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbiDZC51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 22:57:27 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D90C11F637
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 19:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650941661; x=1682477661;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SpLLNX6bkwHMvUHJkzynONm2cC1Zthxqwh7DchfM1eM=;
  b=QXYsQNNM0/WX4mVvxvo007njQERlJFOprNys2SzJDc7alUhvCcpeL5VU
   tJbjAaO70Ek9J8XnO7YOeT4+LckDibQJED+8PkImqymVV16TpPU7sKM77
   AWLfkbodkBhyeWxTqMd5p0KevGUrRLnOFgoNcPwJzNEWZID7rPBqWKqbT
   0qRJyaL2rhqbEZSmsoPLZRDggcwkmZbj/eZ/MLBon4mCsfGiF4fF2/Qkv
   7Z7rS6NGwEZsI09n0XNYg3nFGpNJsvOFEo3nCYwOJNC7ITWYV2G/O1D2A
   dXqWoHtWjNFWMh44eIcRfrula4p5vYO6a+NNuTIZxcFmdLeTIdV1B7Bd6
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="264950980"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="264950980"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 19:54:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="677886747"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 25 Apr 2022 19:54:18 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njBLF-00039q-CU;
        Tue, 26 Apr 2022 02:54:17 +0000
Date:   Tue, 26 Apr 2022 10:54:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [broonie-sound:for-5.19 88/98] sound/soc/soc-acpi.c:58:36: warning:
 initialization of 'struct acpi_device *' from 'int' makes pointer from
 integer without a cast
Message-ID: <202204261004.8OOIWobj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.19
head:   83f48ad508b0539f4a1737a1a125d1b66191dbc3
commit: 47a1886a610aca6a55c18ee677f9176e73162e97 [88/98] ASoC: Intel: avs: Enable AVS driver only on x86 platforms
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220426/202204261004.8OOIWobj-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?id=47a1886a610aca6a55c18ee677f9176e73162e97
        git remote add broonie-sound https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
        git fetch --no-tags broonie-sound for-5.19
        git checkout 47a1886a610aca6a55c18ee677f9176e73162e97
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash sound/soc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   sound/soc/soc-acpi.c:34:1: error: redefinition of 'snd_soc_acpi_find_machine'
      34 | snd_soc_acpi_find_machine(struct snd_soc_acpi_mach *machines)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from sound/soc/soc-acpi.c:9:
   include/sound/soc-acpi.h:38:1: note: previous definition of 'snd_soc_acpi_find_machine' with type 'struct snd_soc_acpi_mach *(struct snd_soc_acpi_mach *)'
      38 | snd_soc_acpi_find_machine(struct snd_soc_acpi_mach *machines)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/soc-acpi.c: In function 'snd_soc_acpi_find_package':
   sound/soc/soc-acpi.c:58:36: error: implicit declaration of function 'acpi_fetch_acpi_dev'; did you mean 'device_match_acpi_dev'? [-Werror=implicit-function-declaration]
      58 |         struct acpi_device *adev = acpi_fetch_acpi_dev(handle);
         |                                    ^~~~~~~~~~~~~~~~~~~
         |                                    device_match_acpi_dev
>> sound/soc/soc-acpi.c:58:36: warning: initialization of 'struct acpi_device *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   sound/soc/soc-acpi.c:64:25: error: invalid use of undefined type 'struct acpi_device'
      64 |         if (adev && adev->status.present && adev->status.functional) {
         |                         ^~
   sound/soc/soc-acpi.c:64:49: error: invalid use of undefined type 'struct acpi_device'
      64 |         if (adev && adev->status.present && adev->status.functional) {
         |                                                 ^~
   sound/soc/soc-acpi.c:80:26: error: implicit declaration of function 'acpi_extract_package' [-Werror=implicit-function-declaration]
      80 |                 status = acpi_extract_package(myobj,
         |                          ^~~~~~~~~~~~~~~~~~~~
   sound/soc/soc-acpi.c: At top level:
   sound/soc/soc-acpi.c:95:6: error: redefinition of 'snd_soc_acpi_find_package_from_hid'
      95 | bool snd_soc_acpi_find_package_from_hid(const u8 hid[ACPI_ID_LEN],
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from sound/soc/soc-acpi.c:9:
   include/sound/soc-acpi.h:44:1: note: previous definition of 'snd_soc_acpi_find_package_from_hid' with type 'bool(const u8 *, struct snd_soc_acpi_package_context *)' {aka '_Bool(const unsigned char *, struct snd_soc_acpi_package_context *)'}
      44 | snd_soc_acpi_find_package_from_hid(const u8 hid[ACPI_ID_LEN],
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/soc-acpi.c:109:27: error: redefinition of 'snd_soc_acpi_codec_list'
     109 | struct snd_soc_acpi_mach *snd_soc_acpi_codec_list(void *arg)
         |                           ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from sound/soc/soc-acpi.c:9:
   include/sound/soc-acpi.h:51:41: note: previous definition of 'snd_soc_acpi_codec_list' with type 'struct snd_soc_acpi_mach *(void *)'
      51 | static inline struct snd_soc_acpi_mach *snd_soc_acpi_codec_list(void *arg)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +58 sound/soc/soc-acpi.c

8ceffd229f0ef1 sound/soc/intel/common/sst-match-acpi.c Vinod Koul           2016-02-08  54  
7feb2f786a46d3 sound/soc/soc-acpi.c                    Pierre-Louis Bossart 2017-10-12  55  static acpi_status snd_soc_acpi_find_package(acpi_handle handle, u32 level,
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  56  					     void *context, void **ret)
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  57  {
ff4865b3c8cd74 sound/soc/soc-acpi.c                    Rafael J. Wysocki    2022-01-26 @58  	struct acpi_device *adev = acpi_fetch_acpi_dev(handle);
59ce3233a538fc sound/soc/soc-acpi.c                    Pierre-Louis Bossart 2021-04-16  59  	acpi_status status;
7feb2f786a46d3 sound/soc/soc-acpi.c                    Pierre-Louis Bossart 2017-10-12  60  	struct snd_soc_acpi_package_context *pkg_ctx = context;
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  61  
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  62  	pkg_ctx->data_valid = false;
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  63  
ff4865b3c8cd74 sound/soc/soc-acpi.c                    Rafael J. Wysocki    2022-01-26  64  	if (adev && adev->status.present && adev->status.functional) {
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  65  		struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  66  		union acpi_object  *myobj = NULL;
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  67  
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  68  		status = acpi_evaluate_object_typed(handle, pkg_ctx->name,
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  69  						NULL, &buffer,
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  70  						ACPI_TYPE_PACKAGE);
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  71  		if (ACPI_FAILURE(status))
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  72  			return AE_OK;
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  73  
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  74  		myobj = buffer.pointer;
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  75  		if (!myobj || myobj->package.count != pkg_ctx->length) {
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  76  			kfree(buffer.pointer);
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  77  			return AE_OK;
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  78  		}
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  79  
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  80  		status = acpi_extract_package(myobj,
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  81  					pkg_ctx->format, pkg_ctx->state);
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  82  		if (ACPI_FAILURE(status)) {
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  83  			kfree(buffer.pointer);
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  84  			return AE_OK;
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  85  		}
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  86  
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  87  		kfree(buffer.pointer);
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  88  		pkg_ctx->data_valid = true;
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  89  		return AE_CTRL_TERMINATE;
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  90  	}
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  91  
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  92  	return AE_OK;
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  93  }
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  94  

:::::: The code at line 58 was first introduced by commit
:::::: ff4865b3c8cd746ef72f59bdd485848b4cebd43d ALSA: Replace acpi_bus_get_device()

:::::: TO: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
:::::: CC: Takashi Iwai <tiwai@suse.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3965690DF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 19:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbiGFRmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 13:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbiGFRmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 13:42:19 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A759720BD4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 10:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657129338; x=1688665338;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cmcTql/wpNIHAh2NbA+ZXsM9qZOwJwt62fKRqJPgpmM=;
  b=BsD9IKRc1maY3OWQzUXSJ/ohIhEM3thhcIqf4YxooY+gi17uAao7VAYp
   OOl+PE/zb3E3w0SeNEwdNPpTbvUeVS4ctx7k28GE7USyncQ5tZEnZoMmt
   lA1V9coQ4+XwSQRkkxng9wunu53rIdLBXhi8fe1yoOPJbryl0cF+Zhwof
   MwFkv6pIgvvSLuX35+JEAzViX3dPycwEcNvCnBCElUeYz+6rwsFw81gfy
   VHI2B9YcdpR8kW5zzHkiYpYadikXX4WLg1ub2abOqRgsYzFdYkDECJsqN
   J+4AkviclsZdK4dZZrbJ+kxSJB30qmZT4dryR3XHOF7vONekvsZTsB67A
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="284946877"
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="284946877"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 10:42:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="543496690"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 06 Jul 2022 10:42:16 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o992V-000KrJ-MN;
        Wed, 06 Jul 2022 17:42:15 +0000
Date:   Thu, 7 Jul 2022 01:41:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [ammarfaizi2-block:broonie/sound/for-next 328/352]
 sound/soc/soc-acpi.c:58:36: warning: initialization of 'struct acpi_device
 *' from 'int' makes pointer from integer without a cast
Message-ID: <202207070102.kkRe03MS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block broonie/sound/for-next
head:   6abb4d7d17ffe320e9b7e22f474e5631c0464524
commit: f94fa84058014f81ad526641f1b1f583ca2cf32f [328/352] ASoC: amd: enable machine driver build for Jadeite platform
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220707/202207070102.kkRe03MS-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/f94fa84058014f81ad526641f1b1f583ca2cf32f
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block broonie/sound/for-next
        git checkout f94fa84058014f81ad526641f1b1f583ca2cf32f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash sound/soc/

If you fix the issue, kindly add following tag where applicable
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

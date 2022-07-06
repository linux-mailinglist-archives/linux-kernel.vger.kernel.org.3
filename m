Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBA056959D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 01:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbiGFXHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 19:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbiGFXHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 19:07:33 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824AC2B260
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 16:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657148852; x=1688684852;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AE2UvYsp2+nwmNULN4I1AI/1pvsKh05W3/jaVcEyk/g=;
  b=m3VKP9koof/VyoZ+nQohqVnYtYeuH8xsAnNAi2DevBuhbRWZ+CWmh32C
   JU/WXu4IWTNZPyy9LxUk4E2t+V/w6bbpz1bwK90r/RSVlidguNKHuciaA
   fCbig2SP+VvXZ58fxYIXwVgkF8Ho+RIoToi14ZiL3Nms/t/ndAJbuAqir
   RtIcaheCECEAEo2C2lIjGTATq4j6c4TNwUDW/sUD9bAX/pmIJECrygAk/
   KY5RCtcn3eEjcPhkXnmx5OjlcsSyfMuO4y8tvNt9ztVN5zzSjdaSL1wUU
   oYOOOKpmnf+y+kFjOdnJ8DtUnpbAY1OK3pCKvpwiwF+s11bEaCN7FSI/c
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="283913360"
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="283913360"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 16:07:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="683103119"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Jul 2022 16:07:30 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9E7G-000LCY-1l;
        Wed, 06 Jul 2022 23:07:30 +0000
Date:   Thu, 7 Jul 2022 07:07:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [ammarfaizi2-block:broonie/sound/for-next 328/353]
 sound/soc/soc-acpi.c:34:1: error: redefinition of
 'snd_soc_acpi_find_machine'
Message-ID: <202207070640.BouQoaUc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vijendar,

First bad commit (maybe != root cause):

tree:   https://github.com/ammarfaizi2/linux-block broonie/sound/for-next
head:   3f4322bb413adb7f9d8b5e9005eb1b9bc85f9312
commit: f94fa84058014f81ad526641f1b1f583ca2cf32f [328/353] ASoC: amd: enable machine driver build for Jadeite platform
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220707/202207070640.BouQoaUc-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> sound/soc/soc-acpi.c:34:1: error: redefinition of 'snd_soc_acpi_find_machine'
      34 | snd_soc_acpi_find_machine(struct snd_soc_acpi_mach *machines)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from sound/soc/soc-acpi.c:9:
   include/sound/soc-acpi.h:38:1: note: previous definition of 'snd_soc_acpi_find_machine' with type 'struct snd_soc_acpi_mach *(struct snd_soc_acpi_mach *)'
      38 | snd_soc_acpi_find_machine(struct snd_soc_acpi_mach *machines)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/soc-acpi.c: In function 'snd_soc_acpi_find_package':
>> sound/soc/soc-acpi.c:58:36: error: implicit declaration of function 'acpi_fetch_acpi_dev'; did you mean 'device_match_acpi_dev'? [-Werror=implicit-function-declaration]
      58 |         struct acpi_device *adev = acpi_fetch_acpi_dev(handle);
         |                                    ^~~~~~~~~~~~~~~~~~~
         |                                    device_match_acpi_dev
   sound/soc/soc-acpi.c:58:36: warning: initialization of 'struct acpi_device *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>> sound/soc/soc-acpi.c:64:25: error: invalid use of undefined type 'struct acpi_device'
      64 |         if (adev && adev->status.present && adev->status.functional) {
         |                         ^~
   sound/soc/soc-acpi.c:64:49: error: invalid use of undefined type 'struct acpi_device'
      64 |         if (adev && adev->status.present && adev->status.functional) {
         |                                                 ^~
>> sound/soc/soc-acpi.c:80:26: error: implicit declaration of function 'acpi_extract_package' [-Werror=implicit-function-declaration]
      80 |                 status = acpi_extract_package(myobj,
         |                          ^~~~~~~~~~~~~~~~~~~~
   sound/soc/soc-acpi.c: At top level:
>> sound/soc/soc-acpi.c:95:6: error: redefinition of 'snd_soc_acpi_find_package_from_hid'
      95 | bool snd_soc_acpi_find_package_from_hid(const u8 hid[ACPI_ID_LEN],
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from sound/soc/soc-acpi.c:9:
   include/sound/soc-acpi.h:44:1: note: previous definition of 'snd_soc_acpi_find_package_from_hid' with type 'bool(const u8 *, struct snd_soc_acpi_package_context *)' {aka '_Bool(const unsigned char *, struct snd_soc_acpi_package_context *)'}
      44 | snd_soc_acpi_find_package_from_hid(const u8 hid[ACPI_ID_LEN],
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> sound/soc/soc-acpi.c:109:27: error: redefinition of 'snd_soc_acpi_codec_list'
     109 | struct snd_soc_acpi_mach *snd_soc_acpi_codec_list(void *arg)
         |                           ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from sound/soc/soc-acpi.c:9:
   include/sound/soc-acpi.h:51:41: note: previous definition of 'snd_soc_acpi_codec_list' with type 'struct snd_soc_acpi_mach *(void *)'
      51 | static inline struct snd_soc_acpi_mach *snd_soc_acpi_codec_list(void *arg)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   sound/soc/amd/acp-es8336.c: In function 'st_es8336_late_probe':
>> sound/soc/amd/acp-es8336.c:204:33: error: invalid use of undefined type 'struct acpi_device'
     204 |                 put_device(&adev->dev);
         |                                 ^~
   sound/soc/amd/acp-es8336.c:200:13: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     200 |         int ret;
         |             ^~~


vim +/snd_soc_acpi_find_machine +34 sound/soc/soc-acpi.c

cafa39b650ec3b sound/soc/soc-acpi.c                    Brent Lu             2021-10-30   32  
7feb2f786a46d3 sound/soc/soc-acpi.c                    Pierre-Louis Bossart 2017-10-12   33  struct snd_soc_acpi_mach *
7feb2f786a46d3 sound/soc/soc-acpi.c                    Pierre-Louis Bossart 2017-10-12  @34  snd_soc_acpi_find_machine(struct snd_soc_acpi_mach *machines)
95f098014815b3 sound/soc/intel/common/sst-match-acpi.c Vinod Koul           2015-11-05   35  {
7feb2f786a46d3 sound/soc/soc-acpi.c                    Pierre-Louis Bossart 2017-10-12   36  	struct snd_soc_acpi_mach *mach;
a3e620f8422832 sound/soc/soc-acpi.c                    Keyon Jie            2018-11-16   37  	struct snd_soc_acpi_mach *mach_alt;
95f098014815b3 sound/soc/intel/common/sst-match-acpi.c Vinod Koul           2015-11-05   38  
cafa39b650ec3b sound/soc/soc-acpi.c                    Brent Lu             2021-10-30   39  	for (mach = machines; mach->id[0] || mach->comp_ids; mach++) {
cafa39b650ec3b sound/soc/soc-acpi.c                    Brent Lu             2021-10-30   40  		if (snd_soc_acpi_id_present(mach)) {
a3e620f8422832 sound/soc/soc-acpi.c                    Keyon Jie            2018-11-16   41  			if (mach->machine_quirk) {
a3e620f8422832 sound/soc/soc-acpi.c                    Keyon Jie            2018-11-16   42  				mach_alt = mach->machine_quirk(mach);
a3e620f8422832 sound/soc/soc-acpi.c                    Keyon Jie            2018-11-16   43  				if (!mach_alt)
a3e620f8422832 sound/soc/soc-acpi.c                    Keyon Jie            2018-11-16   44  					continue; /* not full match, ignore */
a3e620f8422832 sound/soc/soc-acpi.c                    Keyon Jie            2018-11-16   45  				mach = mach_alt;
a3e620f8422832 sound/soc/soc-acpi.c                    Keyon Jie            2018-11-16   46  			}
a3e620f8422832 sound/soc/soc-acpi.c                    Keyon Jie            2018-11-16   47  
7827d66946ad3a sound/soc/intel/common/sst-match-acpi.c Naveen M             2017-05-15   48  			return mach;
7827d66946ad3a sound/soc/intel/common/sst-match-acpi.c Naveen M             2017-05-15   49  		}
7827d66946ad3a sound/soc/intel/common/sst-match-acpi.c Naveen M             2017-05-15   50  	}
95f098014815b3 sound/soc/intel/common/sst-match-acpi.c Vinod Koul           2015-11-05   51  	return NULL;
95f098014815b3 sound/soc/intel/common/sst-match-acpi.c Vinod Koul           2015-11-05   52  }
7feb2f786a46d3 sound/soc/soc-acpi.c                    Pierre-Louis Bossart 2017-10-12   53  EXPORT_SYMBOL_GPL(snd_soc_acpi_find_machine);
8ceffd229f0ef1 sound/soc/intel/common/sst-match-acpi.c Vinod Koul           2016-02-08   54  
7feb2f786a46d3 sound/soc/soc-acpi.c                    Pierre-Louis Bossart 2017-10-12   55  static acpi_status snd_soc_acpi_find_package(acpi_handle handle, u32 level,
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12   56  					     void *context, void **ret)
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12   57  {
ff4865b3c8cd74 sound/soc/soc-acpi.c                    Rafael J. Wysocki    2022-01-26  @58  	struct acpi_device *adev = acpi_fetch_acpi_dev(handle);
59ce3233a538fc sound/soc/soc-acpi.c                    Pierre-Louis Bossart 2021-04-16   59  	acpi_status status;
7feb2f786a46d3 sound/soc/soc-acpi.c                    Pierre-Louis Bossart 2017-10-12   60  	struct snd_soc_acpi_package_context *pkg_ctx = context;
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12   61  
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12   62  	pkg_ctx->data_valid = false;
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12   63  
ff4865b3c8cd74 sound/soc/soc-acpi.c                    Rafael J. Wysocki    2022-01-26  @64  	if (adev && adev->status.present && adev->status.functional) {
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12   65  		struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12   66  		union acpi_object  *myobj = NULL;
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12   67  
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12   68  		status = acpi_evaluate_object_typed(handle, pkg_ctx->name,
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12   69  						NULL, &buffer,
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12   70  						ACPI_TYPE_PACKAGE);
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12   71  		if (ACPI_FAILURE(status))
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12   72  			return AE_OK;
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12   73  
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12   74  		myobj = buffer.pointer;
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12   75  		if (!myobj || myobj->package.count != pkg_ctx->length) {
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12   76  			kfree(buffer.pointer);
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12   77  			return AE_OK;
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12   78  		}
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12   79  
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  @80  		status = acpi_extract_package(myobj,
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12   81  					pkg_ctx->format, pkg_ctx->state);
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12   82  		if (ACPI_FAILURE(status)) {
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12   83  			kfree(buffer.pointer);
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12   84  			return AE_OK;
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12   85  		}
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12   86  
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12   87  		kfree(buffer.pointer);
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12   88  		pkg_ctx->data_valid = true;
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12   89  		return AE_CTRL_TERMINATE;
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12   90  	}
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12   91  
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12   92  	return AE_OK;
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12   93  }
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12   94  
7feb2f786a46d3 sound/soc/soc-acpi.c                    Pierre-Louis Bossart 2017-10-12  @95  bool snd_soc_acpi_find_package_from_hid(const u8 hid[ACPI_ID_LEN],
7feb2f786a46d3 sound/soc/soc-acpi.c                    Pierre-Louis Bossart 2017-10-12   96  				struct snd_soc_acpi_package_context *ctx)
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12   97  {
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12   98  	acpi_status status;
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12   99  
7feb2f786a46d3 sound/soc/soc-acpi.c                    Pierre-Louis Bossart 2017-10-12  100  	status = acpi_get_devices(hid, snd_soc_acpi_find_package, ctx, NULL);
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  101  
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  102  	if (ACPI_FAILURE(status) || !ctx->data_valid)
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  103  		return false;
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  104  
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  105  	return true;
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  106  }
7feb2f786a46d3 sound/soc/soc-acpi.c                    Pierre-Louis Bossart 2017-10-12  107  EXPORT_SYMBOL_GPL(snd_soc_acpi_find_package_from_hid);
3421894765a345 sound/soc/intel/common/sst-match-acpi.c Pierre-Louis Bossart 2016-11-12  108  
7feb2f786a46d3 sound/soc/soc-acpi.c                    Pierre-Louis Bossart 2017-10-12 @109  struct snd_soc_acpi_mach *snd_soc_acpi_codec_list(void *arg)
54746dabf770eb sound/soc/intel/common/sst-match-acpi.c Naveen M             2017-05-15  110  {
7feb2f786a46d3 sound/soc/soc-acpi.c                    Pierre-Louis Bossart 2017-10-12  111  	struct snd_soc_acpi_mach *mach = arg;
7feb2f786a46d3 sound/soc/soc-acpi.c                    Pierre-Louis Bossart 2017-10-12  112  	struct snd_soc_acpi_codecs *codec_list =
7feb2f786a46d3 sound/soc/soc-acpi.c                    Pierre-Louis Bossart 2017-10-12  113  		(struct snd_soc_acpi_codecs *) mach->quirk_data;
54746dabf770eb sound/soc/intel/common/sst-match-acpi.c Naveen M             2017-05-15  114  	int i;
54746dabf770eb sound/soc/intel/common/sst-match-acpi.c Naveen M             2017-05-15  115  
54746dabf770eb sound/soc/intel/common/sst-match-acpi.c Naveen M             2017-05-15  116  	if (mach->quirk_data == NULL)
54746dabf770eb sound/soc/intel/common/sst-match-acpi.c Naveen M             2017-05-15  117  		return mach;
54746dabf770eb sound/soc/intel/common/sst-match-acpi.c Naveen M             2017-05-15  118  
54746dabf770eb sound/soc/intel/common/sst-match-acpi.c Naveen M             2017-05-15  119  	for (i = 0; i < codec_list->num_codecs; i++) {
0d5ea120abc020 sound/soc/soc-acpi.c                    Jeremy Cline         2018-01-05  120  		if (!acpi_dev_present(codec_list->codecs[i], NULL, -1))
54746dabf770eb sound/soc/intel/common/sst-match-acpi.c Naveen M             2017-05-15  121  			return NULL;
54746dabf770eb sound/soc/intel/common/sst-match-acpi.c Naveen M             2017-05-15  122  	}
54746dabf770eb sound/soc/intel/common/sst-match-acpi.c Naveen M             2017-05-15  123  
54746dabf770eb sound/soc/intel/common/sst-match-acpi.c Naveen M             2017-05-15  124  	return mach;
54746dabf770eb sound/soc/intel/common/sst-match-acpi.c Naveen M             2017-05-15  125  }
7feb2f786a46d3 sound/soc/soc-acpi.c                    Pierre-Louis Bossart 2017-10-12  126  EXPORT_SYMBOL_GPL(snd_soc_acpi_codec_list);
54746dabf770eb sound/soc/intel/common/sst-match-acpi.c Naveen M             2017-05-15  127  

:::::: The code at line 34 was first introduced by commit
:::::: 7feb2f786a46d34cac760d5e246dfbdafafa0e96 ASoC: move ACPI common code out of Intel/sst tree

:::::: TO: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
:::::: CC: Mark Brown <broonie@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

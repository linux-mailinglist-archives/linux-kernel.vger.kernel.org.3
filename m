Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C6B5AE8DB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 14:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239847AbiIFMyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 08:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240445AbiIFMx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 08:53:56 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE8374E0D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 05:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662468806; x=1694004806;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6TbReH72SUPOamzSGR3FcLhEAd1HtZtPrDdk5H2ksAg=;
  b=X1shcFpWIst1EdMsqIoJlsmHcB+kTIZ56UEwqbvqEigLajXnTjitM21+
   PopGOqikhg1A6UYYuEBb6JDTUu4rz5ndH4LZL7NW8djlro2NJWo5y6WXs
   82ZlBC36mNvtKHkJ3XqGfSMsWK4OgHiJXyO1WT3SIg4tNqadJiwm4Ya37
   7CWIMPC7W3ZeSCfR6GEh2yUyS3RQciYK15Oxvy0vjQjFgr1BnCcRJ9Tpy
   qMeuwSmFW8xeBsdO+drrQXWyVnrEwvU6BbvjWkzGvJ1shmvZGG5diqlIl
   epcXFvd5joH9TwdNp90zIfGJYRBdCh9N3VKtEsAMErE/x58+9zzfj1v3S
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="322757662"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="322757662"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 05:53:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="565081713"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 06 Sep 2022 05:53:22 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVY4v-00057D-1E;
        Tue, 06 Sep 2022 12:53:21 +0000
Date:   Tue, 6 Sep 2022 20:53:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [pinchartl-media:streams/v6.0/v11 49/49]
 include/linux/container_of.h:17:42: error: returning 'struct iss_pipeline *'
 from a function with incompatible return type 'struct media_pipeline *'
Message-ID: <202209062003.eFiRJ8vz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/pinchartl/media.git streams/v6.0/v11
head:   c8cf58f00bee6d4f43462b3e3f83ef516c594d61
commit: c8cf58f00bee6d4f43462b3e3f83ef516c594d61 [49/49] media: mc: entity: Add media_entity_pipeline() to access the media pipeline
config: ia64-allyesconfig (https://download.01.org/0day-ci/archive/20220906/202209062003.eFiRJ8vz-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add pinchartl-media git://linuxtv.org/pinchartl/media.git
        git fetch --no-tags pinchartl-media streams/v6.0/v11
        git checkout c8cf58f00bee6d4f43462b3e3f83ef516c594d61
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/staging/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:21,
                    from include/linux/clk.h:13,
                    from drivers/staging/media/omap4iss/iss.c:10:
   drivers/staging/media/omap4iss/iss_video.h: In function 'to_iss_pipeline':
>> include/linux/container_of.h:17:42: error: returning 'struct iss_pipeline *' from a function with incompatible return type 'struct media_pipeline *' [-Werror=incompatible-pointer-types]
      17 | #define container_of(ptr, type, member) ({                              \
         |                                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      18 |         void *__mptr = (void *)(ptr);                                   \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      20 |                       __same_type(*(ptr), void),                        \
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      21 |                       "pointer type mismatch in container_of()");       \
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      22 |         ((type *)(__mptr - offsetof(type, member))); })
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/media/omap4iss/iss_video.h:100:16: note: in expansion of macro 'container_of'
     100 |         return container_of(pipe, struct iss_pipeline, pipe);
         |                ^~~~~~~~~~~~
   drivers/staging/media/omap4iss/iss.c: In function 'iss_pipeline_is_last':
>> drivers/staging/media/omap4iss/iss.c:551:14: error: assignment to 'struct iss_pipeline *' from incompatible pointer type 'struct media_pipeline *' [-Werror=incompatible-pointer-types]
     551 |         pipe = to_iss_pipeline(me);
         |              ^
   drivers/staging/media/omap4iss/iss.c: In function 'omap4iss_module_sync_idle':
>> drivers/staging/media/omap4iss/iss.c:624:37: error: initialization of 'struct iss_pipeline *' from incompatible pointer type 'struct media_pipeline *' [-Werror=incompatible-pointer-types]
     624 |         struct iss_pipeline *pipe = to_iss_pipeline(me);
         |                                     ^~~~~~~~~~~~~~~
   {standard input}: Assembler messages:
   {standard input}:977: Error: Register number out of range 0..3
   {standard input}:977: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 36
   {standard input}:977: Warning: Only the first path encountering the conflict is reported
   {standard input}:972: Warning: This is the location of the conflicting usage
   {standard input}:978: Error: Register number out of range 0..3
   {standard input}:978: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 36
   {standard input}:978: Warning: Only the first path encountering the conflict is reported
   {standard input}:972: Warning: This is the location of the conflicting usage
   {standard input}:978: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 36
   {standard input}:978: Warning: Only the first path encountering the conflict is reported
   {standard input}:977: Warning: This is the location of the conflicting usage
   {standard input}:981: Error: Register number out of range 0..3
   {standard input}:982: Error: Register number out of range 0..3
   {standard input}:982: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 36
   {standard input}:982: Warning: Only the first path encountering the conflict is reported
   {standard input}:981: Warning: This is the location of the conflicting usage
   {standard input}:2630: Error: Register number out of range 0..2
   {standard input}:2632: Error: Register number out of range 0..2
   {standard input}:2632: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 39
   {standard input}:2632: Warning: Only the first path encountering the conflict is reported
   {standard input}:2630: Warning: This is the location of the conflicting usage
   {standard input}:2633: Error: Register number out of range 0..2
   {standard input}:2633: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 39
   {standard input}:2633: Warning: Only the first path encountering the conflict is reported
   {standard input}:2630: Warning: This is the location of the conflicting usage
   {standard input}:2633: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 39
   {standard input}:2633: Warning: Only the first path encountering the conflict is reported
   {standard input}:2632: Warning: This is the location of the conflicting usage
   {standard input}:2634: Error: Register number out of range 0..2
   {standard input}:2634: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 39
   {standard input}:2634: Warning: Only the first path encountering the conflict is reported
   {standard input}:2630: Warning: This is the location of the conflicting usage
   {standard input}:2634: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 39
   {standard input}:2634: Warning: Only the first path encountering the conflict is reported
   {standard input}:2632: Warning: This is the location of the conflicting usage
   {standard input}:2634: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 39
   {standard input}:2634: Warning: Only the first path encountering the conflict is reported
   {standard input}:2633: Warning: This is the location of the conflicting usage
   {standard input}:2638: Error: Register number out of range 0..2
   {standard input}:3883: Error: Register number out of range 0..0
   {standard input}:3883: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 36
   {standard input}:3883: Warning: Only the first path encountering the conflict is reported
   {standard input}:3882: Warning: This is the location of the conflicting usage
   {standard input}:3884: Error: Register number out of range 0..0
   {standard input}:3884: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 36
   {standard input}:3884: Warning: Only the first path encountering the conflict is reported
   {standard input}:3882: Warning: This is the location of the conflicting usage
   {standard input}:3884: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 36
   {standard input}:3884: Warning: Only the first path encountering the conflict is reported
   {standard input}:3883: Warning: This is the location of the conflicting usage
   {standard input}:3886: Error: Register number out of range 0..0
   {standard input}:3886: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 36
   {standard input}:3886: Warning: Only the first path encountering the conflict is reported
   {standard input}:3882: Warning: This is the location of the conflicting usage
   {standard input}:3886: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 36
   {standard input}:3886: Warning: Only the first path encountering the conflict is reported
   {standard input}:3883: Warning: This is the location of the conflicting usage
   {standard input}:3886: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 36
   {standard input}:3886: Warning: Only the first path encountering the conflict is reported
   {standard input}:3884: Warning: This is the location of the conflicting usage
   {standard input}:3887: Error: Register number out of range 0..0
   {standard input}:3887: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 36
   {standard input}:3887: Warning: Only the first path encountering the conflict is reported
   {standard input}:3882: Warning: This is the location of the conflicting usage
   {standard input}:3887: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 36
   {standard input}:3887: Warning: Only the first path encountering the conflict is reported
   {standard input}:3883: Warning: This is the location of the conflicting usage
   {standard input}:3887: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 36
   {standard input}:3887: Warning: Only the first path encountering the conflict is reported
   {standard input}:3884: Warning: This is the location of the conflicting usage
   {standard input}:3887: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 36
   {standard input}:3887: Warning: Only the first path encountering the conflict is reported
   {standard input}:3886: Warning: This is the location of the conflicting usage
   {standard input}:3888: Error: Register number out of range 0..0
   {standard input}:3888: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 36
   {standard input}:3888: Warning: Only the first path encountering the conflict is reported
   {standard input}:3882: Warning: This is the location of the conflicting usage
   {standard input}:3888: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 36
   {standard input}:3888: Warning: Only the first path encountering the conflict is reported
   {standard input}:3883: Warning: This is the location of the conflicting usage
   {standard input}:3888: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 36
   {standard input}:3888: Warning: Only the first path encountering the conflict is reported
   {standard input}:3884: Warning: This is the location of the conflicting usage
   {standard input}:3888: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 36
   {standard input}:3888: Warning: Only the first path encountering the conflict is reported
   {standard input}:3886: Warning: This is the location of the conflicting usage
   {standard input}:3888: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 36
   {standard input}:3888: Warning: Only the first path encountering the conflict is reported
   {standard input}:3887: Warning: This is the location of the conflicting usage
   {standard input}:3891: Error: Register number out of range 0..0
   {standard input}:3892: Error: Register number out of range 0..0
   {standard input}:3892: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 36
   {standard input}:3892: Warning: Only the first path encountering the conflict is reported
   {standard input}:3891: Warning: This is the location of the conflicting usage
   {standard input}:5338: Error: Register number out of range 0..3
   {standard input}:5338: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 38
   {standard input}:5338: Warning: Only the first path encountering the conflict is reported
--
   In file included from include/linux/list.h:5,
                    from include/linux/rculist.h:10,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/delay.h:23,
                    from drivers/staging/media/omap4iss/iss_csi2.c:10:
   drivers/staging/media/omap4iss/iss_video.h: In function 'to_iss_pipeline':
>> include/linux/container_of.h:17:42: error: returning 'struct iss_pipeline *' from a function with incompatible return type 'struct media_pipeline *' [-Werror=incompatible-pointer-types]
      17 | #define container_of(ptr, type, member) ({                              \
         |                                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      18 |         void *__mptr = (void *)(ptr);                                   \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      20 |                       __same_type(*(ptr), void),                        \
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      21 |                       "pointer type mismatch in container_of()");       \
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      22 |         ((type *)(__mptr - offsetof(type, member))); })
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/media/omap4iss/iss_video.h:100:16: note: in expansion of macro 'container_of'
     100 |         return container_of(pipe, struct iss_pipeline, pipe);
         |                ^~~~~~~~~~~~
   drivers/staging/media/omap4iss/iss_csi2.c: In function 'csi2_isr_ctx':
   drivers/staging/media/omap4iss/iss_csi2.c:679:38: error: initialization of 'struct iss_pipeline *' from incompatible pointer type 'struct media_pipeline *' [-Werror=incompatible-pointer-types]
     679 |                                      to_iss_pipeline(&csi2->subdev.entity);
         |                                      ^~~~~~~~~~~~~~~
   drivers/staging/media/omap4iss/iss_csi2.c: In function 'omap4iss_csi2_isr':
   drivers/staging/media/omap4iss/iss_csi2.c:742:37: error: initialization of 'struct iss_pipeline *' from incompatible pointer type 'struct media_pipeline *' [-Werror=incompatible-pointer-types]
     742 |         struct iss_pipeline *pipe = to_iss_pipeline(&csi2->subdev.entity);
         |                                     ^~~~~~~~~~~~~~~
   drivers/staging/media/omap4iss/iss_csi2.c: In function 'csi2_link_validate':
   drivers/staging/media/omap4iss/iss_csi2.c:1025:37: error: initialization of 'struct iss_pipeline *' from incompatible pointer type 'struct media_pipeline *' [-Werror=incompatible-pointer-types]
    1025 |         struct iss_pipeline *pipe = to_iss_pipeline(&csi2->subdev.entity);
         |                                     ^~~~~~~~~~~~~~~
   {standard input}: Assembler messages:
   {standard input}:2581: Error: Register number out of range 0..3
   {standard input}:2581: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 37
   {standard input}:2581: Warning: Only the first path encountering the conflict is reported
   {standard input}:2576: Warning: This is the location of the conflicting usage
   {standard input}:2582: Error: Register number out of range 0..3
   {standard input}:2582: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 37
   {standard input}:2582: Warning: Only the first path encountering the conflict is reported
   {standard input}:2576: Warning: This is the location of the conflicting usage
   {standard input}:2582: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 37
   {standard input}:2582: Warning: Only the first path encountering the conflict is reported
   {standard input}:2581: Warning: This is the location of the conflicting usage
   {standard input}:2585: Error: Register number out of range 0..3
   {standard input}:2586: Error: Register number out of range 0..3
   {standard input}:2586: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 37
   {standard input}:2586: Warning: Only the first path encountering the conflict is reported
   {standard input}:2585: Warning: This is the location of the conflicting usage
   {standard input}:2927: Error: Register number out of range 0..3
   {standard input}:2928: Error: Register number out of range 0..3
   {standard input}:2928: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 39
   {standard input}:2927: Warning: This is the location of the conflicting usage
   {standard input}:2929: Error: Register number out of range 0..3
   {standard input}:2929: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 39
   {standard input}:2927: Warning: This is the location of the conflicting usage
   {standard input}:2929: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 39
   {standard input}:2928: Warning: This is the location of the conflicting usage
   {standard input}:2933: Error: Register number out of range 0..3
   {standard input}:3168: Error: Register number out of range 0..3
   {standard input}:3168: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 43
   {standard input}:3168: Warning: Only the first path encountering the conflict is reported
   {standard input}:3163: Warning: This is the location of the conflicting usage
   {standard input}:3169: Error: Register number out of range 0..3
   {standard input}:3169: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 43
   {standard input}:3169: Warning: Only the first path encountering the conflict is reported
   {standard input}:3163: Warning: This is the location of the conflicting usage
   {standard input}:3169: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 43
   {standard input}:3169: Warning: Only the first path encountering the conflict is reported
   {standard input}:3168: Warning: This is the location of the conflicting usage
   {standard input}:3172: Error: Register number out of range 0..3
   {standard input}:3173: Error: Register number out of range 0..3
   {standard input}:3173: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 43
   {standard input}:3173: Warning: Only the first path encountering the conflict is reported
   {standard input}:3172: Warning: This is the location of the conflicting usage
   {standard input}:4933: Error: Register number out of range 0..3
   {standard input}:4934: Error: Register number out of range 0..3
   {standard input}:4934: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 39
   {standard input}:4934: Warning: Only the first path encountering the conflict is reported
   {standard input}:4933: Warning: This is the location of the conflicting usage
   {standard input}:4935: Error: Register number out of range 0..3
   {standard input}:4935: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 39
   {standard input}:4935: Warning: Only the first path encountering the conflict is reported
   {standard input}:4933: Warning: This is the location of the conflicting usage
   {standard input}:4935: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 39
   {standard input}:4935: Warning: Only the first path encountering the conflict is reported
   {standard input}:4934: Warning: This is the location of the conflicting usage
   {standard input}:4939: Error: Register number out of range 0..3
   cc1: some warnings being treated as errors
--
   In file included from include/linux/list.h:5,
                    from include/linux/rculist.h:10,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/delay.h:23,
                    from drivers/staging/media/omap4iss/iss_csiphy.c:10:
   drivers/staging/media/omap4iss/iss_video.h: In function 'to_iss_pipeline':
>> include/linux/container_of.h:17:42: error: returning 'struct iss_pipeline *' from a function with incompatible return type 'struct media_pipeline *' [-Werror=incompatible-pointer-types]
      17 | #define container_of(ptr, type, member) ({                              \
         |                                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      18 |         void *__mptr = (void *)(ptr);                                   \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      20 |                       __same_type(*(ptr), void),                        \
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      21 |                       "pointer type mismatch in container_of()");       \
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      22 |         ((type *)(__mptr - offsetof(type, member))); })
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/media/omap4iss/iss_video.h:100:16: note: in expansion of macro 'container_of'
     100 |         return container_of(pipe, struct iss_pipeline, pipe);
         |                ^~~~~~~~~~~~
   drivers/staging/media/omap4iss/iss_csiphy.c: In function 'omap4iss_csiphy_config':
   drivers/staging/media/omap4iss/iss_csiphy.c:119:37: error: initialization of 'struct iss_pipeline *' from incompatible pointer type 'struct media_pipeline *' [-Werror=incompatible-pointer-types]
     119 |         struct iss_pipeline *pipe = to_iss_pipeline(&csi2_subdev->entity);
         |                                     ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/list.h:5,
                    from include/linux/module.h:12,
                    from drivers/staging/media/omap4iss/iss_ipipeif.c:10:
   drivers/staging/media/omap4iss/iss_video.h: In function 'to_iss_pipeline':
>> include/linux/container_of.h:17:42: error: returning 'struct iss_pipeline *' from a function with incompatible return type 'struct media_pipeline *' [-Werror=incompatible-pointer-types]
      17 | #define container_of(ptr, type, member) ({                              \
         |                                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      18 |         void *__mptr = (void *)(ptr);                                   \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      20 |                       __same_type(*(ptr), void),                        \
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      21 |                       "pointer type mismatch in container_of()");       \
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      22 |         ((type *)(__mptr - offsetof(type, member))); })
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/media/omap4iss/iss_video.h:100:16: note: in expansion of macro 'container_of'
     100 |         return container_of(pipe, struct iss_pipeline, pipe);
         |                ^~~~~~~~~~~~
   {standard input}: Assembler messages:
   {standard input}:2314: Error: Register number out of range 0..3
   {standard input}:2314: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 36
   {standard input}:2314: Warning: Only the first path encountering the conflict is reported
   {standard input}:2309: Warning: This is the location of the conflicting usage
   {standard input}:2315: Error: Register number out of range 0..3
   {standard input}:2315: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 36
   {standard input}:2315: Warning: Only the first path encountering the conflict is reported
   {standard input}:2309: Warning: This is the location of the conflicting usage
   {standard input}:2315: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 36
   {standard input}:2315: Warning: Only the first path encountering the conflict is reported
   {standard input}:2314: Warning: This is the location of the conflicting usage
   {standard input}:2318: Error: Register number out of range 0..3
   {standard input}:2319: Error: Register number out of range 0..3
   {standard input}:2319: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 36
   {standard input}:2319: Warning: Only the first path encountering the conflict is reported
   {standard input}:2318: Warning: This is the location of the conflicting usage
   {standard input}:3122: Error: Register number out of range 0..3
   {standard input}:3123: Error: Register number out of range 0..3
   {standard input}:3123: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 38
   {standard input}:3123: Warning: Only the first path encountering the conflict is reported
   {standard input}:3122: Warning: This is the location of the conflicting usage
   {standard input}:3124: Error: Register number out of range 0..3
   {standard input}:3124: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 38
   {standard input}:3124: Warning: Only the first path encountering the conflict is reported
   {standard input}:3122: Warning: This is the location of the conflicting usage
   {standard input}:3124: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 38
   {standard input}:3124: Warning: Only the first path encountering the conflict is reported
   {standard input}:3123: Warning: This is the location of the conflicting usage
   {standard input}:3128: Error: Register number out of range 0..3
   {standard input}:3448: Error: Register number out of range 0..3
   {standard input}:3448: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 43
   {standard input}:3448: Warning: Only the first path encountering the conflict is reported
   {standard input}:3443: Warning: This is the location of the conflicting usage
   {standard input}:3449: Error: Register number out of range 0..3
   {standard input}:3449: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 43
   {standard input}:3449: Warning: Only the first path encountering the conflict is reported
   {standard input}:3443: Warning: This is the location of the conflicting usage
   {standard input}:3449: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 43
   {standard input}:3449: Warning: Only the first path encountering the conflict is reported
   {standard input}:3448: Warning: This is the location of the conflicting usage
   {standard input}:3452: Error: Register number out of range 0..3
   {standard input}:3453: Error: Register number out of range 0..3
   {standard input}:3453: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 43
   {standard input}:3453: Warning: Only the first path encountering the conflict is reported
   {standard input}:3452: Warning: This is the location of the conflicting usage
   cc1: some warnings being treated as errors
..


vim +17 include/linux/container_of.h

d2a8ebbf8192b8 Andy Shevchenko  2021-11-08   9  
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  10  /**
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  11   * container_of - cast a member of a structure out to the containing structure
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  12   * @ptr:	the pointer to the member.
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  13   * @type:	the type of the container struct this is embedded in.
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  14   * @member:	the name of the member within the struct.
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  15   *
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  16   */
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08 @17  #define container_of(ptr, type, member) ({				\
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  18  	void *__mptr = (void *)(ptr);					\
e1edc277e6f6df Rasmus Villemoes 2021-11-08  19  	static_assert(__same_type(*(ptr), ((type *)0)->member) ||	\
e1edc277e6f6df Rasmus Villemoes 2021-11-08  20  		      __same_type(*(ptr), void),			\
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  21  		      "pointer type mismatch in container_of()");	\
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  22  	((type *)(__mptr - offsetof(type, member))); })
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  23  

:::::: The code at line 17 was first introduced by commit
:::::: d2a8ebbf8192b84b11f1b204c4f7c602df32aeac kernel.h: split out container_of() and typeof_member() macros

:::::: TO: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

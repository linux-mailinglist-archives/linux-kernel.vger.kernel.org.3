Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908E55866B6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 11:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiHAJH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 05:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiHAJHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 05:07:54 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976F528E3D
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 02:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659344873; x=1690880873;
  h=subject:references:in-reply-to:to:cc:from:message-id:
   date:mime-version:content-transfer-encoding;
  bh=x9bmLfqCPADKO2VY/iNwV4o1wHzfaCzuIvmDlwgtyz8=;
  b=LhwkloXG5Scc2hiDUSiI7d1Z3U23Ft4M7XP77HEyB3IPyBRqMYwKo/rB
   ZR0ftJEjW7I/ubgAPVooBDQC92I8TRdBpMZ10//JnE9YRHA3J1BcP3dSN
   P1oiQgDfrmVdT2qwyBsuGHDi6RO6r5eoqM/3OnYxWHFNQCXRMGfIPwwTF
   dme9ljDovu0rFFNOLSek5JFbECoWul+Fi4s8B5WaL3FPnmaXzKWiUEKQO
   WlC0SWfvETNcT2akS2EfdBa+orv+RB22MeNhl3qvrkoF0iKPnjBsColUx
   gql+SnXymrpQDNgi12kcSopyyqKUFJVgFZEuSvrlaWNnwbqrwJ1MsMkNr
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="314922841"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="314922841"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 02:07:53 -0700
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="661067254"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.172.209]) ([10.249.172.209])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 02:07:50 -0700
Subject: Re: [PATCH drm-misc-next v6 3/5] drm/gem: rename GEM CMA helpers to
 GEM DMA helpers
References: <202207312337.CwA6jvYb-lkp@intel.com>
In-Reply-To: <202207312337.CwA6jvYb-lkp@intel.com>
To:     Danilo Krummrich <dakr@redhat.com>, daniel@ffwll.ch,
        laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        tzimmermann@suse.de, mripard@kernel.org, sam@ravnborg.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Danilo Krummrich <dakr@redhat.com>
From:   kernel test robot <rong.a.chen@intel.com>
X-Forwarded-Message-Id: <202207312337.CwA6jvYb-lkp@intel.com>
Message-ID: <c1fb382d-b8ff-5e68-5c50-bf820704ceec@intel.com>
Date:   Mon, 1 Aug 2022 17:07:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Danilo,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on drm-misc/drm-misc-next]
[cannot apply to linus/master v5.19-rc8 next-20220728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url: 
https://github.com/intel-lab-lkp/linux/commits/Danilo-Krummrich/drm-rename-CMA-helpers-to-DMA-helpers/20220721-210404
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
config: nios2-buildonly-randconfig-r006-20220721 
(https://download.01.org/0day-ci/archive/20220731/202207312337.CwA6jvYb-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
         wget 
https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross 
-O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # 
https://github.com/intel-lab-lkp/linux/commit/140c3d95439b5852acd816850625036ac3a1019d
         git remote add linux-review https://github.com/intel-lab-lkp/linux
         git fetch --no-tags linux-review 
Danilo-Krummrich/drm-rename-CMA-helpers-to-DMA-helpers/20220721-210404
         git checkout 140c3d95439b5852acd816850625036ac3a1019d
         # save the config file
         mkdir build_dir && cp config build_dir/.config
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross 
W=1 O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> nios2-linux-ld: drivers/gpu/drm/mxsfb/lcdif_drv.o:(.rodata+0x218): undefined reference to `drm_gem_dma_prime_import_sg_table'
>> nios2-linux-ld: drivers/gpu/drm/mxsfb/lcdif_drv.o:(.rodata+0x220): undefined reference to `drm_gem_dma_dumb_create'
    nios2-linux-ld: drivers/gpu/drm/mxsfb/lcdif_kms.o: in function 
`lcdif_plane_primary_atomic_update':
>> lcdif_kms.c:(.text+0x3a8): undefined reference to `drm_fb_dma_get_gem_addr'
    lcdif_kms.c:(.text+0x3a8): relocation truncated to fit: 
R_NIOS2_CALL26 against `drm_fb_dma_get_gem_addr'
    nios2-linux-ld: drivers/gpu/drm/mxsfb/lcdif_kms.o: in function 
`lcdif_crtc_atomic_enable':
    lcdif_kms.c:(.text+0x658): undefined reference to 
`drm_fb_dma_get_gem_addr'
    lcdif_kms.c:(.text+0x658): relocation truncated to fit: 
R_NIOS2_CALL26 against `drm_fb_dma_get_gem_addr'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp


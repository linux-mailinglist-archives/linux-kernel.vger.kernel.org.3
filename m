Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A4052EC93
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349496AbiETMsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349475AbiETMss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:48:48 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB291668A6;
        Fri, 20 May 2022 05:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653050927; x=1684586927;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RMCcUvf4lESFVE+KBBnXAEay0T2uWzyIBLfBOA+tar4=;
  b=cfebuhoXUCFshQAg44+VuBtepj644cDvzvHF5cAMsFFVk/2XIT6962gM
   bf4aALRh/O5s/QVi2NGefZFGweCsQkdtDFt2MtOxMOK9XpscoPX3sRrwY
   ZHpdYEYvT/nAMxF45lo6MJJHTMAC1PMtZmOcVomvy26Vf34wix9DXqwrf
   k8i+nrD9kHm+xEj96TuiVQEcmmCTP2mXM+FFEEMDBNNkcPRXt5Thzg8TU
   j3y6r0DjWTuTEZiq/ygf1zQVF0R+39EI+0ELv2Pj7tTLswy5WmcnMOWIh
   PsbbYlHkJqyb9qDx2/K/AkuLke59yH8hM2vlzOWdriG9pf/L0g/4Ohx7s
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="252482305"
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="252482305"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 05:48:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="674603101"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 20 May 2022 05:48:44 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ns23g-0004ht-4I;
        Fri, 20 May 2022 12:48:44 +0000
Date:   Fri, 20 May 2022 20:48:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marvin Lin <milkfafa@gmail.com>, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com, Marvin Lin <milkfafa@gmail.com>
Subject: Re: [PATCH v3 5/5] drivers: media: platform: Add NPCM Video
 Capture/Encode Engine driver
Message-ID: <202205202038.PeQqCdhg-lkp@intel.com>
References: <20220520024744.25655-6-milkfafa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520024744.25655-6-milkfafa@gmail.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marvin,

I love your patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linux/master linus/master v5.18-rc7]
[cannot apply to media-tree/master next-20220519]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Marvin-Lin/Support-Nuvoton-NPCM-Video-Capture-Encode-Engine/20220520-104901
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20220520/202205202038.PeQqCdhg-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project e00cbbec06c08dc616a0d52a20f678b8fbd4e304)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/56e41b3b4b1a54f2096e810eda12259da495c686
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Marvin-Lin/Support-Nuvoton-NPCM-Video-Capture-Encode-Engine/20220520-104901
        git checkout 56e41b3b4b1a54f2096e810eda12259da495c686
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/media/platform/nuvoton/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/media/platform/nuvoton/npcm-video.c:2048:45: error: expected ';' after top level declarator
   MODULE_DEVICE_TABLE(of, nuvoton_video_match)
                                               ^
                                               ;
   1 error generated.


vim +2048 drivers/media/platform/nuvoton/npcm-video.c

  2047	
> 2048	MODULE_DEVICE_TABLE(of, nuvoton_video_match)
  2049	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

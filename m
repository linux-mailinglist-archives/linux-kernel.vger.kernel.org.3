Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99BA516A43
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 07:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381247AbiEBFXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 01:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236108AbiEBFXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 01:23:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF719EB2
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 22:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651468814; x=1683004814;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QuFyDqKGVTfY4iNddWhDkWIGMMe5nOROfsUE1mx0mJk=;
  b=KuFoz90W88aL6zwUAaMJFvtB78hgmVAxfx1jxd1at8qUlDYXYUsSRHSw
   sNUpofYrXZ2hsSb4So4kLL4bcS7CL4fu8QB0GBxSdZNjjwUC2dm6r9FGf
   BVzHLEsGKlUWnSgUxUNqShoSCUHHoAFHPT5kDSgMZdyOyzTbJQMIlfxrS
   b5RXkUeZPjQ0UFUnNp/bZdCrHfjzuKCEX2dWKoT+05UPEDtGxVg7zq4iw
   t6tzCwdr71SmTvk/dnKlK0E76D9SMJfS/JIfUQd8iUdTzCTuqwooz0kFF
   TYc1E4RowfLyAnmO2VXYS7pF6xe6EmyuvpxGhSoAWE5PhQwL9YZB1X8ix
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="264713449"
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="264713449"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2022 22:20:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="515918422"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 01 May 2022 22:20:12 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlOTk-0009J9-0Y;
        Mon, 02 May 2022 05:20:12 +0000
Date:   Mon, 2 May 2022 13:19:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [drm-msm:msm-next-staging 56/96]
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c:273:2: warning: unannotated
 fall-through between switch labels
Message-ID: <202205021302.tnSsOIBN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/drm/msm.git msm-next-staging
head:   f1fc2b87de4719cfa8e193e0746cc524dd9f7472
commit: 6d084806c8c107dc0b652d6792c7aea9b6b0d66f [56/96] drm/msm/dpu: add changes to support writeback in hw_ctl
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220502/202205021302.tnSsOIBN-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 09325d36061e42b495d1f4c7e933e260eac260ed)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        git remote add drm-msm https://gitlab.freedesktop.org/drm/msm.git
        git fetch --no-tags drm-msm msm-next-staging
        git checkout 6d084806c8c107dc0b652d6792c7aea9b6b0d66f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/dma/ti/ drivers/gpu/drm/msm/ drivers/pci/controller/dwc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c:273:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
           default:
           ^
   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c:273:2: note: insert 'break;' to avoid fall-through
           default:
           ^
           break; 
   1 warning generated.


vim +273 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c

   264	
   265	static void dpu_hw_ctl_update_pending_flush_wb(struct dpu_hw_ctl *ctx,
   266			enum dpu_wb wb)
   267	{
   268		switch (wb) {
   269		case WB_0:
   270		case WB_1:
   271		case WB_2:
   272			ctx->pending_flush_mask |= BIT(WB_IDX);
 > 273		default:
   274			break;
   275		}
   276	}
   277	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

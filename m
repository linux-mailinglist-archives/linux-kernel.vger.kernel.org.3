Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF77F5270BD
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 12:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbiENKmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 06:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiENKml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 06:42:41 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8FC12D26;
        Sat, 14 May 2022 03:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652524959; x=1684060959;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=owL2E8dN4WOVXiXSAA2t80U2WaZOkvUVbpuMiP4wVM8=;
  b=bWBJ+mcgQ5Z+TPdVrKeHG5Corj1LC8Pxayp4juMk7OVoDQfc+jg5cNAS
   tiPpwkwV3TurD6iNfjoZsyFcPScIpEG4bjqsMOo7o5GtoxAWYEEiJbiHT
   TV9IOtDhxJm6MK8gvMpHDng8zVyPQrmZmXNQwEMCjAFxz1V4cZ2+RSamy
   vjc18W/QfHpbOurC9KvTgFQTcek9HKu9epgb+R7OopF4zbOR5nmA/HvFf
   7KEbNer6aiV5Vqo6N49C5l4we1xfIaozZVLiOWSFg29jdRNCylaLojE27
   gbyPvoAiUBke3VPHj4rxudoLUsYjB3hKyeEQHeuUFdrN2MM0KxDxNEfQd
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="250402859"
X-IronPort-AV: E=Sophos;i="5.91,225,1647327600"; 
   d="scan'208";a="250402859"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2022 03:42:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,225,1647327600"; 
   d="scan'208";a="595648948"
Received: from lkp-server01.sh.intel.com (HELO d1462bc4b09b) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 14 May 2022 03:42:36 -0700
Received: from kbuild by d1462bc4b09b with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nppEJ-0000Vx-Ds;
        Sat, 14 May 2022 10:42:35 +0000
Date:   Sat, 14 May 2022 18:41:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marvin Lin <milkfafa@gmail.com>, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com
Subject: Re: [PATCH v2 5/5] drivers: media: platform: Add NPCM Video
 Capture/Encode Engine driver
Message-ID: <202205141815.QVBWWaqM-lkp@intel.com>
References: <20220513033450.7038-6-kflin@nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513033450.7038-6-kflin@nuvoton.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marvin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linux/master linus/master v5.18-rc6]
[cannot apply to media-tree/master next-20220513]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Marvin-Lin/Support-Nuvoton-NPCM-Video-Capture-Encode-Engine/20220513-113806
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220514/202205141815.QVBWWaqM-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 38189438b69ca27b4c6ce707c52dbd217583d046)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7fa1f7750e7317479ce2c2c043b44fa19c46b1a8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Marvin-Lin/Support-Nuvoton-NPCM-Video-Capture-Encode-Engine/20220513-113806
        git checkout 7fa1f7750e7317479ce2c2c043b44fa19c46b1a8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/media/platform/nuvoton/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/media/platform/nuvoton/npcm-video.c:1776:6: warning: variable 'empty' set but not used [-Wunused-but-set-variable]
           int empty;
               ^
   1 warning generated.


vim +/empty +1776 drivers/media/platform/nuvoton/npcm-video.c

  1773	
  1774	static void nuvoton_video_buf_queue(struct vb2_buffer *vb)
  1775	{
> 1776		int empty;
  1777		struct nuvoton_video *video = vb2_get_drv_priv(vb->vb2_queue);
  1778		struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
  1779		struct nuvoton_video_buffer *nvb = to_nuvoton_video_buffer(vbuf);
  1780		unsigned long flags;
  1781	
  1782		dev_dbg(video->dev, "%s\n", __func__);
  1783	
  1784		spin_lock_irqsave(&video->lock, flags);
  1785		empty = list_empty(&video->buffers);
  1786		list_add_tail(&nvb->link, &video->buffers);
  1787		spin_unlock_irqrestore(&video->lock, flags);
  1788	}
  1789	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

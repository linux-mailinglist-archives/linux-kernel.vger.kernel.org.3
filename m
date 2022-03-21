Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0944E2ED0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 18:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351670AbiCURJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 13:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351686AbiCURJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 13:09:40 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CE52BE;
        Mon, 21 Mar 2022 10:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647882494; x=1679418494;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KfO3FDuPvou5MkoqbbYqi9PWLKEbm5Zj4sMWJXhm5aA=;
  b=Trs3hE9c7lPs9UiEodTjlIv1kGybrNLxBifrv6hiKhOnDX2K8JC4Q+qF
   P2fq/L0qAkE5C5wva3zcyQEXDvxSZ9CMdntkRBor69k3FxnIeroqYSWPR
   n2c+LjCO01RtwiCi8jH9NSybZr0uoB3njweS8hw2YDyxzv0XNKK/p05/Q
   Je2yfubAZRKApEnqiIOPqtUs/o29lT4sE+TWFw75T4XRJHS295kqlBdfD
   Nj4VKMhXBwJOhJTknRtrhGjZ2dFNHYVUCmn/erqiswagTzY77UPiIGnQM
   VGRhbzFqtBTJD6vO4F7pj6f3lg+8F4FTWOEIKZeSSBWIIl1MFWG4qAO8O
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="282431645"
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="282431645"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 10:08:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="500241838"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 21 Mar 2022 10:08:11 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWLVq-000I0c-Ti; Mon, 21 Mar 2022 17:08:10 +0000
Date:   Tue, 22 Mar 2022 01:07:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: drivers/gpu/drm/sti/sti_hdmi.c:187: warning: This comment starts
 with '/**', but isn't a kernel-doc comment. Refer
 Documentation/doc-guide/kernel-doc.rst
Message-ID: <202203220003.ultJrIat-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aditya,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f443e374ae131c168a065ea1748feac6b2e76613
commit: f9bbc12ccb35ac8b3fa01cec1a19cb523a7707c7 scripts: kernel-doc: improve parsing for kernel-doc comments syntax
date:   11 months ago
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20220322/202203220003.ultJrIat-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f9bbc12ccb35ac8b3fa01cec1a19cb523a7707c7
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f9bbc12ccb35ac8b3fa01cec1a19cb523a7707c7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/mach-omap2/ drivers/gpu/drm/sti/ drivers/usb/gadget/udc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/sti/sti_hdmi.c:187: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * HDMI interrupt handler threaded
   drivers/gpu/drm/sti/sti_hdmi.c:219: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * HDMI interrupt handler
   drivers/gpu/drm/sti/sti_hdmi.c:241: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Set hdmi active area depending on the drm display mode selected
   drivers/gpu/drm/sti/sti_hdmi.c:262: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Overall hdmi configuration
   drivers/gpu/drm/sti/sti_hdmi.c:340: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Helper to concatenate infoframe in 32 bits word
   drivers/gpu/drm/sti/sti_hdmi.c:357: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Helper to write info frame
   drivers/gpu/drm/sti/sti_hdmi.c:427: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Prepare and configure the AVI infoframe
   drivers/gpu/drm/sti/sti_hdmi.c:470: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Prepare and configure the AUDIO infoframe
   drivers/gpu/drm/sti/sti_hdmi.c:555: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Software reset of the hdmi subsystem
--
>> arch/arm/mach-omap2/cpuidle44xx.c:88: warning: expecting prototype for omap_enter_idle_[simple/coupled](). Prototype was for omap_enter_idle_simple() instead


vim +187 drivers/gpu/drm/sti/sti_hdmi.c

5402626c83a2f19 Benjamin Gaignard 2014-07-30  185  
5402626c83a2f19 Benjamin Gaignard 2014-07-30  186  /**
5402626c83a2f19 Benjamin Gaignard 2014-07-30 @187   * HDMI interrupt handler threaded
5402626c83a2f19 Benjamin Gaignard 2014-07-30  188   *
5402626c83a2f19 Benjamin Gaignard 2014-07-30  189   * @irq: irq number
5402626c83a2f19 Benjamin Gaignard 2014-07-30  190   * @arg: connector structure
5402626c83a2f19 Benjamin Gaignard 2014-07-30  191   */
5402626c83a2f19 Benjamin Gaignard 2014-07-30  192  static irqreturn_t hdmi_irq_thread(int irq, void *arg)
5402626c83a2f19 Benjamin Gaignard 2014-07-30  193  {
5402626c83a2f19 Benjamin Gaignard 2014-07-30  194  	struct sti_hdmi *hdmi = arg;
5402626c83a2f19 Benjamin Gaignard 2014-07-30  195  
5402626c83a2f19 Benjamin Gaignard 2014-07-30  196  	/* Hot plug/unplug IRQ */
5402626c83a2f19 Benjamin Gaignard 2014-07-30  197  	if (hdmi->irq_status & HDMI_INT_HOT_PLUG) {
765692078f08d02 Benjamin Gaignard 2014-10-09  198  		hdmi->hpd = readl(hdmi->regs + HDMI_STA) & HDMI_STA_HOT_PLUG;
5402626c83a2f19 Benjamin Gaignard 2014-07-30  199  		if (hdmi->drm_dev)
5402626c83a2f19 Benjamin Gaignard 2014-07-30  200  			drm_helper_hpd_irq_event(hdmi->drm_dev);
5402626c83a2f19 Benjamin Gaignard 2014-07-30  201  	}
5402626c83a2f19 Benjamin Gaignard 2014-07-30  202  
5402626c83a2f19 Benjamin Gaignard 2014-07-30  203  	/* Sw reset and PLL lock are exclusive so we can use the same
5402626c83a2f19 Benjamin Gaignard 2014-07-30  204  	 * event to signal them
5402626c83a2f19 Benjamin Gaignard 2014-07-30  205  	 */
5402626c83a2f19 Benjamin Gaignard 2014-07-30  206  	if (hdmi->irq_status & (HDMI_INT_SW_RST | HDMI_INT_DLL_LCK)) {
5402626c83a2f19 Benjamin Gaignard 2014-07-30  207  		hdmi->event_received = true;
5402626c83a2f19 Benjamin Gaignard 2014-07-30  208  		wake_up_interruptible(&hdmi->wait_event);
5402626c83a2f19 Benjamin Gaignard 2014-07-30  209  	}
5402626c83a2f19 Benjamin Gaignard 2014-07-30  210  
2c348e505328155 Arnaud Pouliquen  2016-05-30  211  	/* Audio FIFO underrun IRQ */
2c348e505328155 Arnaud Pouliquen  2016-05-30  212  	if (hdmi->irq_status & HDMI_INT_AUDIO_FIFO_XRUN)
29ffa77668235bd Fabien Dessenne   2016-09-06  213  		DRM_INFO("Warning: audio FIFO underrun occurs!\n");
2c348e505328155 Arnaud Pouliquen  2016-05-30  214  
5402626c83a2f19 Benjamin Gaignard 2014-07-30  215  	return IRQ_HANDLED;
5402626c83a2f19 Benjamin Gaignard 2014-07-30  216  }
5402626c83a2f19 Benjamin Gaignard 2014-07-30  217  

:::::: The code at line 187 was first introduced by commit
:::::: 5402626c83a2f19da14859e2bab231a53e16ee74 drm: sti: add HDMI driver

:::::: TO: Benjamin Gaignard <benjamin.gaignard@linaro.org>
:::::: CC: Benjamin Gaignard <benjamin.gaignard@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

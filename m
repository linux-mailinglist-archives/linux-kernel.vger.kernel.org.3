Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A51528B14
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 18:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237358AbiEPQxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 12:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbiEPQxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 12:53:42 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB0A27B24;
        Mon, 16 May 2022 09:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652720021; x=1684256021;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QwE4qZcr0kfgxgWwYG+DqB0YHJUWXlP/2JufN6m80rE=;
  b=lArZmi/0BYZ62djCCUBEjKVX1shTpzLJa/3loS0KpXo1IT9ovTLjmWhP
   lpwOGcJwjy/cxItJs+6dc+o0sUzlPnzhmkPscpAhxYVZEJJJsweaLhqhH
   CbfYdfavnlw6K56445IIf5Zpn67b7Cs4KrGbldxlwoFCzMJAqX+9R77j0
   v6YxpXB+NEypbF6PNPsMpWme/osYX78xgn7stIDGWuoH7BJpTazEEaM3a
   AYV6Fccm7IjM4+Khb3JlmNp/ckYGduymlTNHtpbH77dUtpLf92DEmVaqZ
   xElLicm+HbibIU33WlD6Q7sb4AdyGlc4jRnm1v7yYPo3dwLvWzsg4WUWD
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="252951769"
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="252951769"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 09:53:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="897289897"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 16 May 2022 09:53:38 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqdyU-0000Cp-AJ;
        Mon, 16 May 2022 16:53:38 +0000
Date:   Tue, 17 May 2022 00:52:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, hverkuil@xs4all.nl,
        yj.chiang@mediatek.com, Lecopzer Chen <lecopzer.chen@mediatek.com>
Subject: Re: [PATCH v2] media: Kconfig: Make DVB_CORE=m possible when
 MEDIA_SUPPORT=y
Message-ID: <202205170022.UTCdqnyp-lkp@intel.com>
References: <20220513173036.10807-1-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513173036.10807-1-lecopzer.chen@mediatek.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lecopzer,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on media-tree/master]
[also build test ERROR on v5.18-rc7 next-20220516]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Lecopzer-Chen/media-Kconfig-Make-DVB_CORE-m-possible-when-MEDIA_SUPPORT-y/20220514-013156
base:   git://linuxtv.org/media_tree.git master
config: arm64-randconfig-c004-20220516 (https://download.01.org/0day-ci/archive/20220517/202205170022.UTCdqnyp-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a487d9187c58c094c8886af300300e5ee92b6e05
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Lecopzer-Chen/media-Kconfig-Make-DVB_CORE-m-possible-when-MEDIA_SUPPORT-y/20220514-013156
        git checkout a487d9187c58c094c8886af300300e5ee92b6e05
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: "dvb_dmx_init" [drivers/media/pci/mantis/mantis_core.ko] undefined!
ERROR: modpost: "dvb_unregister_adapter" [drivers/media/pci/mantis/mantis_core.ko] undefined!
ERROR: modpost: "dvb_register_frontend" [drivers/media/pci/mantis/mantis_core.ko] undefined!
ERROR: modpost: "dvb_ca_en50221_camchange_irq" [drivers/media/pci/mantis/mantis_core.ko] undefined!
ERROR: modpost: "dvb_unregister_frontend" [drivers/media/pci/mantis/mantis_core.ko] undefined!
>> ERROR: modpost: "dvb_ca_en50221_camready_irq" [drivers/media/pci/mantis/mantis_core.ko] undefined!
>> ERROR: modpost: "dvb_frontend_detach" [drivers/media/pci/mantis/mantis_core.ko] undefined!
>> ERROR: modpost: "dvb_dmxdev_release" [drivers/media/pci/mantis/mantis_core.ko] undefined!
>> ERROR: modpost: "dvb_dmx_swfilter" [drivers/media/pci/mantis/mantis_core.ko] undefined!
>> ERROR: modpost: "dvb_ca_en50221_release" [drivers/media/pci/mantis/mantis_core.ko] undefined!
WARNING: modpost: suppressed 5 unresolved symbol warnings because there were too many)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

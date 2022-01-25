Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3B149B067
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 10:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574664AbiAYJgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 04:36:08 -0500
Received: from mga12.intel.com ([192.55.52.136]:43254 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1574351AbiAYJd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 04:33:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643103208; x=1674639208;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+VQ5+r1Kq+buQ3KBsLXGaXoqqEJxE2QX8j2kQTLRU9o=;
  b=i/xdvNXlQtWDkS6tzEBD0cvQzi5D6+i05smEl9aRhwiuTKdFD8D8EBa3
   YBLJKKMJ7jYYwGx7RIrI/mSCVK1eMBVEzmN1bWIOT2+PO9lYxIutpbEWd
   uqMzHH5FxERUhlomVYX22qiRH3susrC6M+ZMlHU0lDlctbmPE9IDWa3oM
   brKA/SQu6tZBxmLyg1AJ7bG+6FgXQubbC6STasomrUokKlLcMBeLm86Ph
   mBnjEieO0HsWlIrgUvwOyvQZyhcKPHUcXTkmajFnnuMa1r0Tqo7ELgxce
   QsUCzEmQxddVJ3OQhkCdRzcyrhNEzaT6G5PEUCUWuT0djjs+P8VHqQNsE
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="226242014"
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="226242014"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 01:31:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="597074199"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 25 Jan 2022 01:31:34 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCIAo-000Jf9-1a; Tue, 25 Jan 2022 09:31:34 +0000
Date:   Tue, 25 Jan 2022 17:31:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org
Cc:     kbuild-all@lists.01.org, dan.carpenter@oracle.com,
        Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, paskripkin@gmail.com
Subject: Re: [PATCH 06/10] staging: r8188eu: remove DBG_88E calls from
 os_dep/ioctl_linux.c
Message-ID: <202201251730.AgK9qxSH-lkp@intel.com>
References: <20220124224415.831-7-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124224415.831-7-phil@philpotter.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phillip,

I love your patch! Perhaps something to improve:

[auto build test WARNING on staging/staging-testing]
[also build test WARNING on v5.17-rc1 next-20220124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Phillip-Potter/Cleanup-and-removal-of-DBG_88E-macro/20220125-125206
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git fa783154524a71ab74e293cd8251155e5971952b
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220125/202201251730.AgK9qxSH-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/1724ade2c1f2fa95e0e314ed9229700d6158fbbc
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Phillip-Potter/Cleanup-and-removal-of-DBG_88E-macro/20220125-125206
        git checkout 1724ade2c1f2fa95e0e314ed9229700d6158fbbc
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/staging/r8188eu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/staging/r8188eu/os_dep/ioctl_linux.c: In function 'rtw_wx_set_mlme':
>> drivers/staging/r8188eu/os_dep/ioctl_linux.c:1022:13: warning: variable 'reason' set but not used [-Wunused-but-set-variable]
    1022 |         u16 reason;
         |             ^~~~~~


vim +/reason +1022 drivers/staging/r8188eu/os_dep/ioctl_linux.c

2b42bd58b32155 Phillip Potter  2021-07-28  1016  
2b42bd58b32155 Phillip Potter  2021-07-28  1017  static int rtw_wx_set_mlme(struct net_device *dev,
2b42bd58b32155 Phillip Potter  2021-07-28  1018  			     struct iw_request_info *info,
2b42bd58b32155 Phillip Potter  2021-07-28  1019  			     union iwreq_data *wrqu, char *extra)
2b42bd58b32155 Phillip Potter  2021-07-28  1020  {
2b42bd58b32155 Phillip Potter  2021-07-28  1021  	int ret = 0;
2b42bd58b32155 Phillip Potter  2021-07-28 @1022  	u16 reason;
2b42bd58b32155 Phillip Potter  2021-07-28  1023  	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
2b42bd58b32155 Phillip Potter  2021-07-28  1024  	struct iw_mlme *mlme = (struct iw_mlme *)extra;
2b42bd58b32155 Phillip Potter  2021-07-28  1025  
d8062f6adca1ef Michael Straube 2021-07-30  1026  	if (!mlme)
2b42bd58b32155 Phillip Potter  2021-07-28  1027  		return -1;
2b42bd58b32155 Phillip Potter  2021-07-28  1028  
2b42bd58b32155 Phillip Potter  2021-07-28  1029  	reason = mlme->reason_code;
2b42bd58b32155 Phillip Potter  2021-07-28  1030  
2b42bd58b32155 Phillip Potter  2021-07-28  1031  	switch (mlme->cmd) {
2b42bd58b32155 Phillip Potter  2021-07-28  1032  	case IW_MLME_DEAUTH:
2b42bd58b32155 Phillip Potter  2021-07-28  1033  		if (!rtw_set_802_11_disassociate(padapter))
2b42bd58b32155 Phillip Potter  2021-07-28  1034  			ret = -1;
2b42bd58b32155 Phillip Potter  2021-07-28  1035  		break;
2b42bd58b32155 Phillip Potter  2021-07-28  1036  	case IW_MLME_DISASSOC:
2b42bd58b32155 Phillip Potter  2021-07-28  1037  		if (!rtw_set_802_11_disassociate(padapter))
2b42bd58b32155 Phillip Potter  2021-07-28  1038  			ret = -1;
2b42bd58b32155 Phillip Potter  2021-07-28  1039  		break;
2b42bd58b32155 Phillip Potter  2021-07-28  1040  	default:
2b42bd58b32155 Phillip Potter  2021-07-28  1041  		return -EOPNOTSUPP;
2b42bd58b32155 Phillip Potter  2021-07-28  1042  	}
2b42bd58b32155 Phillip Potter  2021-07-28  1043  	return ret;
2b42bd58b32155 Phillip Potter  2021-07-28  1044  }
2b42bd58b32155 Phillip Potter  2021-07-28  1045  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

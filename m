Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB8758591C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 10:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbiG3IQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 04:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbiG3IQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 04:16:01 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AC64D83A
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 01:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659168959; x=1690704959;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oMLBLUEV0c73UmvX+x0ng5G4mX/0i7sf3gVdg+mllL8=;
  b=mamxE52/cumKe8xZS3IUWhI/GHZv8Lfmgk+j5APRLV7qyZznOegMIlPd
   vn//h1canmfPetBjissp5bW5etdfJo383Kab4qtREHCLtuU7gGawIkKuv
   LkkdNacFfn8JIc7i/jpLZaZvimjH2kTVVBZmAz7r/5rpAN9qRdx5kYSUa
   i4sTa7DUp8fsg48qTMRGLPyX6yHhUzTV8QcSX5B8mX4rVarYOUuFc5eVu
   M6SxBY4IDqCGZWcsm+iVOOxC6+VOjSg5ztDZP/EiyEyOqJ0Sv+PKDMbuq
   oKUIF/1zdK5r3GKkDCuJVzwvcPgTLB3tHJYUQDnOcQjRz5IJ505HRIEMR
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="375205947"
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="375205947"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 01:15:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="727964734"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 30 Jul 2022 01:15:57 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHhdc-000CdU-1v;
        Sat, 30 Jul 2022 08:15:56 +0000
Date:   Sat, 30 Jul 2022 16:14:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [staging:staging-testing 54/54]
 drivers/staging/r8188eu/core/rtw_pwrctrl.c:400:6: warning: variable 'ret' is
 used uninitialized whenever 'if' condition is false
Message-ID: <202207301623.BfMKLfhv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git staging-testing
head:   f3a76018dd55d8ddcd28cb47049f46ae5c0ce557
commit: f3a76018dd55d8ddcd28cb47049f46ae5c0ce557 [54/54] staging: r8188eu: remove initializer from ret in rtw_pwr_wakeup
config: hexagon-randconfig-r015-20220729 (https://download.01.org/0day-ci/archive/20220730/202207301623.BfMKLfhv-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?id=f3a76018dd55d8ddcd28cb47049f46ae5c0ce557
        git remote add staging https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
        git fetch --no-tags staging staging-testing
        git checkout f3a76018dd55d8ddcd28cb47049f46ae5c0ce557
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/staging/r8188eu/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/staging/r8188eu/core/rtw_pwrctrl.c:400:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (padapter->bDriverStopped || !padapter->bup || !padapter->hw_init_completed) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/r8188eu/core/rtw_pwrctrl.c:409:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/staging/r8188eu/core/rtw_pwrctrl.c:400:2: note: remove the 'if' if its condition is always true
           if (padapter->bDriverStopped || !padapter->bup || !padapter->hw_init_completed) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/r8188eu/core/rtw_pwrctrl.c:384:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   1 warning generated.


vim +400 drivers/staging/r8188eu/core/rtw_pwrctrl.c

15865124feed88 Phillip Potter  2021-07-28  376  
57c27d38ff9379 Michael Straube 2022-04-03  377  /* Wake the NIC up from: 1)IPS 2)USB autosuspend */
719cf66c8a2b06 Michael Straube 2022-04-03  378  int rtw_pwr_wakeup(struct adapter *padapter)
15865124feed88 Phillip Potter  2021-07-28  379  {
15865124feed88 Phillip Potter  2021-07-28  380  	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
15865124feed88 Phillip Potter  2021-07-28  381  	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
3b9d0da6aa08a3 Martin Kaiser   2022-04-13  382  	unsigned long timeout = jiffies + msecs_to_jiffies(3000);
1dd0ac70494c1d Martin Kaiser   2022-04-13  383  	unsigned long deny_time;
f3a76018dd55d8 Phillip Potter  2022-07-29  384  	int ret;
15865124feed88 Phillip Potter  2021-07-28  385  
3b9d0da6aa08a3 Martin Kaiser   2022-04-13  386  	while (pwrpriv->ps_processing && time_before(jiffies, timeout))
d21edee5a4276b Larry Finger    2021-08-05  387  		msleep(10);
15865124feed88 Phillip Potter  2021-07-28  388  
15865124feed88 Phillip Potter  2021-07-28  389  	/* I think this should be check in IPS, LPS, autosuspend functions... */
15865124feed88 Phillip Potter  2021-07-28  390  	if (check_fwstate(pmlmepriv, _FW_LINKED)) {
2b5002e2cc1483 Phillip Potter  2022-07-25  391  		ret = 0;
15865124feed88 Phillip Potter  2021-07-28  392  		goto exit;
15865124feed88 Phillip Potter  2021-07-28  393  	}
294e69c69c4d4a Martin Kaiser   2022-04-13  394  
294e69c69c4d4a Martin Kaiser   2022-04-13  395  	if (pwrpriv->rf_pwrstate == rf_off && ips_leave(padapter) == _FAIL) {
2b5002e2cc1483 Phillip Potter  2022-07-25  396  		ret = -ENOMEM;
15865124feed88 Phillip Potter  2021-07-28  397  		goto exit;
15865124feed88 Phillip Potter  2021-07-28  398  	}
15865124feed88 Phillip Potter  2021-07-28  399  
a9f136fa7e67fd Martin Kaiser   2022-04-13 @400  	if (padapter->bDriverStopped || !padapter->bup || !padapter->hw_init_completed) {
2b5002e2cc1483 Phillip Potter  2022-07-25  401  		ret = -EBUSY;
15865124feed88 Phillip Potter  2021-07-28  402  		goto exit;
15865124feed88 Phillip Potter  2021-07-28  403  	}
15865124feed88 Phillip Potter  2021-07-28  404  
15865124feed88 Phillip Potter  2021-07-28  405  exit:
1dd0ac70494c1d Martin Kaiser   2022-04-13  406  	deny_time = jiffies + msecs_to_jiffies(RTW_PWR_STATE_CHK_INTERVAL);
1dd0ac70494c1d Martin Kaiser   2022-04-13  407  	if (time_before(pwrpriv->ips_deny_time, deny_time))
1dd0ac70494c1d Martin Kaiser   2022-04-13  408  		pwrpriv->ips_deny_time = deny_time;
15865124feed88 Phillip Potter  2021-07-28  409  	return ret;
15865124feed88 Phillip Potter  2021-07-28  410  }
15865124feed88 Phillip Potter  2021-07-28  411  

:::::: The code at line 400 was first introduced by commit
:::::: a9f136fa7e67fdef97ad6c4be5f04f60ad78b5f3 staging: r8188eu: make return values consistent

:::::: TO: Martin Kaiser <martin@kaiser.cx>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

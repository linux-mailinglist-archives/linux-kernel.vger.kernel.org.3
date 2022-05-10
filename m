Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9296F520EEF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 09:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237222AbiEJHsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 03:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237952AbiEJHrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 03:47:05 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16A1E732D
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 00:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652168587; x=1683704587;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SHaG7t37QKOZYLf/zhZyr1RLSxEVuMN/GSFyutKANt0=;
  b=b80YXAKsCQTIHqthPwITHj0HdYYlCzd6TmWmRS94qdy2Z68voKQQRnfJ
   YKFrTZi+6oywmXwCfldHSkvvdzzipKIWe1YmLrl2SMrC6WO6dnJ8hojnU
   6qhd+uN8MMsJEuEae1kaBpN1RoAYEP01xSnpBdo/5ZUw66czp4PHHIm1S
   R7ATCQm5iNigGRw2bi5XySZzIbDPkZvx8B8IUy3v//fNd5OkHcgWHcTxv
   qm2LT4Oxv2ajaoKvLLFRiQOXwDRtPxdJx6hq4QVBFhBET9sJwnsPcJNWD
   cFWLjVymkvfLUjEMnOO+Thf+7ffnXTl70vFwmXbzwiArDrqgWi5JQgx/6
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="249196276"
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="249196276"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 00:43:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="602346135"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 10 May 2022 00:43:02 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noKWM-000HUc-4m;
        Tue, 10 May 2022 07:43:02 +0000
Date:   Tue, 10 May 2022 15:42:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Jason Ekstrand <jason@jlekstrand.net>,
        Sean Paul <seanpaul@chromium.org>,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>
Subject: [jsarha:topic/cros-sof-v4.19 1074/6555]
 drivers/gpu/drm/drm_syncobj.c:125:6: warning: no previous prototype for
 function 'drm_syncobj_add_callback'
Message-ID: <202205101535.GWoZC8wP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jsarha/linux topic/cros-sof-v4.19
head:   d7a3e91d8d16d1ef8653deec5a1fffc4de034a0c
commit: 8e82fa1ed837aefa829a82894a950e7abc393536 [1074/6555] UPSTREAM: drm/syncobj: Drop add/remove_callback from driver interface
config: x86_64-randconfig-a003-20220509 (https://download.01.org/0day-ci/archive/20220510/202205101535.GWoZC8wP-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 18dd123c56754edf62c7042dcf23185c3727610f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jsarha/linux/commit/8e82fa1ed837aefa829a82894a950e7abc393536
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/cros-sof-v4.19
        git checkout 8e82fa1ed837aefa829a82894a950e7abc393536
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/drm_syncobj.c:125:6: warning: no previous prototype for function 'drm_syncobj_add_callback' [-Wmissing-prototypes]
   void drm_syncobj_add_callback(struct drm_syncobj *syncobj,
        ^
   drivers/gpu/drm/drm_syncobj.c:125:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void drm_syncobj_add_callback(struct drm_syncobj *syncobj,
   ^
   static 
>> drivers/gpu/drm/drm_syncobj.c:134:6: warning: no previous prototype for function 'drm_syncobj_remove_callback' [-Wmissing-prototypes]
   void drm_syncobj_remove_callback(struct drm_syncobj *syncobj,
        ^
   drivers/gpu/drm/drm_syncobj.c:134:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void drm_syncobj_remove_callback(struct drm_syncobj *syncobj,
   ^
   static 
   2 warnings generated.


vim +/drm_syncobj_add_callback +125 drivers/gpu/drm/drm_syncobj.c

e7aca5031a2fb5 Jason Ekstrand 2017-08-25  124  
9c19fb10a5893d Jason Ekstrand 2017-08-28 @125  void drm_syncobj_add_callback(struct drm_syncobj *syncobj,
9c19fb10a5893d Jason Ekstrand 2017-08-28  126  			      struct drm_syncobj_cb *cb,
9c19fb10a5893d Jason Ekstrand 2017-08-28  127  			      drm_syncobj_func_t func)
9c19fb10a5893d Jason Ekstrand 2017-08-28  128  {
9c19fb10a5893d Jason Ekstrand 2017-08-28  129  	spin_lock(&syncobj->lock);
9c19fb10a5893d Jason Ekstrand 2017-08-28  130  	drm_syncobj_add_callback_locked(syncobj, cb, func);
9c19fb10a5893d Jason Ekstrand 2017-08-28  131  	spin_unlock(&syncobj->lock);
9c19fb10a5893d Jason Ekstrand 2017-08-28  132  }
9c19fb10a5893d Jason Ekstrand 2017-08-28  133  
9c19fb10a5893d Jason Ekstrand 2017-08-28 @134  void drm_syncobj_remove_callback(struct drm_syncobj *syncobj,
9c19fb10a5893d Jason Ekstrand 2017-08-28  135  				 struct drm_syncobj_cb *cb)
9c19fb10a5893d Jason Ekstrand 2017-08-28  136  {
9c19fb10a5893d Jason Ekstrand 2017-08-28  137  	spin_lock(&syncobj->lock);
9c19fb10a5893d Jason Ekstrand 2017-08-28  138  	list_del_init(&cb->node);
9c19fb10a5893d Jason Ekstrand 2017-08-28  139  	spin_unlock(&syncobj->lock);
9c19fb10a5893d Jason Ekstrand 2017-08-28  140  }
9c19fb10a5893d Jason Ekstrand 2017-08-28  141  

:::::: The code at line 125 was first introduced by commit
:::::: 9c19fb10a5893d6501df4d0fb93d954d5fc1d91b drm/syncobj: Add a callback mechanism for replace_fence (v3)

:::::: TO: Jason Ekstrand <jason@jlekstrand.net>
:::::: CC: Dave Airlie <airlied@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

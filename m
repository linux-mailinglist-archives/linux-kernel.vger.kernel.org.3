Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C655060F8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240629AbiDSAdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237339AbiDSAdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:33:51 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557DD252BB
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650328270; x=1681864270;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nws54ezawM9bqSqbX5zehME3Uk2VbZrkK2PxaNuWODY=;
  b=fRGzxiWJxgHE3Lz0mDbgbDYktQ1ncmAatxY34ZA7om/ul5XWYyRKWPlX
   G8hoZ5tqWp2Q76rzVb7z3xOpfq2mvsUKFZ7qFCTGJDEa1HW4JeWQdxs6D
   NuLkTVgXr6ekvk5Udd/CDv9JDcXKojg/uN1+UhgXjtUp7JM2l0JdjSLuN
   YXMOOH4n0JFOYnz1tPrfREO6q7hplaLwhlYCiThMxAtXjYReG9X6ygukA
   /K5CpdHfi6bImxTgJFZ/vppSfb0GWlyrxT2gwCELdB0z6Vw6LkOHoDiiV
   9zQ3zjejxGtpP6dN4wRaOEH+Ww4APvuhqV1kMFRk1f/y8EehX0bsyNndF
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="263102647"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="263102647"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 17:31:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="702001891"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 18 Apr 2022 17:31:08 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngblr-00057s-O7;
        Tue, 19 Apr 2022 00:31:07 +0000
Date:   Tue, 19 Apr 2022 08:30:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1591/2356]
 drivers/gpu/drm/dp/drm_dp_aux_bus.c:224:10: warning: incompatible integer to
 pointer conversion assigning to 'struct dp_aux_ep_device *' from 'int'
Message-ID: <202204190823.7G1aai7b-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   af93551cf39027d176f30b9beafc60a4c130998a
commit: 97285b3fe2fe8e0e139fea227831531395c3007d [1591/2356] headers/deps: ftrace: Optimize the <linux/ftrace.h> header dependencies
config: i386-randconfig-a011-20220418 (https://download.01.org/0day-ci/archive/20220419/202204190823.7G1aai7b-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 429cbac0390654f90bba18a41799464adf31a5ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=97285b3fe2fe8e0e139fea227831531395c3007d
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 97285b3fe2fe8e0e139fea227831531395c3007d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/bus/mhi/host/ drivers/gpu/drm/bridge/ drivers/gpu/drm/dp/ drivers/md/bcache/ drivers/media/tuners/ drivers/peci/ drivers/power/supply/ drivers/regulator/ drivers/rpmsg/ fs/pstore/ fs/ubifs/ fs/xfs/ net/bpf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/dp/drm_dp_aux_bus.c:128:2: error: implicit declaration of function 'kfree' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           kfree(to_dp_aux_ep_dev(dev));
           ^
   drivers/gpu/drm/dp/drm_dp_aux_bus.c:128:2: note: did you mean 'kvfree'?
   include/linux/rcutiny.h:41:13: note: 'kvfree' declared here
   extern void kvfree(const void *addr);
               ^
   drivers/gpu/drm/dp/drm_dp_aux_bus.c:224:12: error: implicit declaration of function 'kzalloc' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   aux_ep = kzalloc(sizeof(*aux_ep), GFP_KERNEL);
                            ^
>> drivers/gpu/drm/dp/drm_dp_aux_bus.c:224:10: warning: incompatible integer to pointer conversion assigning to 'struct dp_aux_ep_device *' from 'int' [-Wint-conversion]
                   aux_ep = kzalloc(sizeof(*aux_ep), GFP_KERNEL);
                          ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning and 2 errors generated.


vim +224 drivers/gpu/drm/dp/drm_dp_aux_bus.c

aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  181  
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  182  /**
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  183   * of_dp_aux_populate_ep_devices() - Populate the endpoint devices on the DP AUX
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  184   * @aux: The AUX channel whose devices we want to populate. It is required that
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  185   *       drm_dp_aux_init() has already been called for this AUX channel.
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  186   *
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  187   * This will populate all the devices under the "aux-bus" node of the device
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  188   * providing the AUX channel (AKA aux->dev).
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  189   *
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  190   * When this function finishes, it is _possible_ (but not guaranteed) that
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  191   * our sub-devices will have finished probing. It should be noted that if our
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  192   * sub-devices return -EPROBE_DEFER that we will not return any error codes
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  193   * ourselves but our sub-devices will _not_ have actually probed successfully
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  194   * yet. There may be other cases (maybe added in the future?) where sub-devices
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  195   * won't have been probed yet when this function returns, so it's best not to
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  196   * rely on that.
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  197   *
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  198   * If this function succeeds you should later make sure you call
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  199   * of_dp_aux_depopulate_ep_devices() to undo it, or just use the devm version
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  200   * of this function.
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  201   *
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  202   * Return: 0 if no error or negative error code.
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  203   */
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  204  int of_dp_aux_populate_ep_devices(struct drm_dp_aux *aux)
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  205  {
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  206  	struct device_node *bus, *np;
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  207  	struct dp_aux_ep_device *aux_ep;
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  208  	int ret;
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  209  
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  210  	/* drm_dp_aux_init() should have been called already; warn if not */
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  211  	WARN_ON_ONCE(!aux->ddc.algo);
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  212  
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  213  	if (!aux->dev->of_node)
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  214  		return 0;
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  215  
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  216  	bus = of_get_child_by_name(aux->dev->of_node, "aux-bus");
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  217  	if (!bus)
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  218  		return 0;
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  219  
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  220  	for_each_available_child_of_node(bus, np) {
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  221  		if (of_node_test_and_set_flag(np, OF_POPULATED))
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  222  			continue;
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  223  
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11 @224  		aux_ep = kzalloc(sizeof(*aux_ep), GFP_KERNEL);
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  225  		if (!aux_ep)
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  226  			continue;
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  227  		aux_ep->aux = aux;
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  228  
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  229  		aux_ep->dev.parent = aux->dev;
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  230  		aux_ep->dev.bus = &dp_aux_bus_type;
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  231  		aux_ep->dev.type = &dp_aux_device_type_type;
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  232  		aux_ep->dev.of_node = of_node_get(np);
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  233  		dev_set_name(&aux_ep->dev, "aux-%s", dev_name(aux->dev));
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  234  
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  235  		ret = device_register(&aux_ep->dev);
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  236  		if (ret) {
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  237  			dev_err(aux->dev, "Failed to create AUX EP for %pOF: %d\n", np, ret);
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  238  			of_node_clear_flag(np, OF_POPULATED);
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  239  			of_node_put(np);
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  240  
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  241  			/*
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  242  			 * As per docs of device_register(), call this instead
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  243  			 * of kfree() directly for error cases.
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  244  			 */
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  245  			put_device(&aux_ep->dev);
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  246  
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  247  			/*
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  248  			 * Following in the footsteps of of_i2c_register_devices(),
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  249  			 * we won't fail the whole function here--we'll just
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  250  			 * continue registering any other devices we find.
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  251  			 */
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  252  		}
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  253  	}
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  254  
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  255  	of_node_put(bus);
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  256  
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  257  	return 0;
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  258  }
aeb33699fc2c97 drivers/gpu/drm/drm_dp_aux_bus.c Douglas Anderson 2021-06-11  259  

:::::: The code at line 224 was first introduced by commit
:::::: aeb33699fc2c97994de0e9acb74d0fd319380614 drm: Introduce the DP AUX bus

:::::: TO: Douglas Anderson <dianders@chromium.org>
:::::: CC: Douglas Anderson <dianders@chromium.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

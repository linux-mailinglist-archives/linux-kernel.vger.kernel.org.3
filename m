Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A78E557363
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 08:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiFWG7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 02:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiFWG7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 02:59:22 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994B144A2A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 23:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655967561; x=1687503561;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fWC+lL2LEU6kqh6kHb4cW7RSZrHKc+QgjRWTdAXjaO0=;
  b=N096uP7wdEDxHvzkhlu2KcRsUSlFC2iT5Yvh8ck17lPSlWCPUMIvUugO
   TVF2t+zWoznoba55dm2x1sMb2wHWSROM18Qow+Bhnmia3JW7HIGGbydSk
   YQL+Hha7ySwf8+U4NC4s3ps8dwODwLtLxwwXTZN8cJQin+57e1JXXsDbz
   DmG/CvFnJlOlbOQr6eQ53XlAp+eVvMrhoOBmls/rOF36qCWR/VlFVBdYo
   S3KSKQGMaOiGIYUU8KGccIs8zx+4Ak9AbxRHRds6S3FC2g+LBHtgDnjOP
   m9eyjsKgA+Ce/a4cgv95bx45HS6x4R6fUOeu9wlw86V4JWwTQqLysYZUB
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="344634005"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="344634005"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 23:59:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="615472687"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 22 Jun 2022 23:59:20 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4GoB-0000p9-Lj;
        Thu, 23 Jun 2022 06:59:19 +0000
Date:   Thu, 23 Jun 2022 14:58:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kbingham-rcar:kbingham/drm-misc/next/sn65dsi86/hpd 9/21]
 drivers/gpu/drm/bridge/ti-sn65dsi86.c:736:1: warning: label 'err_conn_init'
 defined but not used
Message-ID: <202206231409.6ArVuVUs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kbingham/rcar.git kbingham/drm-misc/next/sn65dsi86/hpd
head:   69c67e7d89e9e68e6ffb17deec7112af1d529ac9
commit: 89cc7f4771cdaa89ba193c12722fd330b4d5d34c [9/21] squash: drm/bridge: ti-sn65dsi86: Add NO_CONNECTOR support
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20220623/202206231409.6ArVuVUs-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/kbingham/rcar.git/commit/?id=89cc7f4771cdaa89ba193c12722fd330b4d5d34c
        git remote add kbingham-rcar https://git.kernel.org/pub/scm/linux/kernel/git/kbingham/rcar.git
        git fetch --no-tags kbingham-rcar kbingham/drm-misc/next/sn65dsi86/hpd
        git checkout 89cc7f4771cdaa89ba193c12722fd330b4d5d34c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/drm/bridge/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/bridge/ti-sn65dsi86.c: In function 'ti_sn_bridge_attach':
>> drivers/gpu/drm/bridge/ti-sn65dsi86.c:736:1: warning: label 'err_conn_init' defined but not used [-Wunused-label]
     736 | err_conn_init:
         | ^~~~~~~~~~~~~


vim +/err_conn_init +736 drivers/gpu/drm/bridge/ti-sn65dsi86.c

c3b75d4734cb82 Maxime Ripard    2021-10-25  695  
c3b75d4734cb82 Maxime Ripard    2021-10-25  696  static int ti_sn_bridge_attach(struct drm_bridge *bridge,
c3b75d4734cb82 Maxime Ripard    2021-10-25  697  			       enum drm_bridge_attach_flags flags)
c3b75d4734cb82 Maxime Ripard    2021-10-25  698  {
c3b75d4734cb82 Maxime Ripard    2021-10-25  699  	struct ti_sn65dsi86 *pdata = bridge_to_ti_sn65dsi86(bridge);
c3b75d4734cb82 Maxime Ripard    2021-10-25  700  	int ret;
c3b75d4734cb82 Maxime Ripard    2021-10-25  701  
c3b75d4734cb82 Maxime Ripard    2021-10-25  702  	pdata->aux.drm_dev = bridge->dev;
c3b75d4734cb82 Maxime Ripard    2021-10-25  703  	ret = drm_dp_aux_register(&pdata->aux);
c3b75d4734cb82 Maxime Ripard    2021-10-25  704  	if (ret < 0) {
c3b75d4734cb82 Maxime Ripard    2021-10-25  705  		drm_err(bridge->dev, "Failed to register DP AUX channel: %d\n", ret);
c3b75d4734cb82 Maxime Ripard    2021-10-25  706  		return ret;
c3b75d4734cb82 Maxime Ripard    2021-10-25  707  	}
c3b75d4734cb82 Maxime Ripard    2021-10-25  708  
89cc7f4771cdaa Kieran Bingham   2022-03-09  709  	/*
89cc7f4771cdaa Kieran Bingham   2022-03-09  710  	 * Attach the next bridge We never want the next bridge to *also* create
89cc7f4771cdaa Kieran Bingham   2022-03-09  711  	 * a connector:
89cc7f4771cdaa Kieran Bingham   2022-03-09  712  	 */
4e5763f03e105f Laurent Pinchart 2021-06-24  713  	ret = drm_bridge_attach(bridge->encoder, pdata->next_bridge,
89cc7f4771cdaa Kieran Bingham   2022-03-09  714  				&pdata->bridge,
89cc7f4771cdaa Kieran Bingham   2022-03-09  715  				flags | DRM_BRIDGE_ATTACH_NO_CONNECTOR);
4e5763f03e105f Laurent Pinchart 2021-06-24  716  	if (ret < 0)
e283820cbf8092 Douglas Anderson 2022-02-04  717  		goto err_initted_aux;
e283820cbf8092 Douglas Anderson 2022-02-04  718  
89cc7f4771cdaa Kieran Bingham   2022-03-09  719  	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
89cc7f4771cdaa Kieran Bingham   2022-03-09  720  		return 0;
89cc7f4771cdaa Kieran Bingham   2022-03-09  721  
e283820cbf8092 Douglas Anderson 2022-02-04  722  	pdata->connector = drm_bridge_connector_init(pdata->bridge.dev,
e283820cbf8092 Douglas Anderson 2022-02-04  723  						     pdata->bridge.encoder);
e283820cbf8092 Douglas Anderson 2022-02-04  724  	if (IS_ERR(pdata->connector)) {
e283820cbf8092 Douglas Anderson 2022-02-04  725  		ret = PTR_ERR(pdata->connector);
e283820cbf8092 Douglas Anderson 2022-02-04  726  		goto err_initted_aux;
e283820cbf8092 Douglas Anderson 2022-02-04  727  	}
e283820cbf8092 Douglas Anderson 2022-02-04  728  
e283820cbf8092 Douglas Anderson 2022-02-04  729  	drm_connector_attach_encoder(pdata->connector, pdata->bridge.encoder);
4e5763f03e105f Laurent Pinchart 2021-06-24  730  
a095f15c00e278 Sandeep Panda    2018-07-20  731  	return 0;
a095f15c00e278 Sandeep Panda    2018-07-20  732  
e283820cbf8092 Douglas Anderson 2022-02-04  733  err_initted_aux:
b7f228f9db56bd Rob Clark        2022-02-06  734  	if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR))
89cc7f4771cdaa Kieran Bingham   2022-03-09  735  		drm_connector_cleanup(pdata->connector);
b7f228f9db56bd Rob Clark        2022-02-06 @736  err_conn_init:
61712618753032 Lyude Paul       2021-02-19  737  	drm_dp_aux_unregister(&pdata->aux);
a095f15c00e278 Sandeep Panda    2018-07-20  738  	return ret;
a095f15c00e278 Sandeep Panda    2018-07-20  739  }
a095f15c00e278 Sandeep Panda    2018-07-20  740  

:::::: The code at line 736 was first introduced by commit
:::::: b7f228f9db56bde6efec21c3e30d620c430236e5 drm/bridge: ti-sn65dsi86: Add NO_CONNECTOR support

:::::: TO: Rob Clark <robdclark@chromium.org>
:::::: CC: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

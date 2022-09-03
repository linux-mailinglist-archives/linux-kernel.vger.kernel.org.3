Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66485ABF26
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 15:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbiICNmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 09:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiICNmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 09:42:38 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A02D57E2A
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 06:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662212558; x=1693748558;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JWXBYi6wj7UanpONosxU3VdonLafP0dX8CcdOCc9KnY=;
  b=XYnihnSKSj9+p+3bbFktZsOXxfnwYLxGVjYn7RnIGXFBoFuH3Qu/jBGt
   MJHOXeWY14KiiQd6+whtlCfnfqigDoKb/5IZhNQYLJW/vijA/AmWV/1Hl
   ykpVza7JLf9vRbC+z2OOdyMxF9bkhzg8h6prf/wnaT0huXuaekriUDojA
   uSUt+ngsMoJVGqKgIxA7EoQgPTFzB5IuSXOgifNcQIiG/yd3tQQpvdouh
   cALa9DId4asaH0q0utJsRoTcKQGmlyHQUx5aOWl1AvFWAzfxIiWCP4/pd
   YmOquMZURblWrBQVxOPowkI/iY37tzGa46GZtiOIZiyJlDGpAuAQ/9XtV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="297453892"
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="297453892"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 06:42:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="564257424"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 03 Sep 2022 06:42:36 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUTPv-0001iV-2j;
        Sat, 03 Sep 2022 13:42:35 +0000
Date:   Sat, 3 Sep 2022 21:42:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Steev Klimaszewski <steev@kali.org>
Subject: [steev:c630-6.0.0-rc3 55/94] drivers/soc/qcom/pmic_glink.c:200:34:
 warning: 'pmic_glink_of_match' defined but not used
Message-ID: <202209032155.zm12fhX7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/steev/linux c630-6.0.0-rc3
head:   012f3cdd2a60528b877305877b52135b0076e028
commit: 20a897f2e309490859a53e4627b72227768dcd84 [55/94] soc: qcom: pmic_glink: Introduce base PMIC GLINK driver
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220903/202209032155.zm12fhX7-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/steev/linux/commit/20a897f2e309490859a53e4627b72227768dcd84
        git remote add steev https://github.com/steev/linux
        git fetch --no-tags steev c630-6.0.0-rc3
        git checkout 20a897f2e309490859a53e4627b72227768dcd84
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/soc/qcom/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/soc/qcom/pmic_glink.c:200:34: warning: 'pmic_glink_of_match' defined but not used [-Wunused-const-variable=]
     200 | static const struct of_device_id pmic_glink_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~


vim +/pmic_glink_of_match +200 drivers/soc/qcom/pmic_glink.c

   199	
 > 200	static const struct of_device_id pmic_glink_of_match[] = {
   201		{ .compatible = "qcom,pmic-glink", },
   202		{}
   203	};
   204	MODULE_DEVICE_TABLE(of, pmic_glink_of_match);
   205	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9C34C8F2F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbiCAPgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbiCAPgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:36:08 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C313A94C7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 07:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646148927; x=1677684927;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7VsJK1X3C2AZhqBg1w2nTjKQFwowVApnFt7DX9FwtCA=;
  b=XZBve0MWO0FkZ3sycp9ovh2TuM6eu85xgXLUNEpNxh/GNm38/g3GLjKE
   UUcuvk1+IqTr8rDymmE2BsTrnluyA4OTeIZ3pqqokJ2yOEjZEpsNvULec
   cHA50aXhxDIUt+oBQ25hKoc3zqAIN9s4mO4pPr+J4TOFD891qI1gN2F6D
   BH6dcIg0hI30nGvhzVce8POyNyWKxNxN0wDBu3AB12zmZEcaIcGej2L35
   zsfn+tOQxfL8+1T42Tm9W61IpEPQSpjHuOWWdVIyn0IRZey5CAGDlCNzz
   1Qe0xaOnHXwIzjMCAzlAW117f+SnKyFeRezHwRXVXcWR163+gdXoOp66w
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="236663377"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="236663377"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 07:35:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="493144449"
Received: from lkp-server01.sh.intel.com (HELO 2146afe809fb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 01 Mar 2022 07:35:25 -0800
Received: from kbuild by 2146afe809fb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nP4X6-0000cu-FJ; Tue, 01 Mar 2022 15:35:24 +0000
Date:   Tue, 1 Mar 2022 23:34:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hemant Kumar <hemantk@codeaurora.org>,
        Alex Elder <elder@linaro.org>
Subject: [mani-mhi:mhi-next 12/30] drivers/bus/mhi/host/../common.h:278:15:
 warning: type qualifiers ignored on function return type
Message-ID: <202203012357.0m19fbpl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git mhi-next
head:   b85d0d28ed263a5421f698d5c7bd513c7b6d8b97
commit: ed97144182117586712c8036ded0bab36898eae0 [12/30] bus: mhi: Make mhi_state_str[] array static inline and move to common.h
config: arc-randconfig-r043-20220301 (https://download.01.org/0day-ci/archive/20220301/202203012357.0m19fbpl-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git/commit/?id=ed97144182117586712c8036ded0bab36898eae0
        git remote add mani-mhi https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git
        git fetch --no-tags mani-mhi mhi-next
        git checkout ed97144182117586712c8036ded0bab36898eae0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/bus/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/bus/mhi/host/internal.h:10,
                    from drivers/bus/mhi/host/init.c:21:
>> drivers/bus/mhi/host/../common.h:278:15: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
     278 | static inline const char * const mhi_state_str(enum mhi_state state)
         |               ^~~~~


vim +278 drivers/bus/mhi/host/../common.h

   277	
 > 278	static inline const char * const mhi_state_str(enum mhi_state state)
   279	{
   280		switch (state) {
   281		case MHI_STATE_RESET:
   282			return "RESET";
   283		case MHI_STATE_READY:
   284			return "READY";
   285		case MHI_STATE_M0:
   286			return "M0";
   287		case MHI_STATE_M1:
   288			return "M1";
   289		case MHI_STATE_M2:
   290			return "M2";
   291		case MHI_STATE_M3:
   292			return "M3";
   293		case MHI_STATE_M3_FAST:
   294			return "M3 FAST";
   295		case MHI_STATE_BHI:
   296			return "BHI";
   297		case MHI_STATE_SYS_ERR:
   298			return "SYS ERROR";
   299		default:
   300			return "Unknown state";
   301		}
   302	};
   303	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

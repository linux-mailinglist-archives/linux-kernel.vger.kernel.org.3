Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72834C902C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 17:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236179AbiCAQTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 11:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbiCAQTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 11:19:08 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA972395
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 08:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646151507; x=1677687507;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=99PDWrnZC+94sUm2Of52rgGL0LZDuPgk1v8mjahoKLg=;
  b=ZJcTBsN449oG2niAyU11jay6LomfU2wkoFk4i8QRqPkUbz+xnUR3MUdW
   R9Qbcmhq3YBMNWqnSgQfRkHSVLSouJFYXj2sJ3IB5XcuUDwo5SphG0HmN
   GCtKbA3JlEjGJVmHbXZaHL7jJ8R3RRN8eR2I7EI0F0oR2mcm0f2FSqYar
   jmzEC8DifFAd0R7ZGnSd8VKmks45D8ZuCBIyXhXtyhI85OuyAw61cpcDJ
   bMd5LxrVyc/ZqJVlPLfqTwhpH0xgWTqcBiTSXceEEdRkDzs6woWQNkHMi
   bpLl1MAl1/zE1t69aEczSduh4xsfnggr+wZ9aYii2etr2E5Bf3UYighGo
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="250749783"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="250749783"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 08:17:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="493160719"
Received: from lkp-server01.sh.intel.com (HELO 2146afe809fb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 01 Mar 2022 08:17:42 -0800
Received: from kbuild by 2146afe809fb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nP5C1-0000h9-Ub; Tue, 01 Mar 2022 16:17:41 +0000
Date:   Wed, 2 Mar 2022 00:16:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Hemant Kumar <hemantk@codeaurora.org>,
        Alex Elder <elder@linaro.org>
Subject: [mani-mhi:mhi-next 12/30] drivers/bus/mhi/host/../common.h:278:28:
 warning: 'const' type qualifier on return type has no effect
Message-ID: <202203020002.8Of9vVDg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git mhi-next
head:   b85d0d28ed263a5421f698d5c7bd513c7b6d8b97
commit: ed97144182117586712c8036ded0bab36898eae0 [12/30] bus: mhi: Make mhi_state_str[] array static inline and move to common.h
config: hexagon-randconfig-r036-20220301 (https://download.01.org/0day-ci/archive/20220302/202203020002.8Of9vVDg-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git/commit/?id=ed97144182117586712c8036ded0bab36898eae0
        git remote add mani-mhi https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git
        git fetch --no-tags mani-mhi mhi-next
        git checkout ed97144182117586712c8036ded0bab36898eae0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/bus/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/bus/mhi/host/init.c:21:
   In file included from drivers/bus/mhi/host/internal.h:10:
>> drivers/bus/mhi/host/../common.h:278:28: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
   static inline const char * const mhi_state_str(enum mhi_state state)
                              ^~~~~~
   1 warning generated.


vim +/const +278 drivers/bus/mhi/host/../common.h

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

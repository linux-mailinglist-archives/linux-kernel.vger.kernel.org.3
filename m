Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366454D5956
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 04:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346120AbiCKD6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 22:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbiCKD6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 22:58:22 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAD71903D4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 19:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646971040; x=1678507040;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2SwiJSRyAjeIu5DCifkzZtQIgyzumqK4hBRfXBQU+YE=;
  b=mF1DGv7iJL+PiBd/2X4+PyaNMN2fay/DhpqNcRC6aISvMu1ofTFpwvks
   REVR4IfKPxGoXXnSQMSn6NE88WJsi9omk4WF1PMsng4fVtUWM3ZXwLduC
   1WVNdiUUxn2sBvdpLxfN1em0TMs2b9fbmu/0Q7Kus2zm0LvmqyoaMW0a4
   jfsPU2XOlEWXjpZ8zRt6Bg986M+KgwVgB8n9ynWGi0m1HJIbBml8ixrjZ
   mzn7MbScrdnIedcEhlI25bEXyK60QuJm9Ip9m3c6VCwznrRIgDVbfTw65
   93AGO+a4y803w5OnNEXtBc/e+DqWNJGavzHHqjm7xV2qoeS3tjk831ahr
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="254321177"
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="254321177"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 19:57:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="712705012"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 10 Mar 2022 19:57:18 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSWOz-0005nG-Ei; Fri, 11 Mar 2022 03:57:17 +0000
Date:   Fri, 11 Mar 2022 11:57:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [andersson:wip/sm8350-next-20211118 38/52]
 drivers/soc/qcom/pmic_glink_pan.c:9:10: fatal error:
 linux/soc/qcom/pmic_glink.h: No such file or directory
Message-ID: <202203111158.Uvr9dlrm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

FYI, the error/warning still remains.

tree:   https://github.com/andersson/kernel wip/sm8350-next-20211118
head:   922cbe415e8e30b48170e281ce8d6a6638056322
commit: af2e40a7c1b6390b42af215ac19c9be35554b397 [38/52] pmic_glink: Initial patch
config: powerpc-randconfig-m031-20211207 (https://download.01.org/0day-ci/archive/20220311/202203111158.Uvr9dlrm-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/andersson/kernel/commit/af2e40a7c1b6390b42af215ac19c9be35554b397
        git remote add andersson https://github.com/andersson/kernel
        git fetch --no-tags andersson wip/sm8350-next-20211118
        git checkout af2e40a7c1b6390b42af215ac19c9be35554b397
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/soc/qcom/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> drivers/soc/qcom/pmic_glink.c:44:26: warning: no previous prototype for 'pmic_glink_register_callback' [-Wmissing-prototypes]
      44 | struct pmic_glink_owner *pmic_glink_register_callback(struct pmic_glink *pg,
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/soc/qcom/pmic_glink.c:67:6: warning: no previous prototype for 'pmic_glink_unregister_callback' [-Wmissing-prototypes]
      67 | void pmic_glink_unregister_callback(struct pmic_glink *pg,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/soc/qcom/pmic_glink.c:76:5: warning: no previous prototype for 'pmic_glink_send' [-Wmissing-prototypes]
      76 | int pmic_glink_send(struct pmic_glink *pg, void *data, size_t len)
         |     ^~~~~~~~~~~~~~~
   drivers/soc/qcom/pmic_glink.c:200:34: warning: 'pmic_glink_of_match' defined but not used [-Wunused-const-variable=]
     200 | static const struct of_device_id pmic_glink_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~
--
>> drivers/soc/qcom/pmic_glink_pan.c:9:10: fatal error: linux/soc/qcom/pmic_glink.h: No such file or directory
       9 | #include <linux/soc/qcom/pmic_glink.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +9 drivers/soc/qcom/pmic_glink_pan.c

     8	
   > 9	#include <linux/soc/qcom/pmic_glink.h>
    10	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

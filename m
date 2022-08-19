Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6455D5992B6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 03:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243552AbiHSBqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 21:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242080AbiHSBqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 21:46:24 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E796D5EB6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 18:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660873584; x=1692409584;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wf/ZznegE7AhnzRxw+yrJEvsq4RrbbZD5gyFoFJ8xL4=;
  b=BAkSSeZmC0uIfhfDeK9ACvYCxiMAbl99RPZsR3jZigzz9DRnYQbw4vsq
   nqc5jpPW+tBGzFh0cNdesE8DesIXartKg3kGvrEUJGMPDXgtRPSgcnzEe
   /MZu1+AFjriSdUPOmHs/VdCG0Q8FJkUYreAM8LjLV34ogCPt7lKKaTlGK
   qHePMRKd4IK85NHuEDh72KtZGyyiDLrLNS4pMwA970tFpTEob6End2kKl
   /N73cYQJxtjTs6L2TIV3y5H6e889o5XTMwY3eyxFiR+F/kMUcp98zYnC0
   89duMi8SIRHAJJaZofXBrrNjr26cfd4Mb5QfNEHvs2IKY3o5TN1FyUvLP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="291667779"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="291667779"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 18:46:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="637074140"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 18 Aug 2022 18:46:22 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOr5Z-0000sr-1S;
        Fri, 19 Aug 2022 01:46:21 +0000
Date:   Fri, 19 Aug 2022 09:45:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Steev Klimaszewski <steev@kali.org>
Subject: [steev:sc8280xp-next-20220818 132/159]
 drivers/soc/qcom/pmic_glink_altmode.c:234:16: error: implicit declaration of
 function 'FIELD_GET'; did you mean 'FOLL_GET'?
Message-ID: <202208190946.98QZtV0a-lkp@intel.com>
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

tree:   https://github.com/steev/linux sc8280xp-next-20220818
head:   34fef0fd022b76178b8c48819465ec265c5aac2e
commit: 7e91d160800c85329a861246e2225a80e0c842ea [132/159] soc: qcom: pmic_glink: Introduce altmode support
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220819/202208190946.98QZtV0a-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/steev/linux/commit/7e91d160800c85329a861246e2225a80e0c842ea
        git remote add steev https://github.com/steev/linux
        git fetch --no-tags steev sc8280xp-next-20220818
        git checkout 7e91d160800c85329a861246e2225a80e0c842ea
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/soc/qcom/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/soc/qcom/pmic_glink_altmode.c: In function 'pmic_glink_altmode_sc8180xp_notify':
>> drivers/soc/qcom/pmic_glink_altmode.c:234:16: error: implicit declaration of function 'FIELD_GET'; did you mean 'FOLL_GET'? [-Werror=implicit-function-declaration]
     234 |         port = FIELD_GET(SC8180X_PORT_MASK, notification);
         |                ^~~~~~~~~
         |                FOLL_GET
>> drivers/soc/qcom/pmic_glink_altmode.c:222:13: warning: variable 'svid' set but not used [-Wunused-but-set-variable]
     222 |         u16 svid;
         |             ^~~~
   cc1: some warnings being treated as errors


vim +234 drivers/soc/qcom/pmic_glink_altmode.c

   212	
   213	static void pmic_glink_altmode_sc8180xp_notify(struct pmic_glink_altmode *altmode,
   214						       const void *data, size_t len)
   215	{
   216		struct pmic_glink_altmode_port *alt_port;
   217		const struct usbc_sc8180x_notify *msg;
   218		u32 notification;
   219		u8 orientation;
   220		u8 hpd_state;
   221		u8 hpd_irq;
 > 222		u16 svid;
   223		u8 port;
   224		u8 mode;
   225		u8 mux;
   226	
   227		if (len != sizeof(*msg)) {
   228			dev_warn(altmode->dev, "invalid length of USBC_NOTIFY indication: %zd\n", len);
   229			return;
   230		}
   231	
   232		msg = data;
   233		notification = le32_to_cpu(msg->notification);
 > 234		port = FIELD_GET(SC8180X_PORT_MASK, notification);
   235		orientation = FIELD_GET(SC8180X_ORIENTATION_MASK, notification);
   236		mux = FIELD_GET(SC8180X_MUX_MASK, notification);
   237		mode = FIELD_GET(SC8180X_MODE_MASK, notification);
   238		hpd_state = FIELD_GET(SC8180X_HPD_STATE_MASK, notification);
   239		hpd_irq = FIELD_GET(SC8180X_HPD_IRQ_MASK, notification);
   240	
   241		svid = mux == 2 ? USB_TYPEC_DP_SID : 0;
   242	
   243		if (!altmode->ports[port].altmode) {
   244			dev_dbg(altmode->dev, "notification on undefined port %d\n", port);
   245			return;
   246		}
   247	
   248		alt_port = &altmode->ports[port];
   249		alt_port->orientation = pmic_glink_altmode_orientation(orientation);
   250		alt_port->svid = mux == 2 ? USB_TYPEC_DP_SID : 0;
   251		alt_port->mode = mode;
   252		alt_port->hpd_state = hpd_state;
   253		alt_port->hpd_irq = hpd_irq;
   254		schedule_work(&alt_port->work);
   255	}
   256	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

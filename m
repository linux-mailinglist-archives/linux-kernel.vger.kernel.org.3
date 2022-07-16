Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCAC577176
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 22:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbiGPU5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 16:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGPU5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 16:57:41 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2441C10E;
        Sat, 16 Jul 2022 13:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658005060; x=1689541060;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6Nvah0OLM5KwyywKP2edlL7JazNGxrlMVyVdA+l9ETE=;
  b=kjtssPG3m1gGbD/KPcS9eZMwUvGEAy/bycC/1ioFHA8jbL21432+AQqi
   QYE+24slqRXU553+QF3gUZtBtlD+TPGJ8GssyhadoEXF97b/zd/BVvVFI
   hxnI/2cn2ssj36omUExPO0ZKuooYgcawKwoFk1OLBr5qqoFCj51ZhEPJc
   3lBZRdc+ZXR1RXr3eEWgVzt+1l/auKfWQk+H7A08ZImThzncEqFh+d2TB
   gpjl8mqRVWxoGIyuG4C5wUyYZ9COGnUGzlM8i7b/EUHlQnJbpqAXyfdBI
   bKRPUfRupBeMIF1PVwwFAuFGJLwZZS6zxSQbYy3cnpY4X3TQ3Pu03K52X
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="287149459"
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="287149459"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 13:57:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="547041215"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 16 Jul 2022 13:57:37 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCor2-000292-NS;
        Sat, 16 Jul 2022 20:57:36 +0000
Date:   Sun, 17 Jul 2022 04:56:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gene Chen <gene.chen.richtek@gmail.com>, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     kbuild-all@lists.01.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        gene_chen@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH 3/3] usb: typec: tcpci_rt1711h: Add compatible with rt1715
Message-ID: <202207170406.z3r8vDPb-lkp@intel.com>
References: <20220715100418.155011-4-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715100418.155011-4-gene.chen.richtek@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gene,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on v5.19-rc6]
[also build test WARNING on linus/master]
[cannot apply to usb/usb-testing next-20220715]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gene-Chen/usb-typec-tcpci_rt1711h-Add-compatible-with-rt1715/20220717-003638
base:    32346491ddf24599decca06190ebca03ff9de7f8
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220717/202207170406.z3r8vDPb-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/694b38f034326c96d5211fc2da10a25f4938cc3b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Gene-Chen/usb-typec-tcpci_rt1711h-Add-compatible-with-rt1715/20220717-003638
        git checkout 694b38f034326c96d5211fc2da10a25f4938cc3b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/usb/typec/tcpm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/usb/typec/tcpm/tcpci_rt1711h.c: In function 'rt1711h_init_cc_params':
>> drivers/usb/typec/tcpm/tcpci_rt1711h.c:181:26: warning: variable 'rxdz_sel' set but not used [-Wunused-but-set-variable]
     181 |         u32 rxdz_en = 0, rxdz_sel = 0;
         |                          ^~~~~~~~


vim +/rxdz_sel +181 drivers/usb/typec/tcpm/tcpci_rt1711h.c

   170	
   171	/*
   172	 * Selects the CC PHY noise filter voltage level according to the current
   173	 * CC voltage level.
   174	 *
   175	 * @param cc_level The CC voltage level for the port's current role
   176	 * @return EC_SUCCESS if writes succeed; failure code otherwise
   177	 */
   178	static inline int rt1711h_init_cc_params(struct rt1711h_chip *chip,
   179		enum typec_cc_status cc1, enum typec_cc_status cc2)
   180	{
 > 181		u32 rxdz_en = 0, rxdz_sel = 0;
   182		int ret;
   183	
   184		if ((cc1 >= TYPEC_CC_RP_1_5 && cc2 < TYPEC_CC_RP_DEF) ||
   185		    (cc2 >= TYPEC_CC_RP_1_5 && cc1 < TYPEC_CC_RP_DEF)) {
   186			if (chip->did == RT1715_DID) {
   187				rxdz_en = 1;
   188				rxdz_sel = 1;
   189			} else {
   190				rxdz_en = 1;
   191				rxdz_sel = 0;
   192			}
   193		} else {
   194			rxdz_en = 0;
   195			rxdz_sel = 1;
   196		}
   197	
   198		ret = regmap_update_bits(chip->data.regmap, RT1711H_RTCTRL18,
   199					 BMCIO_RXDZEN_MASK, rxdz_en);
   200		if (ret < 0)
   201			return ret;
   202	
   203		return regmap_update_bits(chip->data.regmap, RT1711H_RTCTRL4,
   204					  RT1711H_BMCIO_RXDZSEL, rxdz_en);
   205	}
   206	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

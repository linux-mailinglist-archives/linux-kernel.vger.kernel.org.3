Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0B056C7AB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 09:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiGIHVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 03:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGIHVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 03:21:31 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AE466AE9;
        Sat,  9 Jul 2022 00:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657351290; x=1688887290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mK3h89NOmsA9IEWTgtnuN+xw4CIUfxdxOLlCl9s+Q60=;
  b=Jta57/Umvu8Vz5CRHGk1g0bnP+d4b+VfzDUQMNE1km6tdq5j97wXCewn
   VRqfn1wokPZS5KrlhGRWN0477jJd8dXBzzo7zreT5otjMVrfqJG36U9rd
   hdwc/rKDDKyAy7yBB2E+fcXufm7Ioz0kPf5pAPpEXb+UBApo+eWY7uVsn
   0QOtRTT87mJv0M/RUVZbtgoYM5jL9hmc60sZi+Bdcwg6H50AmKOsPSmnI
   Pj6aYlo77wbIG3a+SbCMafjZdLGhtW/s8VBP9MgI+33ajWwv+K5pPanm8
   kbTP8aGI7kDJhRcrvq6lBlEEWKx9ART0TBhdEZvn5ssCR1VBaBWRdUyrB
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="285541959"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="285541959"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 00:21:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="626942379"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 09 Jul 2022 00:21:27 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oA4mN-000OQU-5Q;
        Sat, 09 Jul 2022 07:21:27 +0000
Date:   Sat, 9 Jul 2022 15:21:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xin Ji <xji@analogixsemi.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, bliang@analogixsemi.com,
        qwen@analogixsemi.com, jli@analogixsemi.com,
        Xin Ji <xji@analogixsemi.com>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v14 3/3] usb: typec: anx7411: Add Analogix PD ANX7411
 support
Message-ID: <202207091509.VXtuoiWm-lkp@intel.com>
References: <20220706083433.2415524-3-xji@analogixsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706083433.2415524-3-xji@analogixsemi.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on linus/master v5.19-rc5 next-20220708]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xin-Ji/usb-typec-tcpci-move-tcpci-h-to-include-linux-usb/20220706-163653
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
config: arm-randconfig-s032-20220707 (https://download.01.org/0day-ci/archive/20220709/202207091509.VXtuoiWm-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/6dc890db91c87d455e5a4588fa3c1182dfe2e65a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Xin-Ji/usb-typec-tcpci-move-tcpci-h-to-include-linux-usb/20220706-163653
        git checkout 6dc890db91c87d455e5a4588fa3c1182dfe2e65a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash drivers/usb/typec/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/usb/typec/anx7411.c:295:9: sparse: sparse: cast truncates bits from constant value (1f29 becomes 29)
>> drivers/usb/typec/anx7411.c:297:21: sparse: sparse: cast truncates bits from constant value (7411 becomes 11)

vim +295 drivers/usb/typec/anx7411.c

   293	
   294	static u8 snk_identity[] = {
 > 295		LOBYTE(VID_ANALOGIX), HIBYTE(VID_ANALOGIX), 0x00, 0x82, /* snk_id_hdr */
   296		0x00, 0x00, 0x00, 0x00,                                 /* snk_cert */
 > 297		0x00, 0x00, LOBYTE(PID_ANALOGIX), HIBYTE(PID_ANALOGIX), /* 5snk_ama */
   298	};
   299	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

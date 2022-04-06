Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1427E4F6B6E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 22:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbiDFUax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 16:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234578AbiDFUae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:30:34 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E772B35C056
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 11:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649271211; x=1680807211;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eHCPzuLEPLNJFzg+yjgofv3fkWvATV0iUvebvyap6JA=;
  b=YA8JlQOiQ9qZBNT+nXxC7EzCvNJWV+KTmFFr0pXxuv+TKPnWWcs6CBMK
   oOrGHmuTwdGz7VUqpNYjsX7ZH+k1atjpyY6EIE46v7+nE0UPInBsIwBiL
   ND6IpbMJyopolPMw9OXqmjX/0a08R7uNZDp3mmy9yJHe1zc2We4UPOQba
   bID1i62Zc4Y4YDfyC8j6D9k2hNNMqVSZyAHjEYvhidTJvI/e0sMc8ijzH
   oOUyiC1ytMkJjIKfsMMu5Zl1gUYf88CNYPBz0drtRQvxAZ7dd/DEa2kTL
   YhvfcJV7H4rnKDC211VDUz93o69BOmX9swXD7Ut6ORljsqmB8suR2dkMv
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="286103018"
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="286103018"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 11:53:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="851384654"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 06 Apr 2022 11:53:28 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncAmW-0004ey-88;
        Wed, 06 Apr 2022 18:53:28 +0000
Date:   Thu, 7 Apr 2022 02:53:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Li Jun <jun.li@nxp.com>, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, krzk@kernel.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        frank.li@nxp.com, xu.yang_2@nxp.com
Subject: Re: [PATCH] extcon: ptn5150: add usb role class support
Message-ID: <202204070226.kTAMpspa-lkp@intel.com>
References: <1649238142-27564-1-git-send-email-jun.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649238142-27564-1-git-send-email-jun.li@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on chanwoo-extcon/extcon-next]
[also build test ERROR on v5.18-rc1 next-20220406]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-Jun/extcon-ptn5150-add-usb-role-class-support/20220406-212038
base:   https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git extcon-next
config: parisc-randconfig-r031-20220406 (https://download.01.org/0day-ci/archive/20220407/202204070226.kTAMpspa-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/beb6b76258bb1ae1e371486cd4fe97fee393ac83
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Li-Jun/extcon-ptn5150-add-usb-role-class-support/20220406-212038
        git checkout beb6b76258bb1ae1e371486cd4fe97fee393ac83
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   hppa-linux-ld: drivers/extcon/extcon-ptn5150.o: in function `ptn5150_put_role_sw':
>> (.text+0x20): undefined reference to `usb_role_switch_put'
   hppa-linux-ld: drivers/extcon/extcon-ptn5150.o: in function `ptn5150_check_state':
>> (.text+0xc8): undefined reference to `usb_role_switch_set_role'
>> hppa-linux-ld: (.text+0x11c): undefined reference to `usb_role_switch_set_role'
   hppa-linux-ld: drivers/extcon/extcon-ptn5150.o: in function `ptn5150_irq_work':
   (.text+0x1f4): undefined reference to `usb_role_switch_set_role'
   hppa-linux-ld: drivers/extcon/extcon-ptn5150.o: in function `ptn5150_i2c_probe':
>> (.text+0x4fc): undefined reference to `usb_role_switch_get'
>> hppa-linux-ld: (.text+0x53c): undefined reference to `usb_role_switch_put'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for USB_ROLE_SWITCH
   Depends on USB_SUPPORT
   Selected by
   - EXTCON_PTN5150 && EXTCON && I2C && (GPIOLIB || COMPILE_TEST

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

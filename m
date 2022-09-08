Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2A35B29D7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 01:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiIHXBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 19:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiIHXBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 19:01:38 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5383882D07;
        Thu,  8 Sep 2022 16:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662678097; x=1694214097;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MFXBmJ7gfF/wkmTJSQPdplrbzWvYqllVCnJDUiWo50A=;
  b=Otikuo+C4RZKqivczncfvulWtRcKZNgd5gy3agj9Yi2pjA+1uWgwJZnP
   svWKQx6tTgTNsX42KgkZjFhmJh9ryU1hSpoxtViyfDh2fJ0NklPOQCT24
   SkYO23/L0NnTPAaLL331SGBU9w79K1T377yx5uNpg4xD8yKKOOMBekGQ4
   H+H5NoMW5TvDb8Tx+nuTgTpMNO3GjZyrBjdOagQnGL+ZNsdJy99N82GQF
   KFxGFlubxV1TGBPdbvb+KYDMbxCf5qnCPguWPA2iPV06X5F5bKtZvszdn
   xySiCmu3IRVu8zDmgdVO0FsGnGbM2GOjmrvF+wBEvj1+SWuIbiZ799ddS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="383638507"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="383638507"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 16:01:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="683419761"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 08 Sep 2022 16:01:34 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWQWb-0000PZ-2y;
        Thu, 08 Sep 2022 23:01:33 +0000
Date:   Fri, 9 Sep 2022 07:00:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Duke Du <dukedu83@gmail.com>, jdelvare@suse.com,
        linux@roeck-us.net, corbet@lwn.net, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, fran.hsu@quantatw.com,
        george.hung@quantatw.com, charles.hsu@quantatw.com,
        duke.du@quantatw.com
Subject: Re: [PATCH v4] hwmon: Add driver for the TEXAS TPS546D24 Buck
 Converter.
Message-ID: <202209090609.0lCP8G6F-lkp@intel.com>
References: <1662617599-15270-1-git-send-email-Duke.Du@quantatw.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662617599-15270-1-git-send-email-Duke.Du@quantatw.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Duke,

I love your patch! Perhaps something to improve:

[auto build test WARNING on groeck-staging/hwmon-next]
[also build test WARNING on linus/master v6.0-rc4 next-20220908]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Duke-Du/hwmon-Add-driver-for-the-TEXAS-TPS546D24-Buck-Converter/20220908-141642
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/92b26ac053d4e2673c22de7d93e91b8efbb3d1bb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Duke-Du/hwmon-Add-driver-for-the-TEXAS-TPS546D24-Buck-Converter/20220908-141642
        git checkout 92b26ac053d4e2673c22de7d93e91b8efbb3d1bb
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/hwmon/tps546d24.rst:4: WARNING: Title underline too short.

vim +4 Documentation/hwmon/tps546d24.rst

     2	
     3	Kernel driver tps546d24
   > 4	======================
     5	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

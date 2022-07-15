Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843195758E4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 02:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241201AbiGOAy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 20:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241035AbiGOAy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 20:54:27 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CFA74E07;
        Thu, 14 Jul 2022 17:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657846451; x=1689382451;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fju0Ru0qBGMIRYB31mHEpQT0NkaHTGTKqnhaAAudPPM=;
  b=ibmqRjf1It71WdUkrRLXO8ILC4eVS20DriAHetd7Dx1hG13TmtdhT00r
   leP5M90urNg0D/ANJXLEHAAXyUA54FuLB6+B/UwnLIgF8ne1D+31zzd0f
   ff5ra7QTZe4CZKLcHy2Sa2oo7b9xdCad/CKaJ11uZf9cgxgSWrJxrViIL
   2DArIf8CR5ymQWUu2YbVyM/h6ckb5UYMPpptIUaTKdCseH2Xc0UpHbR5O
   lynuS0TIqEcsTLFjqfdeSZ5a98u5C/gKVJCRFiDbvQhkdcEBfJv9tYCTv
   YQOa8tRIaLqIbhvQx26SwDn6S3PHWnf4f09Lw8MjLLihpynYpUp/DEyu5
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="265459553"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="265459553"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:53:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="923306854"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jul 2022 17:53:53 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oC9aa-0001KH-Ib;
        Fri, 15 Jul 2022 00:53:52 +0000
Date:   Fri, 15 Jul 2022 08:53:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Benjamin Bara <bbara93@gmail.com>, dmitry.torokhov@gmail.com
Cc:     kbuild-all@lists.01.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: Re: [PATCH] Input: tsc2007 - enable GPIO chips that can sleep
Message-ID: <202207150801.7z40LFNI-lkp@intel.com>
References: <20220713084247.3090353-1-bbara93@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713084247.3090353-1-bbara93@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on dtor-input/next]
[also build test WARNING on linus/master v5.19-rc6 next-20220714]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Bara/Input-tsc2007-enable-GPIO-chips-that-can-sleep/20220713-164521
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220715/202207150801.7z40LFNI-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/13455f523263c4e90b5cc8c587ef2be97008ff5f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Benjamin-Bara/Input-tsc2007-enable-GPIO-chips-that-can-sleep/20220713-164521
        git checkout 13455f523263c4e90b5cc8c587ef2be97008ff5f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/input/touchscreen/ sound/soc/codecs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/input/touchscreen/tsc2007_core.c:112:6: warning: no previous prototype for 'tsc2007_is_pen_down_cansleep' [-Wmissing-prototypes]
     112 | bool tsc2007_is_pen_down_cansleep(struct tsc2007 *ts)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/tsc2007_is_pen_down_cansleep +112 drivers/input/touchscreen/tsc2007_core.c

   111	
 > 112	bool tsc2007_is_pen_down_cansleep(struct tsc2007 *ts)
   113	{
   114		if (!ts->get_pendown_state_cansleep)
   115			return true;
   116	
   117		return ts->get_pendown_state_cansleep(&ts->client->dev);
   118	}
   119	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

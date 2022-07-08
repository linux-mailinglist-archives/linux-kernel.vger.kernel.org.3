Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543F156B066
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 04:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236533AbiGHCGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 22:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiGHCGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 22:06:21 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DC2735B2;
        Thu,  7 Jul 2022 19:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657245980; x=1688781980;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BlBX0I1TqW5elHAcr8NUa0MqJo+bb/fv2kN7HWnRDvg=;
  b=FT/sQcQ6fSynWgHsFJu906xRynANUNpSBHQ5+EBRcPamm1NruZnPACCV
   /nPQXE9mAoEwOfGAF8FOelh77Ke1hQbbPoGvxamF3t31O4RHEy9GV7IXN
   9STTUcXIYeGeR4/AeM6aUixT/eVbL4wM4bZkwnyJzhMm2ea5zISvWPX2J
   gZW5ZvkGvEn2Z1C1US6NMeEJ1uyEmwVTXzAQwZlqAK8bdU3gQ81z5DU9d
   hgCZoDVDWJLG8FVP+zxJ7iYGdSSxXumCHsUxmp02/YJDR//La85fQagQx
   gbIrG15LnfBhtjIACrgL7l1nk2bkI2+Z4S5tKgzX1v3FDakj8EAuFNw6l
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="309728915"
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="309728915"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 19:06:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="720725309"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 07 Jul 2022 19:06:18 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9dNp-000Mkt-VW;
        Fri, 08 Jul 2022 02:06:17 +0000
Date:   Fri, 8 Jul 2022 10:05:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [asahilinux:t8112/bringup 18/19] drivers/hid/hid-magicmouse.c:575:
 warning: This comment starts with '/**', but isn't a kernel-doc comment.
 Refer Documentation/doc-guide/kernel-doc.rst
Message-ID: <202207081050.ZuYUDYpP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux t8112/bringup
head:   0e7640fed025ba0ce4b845a0bbf2a5fdceab631d
commit: 086a493b890970d6e0afac83878a36fbb22ffd83 [18/19] hid: magicmouse: Add MTP multi-touch device support
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220708/202207081050.ZuYUDYpP-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/AsahiLinux/linux/commit/086a493b890970d6e0afac83878a36fbb22ffd83
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux t8112/bringup
        git checkout 086a493b890970d6e0afac83878a36fbb22ffd83
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/hid/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/hid/hid-magicmouse.c:171: warning: Function parameter or member 'pos' not described in 'magicmouse_sc'
   drivers/hid/hid-magicmouse.c:171: warning: Function parameter or member 'hdev' not described in 'magicmouse_sc'
   drivers/hid/hid-magicmouse.c:171: warning: Function parameter or member 'work' not described in 'magicmouse_sc'
   drivers/hid/hid-magicmouse.c:171: warning: Function parameter or member 'battery_timer' not described in 'magicmouse_sc'
   drivers/hid/hid-magicmouse.c:171: warning: Function parameter or member 'input_ops' not described in 'magicmouse_sc'
>> drivers/hid/hid-magicmouse.c:575: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * vendor trackpad report
   drivers/hid/hid-magicmouse.c:589: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * standard HID mouse report


vim +575 drivers/hid/hid-magicmouse.c

   573	
   574	/**
 > 575	 * vendor trackpad report
   576	 *
   577	 * @num_fingers:	the number of fingers being reported in @fingers
   578	 * @buttons:		same as HID buttons
   579	 */
   580	struct tp_header {
   581		// HID vendor part, up to 1751 bytes
   582		u8 unknown[22];
   583		u8 num_fingers;
   584		u8 buttons;
   585		u8 unknown3[14];
   586	};
   587	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

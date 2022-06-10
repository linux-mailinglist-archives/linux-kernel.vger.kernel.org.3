Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B123546642
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 14:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347758AbiFJMGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 08:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240885AbiFJMGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 08:06:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E433EF18
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 05:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654862800; x=1686398800;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=K1k+oIO+VBXWvrUqhojZiI+4Uhrj8EJsXUfooupVGdk=;
  b=isXcptkfyiD5+jn8C0KpGl4t/Ml24v8MeuLT3Mm2JGcGrIn+irgyqPg6
   bQH15yRbIDb0/PogITJn6/6rbi6drU2PUWIxFeNi8IXp9ptVeCoEzLvH0
   2UtpxIzMBgFJ53GliHT4zHljsBFagSOO+AMNOlZL/wih01Tg/g/XU39Fy
   j/58EihWuC+38Z4VoF54guTkUOwzAsivHutkWymjgHUNlWJbU8qmkLOAM
   GsOneoFwT580nJnzOf8MXQIly81/2i69y59hgx1Pa4yU61UEuLaKKPC9J
   cwWWaEjYzebibk4JSe0DN9CbY1eq0S7XoT55dpuSo216qbsNPW4VMQx1z
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="275142446"
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="275142446"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 05:06:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="828225455"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 10 Jun 2022 05:06:39 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzdPS-000Hvx-De;
        Fri, 10 Jun 2022 12:06:38 +0000
Date:   Fri, 10 Jun 2022 20:05:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [chrome-platform:for-next 13/34]
 drivers/platform/chrome/cros_kbd_led_backlight.c:192:42: warning:
 'keyboard_led_drvdata_ec_pwm' defined but not used
Message-ID: <202206102051.ZaCPUVE8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next
head:   cfed691b80dce32b62634b1d7f92a661a3b03e4f
commit: 40f58143745eaabc68ef44b068642ca3b38d23a6 [13/34] platform/chrome: cros_kbd_led_backlight: support EC PWM backend
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220610/202206102051.ZaCPUVE8-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git/commit/?id=40f58143745eaabc68ef44b068642ca3b38d23a6
        git remote add chrome-platform https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git
        git fetch --no-tags chrome-platform for-next
        git checkout 40f58143745eaabc68ef44b068642ca3b38d23a6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/platform/chrome/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/platform/chrome/cros_kbd_led_backlight.c:192:42: warning: 'keyboard_led_drvdata_ec_pwm' defined but not used [-Wunused-const-variable=]
     192 | static const struct keyboard_led_drvdata keyboard_led_drvdata_ec_pwm = {};
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/keyboard_led_drvdata_ec_pwm +192 drivers/platform/chrome/cros_kbd_led_backlight.c

   191	
 > 192	static const struct keyboard_led_drvdata keyboard_led_drvdata_ec_pwm = {};
   193	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

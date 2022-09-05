Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7975AD01F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237051AbiIEK1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236578AbiIEK1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:27:12 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07641C134
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 03:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662373631; x=1693909631;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=O9hS2lJn4nPI23jGL54YdBI2A/ulzu7syAeQxEjb9lY=;
  b=PyqEjKbFHbheoKgM0n/tg0y+iE3Gpi+pTK+7b+AWWf+HQFwvfrcK2jWN
   v4kkyuPIceFYP43U3biD+gaEwtKCga/bsgpUAArQDlo+OoBd6t4HsVsAK
   E6PmGOA1iUq5lgv+gX0I2vQ6f+sWA2k8CpiKafwJddl/c7t9Wb+nLG6d8
   0CJNyZJd2i7V98it0hRxTiomf2PQMZAn4FNrX0pQNE5oyMtxURAxCoNRE
   IJgrax/sQYtR6a0wIOKp1i7CFzjEosW3QzM1oAC89MaOPMdZ/Pd7JBscF
   t/yCfHlf2wBPQXCVZnAhM8AIoWFdgv5Q3AAumo5tMssR6o9qjCOczWAq/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="322527060"
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="322527060"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 03:27:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="942061040"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 05 Sep 2022 03:27:10 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oV9Jt-00042T-1d;
        Mon, 05 Sep 2022 10:27:09 +0000
Date:   Mon, 5 Sep 2022 18:26:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     kbuild-all@lists.01.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [pdx86-platform-drivers-x86:platform-drivers-x86-simatec 5/7]
 drivers/leds/simple/simatic-ipc-leds-gpio.c:18:27: sparse: sparse: symbol
 'simatic_ipc_led_gpio_table' was not declared. Should it be static?
Message-ID: <202209051817.JOPCa9LC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git platform-drivers-x86-simatec
head:   8f5c9858c5db129359b5de2f60f5f034bf5d56c0
commit: a97126265dfe10d3321c0fde4708a6cea49b19ed [5/7] leds: simatic-ipc-leds-gpio: add new model 227G
config: x86_64-randconfig-s022-20220905 (https://download.01.org/0day-ci/archive/20220905/202209051817.JOPCa9LC-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?id=a97126265dfe10d3321c0fde4708a6cea49b19ed
        git remote add pdx86-platform-drivers-x86 https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
        git fetch --no-tags pdx86-platform-drivers-x86 platform-drivers-x86-simatec
        git checkout a97126265dfe10d3321c0fde4708a6cea49b19ed
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/leds/simple/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/leds/simple/simatic-ipc-leds-gpio.c:18:27: sparse: sparse: symbol 'simatic_ipc_led_gpio_table' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

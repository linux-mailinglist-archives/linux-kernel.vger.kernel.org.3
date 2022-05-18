Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4C052AF20
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 02:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbiERAYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 20:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiERAYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 20:24:12 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBC927143
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 17:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652833451; x=1684369451;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7qwjNURLH96k8OodZXRELKGcwQadNPgkQYc8CUOJ7lk=;
  b=FQgie5XnCHCfCDk5Dq4IookcjaNfwZyS37GvtkxnqM7eQ06xkpjL0Y3m
   Q9aKhsczFFfRxgOeK8I2BJ/FGLCT1pfBr8lQXBXiFHZlTgrvLAmq3cm5Y
   cGbWrR5bt5f8QeoIlpdPweyUyieWj/tf1Lce0dFJQwOaiq45sYFDpblTk
   BT3DHmf+GDS/QtpzyPTCpIcMgO3To6p663wB8zBkgHi7LQ9kEy5KmHH3Y
   +KxgsSJCeYF2ozTjFMBCkn/rBwlUDcQA45DLkeKvU6cKz4DAPc1e6gBzw
   GBXoIm701xHYrIEp4r5n0A3Atrz5rHqIltf5Mwsvz7eU9OSMExWt6v5YE
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="251295141"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="251295141"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 17:24:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="605609135"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 17 May 2022 17:24:09 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nr7U0-0001bN-TM;
        Wed, 18 May 2022 00:24:08 +0000
Date:   Wed, 18 May 2022 08:23:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: [broonie-ci:v2_20220509_cezary_rojewski_asoc_intel_avs_driver_core_and_pcm_operations
 173/174] sound/soc/intel/avs/trace.c:19:6: error: redefinition of
 'trace_avs_msg_payload'
Message-ID: <202205180850.lKsZGoOE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git v2_20220509_cezary_rojewski_asoc_intel_avs_driver_core_and_pcm_operations
head:   2629dade5628ba54905160bd1898278223458fd3
commit: a76300c1425077cd9eeadf30353ed1794717a135 [173/174] ASoC: Intel: avs: Event tracing
config: alpha-randconfig-r036-20220516 (https://download.01.org/0day-ci/archive/20220518/202205180850.lKsZGoOE-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git/commit/?id=a76300c1425077cd9eeadf30353ed1794717a135
        git remote add broonie-ci https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git
        git fetch --no-tags broonie-ci v2_20220509_cezary_rojewski_asoc_intel_avs_driver_core_and_pcm_operations
        git checkout a76300c1425077cd9eeadf30353ed1794717a135
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash sound/soc/intel/avs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> sound/soc/intel/avs/trace.c:19:6: error: redefinition of 'trace_avs_msg_payload'
      19 | void trace_avs_msg_payload(const void *data, size_t size)
         |      ^~~~~~~~~~~~~~~~~~~~~
   In file included from sound/soc/intel/avs/trace.c:12:
   sound/soc/intel/avs/trace.h:41:20: note: previous definition of 'trace_avs_msg_payload' with type 'void(const void *, size_t)' {aka 'void(const void *, long unsigned int)'}
      41 | static inline void trace_avs_msg_payload(const void *data, size_t size) {};
         |                    ^~~~~~~~~~~~~~~~~~~~~


vim +/trace_avs_msg_payload +19 sound/soc/intel/avs/trace.c

    13	
    14	#define BYTES_PER_LINE 16
    15	#define MAX_CHUNK_SIZE ((PAGE_SIZE - 150) /* Place for trace header */	\
    16				/ (2 * BYTES_PER_LINE + 4) /* chars per line */	\
    17				* BYTES_PER_LINE)
    18	
  > 19	void trace_avs_msg_payload(const void *data, size_t size)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

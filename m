Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB792575418
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 19:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237417AbiGNRer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 13:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiGNRep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 13:34:45 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078CB27B2D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 10:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657820082; x=1689356082;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Q2hr6t9hP30vtYE8U9QK/PSmuSA0zJVABm+vYdNJ3cM=;
  b=n/DweUQEY/yHhM6+HFIq9A/poemIIqHgVqEl+x3kewmbaGQu5TBW4Y2g
   tr4g12SauZS5nt0YpQs7B0bFtEo+XgpAbwjuEhbLq4/Yar2LoCxvVsL0F
   OJl6E5bdOUSkzMB9a5Fv9t2rVlmQudRLyP1H+QU6g5lBbn8MgKbW1yKwz
   ZdWx+jKJtXn/HBspP1QFLq8EsxZH/qx70yK4PLEI6/5KNljmKFOpwuL8b
   IpHPtdhkWmvVAt9s6XnUXXH+92ibf/ZMa1e21ZE93VwtnNGqMUxj0LNPz
   jxQuipeOzqE/wWZTrT8b1xJJ4ErMY68YxGoQ/AX0BMLxJGx2EhPto8vn2
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="265999190"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="265999190"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 10:34:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="628791855"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 14 Jul 2022 10:34:30 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oC2jN-0000vu-Ia;
        Thu, 14 Jul 2022 17:34:29 +0000
Date:   Fri, 15 Jul 2022 01:33:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [morimoto:sound2-2022-07-08-v1 9/18] sound/soc/soc-core.c:966:5:
 sparse: sparse: symbol '__snd_soc_add_pcm_runtime' was not declared. Should
 it be static?
Message-ID: <202207150148.5qKyHdfC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/morimoto/linux sound2-2022-07-08-v1
head:   b5e8d2766050dfd3452dcdcdff072121984c9a31
commit: 525984dfed23d3f036e4c9bd8f8a72bec3823ffb [9/18] ASoC: force to use DPCM on normal connection
config: i386-randconfig-s003 (https://download.01.org/0day-ci/archive/20220715/202207150148.5qKyHdfC-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/morimoto/linux/commit/525984dfed23d3f036e4c9bd8f8a72bec3823ffb
        git remote add morimoto https://github.com/morimoto/linux
        git fetch --no-tags morimoto sound2-2022-07-08-v1
        git checkout 525984dfed23d3f036e4c9bd8f8a72bec3823ffb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash sound/soc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> sound/soc/soc-core.c:966:5: sparse: sparse: symbol '__snd_soc_add_pcm_runtime' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

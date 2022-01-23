Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C11497041
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 06:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbiAWFtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 00:49:42 -0500
Received: from mga03.intel.com ([134.134.136.65]:41747 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229776AbiAWFtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 00:49:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642916982; x=1674452982;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lw8JRPbm/sjYtF+615mXN+kuU0mC5hmp7IWrLL3xOPA=;
  b=kGDJj1yqOXlR6BjWoodXBdH0rNL8H1MlnPQHJy80hy/mMipCpY6s6d1n
   EMdCekXow6XUZykcQu2UNjchir+KqXs+0ax8eYli6JzVz15YL01xqPgnT
   4myvjfWHbZthsIMk21IHQJEHBtiYhRvcaAC1y76mVBrFfEN2nRG/hC7Xr
   vwaAf+pVa9jIvWa3/2ESnsm7lWf5ahty+CbAIxy/c9NVSi+M4JgXcQZFa
   bWWugX6IVYgofpapghbuUOVg9H3niAYGXyJ0z7Q7UEQpcLB0ZlqeOrkEj
   VJRXjpS5GR6yesOJibOGOXS2gDzUxgokOxEgnkXiQJHX1+Q4cwV1h9bTJ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10235"; a="245813811"
X-IronPort-AV: E=Sophos;i="5.88,309,1635231600"; 
   d="scan'208";a="245813811"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2022 21:49:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,309,1635231600"; 
   d="scan'208";a="616913256"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jan 2022 21:49:39 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBVkx-000H1m-4i; Sun, 23 Jan 2022 05:49:39 +0000
Date:   Sun, 23 Jan 2022 13:49:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aditya Bavanari <abavanar@codeaurora.org>
Cc:     kbuild-all@lists.01.org, GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org, Alistair Delva <adelva@google.com>,
        Will McVicker <willmcvicker@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android-4.19-stable
 5722/9999] sound/soc/soc-core.c:761:27: warning: no previous prototype for
 'soc_find_component_locked'
Message-ID: <202201231338.DICsQtPN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aditya,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-4.19-stable
head:   90a691fca4c2525068d9908ac203e9f09e4e33c0
commit: 75fe91933be2dd4b884ca83bd72e1e0f0d05cfc6 [5722/9999] ANDROID: ASoC: core: add locked version of soc_find_component
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220123/202201231338.DICsQtPN-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/75fe91933be2dd4b884ca83bd72e1e0f0d05cfc6
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-4.19-stable
        git checkout 75fe91933be2dd4b884ca83bd72e1e0f0d05cfc6
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash sound/soc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> sound/soc/soc-core.c:761:27: warning: no previous prototype for 'soc_find_component_locked' [-Wmissing-prototypes]
     761 | struct snd_soc_component *soc_find_component_locked(
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/soc-core.c:2971: warning: Excess function parameter 'legacy_dai_naming' description in 'snd_soc_register_dais'
   sound/soc/soc-core.c:3333: warning: Function parameter or member 'online' not described in 'snd_soc_card_change_online_state'


vim +/soc_find_component_locked +761 sound/soc/soc-core.c

   750	
   751	/**
   752	 * soc_find_component_locked: soc_find_component with client lock acquired
   753	 *
   754	 * @of_node: of_node of the component to query.
   755	 * @name: name of the component to query.
   756	 *
   757	 * function to find out if a component is already registered with ASoC core.
   758	 *
   759	 * Returns component handle for success, else NULL error.
   760	 */
 > 761	struct snd_soc_component *soc_find_component_locked(
   762		const struct device_node *of_node, const char *name)
   763	{
   764		struct snd_soc_component *component = NULL;
   765	
   766		mutex_lock(&client_mutex);
   767		component = soc_find_component(of_node, name);
   768		mutex_unlock(&client_mutex);
   769		return component;
   770	}
   771	EXPORT_SYMBOL(soc_find_component_locked);
   772	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

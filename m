Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B479470759
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244660AbhLJRh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:37:29 -0500
Received: from mga02.intel.com ([134.134.136.20]:55928 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244460AbhLJRhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:37:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639157622; x=1670693622;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c5XZKzQpM3T4K/Gncs8Msjc1I4BAyaown97XLRP6Eyk=;
  b=eMeY0eNgwXW4MvBUDQJAdFXXY9DWLC1M92xf6ADBPlRXf1+Aa2/LqqDb
   tTENBr5y/dh53oTs04sLFIcQN1Be6wJCdJp0tAwMW3tGi/ZZ12yBA884J
   P7UYbJKVXSBim5v4c4Dp1e2TtdbM+w/noZiy7Igtb/hwZYY7EEl8sX1Or
   G08dXOjhHev1Xx2KVG+b1ep9rJ2bpOfoCzMv2b0M1hiZLfPc4slQHZLCP
   ZvL4CxW2zHz0u5MX2fE3O0tHFIN12gyzeOel9HK7wsuFCEzZrhshjd85o
   WLxZeurHn8UWickEFMAKDh9GCfEbpCUQQ3WTG+xQeZEqAyp2K3bAG6ZhH
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="225667679"
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="225667679"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 09:33:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="753241002"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 10 Dec 2021 09:33:13 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvjlg-0003Rl-Ce; Fri, 10 Dec 2021 17:33:12 +0000
Date:   Sat, 11 Dec 2021 01:32:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shumin Chen <chenshumin86@sina.com>, perex@perex.cz,
        tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org
Cc:     kbuild-all@lists.01.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Shumin Chen <chenshumin86@sina.com>
Subject: Re: [PATCH 1/2] ASoC: add ES8156 codec driver
Message-ID: <202112110101.i4FDNZ9c-lkp@intel.com>
References: <20211210151041.108751-2-chenshumin86@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210151041.108751-2-chenshumin86@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shumin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on broonie-sound/for-next]
[also build test WARNING on v5.16-rc4 next-20211208]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Shumin-Chen/This-patches-provide-ASoc-codec-support-for-ES8156/20211210-231527
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
config: x86_64-buildonly-randconfig-r003-20211210 (https://download.01.org/0day-ci/archive/20211211/202112110101.i4FDNZ9c-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/4ea33be548d361d7097073473fb018e016091622
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Shumin-Chen/This-patches-provide-ASoc-codec-support-for-ES8156/20211210-231527
        git checkout 4ea33be548d361d7097073473fb018e016091622
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash sound/soc/codecs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> sound/soc/codecs/es8156.c:402:5: warning: no previous prototype for 'es8156_headset_detect' [-Wmissing-prototypes]
     402 | int es8156_headset_detect(int jack_insert)
         |     ^~~~~~~~~~~~~~~~~~~~~
   sound/soc/codecs/es8156.c:421:13: warning: 'hp_work' defined but not used [-Wunused-function]
     421 | static void hp_work(struct work_struct *work)
         |             ^~~~~~~
   sound/soc/codecs/es8156.c:386:20: warning: 'es8156_irq_handler' defined but not used [-Wunused-function]
     386 | static irqreturn_t es8156_irq_handler(int irq, void *data)
         |                    ^~~~~~~~~~~~~~~~~~


vim +/es8156_headset_detect +402 sound/soc/codecs/es8156.c

   395	
   396	/*
   397	 * Call from rk_headset_irq_hook_adc.c
   398	 *
   399	 * Enable micbias for HOOK detection and disable external Amplifier
   400	 * when jack insertion.
   401	 */
 > 402	int es8156_headset_detect(int jack_insert)
   403	{
   404		struct es8156_priv *es8156;
   405	
   406		if (!es8156_codec)
   407			return -1;
   408	
   409		es8156 = snd_soc_component_get_drvdata(es8156_codec);
   410	
   411		es8156->hp_inserted = jack_insert;
   412	
   413		/* enable micbias and disable PA */
   414		if (jack_insert)
   415			es8156_enable_spk(es8156, false);
   416	
   417		return 0;
   418	}
   419	EXPORT_SYMBOL(es8156_headset_detect);
   420	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

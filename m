Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41765176FC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 20:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386756AbiEBS6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 14:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbiEBS6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 14:58:31 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDEC6322
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 11:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651517701; x=1683053701;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kCXTzSns0iKYl99rL1sjqvkpHrrz+nGZO+gRgT8qpxU=;
  b=n1tFqHADeCyFoDK+Sj1kjI/eY6A+ibLdL62EcJv0hQM/7fr6zN8nreo9
   W6X4+bYNTeylQ3AVepcOCaBPy2sg4js/T/1LQLWJ2MIxL4QrV9ioSh/lO
   sf7e+4XaAjDcJze2AL6kMpLqLJ7DlSxJw2ZgGQlc4BCjgrjzjcT36yHsT
   tI36n/o+lNNm78D90vc0J0/3U7b4hunOcwPFgOZrFOAvbJkyssxcaNnDW
   iO68HAKBtHkoIDpSY2Vgy6sG3L2GY1QvrMAMeGYwmNPsAr01U85ZnK5bq
   U2GO5z+mUKLlDr37YfaFFATVKPiM9V9JLQaILV0NmClHBXq7eFk6HdiMp
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="249284835"
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="249284835"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 11:55:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="631209620"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 02 May 2022 11:54:59 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlbCE-0009n9-L9;
        Mon, 02 May 2022 18:54:58 +0000
Date:   Tue, 3 May 2022 02:54:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
Subject: [asahilinux:bits/070-audio 13/20] sound/soc/apple/macaudio.c:429:12:
 warning: stack frame size (1056) exceeds limit (1024) in
 'macaudio_late_probe'
Message-ID: <202205030219.YmvdsBD1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/070-audio
head:   91b81123719d8b742da188f01ee3d897e0fac92b
commit: 6b20b01b79c235ed4543ef5ae2b788b7bca85643 [13/20] ASoC: Add macaudio machine driver
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20220503/202205030219.YmvdsBD1-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 09325d36061e42b495d1f4c7e933e260eac260ed)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/6b20b01b79c235ed4543ef5ae2b788b7bca85643
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/070-audio
        git checkout 6b20b01b79c235ed4543ef5ae2b788b7bca85643
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/platform/ sound/soc/apple/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> sound/soc/apple/macaudio.c:429:12: warning: stack frame size (1056) exceeds limit (1024) in 'macaudio_late_probe' [-Wframe-larger-than]
   static int macaudio_late_probe(struct snd_soc_card *card)
              ^
   1 warning generated.


vim +/macaudio_late_probe +429 sound/soc/apple/macaudio.c

   428	
 > 429	static int macaudio_late_probe(struct snd_soc_card *card)
   430	{
   431		struct macaudio_snd_data *ma = snd_soc_card_get_drvdata(card);
   432		struct snd_kcontrol *kcontrol;
   433		struct snd_soc_pcm_runtime *rtd;
   434		int ret;
   435	
   436		list_for_each_entry(kcontrol, &ma->hidden_kcontrols, list) {
   437			struct fixed_kctl *fctl = find_fixed_kctl(kcontrol->id.name);
   438	
   439			if (fctl)
   440				snd_soc_kcontrol_set_strval(card, kcontrol, fctl->value);
   441		}
   442	
   443		for_each_card_rtds(card, rtd) {
   444			bool speakers_link = !strcmp(rtd->dai_link->name, "Speaker")
   445					|| !strcmp(rtd->dai_link->name, "Speakers");
   446	
   447			if (speakers_link && ma->speaker_chmap) {
   448				ret = snd_pcm_add_chmap_ctls(rtd->pcm,
   449					SNDRV_PCM_STREAM_PLAYBACK, ma->speaker_chmap,
   450					rtd->num_codecs, 0, NULL);
   451				if (ret < 0)
   452					dev_err(card->dev, "failed to add channel map on '%s': %d\n",
   453						rtd->dai_link->name, ret);
   454			}
   455		}
   456	
   457		return 0;
   458	}
   459	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

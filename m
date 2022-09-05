Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445735ACF63
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbiIEJ4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 05:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236825AbiIEJ4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 05:56:19 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38BB52E74
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 02:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662371771; x=1693907771;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+DB4IGBVBWeZ3chZcj7Qho4Ox/7/yDaSr3HigaBM8YA=;
  b=MXnQMzUj58QEhyKl5WKoGe1zFFg8XLHXXcZHvdQ434gwJoB0DvVj9Pgw
   WBNfCd2TOY6vXqW0uNd/Rsv/1LAV1mJ4W+WwyWVKY3tKOcvTN0uL+FPV2
   kvJSU7f4NkMyMsbf1aWJ5fpN2Emlq5gUgq2lAG1ElfeGPR25iXxnjKVEu
   LaNu0SoUXGZwSQ+Jg8GKp7YOxZGujl53sUK4QKCOvNmz01GTiwpl9PAqQ
   VyXypPlrN/KyKY7WmKlDsvx8wnMDHl3pGffO97Qt6jsGujOIyrt002JyG
   tQWSSIWQ0lApyaiOiCibYKhAorGRF0X/bgeBuKVl1OM1kcGTJzHk6YLdO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="276747725"
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="276747725"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 02:56:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="643746199"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 05 Sep 2022 02:56:09 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oV8ps-00041V-2K;
        Mon, 05 Sep 2022 09:56:08 +0000
Date:   Mon, 5 Sep 2022 17:55:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:tiwai/sound/master 42/45]
 sound/pci/hda/patch_sigmatel.c:4450:31: warning: unused variable 'spec'
Message-ID: <202209051719.vnHRdJzk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block tiwai/sound/master
head:   a6c91e26b44722382fb45d782d25d9ed77bbb184
commit: 414d38ba871092aeac4ed097ac4ced89486646f7 [42/45] ALSA: hda/sigmatel: Keep power up while beep is enabled
config: x86_64-randconfig-a004-20220905 (https://download.01.org/0day-ci/archive/20220905/202209051719.vnHRdJzk-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/414d38ba871092aeac4ed097ac4ced89486646f7
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block tiwai/sound/master
        git checkout 414d38ba871092aeac4ed097ac4ced89486646f7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash sound/pci/hda/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   sound/pci/hda/patch_sigmatel.c: In function 'stac_check_power_status':
>> sound/pci/hda/patch_sigmatel.c:4450:31: warning: unused variable 'spec' [-Wunused-variable]
    4450 |         struct sigmatel_spec *spec = codec->spec;
         |                               ^~~~


vim +/spec +4450 sound/pci/hda/patch_sigmatel.c

  4447	
  4448	static int stac_check_power_status(struct hda_codec *codec, hda_nid_t nid)
  4449	{
> 4450		struct sigmatel_spec *spec = codec->spec;
  4451		int ret = snd_hda_gen_check_power_status(codec, nid);
  4452	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

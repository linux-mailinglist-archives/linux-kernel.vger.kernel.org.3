Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D750159C4E5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 19:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237221AbiHVRTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 13:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237216AbiHVRS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 13:18:59 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326261928D
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661188739; x=1692724739;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/Em9cfDMY2xjSlozQXtkKt2ZS9oCG79hCZIZM1AL1X4=;
  b=iUH4nsNbpK71vfegAJmi2Q+IbFZIlhAzQ6bJKGGQT4FRVlLDg9omublu
   N5nXtQYMSRKDC0+hyrGK0LK+NzZPiXLFknSPa9Zjh5K4XDrohN26TUYix
   QgWhs80fS9PzL91xZs0SK89ni/2xM4IXad9/iMSdpmIQ3Ifj7id49gEZk
   IuwjcYawyGJGmNyYtS5bf5pFCGIgvWC5WaZ5vx89u+VIzFGQwcMjRllOS
   aWX6xMJXNvTInZw3Hh9cLp+1MIEpTK+TOXkCgPNxHa8wEzhqebbRTTTaL
   9sJ+xNDqGg8MkEhqNrvNp7sFAFbRYrSgiwINdOtNxUN7TQ5RHrpnmadxq
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="293470446"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="293470446"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 10:18:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="735176964"
Received: from lkp-server01.sh.intel.com (HELO dd9b29378baa) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 22 Aug 2022 10:18:56 -0700
Received: from kbuild by dd9b29378baa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQB4h-0000Vv-1P;
        Mon, 22 Aug 2022 17:18:55 +0000
Date:   Tue, 23 Aug 2022 01:18:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [ammarfaizi2-block:tiwai/sound/for-next 4/13]
 sound/soc/intel/skylake/skl.c:729:25: warning: unused variable 'skl'
Message-ID: <202208230107.aJwMhDQM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block tiwai/sound/for-next
head:   1cda83e42bf66beb06bf61c7a78951ec0c028898
commit: 3fd63658caed9494cca1d4789a66d3d2def2a0ab [4/13] ASoC: Intel: Drop hdac_ext usage for codec device creation
config: x86_64-randconfig-a002-20211028 (https://download.01.org/0day-ci/archive/20220823/202208230107.aJwMhDQM-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/3fd63658caed9494cca1d4789a66d3d2def2a0ab
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block tiwai/sound/for-next
        git checkout 3fd63658caed9494cca1d4789a66d3d2def2a0ab
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash sound/soc/intel/skylake/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   sound/soc/intel/skylake/skl.c: In function 'probe_codec':
>> sound/soc/intel/skylake/skl.c:729:25: warning: unused variable 'skl' [-Wunused-variable]
     729 |         struct skl_dev *skl = bus_to_skl(bus);
         |                         ^~~


vim +/skl +729 sound/soc/intel/skylake/skl.c

e4746d94d00c529 Cezary Rojewski      2022-08-16  720  
d8c2dab8381d583 Jeeja KP             2015-07-09  721  /*
d8c2dab8381d583 Jeeja KP             2015-07-09  722   * Probe the given codec address
d8c2dab8381d583 Jeeja KP             2015-07-09  723   */
76f56fae1cf9040 Rakesh Ughreja       2018-06-01  724  static int probe_codec(struct hdac_bus *bus, int addr)
d8c2dab8381d583 Jeeja KP             2015-07-09  725  {
d8c2dab8381d583 Jeeja KP             2015-07-09  726  	unsigned int cmd = (addr << 28) | (AC_NODE_ROOT << 20) |
d8c2dab8381d583 Jeeja KP             2015-07-09  727  		(AC_VERB_PARAMETERS << 8) | AC_PAR_VENDOR_ID;
e6a33532affd14c Dan Carpenter        2017-04-20  728  	unsigned int res = -1;
bcc2a2dc3ba8c3a Cezary Rojewski      2019-07-23 @729  	struct skl_dev *skl = bus_to_skl(bus);
8c4e7c2ee8096b5 Pierre-Louis Bossart 2018-11-18  730  #if IS_ENABLED(CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC)
6bae5ea94989264 Rakesh Ughreja       2018-08-22  731  	struct hdac_hda_priv *hda_codec;
8c4e7c2ee8096b5 Pierre-Louis Bossart 2018-11-18  732  #endif
3fd63658caed949 Cezary Rojewski      2022-08-16  733  	struct hda_codec *codec;
d8c2dab8381d583 Jeeja KP             2015-07-09  734  
d8c2dab8381d583 Jeeja KP             2015-07-09  735  	mutex_lock(&bus->cmd_mutex);
d8c2dab8381d583 Jeeja KP             2015-07-09  736  	snd_hdac_bus_send_cmd(bus, cmd);
d8c2dab8381d583 Jeeja KP             2015-07-09  737  	snd_hdac_bus_get_response(bus, addr, &res);
d8c2dab8381d583 Jeeja KP             2015-07-09  738  	mutex_unlock(&bus->cmd_mutex);
d8c2dab8381d583 Jeeja KP             2015-07-09  739  	if (res == -1)
d8c2dab8381d583 Jeeja KP             2015-07-09  740  		return -EIO;
00deadb5d86a3c1 Rakesh Ughreja       2018-08-22  741  	dev_dbg(bus->dev, "codec #%d probed OK: %x\n", addr, res);
d8c2dab8381d583 Jeeja KP             2015-07-09  742  

:::::: The code at line 729 was first introduced by commit
:::::: bcc2a2dc3ba8c3a7aed856f840afa6a47e3cb8e0 ASoC: Intel: Skylake: Merge skl_sst and skl into skl_dev struct

:::::: TO: Cezary Rojewski <cezary.rojewski@intel.com>
:::::: CC: Mark Brown <broonie@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

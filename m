Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A578D547D2B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 03:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238088AbiFMBAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 21:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbiFMBA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 21:00:28 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30694167FC
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 18:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655082027; x=1686618027;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XZZQ43k6Ysc+b812IVdZWOWmk7UUmMzZU96eSeWr6QQ=;
  b=GUCXrJG87FyrUBcaC9ud0Hsi6UlRh9gqHtdzfFMIEZbMKZT65gGYT0Q0
   ET9Du/Xhw2yOC8dfVeHMhEWhKkpVpCTSfUFCMeyc65GHontVFkI6D3rSu
   55eacrvQajjHpKxRIWKTGAQSuxZ/ljTjd6Sq9zF00BLEVl4R4PiM9sEEV
   fVNqxvRaLyD5EFvhzJsYExIC91p1Fb3/kGCVOCGP2FGbWnUGEmZup+qku
   8AyrwHkYf7yCkqPWAA2rpx3JZCUEfFDFl5ORjOlp+0kul3kgcFGFVVKFi
   qbpJ8fpypUfy6qATyd8DmNA/HEHIkoXH2fhGQY9xT2BsqG1AUlq3z8zy5
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10376"; a="261167338"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="261167338"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2022 18:00:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="617271254"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 12 Jun 2022 18:00:24 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0YRM-000KLR-57;
        Mon, 13 Jun 2022 01:00:24 +0000
Date:   Mon, 13 Jun 2022 09:00:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:tiwai/sound/test/ctl-xarray 8/8]
 sound/core/control.c:390:11: sparse: sparse: incorrect type in assignment
 (different base types)
Message-ID: <202206130850.ovjHDlOp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block tiwai/sound/test/ctl-xarray
head:   4b5b1ae4a0fc499da62080dc54e6492df9a96dd7
commit: 4b5b1ae4a0fc499da62080dc54e6492df9a96dd7 [8/8] ALSA: control: Use xarray for faster lookups
config: arc-randconfig-s031-20220612 (https://download.01.org/0day-ci/archive/20220613/202206130850.ovjHDlOp-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-30-g92122700-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/4b5b1ae4a0fc499da62080dc54e6492df9a96dd7
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block tiwai/sound/test/ctl-xarray
        git checkout 4b5b1ae4a0fc499da62080dc54e6492df9a96dd7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arc SHELL=/bin/bash sound/core/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> sound/core/control.c:390:11: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long h @@     got restricted snd_ctl_elem_iface_t const [usertype] iface @@
   sound/core/control.c:390:11: sparse:     expected unsigned long h
   sound/core/control.c:390:11: sparse:     got restricted snd_ctl_elem_iface_t const [usertype] iface
   sound/core/control.c:926:17: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:926:26: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:927:17: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:927:26: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:946:48: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:1640:40: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer

vim +390 sound/core/control.c

   378	
   379	#ifdef CONFIG_SND_CTL_FAST_LOOKUP
   380	/* Compute a hash key for the corresponding ctl id
   381	 * It's for the name lookup, hence the numid is excluded.
   382	 * The hash key is bound in LONG_MAX to be used for Xarray key.
   383	 */
   384	#define MULTIPLIER	37
   385	static unsigned long get_ctl_id_hash(const struct snd_ctl_elem_id *id)
   386	{
   387		unsigned long h;
   388		const unsigned char *p;
   389	
 > 390		h = id->iface;
   391		h = MULTIPLIER * h + id->device;
   392		h = MULTIPLIER * h + id->subdevice;
   393		for (p = id->name; *p; p++)
   394			h = MULTIPLIER * h + *p;
   395		h = MULTIPLIER * h + id->index;
   396		h &= LONG_MAX;
   397		return h;
   398	}
   399	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

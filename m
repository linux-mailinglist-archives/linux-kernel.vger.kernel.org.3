Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122604E62B6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 12:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349846AbiCXLwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 07:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbiCXLwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 07:52:43 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D53E97BA4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 04:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648122671; x=1679658671;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MkKgLOGm8fzuqIUVMGedup+WyqyCao28NBMcOzgaAJM=;
  b=aTTQwlRv1TRUHYtPU6cZ+/MNjADUF+gAAXK0F97NDetW7q2ve3fEPKpY
   EumkgIOUbprlWnnVl/olq06aGDnlnJlPB/fHcFaNmKdqsFoXwrY0wwimk
   fM91TsxUODfG0E59bkKH0RMXg/QLapXqYIEYW2551flgSUZPSRkmkEuvf
   G50evg9Qc/XUyMa7jNWec3xVugYoM2ohvf8lli3N1DJfXzWjyGQMJjzjk
   BQtHiPG2H87vB/BWFvW1iQPEZJTzwZGCMb1t6yc/SChKlN4XuyUyIaIco
   XTZMUp1p4eM4sghSQzFjUYCTQ0St4JJnAHseO+RAMeMvgr2DIN5P0QwtN
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="283214930"
X-IronPort-AV: E=Sophos;i="5.90,207,1643702400"; 
   d="scan'208";a="283214930"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 04:51:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,207,1643702400"; 
   d="scan'208";a="649824816"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 24 Mar 2022 04:51:09 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXLzg-000L2i-JY; Thu, 24 Mar 2022 11:51:08 +0000
Date:   Thu, 24 Mar 2022 19:50:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Henningsson <coding@diwic.se>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Jaroslav Kysela <perex@perex.cz>
Subject: sound/core/rawmidi.c:991:6: warning: variable 'dest_frames' set but
 not used
Message-ID: <202203241949.AXselCHw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ed4643521e6af8ab8ed1e467630a85884d2696cf
commit: 08fdced60ca08e34e316a3ab945636fcdfcbc973 ALSA: rawmidi: Add framing mode
date:   10 months ago
config: mips-mtx1_defconfig (https://download.01.org/0day-ci/archive/20220324/202203241949.AXselCHw-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=08fdced60ca08e34e316a3ab945636fcdfcbc973
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 08fdced60ca08e34e316a3ab945636fcdfcbc973
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash sound/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> sound/core/rawmidi.c:991:6: warning: variable 'dest_frames' set but not used [-Wunused-but-set-variable]
           int dest_frames = 0;
               ^
   1 warning generated.


vim +/dest_frames +991 sound/core/rawmidi.c

   984	
   985	static int receive_with_tstamp_framing(struct snd_rawmidi_substream *substream,
   986				const unsigned char *buffer, int src_count, const struct timespec64 *tstamp)
   987	{
   988		struct snd_rawmidi_runtime *runtime = substream->runtime;
   989		struct snd_rawmidi_framing_tstamp *dest_ptr;
   990		struct snd_rawmidi_framing_tstamp frame = { .tv_sec = tstamp->tv_sec, .tv_nsec = tstamp->tv_nsec };
 > 991		int dest_frames = 0;
   992		int orig_count = src_count;
   993		int frame_size = sizeof(struct snd_rawmidi_framing_tstamp);
   994	
   995		BUILD_BUG_ON(frame_size != 0x20);
   996		if (snd_BUG_ON((runtime->hw_ptr & 0x1f) != 0))
   997			return -EINVAL;
   998	
   999		while (src_count > 0) {
  1000			if ((int)(runtime->buffer_size - runtime->avail) < frame_size) {
  1001				runtime->xruns += src_count;
  1002				break;
  1003			}
  1004			if (src_count >= SNDRV_RAWMIDI_FRAMING_DATA_LENGTH)
  1005				frame.length = SNDRV_RAWMIDI_FRAMING_DATA_LENGTH;
  1006			else {
  1007				frame.length = src_count;
  1008				memset(frame.data, 0, SNDRV_RAWMIDI_FRAMING_DATA_LENGTH);
  1009			}
  1010			memcpy(frame.data, buffer, frame.length);
  1011			buffer += frame.length;
  1012			src_count -= frame.length;
  1013			dest_ptr = (struct snd_rawmidi_framing_tstamp *) (runtime->buffer + runtime->hw_ptr);
  1014			*dest_ptr = frame;
  1015			runtime->avail += frame_size;
  1016			runtime->hw_ptr += frame_size;
  1017			runtime->hw_ptr %= runtime->buffer_size;
  1018			dest_frames++;
  1019		}
  1020		return orig_count - src_count;
  1021	}
  1022	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

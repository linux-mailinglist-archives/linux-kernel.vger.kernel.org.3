Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8B5C4A042B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 00:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235971AbiA1XSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 18:18:10 -0500
Received: from mga14.intel.com ([192.55.52.115]:2927 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235317AbiA1XSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 18:18:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643411888; x=1674947888;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gtr5URFvhMGen+44npttODyy0h7F/t99wvMuv/Dqb1s=;
  b=kjTV+C49PCqejKfSTJzRHyoyDXzTRkGaMXjf2cWRzJpqkEbiyPWDYrs5
   TNtNjH2uFbGmnUSGXQbZVdkj6FjK7t7QdGuYqZbB7KaGZ/ZtFKzzzl0e1
   IPCTMzQQJrTP3VleoIgB3y37lvI1g6vY7xdP43uiGXhtPlGQtSyIjlT61
   fiCRa1KxJ74BDxjfiEZe5TUXIelHcN/1BB8d0SeVKIO0au9pAKfueyxkP
   FCvRE0hFvEKOyocQS7Gn1knZm5vKOyG1VUysLysqpLyiuxyXkkIXHSFkN
   PTMb9w/ivNBgwbv89FnnSxBhj66SsHOknnekQXPd5RsknCb0en8TJ3t+B
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="247435968"
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="247435968"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 15:18:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="697247236"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 28 Jan 2022 15:18:06 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDaVJ-000ORB-Bb; Fri, 28 Jan 2022 23:18:05 +0000
Date:   Sat, 29 Jan 2022 07:17:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:tiwai/sound/topic/fw-loader-zstd-5.17 1/3]
 drivers/base/firmware_loader/main.c:326:16: warning: result of comparison of
 constant 18446744073709551614 with expression of type 'size_t' (aka
 'unsigned int') is always false
Message-ID: <202201290700.RQlEvkeI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block tiwai/sound/topic/fw-loader-zstd-5.17
head:   ed4bba5cc56e96fda12bd427e950da2d987c49c9
commit: d8649529852348bd245bfdc5cee97311c57cf73a [1/3] firmware: Add the support for ZSTD-compressed firmware files
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20220129/202201290700.RQlEvkeI-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 33b45ee44b1f32ffdbc995e6fec806271b4b3ba4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/d8649529852348bd245bfdc5cee97311c57cf73a
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block tiwai/sound/topic/fw-loader-zstd-5.17
        git checkout d8649529852348bd245bfdc5cee97311c57cf73a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/base/firmware_loader/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/base/firmware_loader/main.c:326:16: warning: result of comparison of constant 18446744073709551614 with expression of type 'size_t' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
                       out_size == ZSTD_CONTENTSIZE_ERROR) {
                       ~~~~~~~~ ^  ~~~~~~~~~~~~~~~~~~~~~~
   drivers/base/firmware_loader/main.c:325:16: warning: result of comparison of constant 18446744073709551615 with expression of type 'size_t' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
                   if (out_size == ZSTD_CONTENTSIZE_UNKNOWN ||
                       ~~~~~~~~ ^  ~~~~~~~~~~~~~~~~~~~~~~~~
   2 warnings generated.


vim +326 drivers/base/firmware_loader/main.c

   307	
   308	/*
   309	 * ZSTD-compressed firmware support
   310	 */
   311	#ifdef CONFIG_FW_LOADER_COMPRESS_ZSTD
   312	static int fw_decompress_zstd(struct device *dev, struct fw_priv *fw_priv,
   313				      size_t in_size, const void *in_buffer)
   314	{
   315		size_t len, out_size, workspace_size;
   316		void *workspace, *out_buf;
   317		zstd_dctx *ctx;
   318		int err;
   319	
   320		if (fw_priv->data) {
   321			out_size = fw_priv->allocated_size;
   322			out_buf = fw_priv->data;
   323		} else {
   324			out_size = zstd_find_frame_compressed_size(in_buffer, in_size);
   325			if (out_size == ZSTD_CONTENTSIZE_UNKNOWN ||
 > 326			    out_size == ZSTD_CONTENTSIZE_ERROR) {
   327				dev_dbg(dev, "%s: invalid decompression size\n", __func__);
   328				return -EINVAL;
   329			}
   330			out_buf = vzalloc(out_size);
   331			if (!out_buf)
   332				return -ENOMEM;
   333		}
   334	
   335		workspace_size = zstd_dctx_workspace_bound();
   336		workspace = kvzalloc(workspace_size, GFP_KERNEL);
   337		if (!workspace) {
   338			err = -ENOMEM;
   339			goto error;
   340		}
   341	
   342		ctx = zstd_init_dctx(workspace, workspace_size);
   343		if (!ctx) {
   344			dev_dbg(dev, "%s: failed to initialize context\n", __func__);
   345			err = -EINVAL;
   346			goto error;
   347		}
   348	
   349		len = zstd_decompress_dctx(ctx, out_buf, out_size, in_buffer, in_size);
   350		if (zstd_is_error(len)) {
   351			dev_dbg(dev, "%s: failed to decompress: %d\n", __func__,
   352				zstd_get_error_code(len));
   353			err = -EINVAL;
   354			goto error;
   355		}
   356	
   357		fw_priv->size = len;
   358		if (!fw_priv->data)
   359			fw_priv->data = out_buf;
   360		err = 0;
   361	
   362	 error:
   363		kvfree(workspace);
   364		if (!fw_priv->data)
   365			vfree(out_buf);
   366		return err;
   367	}
   368	#endif /* CONFIG_FW_LOADER_COMPRESS_ZSTD */
   369	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

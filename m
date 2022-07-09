Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4513B56C72F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 06:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiGIE6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 00:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiGIE6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 00:58:33 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC24FB51
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 21:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657342707; x=1688878707;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Kt+tNbURyKoG4nJWkHDcVQ3PkVzqAXVRZNl9k2LX1fM=;
  b=oA6V7+HHuamPFzIUsG1pKElWV6xkPKAtZkmP8bBpPX4N4DQzZSasqnc6
   KQ+0nfwSd3IbKwcgpRUALtsp6toyY4dMApbX0Wqx/rxXFudf9cbIpudtE
   Sg2rjmxaUVDcDIxc3KXnFcIe+kGTa87uuLXkz/v2iHe7PdwBp2KZiJiK4
   Q+o23yyQmpAcDsKmUNpmlX10DA2CacVUyUA5uTwnBGBYOBwUAL19WrbXn
   IpGLVJKFUib2mJ9e8x0XzTqLUlUJzcaKg4X09RBhFytbPMXrLVFG07bbY
   2Oescr9UMw/4Qf4qX/BTjGmRCSLcYHXTzTEfFohXCXDoAEEwjeEfiVTgH
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="281960519"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="281960519"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 21:58:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="569177108"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Jul 2022 21:58:24 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oA2Xv-000OKk-O4;
        Sat, 09 Jul 2022 04:58:23 +0000
Date:   Sat, 9 Jul 2022 12:57:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-linked-list 26/61]
 include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument
 1 (different modifiers)
Message-ID: <202207091237.AUlk4Q5b-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-linked-list
head:   ce4670495468b797b0c5927fcb661bc0da48b9ab
commit: 1b8738547bb820a8d288d69c075558762b1e9cd6 [26/61] mm: Make some folio function arguments const
config: i386-randconfig-s002 (https://download.01.org/0day-ci/archive/20220709/202207091237.AUlk4Q5b-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/1b8738547bb820a8d288d69c075558762b1e9cd6
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-linked-list
        git checkout 1b8738547bb820a8d288d69c075558762b1e9cd6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   fs/xfs/xfs_aops.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/slab.h, fs/xfs/kmem.h, ...):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   fs/nfs/file.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/umh.h, include/linux/kmod.h, ...):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   fs/nfs/read.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   fs/orangefs/inode.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   fs/jfs/jfs_metapage.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   fs/f2fs/data.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   fs/btrfs/inode.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/slab.h, ...):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   fs/btrfs/extent_io.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/slab.h):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
   fs/btrfs/extent_io.c:5826:13: sparse: sparse: context imbalance in 'detach_extent_buffer_page' - different lock contexts for basic block
--
   fs/netfs/buffered_read.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   fs/netfs/direct_read.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   fs/netfs/io.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/umh.h, include/linux/kmod.h, ...):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   fs/netfs/misc.c: note: in included file (through include/linux/mmzone.h, include/linux/swap.h):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   fs/reiserfs/inode.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   mm/debug.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   mm/gup.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   mm/highmem.c:97:16: sparse: sparse: Initializer entry defined twice
   mm/highmem.c:97:16: sparse:   also defined here
   mm/highmem.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   mm/mlock.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h, include/linux/mman.h):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
   mm/mlock.c: note: in included file (through include/linux/swap.h):
   include/linux/memcontrol.h:1594:39: sparse: sparse: context imbalance in '__mlock_new_page' - unexpected unlock
   mm/mlock.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h, include/linux/mman.h):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
   mm/mlock.c:208:39: sparse: sparse: context imbalance in 'mlock_pagevec' - unexpected unlock
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
   mm/mlock.c:347:20: sparse: sparse: context imbalance in 'mlock_pte_range' - unexpected unlock
--
   mm/page_vma_mapped.c:16:13: sparse: sparse: context imbalance in 'map_pte' - wrong count at exit
   mm/page_vma_mapped.c: note: in included file:
   include/linux/rmap.h:351:28: sparse: sparse: context imbalance in 'page_vma_mapped_walk' - unexpected unlock
   mm/page_vma_mapped.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
   mm/page_vma_mapped.c: note: in included file:
   include/linux/rmap.h:351:28: sparse: sparse: context imbalance in 'page_mapped_in_vma' - unexpected unlock
--
   mm/memory.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
   mm/memory.c:1030:17: sparse: sparse: context imbalance in 'copy_pte_range' - different lock contexts for basic block
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
   mm/memory.c:1830:16: sparse: sparse: context imbalance in '__get_locked_pte' - different lock contexts for basic block
   mm/memory.c:1878:9: sparse: sparse: context imbalance in 'insert_page' - different lock contexts for basic block
   mm/memory.c:2380:17: sparse: sparse: context imbalance in 'remap_pte_range' - different lock contexts for basic block
   mm/memory.c:2636:17: sparse: sparse: context imbalance in 'apply_to_pte_range' - unexpected unlock
   mm/memory.c:2925:9: sparse: sparse: context imbalance in 'wp_page_copy' - different lock contexts for basic block
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
   mm/memory.c:3285:17: sparse: sparse: context imbalance in 'wp_pfn_shared' - unexpected unlock
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
   mm/memory.c:3352:19: sparse: sparse: context imbalance in 'do_wp_page' - different lock contexts for basic block
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
   mm/memory.c:5252:5: sparse: sparse: context imbalance in 'follow_pte' - different lock contexts for basic block
   mm/memory.c:5317:23: sparse: sparse: context imbalance in 'follow_pfn' - unexpected unlock
   mm/memory.c:5347:9: sparse: sparse: context imbalance in 'follow_phys' - unexpected unlock
   mm/memory.c:5381:9: sparse: sparse: context imbalance in 'generic_access_phys' - unexpected unlock
--
   mm/rmap.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
   mm/rmap.c: note: in included file (through include/linux/ksm.h):
   include/linux/rmap.h:351:28: sparse: sparse: context imbalance in 'folio_referenced_one' - unexpected unlock
   mm/rmap.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
   mm/rmap.c: note: in included file (through include/linux/ksm.h):
   include/linux/rmap.h:351:28: sparse: sparse: context imbalance in 'try_to_unmap_one' - unexpected unlock
   mm/rmap.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
   mm/rmap.c: note: in included file (through include/linux/ksm.h):
   include/linux/rmap.h:351:28: sparse: sparse: context imbalance in 'try_to_migrate_one' - unexpected unlock
   mm/rmap.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   mm/page_alloc.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   mm/page_io.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   mm/swap_state.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   mm/swapfile.c:489:35: sparse: sparse: context imbalance in 'swap_do_scheduled_discard' - different lock contexts for basic block
   mm/swapfile.c:664:9: sparse: sparse: context imbalance in 'scan_swap_map_try_ssd_cluster' - different lock contexts for basic block
   mm/swapfile.c:779:13: sparse: sparse: context imbalance in 'swap_offset_available_and_locked' - wrong count at exit
   mm/swapfile.c:970:20: sparse: sparse: context imbalance in 'scan_swap_map_slots' - unexpected unlock
   mm/swapfile.c:1039:23: sparse: sparse: context imbalance in 'swap_free_cluster' - different lock contexts for basic block
   mm/swapfile.c:1171:36: sparse: sparse: context imbalance in 'swap_info_get_cont' - unexpected unlock
   mm/swapfile.c:385:9: sparse: sparse: context imbalance in '__swap_entry_free' - different lock contexts for basic block
   mm/swapfile.c:1309:23: sparse: sparse: context imbalance in 'swap_entry_free' - different lock contexts for basic block
   mm/swapfile.c:1366:34: sparse: sparse: context imbalance in 'put_swap_page' - different lock contexts for basic block
   mm/swapfile.c:1427:28: sparse: sparse: context imbalance in 'swapcache_free_entries' - unexpected unlock
   mm/swapfile.c:385:9: sparse: sparse: context imbalance in 'page_swapcount' - different lock contexts for basic block
   mm/swapfile.c:385:9: sparse: sparse: context imbalance in 'swap_swapcount' - different lock contexts for basic block
   mm/swapfile.c:385:9: sparse: sparse: context imbalance in 'swp_swapcount' - different lock contexts for basic block
   mm/swapfile.c:385:9: sparse: sparse: context imbalance in 'swap_page_trans_huge_swapped' - different lock contexts for basic block
   mm/swapfile.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
   mm/swapfile.c:385:9: sparse: sparse: context imbalance in '__swap_duplicate' - different lock contexts for basic block
   mm/swapfile.c:3516:23: sparse: sparse: context imbalance in 'add_swap_count_continuation' - different lock contexts for basic block
--
   mm/swap_slots.c: note: in included file (through include/linux/mmzone.h, include/linux/swap.h, include/linux/swap_slots.h):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   mm/hugetlb.c:461:12: sparse: sparse: context imbalance in 'allocate_file_region_entries' - wrong count at exit
   mm/hugetlb.c:534:13: sparse: sparse: context imbalance in 'region_add' - wrong count at exit
   mm/hugetlb.c:601:13: sparse: sparse: context imbalance in 'region_chg' - wrong count at exit
   mm/hugetlb.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
   mm/hugetlb.c: note: in included file:
   include/linux/mm.h:1304:17: sparse: sparse: context imbalance in 'demote_free_huge_page' - unexpected unlock
   mm/hugetlb.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
   mm/hugetlb.c:4924:20: sparse: sparse: context imbalance in 'move_huge_pte' - different lock contexts for basic block
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
   mm/hugetlb.c: note: in included file:
   include/linux/mm.h:1165:22: sparse: sparse: context imbalance in 'hugetlb_wp' - unexpected unlock
   mm/hugetlb.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
   mm/hugetlb.c:6175:25: sparse: sparse: context imbalance in 'follow_hugetlb_page' - different lock contexts for basic block
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   mm/ksm.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
   mm/ksm.c: note: in included file:
   include/linux/rmap.h:351:28: sparse: sparse: context imbalance in 'write_protect_page' - unexpected unlock
   mm/ksm.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   mm/slub.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
   mm/slub.c:2475:9: sparse: sparse: context imbalance in 'deactivate_slab' - different lock contexts for basic block
   mm/slub.c:3350:47: sparse: sparse: context imbalance in '__slab_free' - unexpected unlock
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   mm/migrate.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h, include/linux/migrate.h):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
   mm/migrate.c:289:6: sparse: sparse: context imbalance in '__migration_entry_wait' - different lock contexts for basic block
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
   mm/migrate.c:729:9: sparse: sparse: context imbalance in '__buffer_migrate_page' - different lock contexts for basic block
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   mm/huge_memory.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
   mm/huge_memory.c:1547:20: sparse: sparse: context imbalance in 'madvise_free_huge_pmd' - unexpected unlock
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
   mm/huge_memory.c:1584:28: sparse: sparse: context imbalance in 'zap_huge_pmd' - unexpected unlock
   mm/huge_memory.c:1691:28: sparse: sparse: context imbalance in 'move_huge_pmd' - unexpected unlock
   mm/huge_memory.c:1823:20: sparse: sparse: context imbalance in 'change_huge_pmd' - unexpected unlock
   mm/huge_memory.c:1833:12: sparse: sparse: context imbalance in '__pmd_trans_huge_lock' - wrong count at exit
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
   mm/huge_memory.c:2477:9: sparse: sparse: context imbalance in '__split_huge_page' - different lock contexts for basic block
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
   mm/huge_memory.c:2663:17: sparse: sparse: context imbalance in 'split_huge_page_to_list' - different lock contexts for basic block
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   mm/khugepaged.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   mm/hugetlb_cgroup.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   mm/page_isolation.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   mm/secretmem.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   mm/page_idle.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h, ...):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   mm/memfd.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   mm/compaction.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/radix-tree.h, ...):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
   mm/compaction.c:527:39: sparse: sparse: context imbalance in 'compact_unlock_should_abort' - unexpected unlock
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
   mm/compaction.c:641:39: sparse: sparse: context imbalance in 'isolate_freepages_block' - unexpected unlock
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
   mm/compaction.c:1170:46: sparse: sparse: context imbalance in 'isolate_migratepages_block' - unexpected unlock
--
   mm/filemap.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
   mm/filemap.c:1440:17: sparse: sparse: context imbalance in 'migration_entry_wait_on_locked' - unexpected unlock
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   mm/page-writeback.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   mm/folio-compat.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h, include/linux/migrate.h):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   mm/readahead.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   mm/swap.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
   mm/swap.c: note: in included file (through include/linux/swap.h):
   include/linux/memcontrol.h:1608:46: sparse: sparse: context imbalance in '__pagevec_lru_add' - unexpected unlock
--
   mm/truncate.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   mm/util.c:125:6: sparse: sparse: multiple definitions for function 'kmemdup'
   mm/util.c: note: in included file (through include/linux/string.h, arch/x86/include/asm/page_32.h, arch/x86/include/asm/page.h, ...):
   include/linux/fortify-string.h:448:23: sparse:  the previous one is here
   mm/util.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   mm/vmscan.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
   mm/vmscan.c:1320:28: sparse: sparse: context imbalance in '__remove_mapping' - unexpected unlock
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   mm/shmem.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   mm/workingset.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   fs/libfs.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   fs/remap_range.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/slab.h):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   fs/mpage.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   fs/buffer.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/percpu_counter.h, ...):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   fs/verity/enable.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   fs/iomap/buffered-io.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/umh.h, include/linux/kmod.h, ...):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   fs/proc/task_mmu.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h, ...):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
   fs/proc/task_mmu.c:616:17: sparse: sparse: context imbalance in 'smaps_pte_range' - unexpected unlock
   fs/proc/task_mmu.c:1174:28: sparse: sparse: context imbalance in 'clear_refs_pte_range' - unexpected unlock
   fs/proc/task_mmu.c:1508:28: sparse: sparse: context imbalance in 'pagemap_pmd_range' - unexpected unlock
--
   fs/proc/page.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h, ...):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   fs/cifs/file.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
--
   lib/iov_iter.c:1803:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *p @@     got void [noderef] __user *[assigned] base @@
   lib/iov_iter.c:1803:9: sparse:     expected void const *p
   lib/iov_iter.c:1803:9: sparse:     got void [noderef] __user *[assigned] base
   lib/iov_iter.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/slab.h, ...):
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page
>> include/linux/page-flags.h:788:9: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct page *page @@     got struct page const *page @@
   include/linux/page-flags.h:788:9: sparse:     expected struct page *page
   include/linux/page-flags.h:788:9: sparse:     got struct page const *page

vim +788 include/linux/page-flags.h

e7d324850bfcb3 Muchun Song   2022-03-22  785  
1b8738547bb820 David Howells 2022-06-08  786  static __always_inline int PageHead(const struct page *page)
e7d324850bfcb3 Muchun Song   2022-03-22  787  {
e7d324850bfcb3 Muchun Song   2022-03-22 @788  	PF_POISONED_CHECK(page);
e7d324850bfcb3 Muchun Song   2022-03-22  789  	return test_bit(PG_head, &page->flags) && !page_is_fake_head(page);
e7d324850bfcb3 Muchun Song   2022-03-22  790  }
e7d324850bfcb3 Muchun Song   2022-03-22  791  

:::::: The code at line 788 was first introduced by commit
:::::: e7d324850bfcb30df563d144c0363cc44595277d mm: hugetlb: free the 2nd vmemmap page associated with each HugeTLB page

:::::: TO: Muchun Song <songmuchun@bytedance.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

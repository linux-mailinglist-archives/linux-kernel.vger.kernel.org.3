Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB38A51CE32
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 04:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387601AbiEFApz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 20:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376574AbiEFApx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 20:45:53 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A8A5DBC3
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 17:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651797732; x=1683333732;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fi7TdQDubkiCecQxjR0VrP6BRGP6ATD7G/115c6JQvE=;
  b=XVW5RcmYSpC9vWRudTNGDtxTtOsLsOwD6Ol6GJRH1RCy/qpfS5rT6cg1
   lnlzCOogrYq3hd4I3/HpSRdyiMvMPzqommFs22ZO276BVFce0IvhT85W8
   jAiO6Da4A+wYdpODE/JJSrF2Xc/ZftetBxGW9GBRbrK4m3UJcwXQzKvvy
   ABuqpOSX7fznFVewhhjDGAzruzs7xOTlCvJAj5aSKk7xWxRoJmonUWC4m
   fhVXiidokPaItl/iU+Mh18Pc+gYMjkvivTyv1mD5yy+knr298in4arCaS
   2Dkm9GZFlhEIV/qR1fb/3X2yigy0O8UrvcZjOaV2MfG6lMPlPWgPOB1Nf
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="354737864"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="354737864"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 17:42:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="891590512"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 05 May 2022 17:42:11 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmm2s-000Cso-Gw;
        Fri, 06 May 2022 00:42:10 +0000
Date:   Fri, 6 May 2022 08:41:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Anuj Gupta <anuj20.g@samsung.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [axboe-block:for-5.19/io_uring-passthrough 90/91]
 drivers/nvme/host/multipath.c:440:27: error: initialization of 'int
 (*)(struct io_uring_cmd *, unsigned int)' from incompatible pointer type
 'void (*)(struct io_uring_cmd *, unsigned int)'
Message-ID: <202205060818.JVCJuprZ-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-5.19/io_uring-passthrough
head:   5216380430fe99277e745867b6d9232e09dd1a21
commit: cedc754a8590e5531ec9e85a44e6fe1e296d10c4 [90/91] nvme: wire-up uring-cmd support for io-passthru on char-device.
config: i386-debian-10.3 (https://download.01.org/0day-ci/archive/20220506/202205060818.JVCJuprZ-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?id=cedc754a8590e5531ec9e85a44e6fe1e296d10c4
        git remote add axboe-block https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
        git fetch --no-tags axboe-block for-5.19/io_uring-passthrough
        git checkout cedc754a8590e5531ec9e85a44e6fe1e296d10c4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/nvme/host/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/nvme/host/multipath.c:440:27: error: initialization of 'int (*)(struct io_uring_cmd *, unsigned int)' from incompatible pointer type 'void (*)(struct io_uring_cmd *, unsigned int)' [-Werror=incompatible-pointer-types]
     440 |         .uring_cmd      = nvme_ns_head_chr_uring_cmd,
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/nvme/host/multipath.c:440:27: note: (near initialization for 'nvme_ns_head_chr_fops.uring_cmd')
   cc1: some warnings being treated as errors


vim +440 drivers/nvme/host/multipath.c

   433	
   434	static const struct file_operations nvme_ns_head_chr_fops = {
   435		.owner		= THIS_MODULE,
   436		.open		= nvme_ns_head_chr_open,
   437		.release	= nvme_ns_head_chr_release,
   438		.unlocked_ioctl	= nvme_ns_head_chr_ioctl,
   439		.compat_ioctl	= compat_ptr_ioctl,
 > 440		.uring_cmd	= nvme_ns_head_chr_uring_cmd,
   441	};
   442	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

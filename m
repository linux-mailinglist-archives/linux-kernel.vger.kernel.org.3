Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C755178DB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 23:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387572AbiEBVOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 17:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbiEBVOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 17:14:45 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E131104
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 14:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651525875; x=1683061875;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SQceIYpObcRJKDIzO2ofiVSapZ/ciaY5IFvlc2e2pH0=;
  b=ULQf61m7ArC4lNWp8BddiZnHsoT70VbcPcfrqL8THPuwG8/LTs5fTz0q
   QCuIax3zi9C/6hvoergMS2uvXgppRvNY8HWvGb1v6fkEtHTeKyRBVy9oz
   e0XfpLQ1OPFchiX1RuHWtAlFAde0+t8RtFA39CadwEySsG7t8SvVL0pZP
   rheIRJd7oBmdceNRGjm4mAgw/alXfdTPRtGQF5kmUBpJs8gxlZ4swGjbU
   OAklIUENYwAgOZsdnuyGymNqNe+mYRc2VOsqGviMwT7k3CE3awNAoX88Q
   PF1NS50vrJArloSGl+DKT4wG2cw6p8W3+w/0aF2/S+teV2EdxA3/tr4Bw
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="353765056"
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="353765056"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 14:11:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="620075494"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 02 May 2022 14:11:13 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nldK4-0009sa-IV;
        Mon, 02 May 2022 21:11:12 +0000
Date:   Tue, 3 May 2022 05:10:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Changpeng Liu <changpeng.liu@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Stephen Barber <smbarber@chromium.org>,
        Dylan Reid <dgreid@chromium.org>,
        Ryan Case <ryandcase@chromium.org>
Subject: [jsarha:topic/cros-sof-v4.19 353/6555]
 drivers/block/virtio_blk.c:197:32: sparse: sparse: incorrect type in
 assignment (different base types)
Message-ID: <202205030546.EHrD3oCf-lkp@intel.com>
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

tree:   https://github.com/jsarha/linux topic/cros-sof-v4.19
head:   d7a3e91d8d16d1ef8653deec5a1fffc4de034a0c
commit: 9f34ca2c7bcf381efb6f3e1a876dedf95f9b68ed [353/6555] BACKPORT: FROMLIST: virtio_blk: add discard and write zeroes support
config: i386-randconfig-s002-20220502 (https://download.01.org/0day-ci/archive/20220503/202205030546.EHrD3oCf-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/jsarha/linux/commit/9f34ca2c7bcf381efb6f3e1a876dedf95f9b68ed
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/cros-sof-v4.19
        git checkout 9f34ca2c7bcf381efb6f3e1a876dedf95f9b68ed
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/block/ drivers/input/keyboard/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/block/virtio_blk.c:197:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __virtio32 [usertype] flags @@     got restricted __le32 [usertype] @@
   drivers/block/virtio_blk.c:197:32: sparse:     expected restricted __virtio32 [usertype] flags
   drivers/block/virtio_blk.c:197:32: sparse:     got restricted __le32 [usertype]
>> drivers/block/virtio_blk.c:198:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __virtio32 [usertype] num_sectors @@     got restricted __le32 [usertype] @@
   drivers/block/virtio_blk.c:198:38: sparse:     expected restricted __virtio32 [usertype] num_sectors
   drivers/block/virtio_blk.c:198:38: sparse:     got restricted __le32 [usertype]
>> drivers/block/virtio_blk.c:199:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __virtio64 [usertype] sector @@     got restricted __le64 [usertype] @@
   drivers/block/virtio_blk.c:199:33: sparse:     expected restricted __virtio64 [usertype] sector
   drivers/block/virtio_blk.c:199:33: sparse:     got restricted __le64 [usertype]

vim +197 drivers/block/virtio_blk.c

   175	
   176	
   177	static inline int virtblk_setup_discard_write_zeroes(struct request *req,
   178							     bool unmap)
   179	{
   180		unsigned short segments = blk_rq_nr_discard_segments(req);
   181		unsigned short n = 0;
   182		struct virtio_blk_discard_write_zeroes *range;
   183		struct bio *bio;
   184		u32 flags = 0;
   185	
   186		if (unmap)
   187			flags |= VIRTIO_BLK_WRITE_ZEROES_FLAG_UNMAP;
   188	
   189		range = kmalloc_array(segments, sizeof(*range), GFP_ATOMIC);
   190		if (!range)
   191			return -ENOMEM;
   192	
   193		__rq_for_each_bio(bio, req) {
   194			u64 sector = bio->bi_iter.bi_sector;
   195			u32 num_sectors = bio->bi_iter.bi_size >> 9;
   196	
 > 197			range[n].flags = cpu_to_le32(flags);
 > 198			range[n].num_sectors = cpu_to_le32(num_sectors);
 > 199			range[n].sector = cpu_to_le64(sector);
   200			n++;
   201		}
   202	
   203		req->special_vec.bv_page = virt_to_page(range);
   204		req->special_vec.bv_offset = offset_in_page(range);
   205		req->special_vec.bv_len = sizeof(*range) * segments;
   206		req->rq_flags |= RQF_SPECIAL_PAYLOAD;
   207	
   208		return 0;
   209	}
   210	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

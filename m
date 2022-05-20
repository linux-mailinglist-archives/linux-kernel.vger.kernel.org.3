Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2DF52EDE4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350143AbiETOMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbiETOMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 10:12:51 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87E71271A5
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653055969; x=1684591969;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iKY8F/VX/plDWOJFSr49vGSKgylKvy8RoB+nml/xJLw=;
  b=lMvvijTILLaDQ3fBmZavjpmcP2bIrzOd+4hCeLYDZCeeZLTYWh4rSLYD
   /UtXJCiRIs9xQBKGz5jJB2aR5W/iQP8y3ErxuyUORp3cmsmGY9v5kWPKJ
   CcOWdyEqwpckI80EnZ2+Mx377B4rBfTaEjGzl9I6T2Ivk2hco3MM9EIfq
   COPHgmIkBw6Snst1NUY9d8dCnbLb2QSFeY8nJTU2328QrTbBQ46P6bPSK
   FYnLNmB0d9djVoxg4KIj7yb7ucCDUj5JVeySyDAGFT89J2OheqUToL1fu
   DhumJSaEbvCWf/oZzhSMnus9ljLKfAalQ501v81yQqGrOvW1bTl8kLUzY
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="272742389"
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="272742389"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 07:12:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="628173499"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 20 May 2022 07:12:47 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ns3N0-0004mA-Qu;
        Fri, 20 May 2022 14:12:46 +0000
Date:   Fri, 20 May 2022 22:12:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bo Liu <liubo03@inspur.com>, mst@redhat.com, jasowang@redhat.com
Cc:     kbuild-all@lists.01.org, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Bo Liu <liubo03@inspur.com>
Subject: Re: [PATCH] virtio_ring: remove unused variable in virtqueue_add()
Message-ID: <202205202236.ztzLWFZ4-lkp@intel.com>
References: <20220520070740.7151-1-liubo03@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520070740.7151-1-liubo03@inspur.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bo,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.18-rc7 next-20220519]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Bo-Liu/virtio_ring-remove-unused-variable-in-virtqueue_add/20220520-161845
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 3d7285a335edaf23b699e87c528cf0b0070e3293
config: x86_64-rhel-8.3-func (https://download.01.org/0day-ci/archive/20220520/202205202236.ztzLWFZ4-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/8344061823a47f3245d81db45f5898d940ac488e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Bo-Liu/virtio_ring-remove-unused-variable-in-virtqueue_add/20220520-161845
        git checkout 8344061823a47f3245d81db45f5898d940ac488e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/virtio/virtio_ring.c: In function 'virtqueue_add':
>> drivers/virtio/virtio_ring.c:1785:16: error: 'vq' undeclared (first use in this function); did you mean '_vq'?
    1785 |         return vq->packed_ring ? virtqueue_add_packed(_vq, sgs, total_sg,
         |                ^~
         |                _vq
   drivers/virtio/virtio_ring.c:1785:16: note: each undeclared identifier is reported only once for each function it appears in
   drivers/virtio/virtio_ring.c:1789:1: error: control reaches end of non-void function [-Werror=return-type]
    1789 | }
         | ^
   cc1: some warnings being treated as errors


vim +1785 drivers/virtio/virtio_ring.c

1ce9e6055fa0a9 Tiwei Bie 2018-11-21  1770  
1ce9e6055fa0a9 Tiwei Bie 2018-11-21  1771  
e6f633e5beab65 Tiwei Bie 2018-11-21  1772  /*
e6f633e5beab65 Tiwei Bie 2018-11-21  1773   * Generic functions and exported symbols.
e6f633e5beab65 Tiwei Bie 2018-11-21  1774   */
e6f633e5beab65 Tiwei Bie 2018-11-21  1775  
e6f633e5beab65 Tiwei Bie 2018-11-21  1776  static inline int virtqueue_add(struct virtqueue *_vq,
e6f633e5beab65 Tiwei Bie 2018-11-21  1777  				struct scatterlist *sgs[],
e6f633e5beab65 Tiwei Bie 2018-11-21  1778  				unsigned int total_sg,
e6f633e5beab65 Tiwei Bie 2018-11-21  1779  				unsigned int out_sgs,
e6f633e5beab65 Tiwei Bie 2018-11-21  1780  				unsigned int in_sgs,
e6f633e5beab65 Tiwei Bie 2018-11-21  1781  				void *data,
e6f633e5beab65 Tiwei Bie 2018-11-21  1782  				void *ctx,
e6f633e5beab65 Tiwei Bie 2018-11-21  1783  				gfp_t gfp)
e6f633e5beab65 Tiwei Bie 2018-11-21  1784  {
1ce9e6055fa0a9 Tiwei Bie 2018-11-21 @1785  	return vq->packed_ring ? virtqueue_add_packed(_vq, sgs, total_sg,
1ce9e6055fa0a9 Tiwei Bie 2018-11-21  1786  					out_sgs, in_sgs, data, ctx, gfp) :
1ce9e6055fa0a9 Tiwei Bie 2018-11-21  1787  				 virtqueue_add_split(_vq, sgs, total_sg,
e6f633e5beab65 Tiwei Bie 2018-11-21  1788  					out_sgs, in_sgs, data, ctx, gfp);
e6f633e5beab65 Tiwei Bie 2018-11-21  1789  }
e6f633e5beab65 Tiwei Bie 2018-11-21  1790  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

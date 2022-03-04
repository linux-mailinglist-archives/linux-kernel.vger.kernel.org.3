Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4094CCDD3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 07:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238428AbiCDGem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 01:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238425AbiCDGej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 01:34:39 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6392B19C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 22:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646375625; x=1677911625;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iLSMjd+QXKPx8yaMCa7rXXq/g7ugar8tqhrTd6JAp/w=;
  b=cEB1Y1QygGjagrj5BOdCsuiV8zyAUjeFd24e78H6JPIDoIFhxBbcQCVR
   B5UV7NhHdVX6Tf04yOuAS+bmzj6KDGmXwNWsSzNTDF1hpgsKLAo673l8j
   UaOCQf+tNO7rrsN720EkWAKp7iE8ufQz+COn1UU1QSj4sxByPjOy+NTjY
   Au4Y/F+e/SafCICizisnIZ2hg8s3UkN8Ol8CGnGs18Wgs90QYZaL8Nel9
   +3QGGhtfDXPqsWIhI+N+ksS7yZsI93MSF7JB5+7k8alWCxpZlY223FCOy
   ZoQr46oy1t2We0Z0xKvDQlO1yi4SuWkcNegGvCBHQJZJpJ/4MJk0z7UQY
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="340340290"
X-IronPort-AV: E=Sophos;i="5.90,154,1643702400"; 
   d="scan'208";a="340340290"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 22:33:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,154,1643702400"; 
   d="scan'208";a="508894464"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 03 Mar 2022 22:33:43 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nQ1VW-0001NG-MX; Fri, 04 Mar 2022 06:33:42 +0000
Date:   Fri, 4 Mar 2022 14:32:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lingfeng Yang <lfy@google.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Alistair Delva <adelva@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android-4.14-stable
 3332/9999] drivers/gpu/drm/virtio/virtgpu_vq.c:1130:23: sparse: sparse:
 incorrect type in assignment (different base types)
Message-ID: <202203041419.Yp7SwxGu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-4.14-stable
head:   4ab5bac1598e3ed91a6267f6cada336467312112
commit: 4d701a3899580b291122ab7b147bc20981afd349 [3332/9999] CHROMIUM: drm/virtio: rebase zero-copy patches to virgl/drm-misc-next
config: i386-randconfig-s001-20211101 (https://download.01.org/0day-ci/archive/20220304/202203041419.Yp7SwxGu-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/4d701a3899580b291122ab7b147bc20981afd349
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-4.14-stable
        git checkout 4d701a3899580b291122ab7b147bc20981afd349
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/virtio/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/gpu/drm/virtio/virtgpu_vq.c:200:33: sparse: sparse: restricted __le32 degrades to integer
   drivers/gpu/drm/virtio/virtgpu_vq.c:200:43: sparse: sparse: restricted __le32 degrades to integer
>> drivers/gpu/drm/virtio/virtgpu_vq.c:1130:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le64 [usertype] offset @@     got unsigned long long [usertype] offset @@
   drivers/gpu/drm/virtio/virtgpu_vq.c:1130:23: sparse:     expected restricted __le64 [usertype] offset
   drivers/gpu/drm/virtio/virtgpu_vq.c:1130:23: sparse:     got unsigned long long [usertype] offset

vim +1130 drivers/gpu/drm/virtio/virtgpu_vq.c

  1107	
  1108	void virtio_gpu_cmd_map(struct virtio_gpu_device *vgdev,
  1109				struct virtio_gpu_object *bo,
  1110				uint64_t offset,
  1111				struct virtio_gpu_fence *fence)
  1112	{
  1113		struct virtio_gpu_resource_map *cmd_p;
  1114		struct virtio_gpu_vbuffer *vbuf;
  1115		struct virtio_gpu_resp_map_info *resp_buf;
  1116	
  1117		resp_buf = kzalloc(sizeof(*resp_buf), GFP_KERNEL);
  1118		if (!resp_buf) {
  1119			DRM_ERROR("allocation failure\n");
  1120			return;
  1121		}
  1122	
  1123		cmd_p = virtio_gpu_alloc_cmd_resp(vgdev,
  1124			virtio_gpu_cmd_resource_map_cb, &vbuf, sizeof(*cmd_p),
  1125			sizeof(struct virtio_gpu_resp_map_info), resp_buf);
  1126		memset(cmd_p, 0, sizeof(*cmd_p));
  1127	
  1128		cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_RESOURCE_MAP);
  1129		cmd_p->resource_id = cpu_to_le32(bo->hw_res_handle);
> 1130		cmd_p->offset = offset;
  1131	
  1132		virtio_gpu_queue_fenced_ctrl_buffer(vgdev, vbuf, &cmd_p->hdr, fence);
  1133	}
  1134	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

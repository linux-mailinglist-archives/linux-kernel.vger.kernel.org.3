Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6ACA5625F2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 00:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiF3WRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 18:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiF3WRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 18:17:18 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6737657257
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 15:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656627436; x=1688163436;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+yHWc7muMiZAkjfzNik3Y4IeNpSk+BGTQ20ZIneqc2o=;
  b=F8/4GLnfTxX/UqHQeEKOC4nUUAzkfnkx7Npqe4zrrKC4yQ+anH3dcyWR
   6MiqlQH0Fl2ZOzpa8+8hRk4t4pms12LIs2CWgr1WhjxlVpBuKRIjXPPBw
   LrHdpTnqMYz7QGsThfWhSelRtD8J/3Qun5z6s33zPnuswj1myiENdhOu5
   vKUzkV1HZOMt1scQ+Wn2X/apo2AL2gd+AgQXRNZO9hh7DC91kRRzG0YCL
   Ujj4fFNzEiDdBUSuI2UMuFkS99IoS+FmK87Pg+g1fBl+Nof/vtX8AFR5D
   XyQ2f/FK7DZtkh3q1uOL0PKwMpb5KzaDSoLtjDMPiHqhqXOpGV/u3LRsx
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="346472247"
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="346472247"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 15:17:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="694244207"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 30 Jun 2022 15:17:13 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o72TI-000DFq-Tg;
        Thu, 30 Jun 2022 22:17:12 +0000
Date:   Fri, 1 Jul 2022 06:16:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nas Chung <nas.chung@chipsnmedia.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>,
        Robert Beckett <bob.beckett@collabora.com>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Subject: [hverkuil-media-tree:for-v5.20g 3/6]
 drivers/staging/media/wave5/wave5-vpu-dec.c:1338:6: warning: variable 'ret'
 is used uninitialized whenever 'if' condition is true
Message-ID: <202207010647.LBFPssdW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/hverkuil/media_tree.git for-v5.20g
head:   4a01406b7d1d14a1789d2fde39e8803622a76a5f
commit: 06872f144660558e5bf17a3c8979d0fe39f8414a [3/6] staging: media: wave5: Add the v4l2 layer
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20220701/202207010647.LBFPssdW-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a774ba7f60d1fef403b5507b1b1a7475d3684d71)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add hverkuil-media-tree git://linuxtv.org/hverkuil/media_tree.git
        git fetch --no-tags hverkuil-media-tree for-v5.20g
        git checkout 06872f144660558e5bf17a3c8979d0fe39f8414a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/staging/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/staging/media/wave5/wave5-vpu-dec.c:1143:7: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
                   int ret;
                       ^
>> drivers/staging/media/wave5/wave5-vpu-dec.c:1338:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (kfifo_alloc(&inst->irq_status, 16 * sizeof(int), GFP_KERNEL)) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:350:43: note: expanded from macro 'kfifo_alloc'
   #define kfifo_alloc(fifo, size, gfp_mask) \
                                             ^
   drivers/staging/media/wave5/wave5-vpu-dec.c:1358:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/staging/media/wave5/wave5-vpu-dec.c:1338:2: note: remove the 'if' if its condition is always false
           if (kfifo_alloc(&inst->irq_status, 16 * sizeof(int), GFP_KERNEL)) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/media/wave5/wave5-vpu-dec.c:1286:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   2 warnings generated.
--
>> drivers/staging/media/wave5/wave5-vpu.c:233:3: warning: format specifies type 'unsigned long long' but the argument has type 'dma_addr_t' (aka 'unsigned int') [-Wformat]
                   dev->sram_buf.daddr, dev->sram_buf.size);
                   ^~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:144:65: note: expanded from macro 'dev_err'
           dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                  ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                   _p_func(dev, fmt, ##__VA_ARGS__);                       \
                                ~~~    ^~~~~~~~~~~
>> drivers/staging/media/wave5/wave5-vpu.c:233:24: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
                   dev->sram_buf.daddr, dev->sram_buf.size);
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:144:65: note: expanded from macro 'dev_err'
           dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                  ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                   _p_func(dev, fmt, ##__VA_ARGS__);                       \
                                ~~~    ^~~~~~~~~~~
   2 warnings generated.
--
   drivers/staging/media/wave5/wave5-vpu-enc.c:1247:7: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
                   int ret;
                       ^
>> drivers/staging/media/wave5/wave5-vpu-enc.c:1459:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (kfifo_alloc(&inst->irq_status, 16 * sizeof(int), GFP_KERNEL)) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:350:43: note: expanded from macro 'kfifo_alloc'
   #define kfifo_alloc(fifo, size, gfp_mask) \
                                             ^
   drivers/staging/media/wave5/wave5-vpu-enc.c:1479:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/staging/media/wave5/wave5-vpu-enc.c:1459:2: note: remove the 'if' if its condition is always false
           if (kfifo_alloc(&inst->irq_status, 16 * sizeof(int), GFP_KERNEL)) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/media/wave5/wave5-vpu-enc.c:1379:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   2 warnings generated.


vim +1338 drivers/staging/media/wave5/wave5-vpu-dec.c

  1280	
  1281	static int wave5_vpu_open_dec(struct file *filp)
  1282	{
  1283		struct video_device *vdev = video_devdata(filp);
  1284		struct vpu_device *dev = video_drvdata(filp);
  1285		struct vpu_instance *inst = NULL;
  1286		int ret;
  1287	
  1288		inst = kzalloc(sizeof(*inst), GFP_KERNEL);
  1289		if (!inst)
  1290			return -ENOMEM;
  1291	
  1292		inst->dev = dev;
  1293		inst->type = VPU_INST_TYPE_DEC;
  1294		inst->ops = &wave5_vpu_dec_inst_ops;
  1295	
  1296		v4l2_fh_init(&inst->v4l2_fh, vdev);
  1297		filp->private_data = &inst->v4l2_fh;
  1298		v4l2_fh_add(&inst->v4l2_fh);
  1299	
  1300		INIT_LIST_HEAD(&inst->list);
  1301		list_add_tail(&inst->list, &dev->instances);
  1302	
  1303		inst->v4l2_m2m_dev = v4l2_m2m_init(&wave5_vpu_dec_m2m_ops);
  1304		if (IS_ERR(inst->v4l2_m2m_dev)) {
  1305			ret = PTR_ERR(inst->v4l2_m2m_dev);
  1306			dev_err(inst->dev->dev, "v4l2_m2m_init fail: %d\n", ret);
  1307			goto free_inst;
  1308		}
  1309	
  1310		inst->v4l2_fh.m2m_ctx =
  1311			v4l2_m2m_ctx_init(inst->v4l2_m2m_dev, inst, wave5_vpu_dec_queue_init);
  1312		if (IS_ERR(inst->v4l2_fh.m2m_ctx)) {
  1313			ret = PTR_ERR(inst->v4l2_fh.m2m_ctx);
  1314			goto err_m2m_release;
  1315		}
  1316	
  1317		v4l2_ctrl_handler_init(&inst->v4l2_ctrl_hdl, 10);
  1318		v4l2_ctrl_new_custom(&inst->v4l2_ctrl_hdl, &wave5_vpu_thumbnail_mode, NULL);
  1319		v4l2_ctrl_new_std(&inst->v4l2_ctrl_hdl, &wave5_vpu_dec_ctrl_ops,
  1320				  V4L2_CID_MIN_BUFFERS_FOR_CAPTURE, 1, 32, 1, 1);
  1321	
  1322		if (inst->v4l2_ctrl_hdl.error) {
  1323			ret = -ENODEV;
  1324			goto err_m2m_release;
  1325		}
  1326	
  1327		inst->v4l2_fh.ctrl_handler = &inst->v4l2_ctrl_hdl;
  1328		v4l2_ctrl_handler_setup(&inst->v4l2_ctrl_hdl);
  1329	
  1330		wave5_set_default_format(&inst->src_fmt, &inst->dst_fmt);
  1331		inst->colorspace = V4L2_COLORSPACE_REC709;
  1332		inst->ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
  1333		inst->hsv_enc = 0;
  1334		inst->quantization = V4L2_QUANTIZATION_DEFAULT;
  1335		inst->xfer_func = V4L2_XFER_FUNC_DEFAULT;
  1336	
  1337		init_completion(&inst->irq_done);
> 1338		if (kfifo_alloc(&inst->irq_status, 16 * sizeof(int), GFP_KERNEL)) {
  1339			dev_err(inst->dev->dev, "failed to allocate fifo\n");
  1340			goto err_m2m_release;
  1341		}
  1342	
  1343		inst->id = ida_alloc(&inst->dev->inst_ida, GFP_KERNEL);
  1344		if (inst->id < 0) {
  1345			dev_warn(inst->dev->dev, "unable to allocate instance ID: %d\n", inst->id);
  1346			ret = inst->id;
  1347			goto err_kfifo_free;
  1348		}
  1349	
  1350		return 0;
  1351	
  1352	err_kfifo_free:
  1353		kfifo_free(&inst->irq_status);
  1354	err_m2m_release:
  1355		v4l2_m2m_release(inst->v4l2_m2m_dev);
  1356	free_inst:
  1357		kfree(inst);
  1358		return ret;
  1359	}
  1360	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

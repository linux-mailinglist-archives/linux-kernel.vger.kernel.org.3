Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EA75159A2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 03:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240151AbiD3Blw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 21:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238172AbiD3Blu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 21:41:50 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DAED082F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 18:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651282710; x=1682818710;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gVnaUfg7muXpaET/aapCq/LqD4g6nuBIMtOotXAIVMQ=;
  b=BcL6ktJTq0ZrkaRxqs7/MvWSKKxOH1yIR/P2mk2xR8VtqCHiEEj8tZ7h
   8+nNO1owj4jo60iEskJ6obcqqKzTdTObJzfsxyrIGBxffvvcKOV+g7L7l
   FZceWLfDTtzXm23OYu1iub8jENbqfH0yyRcnntSLMCBWn/VfwOrYCHv0V
   mRAH+IuMDRd8VRsavWkbON8rKBFLoBVVTalUc1lN46eCUh5a4gPYZPhhE
   AJvjOzMhOOkcZvD1civ55uX9Xln7WqoHMcAjewW9uerff5qezcJZijTcY
   dL1gD+CxBZUz5BASrJUnWBFj46mOvydU4VPaWRT7BByccF4DOSfCsgMQw
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="266978307"
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; 
   d="scan'208";a="266978307"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 18:38:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; 
   d="scan'208";a="618963220"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 29 Apr 2022 18:38:29 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkc44-0006lT-Pr;
        Sat, 30 Apr 2022 01:38:28 +0000
Date:   Sat, 30 Apr 2022 09:38:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hverkuil@xs4all.nl>
Subject: [hverkuil-media-tree:for-v5.19g 20/20]
 drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c:684:76:
 warning: cast from pointer to integer of different size
Message-ID: <202204300913.PwSevnFI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/hverkuil/media_tree.git for-v5.19g
head:   f82120aec4e7ee9f06251d36931ab36bd9ef3c42
commit: f82120aec4e7ee9f06251d36931ab36bd9ef3c42 [20/20] media: mediatek: vcodec: add h264 decoder driver for mt8186
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20220430/202204300913.PwSevnFI-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add hverkuil-media-tree git://linuxtv.org/hverkuil/media_tree.git
        git fetch --no-tags hverkuil-media-tree for-v5.19g
        git checkout f82120aec4e7ee9f06251d36931ab36bd9ef3c42
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/media/platform/mediatek/vcodec/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:555,
                    from include/linux/kernel.h:29,
                    from include/linux/cpumask.h:10,
                    from include/linux/smp.h:13,
                    from arch/mips/include/asm/cpu-type.h:12,
                    from arch/mips/include/asm/timex.h:19,
                    from include/linux/timex.h:65,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c:7:
   drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c: In function 'vdec_h264_slice_single_decode':
>> drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c:684:76: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     684 |                          inst->ctx->decoded_frame_cnt, y_fb_dma, c_fb_dma, (u64)fb);
         |                                                                            ^
   include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:162:9: note: in expansion of macro '_dynamic_func_call'
     162 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/printk.h:570:9: note: in expansion of macro 'dynamic_pr_debug'
     570 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~
   drivers/media/platform/mediatek/vcodec/vdec/../mtk_vcodec_util.h:45:9: note: in expansion of macro 'pr_debug'
      45 |         pr_debug("[MTK_VCODEC][%d]: " fmt "\n",                 \
         |         ^~~~~~~~
   drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c:683:9: note: in expansion of macro 'mtk_vcodec_debug'
     683 |         mtk_vcodec_debug(inst, "+ [%d] FB y_dma=%llx c_dma=%llx va=0x%llx",
         |         ^~~~~~~~~~~~~~~~


vim +684 drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c

   659	
   660	static int vdec_h264_slice_single_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
   661						 struct vdec_fb *unused, bool *res_chg)
   662	{
   663		struct vdec_h264_slice_inst *inst = h_vdec;
   664		struct vdec_vpu_inst *vpu = &inst->vpu;
   665		struct mtk_video_dec_buf *src_buf_info, *dst_buf_info;
   666		struct vdec_fb *fb;
   667		unsigned char *buf;
   668		unsigned int nal_start_idx, data[2], i;
   669		u64 y_fb_dma, c_fb_dma;
   670		struct mtk_vcodec_mem *mem;
   671		int err;
   672	
   673		/* bs NULL means flush decoder */
   674		if (!bs)
   675			return vpu_dec_reset(vpu);
   676	
   677		fb = inst->ctx->dev->vdec_pdata->get_cap_buffer(inst->ctx);
   678		src_buf_info = container_of(bs, struct mtk_video_dec_buf, bs_buffer);
   679		dst_buf_info = container_of(fb, struct mtk_video_dec_buf, frame_buffer);
   680	
   681		y_fb_dma = fb ? (u64)fb->base_y.dma_addr : 0;
   682		c_fb_dma = fb ? (u64)fb->base_c.dma_addr : 0;
   683		mtk_vcodec_debug(inst, "+ [%d] FB y_dma=%llx c_dma=%llx va=0x%llx",
 > 684				 inst->ctx->decoded_frame_cnt, y_fb_dma, c_fb_dma, (u64)fb);
   685	
   686		inst->vsi_ctx.dec.bs_buf_addr = (u64)bs->dma_addr;
   687		inst->vsi_ctx.dec.bs_buf_size = bs->size;
   688		inst->vsi_ctx.dec.y_fb_dma = y_fb_dma;
   689		inst->vsi_ctx.dec.c_fb_dma = c_fb_dma;
   690		inst->vsi_ctx.dec.vdec_fb_va = (u64)(uintptr_t)fb;
   691	
   692		v4l2_m2m_buf_copy_metadata(&src_buf_info->m2m_buf.vb,
   693					   &dst_buf_info->m2m_buf.vb, true);
   694		err = get_vdec_sig_decode_parameters(inst);
   695		if (err)
   696			goto err_free_fb_out;
   697	
   698		buf = (unsigned char *)bs->va;
   699		nal_start_idx = mtk_vdec_h264_find_start_code(buf, bs->size);
   700		if (nal_start_idx < 0) {
   701			err = -EINVAL;
   702			goto err_free_fb_out;
   703		}
   704		inst->vsi_ctx.dec.nal_info = buf[nal_start_idx];
   705	
   706		*res_chg = inst->resolution_changed;
   707		if (inst->resolution_changed) {
   708			mtk_vcodec_debug(inst, "- resolution changed -");
   709			if (inst->realloc_mv_buf) {
   710				err = vdec_h264_slice_alloc_mv_buf(inst, &inst->ctx->picinfo);
   711				inst->realloc_mv_buf = false;
   712				if (err)
   713					goto err_free_fb_out;
   714			}
   715			inst->resolution_changed = false;
   716	
   717			for (i = 0; i < H264_MAX_MV_NUM; i++) {
   718				mem = &inst->mv_buf[i];
   719				inst->vsi_ctx.mv_buf_dma[i] = mem->dma_addr;
   720			}
   721		}
   722	
   723		memcpy_toio(inst->vpu.vsi, &inst->vsi_ctx, sizeof(inst->vsi_ctx));
   724		err = vpu_dec_start(vpu, data, 2);
   725		if (err)
   726			goto err_free_fb_out;
   727	
   728		/* wait decoder done interrupt */
   729		err = mtk_vcodec_wait_for_done_ctx(inst->ctx, MTK_INST_IRQ_RECEIVED,
   730						   WAIT_INTR_TIMEOUT_MS, MTK_VDEC_CORE);
   731		if (err)
   732			mtk_vcodec_err(inst, "decode timeout: pic_%d",
   733				       inst->ctx->decoded_frame_cnt);
   734	
   735		inst->vsi->dec.timeout = !!err;
   736		err = vpu_dec_end(vpu);
   737		if (err)
   738			goto err_free_fb_out;
   739	
   740		memcpy_fromio(&inst->vsi_ctx, inst->vpu.vsi, sizeof(inst->vsi_ctx));
   741		mtk_vcodec_debug(inst, "pic[%d] crc: 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x",
   742				 inst->ctx->decoded_frame_cnt,
   743				 inst->vsi_ctx.dec.crc[0], inst->vsi_ctx.dec.crc[1],
   744				 inst->vsi_ctx.dec.crc[2], inst->vsi_ctx.dec.crc[3],
   745				 inst->vsi_ctx.dec.crc[4], inst->vsi_ctx.dec.crc[5],
   746				 inst->vsi_ctx.dec.crc[6], inst->vsi_ctx.dec.crc[7]);
   747	
   748		inst->ctx->decoded_frame_cnt++;
   749		return 0;
   750	
   751	err_free_fb_out:
   752		mtk_vcodec_err(inst, "dec frame number: %d err: %d",
   753			       inst->ctx->decoded_frame_cnt, err);
   754		return err;
   755	}
   756	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

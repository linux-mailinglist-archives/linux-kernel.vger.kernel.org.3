Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB555554039
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 03:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355756AbiFVBrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 21:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiFVBq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 21:46:59 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F2933376;
        Tue, 21 Jun 2022 18:46:53 -0700 (PDT)
X-UUID: 2114a23344b44af6a57dc67a6d9e6346-20220622
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:43c7baa9-5298-48be-a093-f925fce9a22d,OB:10,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:45
X-CID-INFO: VERSION:1.1.6,REQID:43c7baa9-5298-48be-a093-f925fce9a22d,OB:10,LOB
        :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:45
X-CID-META: VersionHash:b14ad71,CLOUDID:f391b02d-1756-4fa3-be7f-474a6e4be921,C
        OID:8cd89d9b3457,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 2114a23344b44af6a57dc67a6d9e6346-20220622
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1066095946; Wed, 22 Jun 2022 09:46:48 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 22 Jun 2022 09:46:46 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Wed, 22 Jun 2022 09:46:45 +0800
Message-ID: <f2bfe015696e943ffddad3be236a00437d18ae51.camel@mediatek.com>
Subject: Re: [PATCH v4, 3/3] media: mediatek: vcodec: add h264 decoder
 driver for mt8186
From:   "yunfei.dong@mediatek.com" <yunfei.dong@mediatek.com>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Tomasz Figa" <tfiga@google.com>
CC:     George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Fritz Koenig" <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        Steve Cho <stevecho@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Wed, 22 Jun 2022 09:46:45 +0800
In-Reply-To: <0f8f32e2b05a93f305e64a67177acd487a6966f4.camel@ndufresne.ca>
References: <20220512034620.30500-1-yunfei.dong@mediatek.com>
         <20220512034620.30500-4-yunfei.dong@mediatek.com>
         <7c0ab49b01c4e80835000eb1d3fd58db542385f2.camel@ndufresne.ca>
         <2e1584f4804c88c4ae9a460c7cb2d4a57ff72e7d.camel@mediatek.com>
         <0f8f32e2b05a93f305e64a67177acd487a6966f4.camel@ndufresne.ca>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

Thanks for your suggestion.
On Tue, 2022-06-21 at 10:53 -0400, Nicolas Dufresne wrote:
> > 
> Le mercredi 15 juin 2022 à 19:33 +0800, yunfei.dong@mediatek.com a
> écrit :
> > Hi Nicolas,
> > 
> > Thanks for your comments.
> > On Mon, 2022-06-13 at 16:08 -0400, Nicolas Dufresne wrote:
> > > Le jeudi 12 mai 2022 à 11:46 +0800, Yunfei Dong a écrit :
> > > > Add h264 decode driver to support mt8186. For the architecture
> > > > is single core, need to add new interface to decode.
> > > > 
> > > > Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> > > > ---
> > > >  .../vcodec/vdec/vdec_h264_req_multi_if.c      | 177
> > > > +++++++++++++++++-
> > > >  1 file changed, 176 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git
> > > > a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_mul
> > > > ti_i
> > > > f.c
> > > > b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_mul
> > > > ti_i
> > > > f.c
> > > > index a96f203b5d54..1d9e753cf894 100644
> > > > ---
> > > > a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_mul
> > > > ti_i
> > > > f.c
> > > > +++
> > > > b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_mul
> > > > ti_i
> > > > f.c
> > > > @@ -140,6 +140,9 @@ struct vdec_h264_slice_share_info {
> > > >   * @vsi:		vsi used for lat
> > > >   * @vsi_core:		vsi used for core
> > > >   *
> > > > + * @vsi_ctx:		Local VSI data for this decoding
> > > > context
> > > > + * @h264_slice_param:	the parameters that hardware use to
> > > > decode
> > > > + *
> > > >   * @resolution_changed:resolution changed
> > > >   * @realloc_mv_buf:	reallocate mv buffer
> > > >   * @cap_num_planes:	number of capture queue plane
> > > > @@ -157,6 +160,9 @@ struct vdec_h264_slice_inst {
> > > >  	struct vdec_h264_slice_vsi *vsi;
> > > >  	struct vdec_h264_slice_vsi *vsi_core;
> > > >  
> > > > +	struct vdec_h264_slice_vsi vsi_ctx;
> > > > +	struct vdec_h264_slice_lat_dec_param h264_slice_param;
> > > > +
> > > >  	unsigned int resolution_changed;
> > > >  	unsigned int realloc_mv_buf;
> > > >  	unsigned int cap_num_planes;
> > > > @@ -208,6 +214,61 @@ static int
> > > > vdec_h264_slice_fill_decode_parameters(struct
> > > > vdec_h264_slice_inst
> > > > *i
> > > >  	return 0;
> > > >  }
> > > >  
> > > > +static int get_vdec_sig_decode_parameters(struct
> > > > vdec_h264_slice_inst *inst)
> > > > +{
> > > > +	const struct v4l2_ctrl_h264_decode_params *dec_params;
> > > > +	const struct v4l2_ctrl_h264_sps *sps;
> > > > +	const struct v4l2_ctrl_h264_pps *pps;
> > > > +	const struct v4l2_ctrl_h264_scaling_matrix
> > > > *scaling_matrix;
> > > > +	struct vdec_h264_slice_lat_dec_param *slice_param =
> > > > &inst-
> > > > > h264_slice_param;
> > > > 
> > > > +	struct v4l2_h264_reflist_builder reflist_builder;
> > > > +	u8 *p0_reflist = slice_param-
> > > > >decode_params.ref_pic_list_p0;
> > > > +	u8 *b0_reflist = slice_param-
> > > > >decode_params.ref_pic_list_b0;
> > > > +	u8 *b1_reflist = slice_param-
> > > > >decode_params.ref_pic_list_b1;
> > > > +
> > > > +	dec_params =
> > > > +		mtk_vdec_h264_get_ctrl_ptr(inst->ctx,
> > > > V4L2_CID_STATELESS_H264_DECODE_PARAMS);
> > > > +	if (IS_ERR(dec_params))
> > > > +		return PTR_ERR(dec_params);
> > > > +
> > > > +	sps = mtk_vdec_h264_get_ctrl_ptr(inst->ctx,
> > > > V4L2_CID_STATELESS_H264_SPS);
> > > > +	if (IS_ERR(sps))
> > > > +		return PTR_ERR(sps);
> > > > +
> > > > +	pps = mtk_vdec_h264_get_ctrl_ptr(inst->ctx,
> > > > V4L2_CID_STATELESS_H264_PPS);
> > > > +	if (IS_ERR(pps))
> > > > +		return PTR_ERR(pps);
> > > > +
> > > > +	scaling_matrix =
> > > > +		mtk_vdec_h264_get_ctrl_ptr(inst->ctx,
> > > > V4L2_CID_STATELESS_H264_SCALING_MATRIX);
> > > > +	if (IS_ERR(scaling_matrix))
> > > > +		return PTR_ERR(scaling_matrix);
> > > > +
> > > > +	mtk_vdec_h264_update_dpb(dec_params, inst->dpb);
> > > > +
> > > > +	mtk_vdec_h264_copy_sps_params(&slice_param->sps, sps);
> > > > +	mtk_vdec_h264_copy_pps_params(&slice_param->pps, pps);
> > > > +	mtk_vdec_h264_copy_scaling_matrix(&slice_param-
> > > > >scaling_matrix, 
> > > > scaling_matrix);
> > > > +
> > > > +	mtk_vdec_h264_copy_decode_params(&slice_param-
> > > > >decode_params,
> > > > dec_params, inst->dpb);
> > > > +	mtk_vdec_h264_fill_dpb_info(inst->ctx, &slice_param-
> > > > > decode_params,
> > > > 
> > > > +				    slice_param-
> > > > >h264_dpb_info);
> > > > +
> > > > +	/* Build the reference lists */
> > > > +	v4l2_h264_init_reflist_builder(&reflist_builder,
> > > > dec_params,
> > > > sps, inst->dpb);
> > > > +	v4l2_h264_build_p_ref_list(&reflist_builder,
> > > > p0_reflist);
> > > > +
> > > > +	v4l2_h264_build_b_ref_lists(&reflist_builder,
> > > > b0_reflist,
> > > > b1_reflist);
> > > > +	/* Adapt the built lists to the firmware's expectations
> > > > */
> > > > +	mtk_vdec_h264_fixup_ref_list(p0_reflist,
> > > > reflist_builder.num_valid);
> > > > +	mtk_vdec_h264_fixup_ref_list(b0_reflist,
> > > > reflist_builder.num_valid);
> > > > +	mtk_vdec_h264_fixup_ref_list(b1_reflist,
> > > > reflist_builder.num_valid);
> > > > +	memcpy(&inst->vsi_ctx.h264_slice_params, slice_param,
> > > > +	       sizeof(inst->vsi_ctx.h264_slice_params));
> > > 
> > > This function looks very redundant across multiple variants,
> > > could
> > > you try and
> > > make a helper to reduce the duplication ?
> > > 
> > 
> > At first, I try to add one helper function for single core and lat
> > decode.
> > 
> > But these two hardware have big differences, need to add many
> > condition
> > to separate. So just add new function for mt8186 single core
> > architecture.
> 
> I still think you could have a very small helper that turns the
> reflist_builder
> incantation (which are fully identical in all SoC), to be one
> line/call. It was
> annoying when I recently had to update this driver for some internal
> API change.
> 
I will refactor the driver flow and add one simple helper function.

Best Regards,
Yunfei Dong
> > Best Regards,
> > Yunfei Dong
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > >  static void vdec_h264_slice_fill_decode_reflist(struct
> > > > vdec_h264_slice_inst *inst,
> > > >  						struct
> > > > vdec_h264_slice_lat_dec_param *slice_param,
> > > >  						struct
> > > > vdec_h264_slice_share_info *share_info)
> > > > @@ -596,6 +657,120 @@ static int
> > > > vdec_h264_slice_lat_decode(void
> > > > *h_vdec, struct mtk_vcodec_mem *bs,
> > > >  	return err;
> > > >  }
> > > >  
> > > > +static int vdec_h264_slice_single_decode(void *h_vdec, struct
> > > > mtk_vcodec_mem *bs,
> > > > +					 struct vdec_fb
> > > > *unused, bool
> > > > *res_chg)
> > > > +{
> > > > +	struct vdec_h264_slice_inst *inst = h_vdec;
> > > > +	struct vdec_vpu_inst *vpu = &inst->vpu;
> > > > +	struct mtk_video_dec_buf *src_buf_info, *dst_buf_info;
> > > > +	struct vdec_fb *fb;
> > > > +	unsigned char *buf;
> > > > +	unsigned int data[2], i;
> > > > +	u64 y_fb_dma, c_fb_dma;
> > > > +	struct mtk_vcodec_mem *mem;
> > > > +	int err, nal_start_idx;
> > > > +
> > > > +	/* bs NULL means flush decoder */
> > > > +	if (!bs)
> > > > +		return vpu_dec_reset(vpu);
> > > > +
> > > > +	fb = inst->ctx->dev->vdec_pdata->get_cap_buffer(inst-
> > > > >ctx);
> > > > +	src_buf_info = container_of(bs, struct
> > > > mtk_video_dec_buf,
> > > > bs_buffer);
> > > > +	dst_buf_info = container_of(fb, struct
> > > > mtk_video_dec_buf,
> > > > frame_buffer);
> > > > +
> > > > +	y_fb_dma = fb ? (u64)fb->base_y.dma_addr : 0;
> > > > +	c_fb_dma = fb ? (u64)fb->base_c.dma_addr : 0;
> > > > +	mtk_vcodec_debug(inst, "[h264-dec] [%d] y_dma=%llx
> > > > c_dma=%llx",
> > > > +			 inst->ctx->decoded_frame_cnt,
> > > > y_fb_dma,
> > > > c_fb_dma);
> > > > +
> > > > +	inst->vsi_ctx.dec.bs_buf_addr = (u64)bs->dma_addr;
> > > > +	inst->vsi_ctx.dec.bs_buf_size = bs->size;
> > > > +	inst->vsi_ctx.dec.y_fb_dma = y_fb_dma;
> > > > +	inst->vsi_ctx.dec.c_fb_dma = c_fb_dma;
> > > > +	inst->vsi_ctx.dec.vdec_fb_va = (u64)(uintptr_t)fb;
> > > > +
> > > > +	v4l2_m2m_buf_copy_metadata(&src_buf_info->m2m_buf.vb,
> > > > +				   &dst_buf_info->m2m_buf.vb,
> > > > true);
> > > > +	err = get_vdec_sig_decode_parameters(inst);
> > > > +	if (err)
> > > > +		goto err_free_fb_out;
> > > > +
> > > > +	buf = (unsigned char *)bs->va;
> > > > +	nal_start_idx = mtk_vdec_h264_find_start_code(buf, bs-
> > > > >size);
> > > > +	if (nal_start_idx < 0) {
> > > > +		err = -EINVAL;
> > > > +		goto err_free_fb_out;
> > > > +	}
> > > > +	inst->vsi_ctx.dec.nal_info = buf[nal_start_idx];
> > > > +
> > > > +	*res_chg = inst->resolution_changed;
> > > > +	if (inst->resolution_changed) {
> > > > +		mtk_vcodec_debug(inst, "- resolution changed
> > > > -");
> > > > +		if (inst->realloc_mv_buf) {
> > > > +			err =
> > > > vdec_h264_slice_alloc_mv_buf(inst, &inst-
> > > > > ctx->picinfo);
> > > > 
> > > > +			inst->realloc_mv_buf = false;
> > > > +			if (err)
> > > > +				goto err_free_fb_out;
> > > > +		}
> > > > +		inst->resolution_changed = false;
> > > > +
> > > > +		for (i = 0; i < H264_MAX_MV_NUM; i++) {
> > > > +			mem = &inst->mv_buf[i];
> > > > +			inst->vsi_ctx.mv_buf_dma[i] = mem-
> > > > >dma_addr;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	memcpy(inst->vpu.vsi, &inst->vsi_ctx, sizeof(inst-
> > > > >vsi_ctx));
> > > > +	err = vpu_dec_start(vpu, data, 2);
> > > > +	if (err)
> > > > +		goto err_free_fb_out;
> > > > +
> > > > +	/* wait decoder done interrupt */
> > > > +	err = mtk_vcodec_wait_for_done_ctx(inst->ctx,
> > > > MTK_INST_IRQ_RECEIVED,
> > > > +					   WAIT_INTR_TIMEOUT_MS
> > > > ,
> > > > MTK_VDEC_CORE);
> > > > +	if (err)
> > > > +		mtk_vcodec_err(inst, "decode timeout: pic_%d",
> > > > +			       inst->ctx->decoded_frame_cnt);
> > > > +
> > > > +	inst->vsi->dec.timeout = !!err;
> > > > +	err = vpu_dec_end(vpu);
> > > > +	if (err)
> > > > +		goto err_free_fb_out;
> > > > +
> > > > +	memcpy(&inst->vsi_ctx, inst->vpu.vsi, sizeof(inst-
> > > > >vsi_ctx));
> > > > +	mtk_vcodec_debug(inst, "pic[%d] crc: 0x%x 0x%x 0x%x
> > > > 0x%x 0x%x
> > > > 0x%x 0x%x 0x%x",
> > > > +			 inst->ctx->decoded_frame_cnt,
> > > > +			 inst->vsi_ctx.dec.crc[0], inst-
> > > > > vsi_ctx.dec.crc[1],
> > > > 
> > > > +			 inst->vsi_ctx.dec.crc[2], inst-
> > > > > vsi_ctx.dec.crc[3],
> > > > 
> > > > +			 inst->vsi_ctx.dec.crc[4], inst-
> > > > > vsi_ctx.dec.crc[5],
> > > > 
> > > > +			 inst->vsi_ctx.dec.crc[6], inst-
> > > > > vsi_ctx.dec.crc[7]);
> > > > 
> > > > +
> > > > +	inst->ctx->decoded_frame_cnt++;
> > > > +	return 0;
> > > > +
> > > > +err_free_fb_out:
> > > > +	mtk_vcodec_err(inst, "dec frame number: %d err: %d",
> > > > +		       inst->ctx->decoded_frame_cnt, err);
> > > > +	return err;
> > > > +}
> > > > +
> > > > +static int vdec_h264_slice_decode(void *h_vdec, struct
> > > > mtk_vcodec_mem *bs,
> > > > +				  struct vdec_fb *unused, bool
> > > > *res_chg)
> > > > +{
> > > > +	struct vdec_h264_slice_inst *inst = h_vdec;
> > > > +	int ret;
> > > > +
> > > > +	if (!h_vdec)
> > > > +		return -EINVAL;
> > > > +
> > > > +	if (inst->ctx->dev->vdec_pdata->hw_arch ==
> > > > MTK_VDEC_PURE_SINGLE_CORE)
> > > > +		ret = vdec_h264_slice_single_decode(h_vdec, bs,
> > > > unused,
> > > > res_chg);
> > > > +	else
> > > > +		ret = vdec_h264_slice_lat_decode(h_vdec, bs,
> > > > unused,
> > > > res_chg);
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > >  static int vdec_h264_slice_get_param(void *h_vdec, enum
> > > > vdec_get_param_type type,
> > > >  				     void *out)
> > > >  {
> > > > @@ -620,7 +795,7 @@ static int vdec_h264_slice_get_param(void
> > > > *h_vdec, enum vdec_get_param_type type
> > > >  
> > > >  const struct vdec_common_if vdec_h264_slice_multi_if = {
> > > >  	.init		= vdec_h264_slice_init,
> > > > -	.decode		= vdec_h264_slice_lat_decode,
> > > > +	.decode		= vdec_h264_slice_decode,
> > > >  	.get_param	= vdec_h264_slice_get_param,
> > > >  	.deinit		= vdec_h264_slice_deinit,
> > > >  };
> > > 
> > > 
> 
> 


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E365096CA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 07:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384495AbiDUF2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 01:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384443AbiDUF1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 01:27:30 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25A1DFAB;
        Wed, 20 Apr 2022 22:24:40 -0700 (PDT)
X-UUID: a1530d4f6bd24a21b814efd6c96aadf2-20220421
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:24d21aa4-8922-42d8-b361-164043ca0f7d,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:25
X-CID-INFO: VERSION:1.1.4,REQID:24d21aa4-8922-42d8-b361-164043ca0f7d,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:25
X-CID-META: VersionHash:faefae9,CLOUDID:556770f0-da02-41b4-b6df-58f4ccd36682,C
        OID:IGNORED,Recheck:0,SF:13|15|28|17|19|48,TC:nil,Content:0,EDM:-3,File:ni
        l,QS:0,BEC:nil
X-UUID: a1530d4f6bd24a21b814efd6c96aadf2-20220421
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1068861943; Thu, 21 Apr 2022 13:24:35 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 Apr 2022 13:24:34 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 21 Apr 2022 13:24:34 +0800
Message-ID: <3ba571f709032d131fc109f27aa021a470326f2d.camel@mediatek.com>
Subject: Re: [PATCH v2] dt-bindings: gce: add the GCE header file for MT8186
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <jassisinghbrar@gmail.com>, <robh+dt@kernel.org>
CC:     <matthias.bgg@gmail.com>, <yongqiang.niu@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Thu, 21 Apr 2022 13:24:34 +0800
In-Reply-To: <20220406091213.27939-1-rex-bc.chen@mediatek.com>
References: <20220406091213.27939-1-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jassi,

Gentle ping for this patch.
Is this patch ok for you?

BRs,
Rex

On Wed, 2022-04-06 at 17:12 +0800, Rex-BC Chen wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> Add the GCE header file to define GCE subsys ids, hardware event ids
> and constants for MT8186.
> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>
> 
> ------
> v2:
> 1. Rebase to 5.18-rc1.
> 2. Remove "dt-bindings: mailbox: add definition for mt8186" because
> it's
>    accepted.
> ------
> 
> ---
>  include/dt-bindings/gce/mt8186-gce.h | 421
> +++++++++++++++++++++++++++
>  1 file changed, 421 insertions(+)
>  create mode 100644 include/dt-bindings/gce/mt8186-gce.h
> 
> diff --git a/include/dt-bindings/gce/mt8186-gce.h b/include/dt-
> bindings/gce/mt8186-gce.h
> new file mode 100644
> index 000000000000..f12e3cb586ce
> --- /dev/null
> +++ b/include/dt-bindings/gce/mt8186-gce.h
> @@ -0,0 +1,421 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (C) 2022 MediaTek Inc.
> + * Author: Yongqiang Niu <yongqiang.niu@mediatek.com>
> + */
> +
> +#ifndef _DT_BINDINGS_GCE_MT8186_H
> +#define _DT_BINDINGS_GCE_MT8186_H
> +
> +/* assign timeout 0 also means default */
> +#define CMDQ_NO_TIMEOUT		0xffffffff
> +#define CMDQ_TIMEOUT_DEFAULT	1000
> +
> +/* GCE thread priority */
> +#define CMDQ_THR_PRIO_LOWEST	0
> +#define CMDQ_THR_PRIO_1		1
> +#define CMDQ_THR_PRIO_2		2
> +#define CMDQ_THR_PRIO_3		3
> +#define CMDQ_THR_PRIO_4		4
> +#define CMDQ_THR_PRIO_5		5
> +#define CMDQ_THR_PRIO_6		6
> +#define CMDQ_THR_PRIO_HIGHEST	7
> +
> +/* CPR count in 32bit register */
> +#define GCE_CPR_COUNT		1312
> +
> +/* GCE subsys table */
> +#define SUBSYS_1300XXXX		0
> +#define SUBSYS_1400XXXX		1
> +#define SUBSYS_1401XXXX		2
> +#define SUBSYS_1402XXXX		3
> +#define SUBSYS_1502XXXX		4
> +#define SUBSYS_1582XXXX		5
> +#define SUBSYS_1B00XXXX		6
> +#define SUBSYS_1C00XXXX		7
> +#define SUBSYS_1C10XXXX		8
> +#define SUBSYS_1000XXXX		9
> +#define SUBSYS_1001XXXX		10
> +#define SUBSYS_1020XXXX		11
> +#define SUBSYS_1021XXXX		12
> +#define SUBSYS_1022XXXX		13
> +#define SUBSYS_1023XXXX		14
> +#define SUBSYS_1060XXXX		15
> +#define SUBSYS_1602XXXX		16
> +#define SUBSYS_1608XXXX		17
> +#define SUBSYS_1700XXXX		18
> +#define SUBSYS_1701XXXX		19
> +#define SUBSYS_1702XXXX		20
> +#define SUBSYS_1703XXXX		21
> +#define SUBSYS_1706XXXX		22
> +#define SUBSYS_1A00XXXX		23
> +#define SUBSYS_1A01XXXX		24
> +#define SUBSYS_1A02XXXX		25
> +#define SUBSYS_1A03XXXX		26
> +#define SUBSYS_1A04XXXX		27
> +#define SUBSYS_1A05XXXX		28
> +#define SUBSYS_1A06XXXX		29
> +#define SUBSYS_NO_SUPPORT	99
> +
> +/* GCE General Purpose Register (GPR) support
> + * Leave note for scenario usage here
> + */
> +/* GCE: write mask */
> +#define GCE_GPR_R00		0x00
> +#define GCE_GPR_R01		0x01
> +/* MDP: P1: JPEG dest */
> +#define GCE_GPR_R02		0x02
> +#define GCE_GPR_R03		0x03
> +/* MDP: PQ color */
> +#define GCE_GPR_R04		0x04
> +/* MDP: 2D sharpness */
> +#define GCE_GPR_R05		0x05
> +/* DISP: poll esd */
> +#define GCE_GPR_R06		0x06
> +#define GCE_GPR_R07		0x07
> +/* MDP: P4: 2D sharpness dst */
> +#define GCE_GPR_R08		0x08
> +#define GCE_GPR_R09		0x09
> +/* VCU: poll with timeout for GPR timer */
> +#define GCE_GPR_R10		0x0A
> +#define GCE_GPR_R11		0x0B
> +/* CMDQ: debug */
> +#define GCE_GPR_R12		0x0C
> +#define GCE_GPR_R13		0x0D
> +/* CMDQ: P7: debug */
> +#define GCE_GPR_R14		0x0E
> +#define GCE_GPR_R15		0x0F
> +
> +/* GCE hardware events */
> +/* VDEC */
> +#define CMDQ_EVENT_LINE_COUNT_THRESHOLD_INTERRUPT	0
> +#define CMDQ_EVENT_VDEC_INT				1
> +#define CMDQ_EVENT_VDEC_PAUSE				2
> +#define CMDQ_EVENT_VDEC_DEC_ERROR			3
> +#define CMDQ_EVENT_MDEC_TIMEOUT				4
> +#define CMDQ_EVENT_DRAM_ACCESS_DONE			5
> +#define CMDQ_EVENT_INI_FETCH_RDY			6
> +#define CMDQ_EVENT_PROCESS_FLAG				7
> +#define CMDQ_EVENT_SEARCH_START_CODE_DONE		8
> +#define CMDQ_EVENT_REF_REORDER_DONE			9
> +#define CMDQ_EVENT_WP_TBLE_DONE				10
> +#define CMDQ_EVENT_COUNT_SRAM_CLR_DONE			11
> +#define CMDQ_EVENT_GCE_CNT_OP_THRESHOLD			15
> +#define CMDQ_EVENT_VDEC_MINI_MDP_EVENT_0		16
> +#define CMDQ_EVENT_VDEC_MINI_MDP_EVENT_1		17
> +#define CMDQ_EVENT_VDEC_MINI_MDP_EVENT_2		18
> +#define CMDQ_EVENT_VDEC_MINI_MDP_EVENT_3		19
> +#define CMDQ_EVENT_VDEC_MINI_MDP_EVENT_4		20
> +#define CMDQ_EVENT_VDEC_MINI_MDP_EVENT_5		21
> +#define CMDQ_EVENT_VDEC_MINI_MDP_EVENT_6		22
> +#define CMDQ_EVENT_VDEC_MINI_MDP_EVENT_7		23
> +#define CMDQ_EVENT_VDEC_MINI_MDP_EVENT_8		24
> +#define CMDQ_EVENT_VDEC_MINI_MDP_EVENT_9		25
> +#define CMDQ_EVENT_VDEC_MINI_MDP_EVENT_10		26
> +#define CMDQ_EVENT_VDEC_MINI_MDP_EVENT_11		27
> +#define CMDQ_EVENT_VDEC_MINI_MDP_EVENT_12		28
> +#define CMDQ_EVENT_VDEC_MINI_MDP_EVENT_13		29
> +#define CMDQ_EVENT_VDEC_MINI_MDP_EVENT_14		30
> +#define CMDQ_EVENT_VDEC_MINI_MDP_EVENT_15		31
> +#define CMDQ_EVENT_WPE_GCE_FRAME_DONE			32
> +
> +/* CAM */
> +#define CMDQ_EVENT_ISP_FRAME_DONE_A			65
> +#define CMDQ_EVENT_ISP_FRAME_DONE_B			66
> +#define CMDQ_EVENT_CAMSV1_PASS1_DONE			70
> +#define CMDQ_EVENT_CAMSV2_PASS1_DONE			71
> +#define CMDQ_EVENT_CAMSV3_PASS1_DONE			72
> +#define CMDQ_EVENT_MRAW_0_PASS1_DONE			73
> +#define CMDQ_EVENT_SENINF_CAM0_FIFO_FULL		75
> +#define CMDQ_EVENT_SENINF_CAM1_FIFO_FULL		76
> +#define CMDQ_EVENT_SENINF_CAM2_FIFO_FULL		77
> +#define CMDQ_EVENT_SENINF_CAM3_FIFO_FULL		78
> +#define CMDQ_EVENT_SENINF_CAM4_FIFO_FULL		79
> +#define CMDQ_EVENT_SENINF_CAM5_FIFO_FULL		80
> +#define CMDQ_EVENT_SENINF_CAM6_FIFO_FULL		81
> +#define CMDQ_EVENT_SENINF_CAM7_FIFO_FULL		82
> +#define CMDQ_EVENT_SENINF_CAM8_FIFO_FULL		83
> +#define CMDQ_EVENT_SENINF_CAM9_FIFO_FULL		84
> +#define CMDQ_EVENT_SENINF_CAM10_FIFO_FULL		85
> +#define CMDQ_EVENT_SENINF_CAM11_FIFO_FULL		86
> +#define CMDQ_EVENT_SENINF_CAM12_FIFO_FULL		87
> +#define CMDQ_EVENT_TG_OVRUN_A_INT			88
> +#define CMDQ_EVENT_DMA_R1_ERROR_A_INT			89
> +#define CMDQ_EVENT_TG_OVRUN_B_INT			90
> +#define CMDQ_EVENT_DMA_R1_ERROR_B_INT			91
> +#define CMDQ_EVENT_TG_OVRUN_M0_INT			94
> +#define CMDQ_EVENT_R1_ERROR_M0_INT			95
> +#define CMDQ_EVENT_TG_GRABERR_M0_INT			96
> +#define CMDQ_EVENT_TG_GRABERR_A_INT			98
> +#define CMDQ_EVENT_CQ_VR_SNAP_A_INT			99
> +#define CMDQ_EVENT_TG_GRABERR_B_INT			100
> +#define CMDQ_EVENT_CQ_VR_SNAP_B_INT			101
> +/* VENC */
> +#define CMDQ_EVENT_VENC_CMDQ_FRAME_DONE			129
> +#define CMDQ_EVENT_VENC_CMDQ_PAUSE_DONE			130
> +#define CMDQ_EVENT_JPGENC_CMDQ_DONE			131
> +#define CMDQ_EVENT_VENC_CMDQ_MB_DONE			132
> +#define CMDQ_EVENT_VENC_CMDQ_128BYTE_CNT_DONE		133
> +#define CMDQ_EVENT_VENC_CMDQ_PPS_DONE			136
> +#define CMDQ_EVENT_VENC_CMDQ_SPS_DONE			137
> +#define CMDQ_EVENT_VENC_CMDQ_VPS_DONE			138
> +/* IPE */
> +#define CMDQ_EVENT_FDVT_DONE				161
> +#define CMDQ_EVENT_FE_DONE				162
> +#define CMDQ_EVENT_RSC_DONE				163
> +#define CMDQ_EVENT_DVS_DONE_ASYNC_SHOT			164
> +#define CMDQ_EVENT_DVP_DONE_ASYNC_SHOT			165
> +/* IMG2 */
> +#define CMDQ_EVENT_GCE_IMG2_EVENT0			193
> +#define CMDQ_EVENT_GCE_IMG2_EVENT1			194
> +#define CMDQ_EVENT_GCE_IMG2_EVENT2			195
> +#define CMDQ_EVENT_GCE_IMG2_EVENT3			196
> +#define CMDQ_EVENT_GCE_IMG2_EVENT4			197
> +#define CMDQ_EVENT_GCE_IMG2_EVENT5			198
> +#define CMDQ_EVENT_GCE_IMG2_EVENT6			199
> +#define CMDQ_EVENT_GCE_IMG2_EVENT7			200
> +#define CMDQ_EVENT_GCE_IMG2_EVENT8			201
> +#define CMDQ_EVENT_GCE_IMG2_EVENT9			202
> +#define CMDQ_EVENT_GCE_IMG2_EVENT10			203
> +#define CMDQ_EVENT_GCE_IMG2_EVENT11			204
> +#define CMDQ_EVENT_GCE_IMG2_EVENT12			205
> +#define CMDQ_EVENT_GCE_IMG2_EVENT13			206
> +#define CMDQ_EVENT_GCE_IMG2_EVENT14			207
> +#define CMDQ_EVENT_GCE_IMG2_EVENT15			208
> +#define CMDQ_EVENT_GCE_IMG2_EVENT16			209
> +#define CMDQ_EVENT_GCE_IMG2_EVENT17			210
> +#define CMDQ_EVENT_GCE_IMG2_EVENT18			211
> +#define CMDQ_EVENT_GCE_IMG2_EVENT19			212
> +#define CMDQ_EVENT_GCE_IMG2_EVENT20			213
> +#define CMDQ_EVENT_GCE_IMG2_EVENT21			214
> +#define CMDQ_EVENT_GCE_IMG2_EVENT22			215
> +#define CMDQ_EVENT_GCE_IMG2_EVENT23			216
> +/* IMG1 */
> +#define CMDQ_EVENT_GCE_IMG1_EVENT0			225
> +#define CMDQ_EVENT_GCE_IMG1_EVENT1			226
> +#define CMDQ_EVENT_GCE_IMG1_EVENT2			227
> +#define CMDQ_EVENT_GCE_IMG1_EVENT3			228
> +#define CMDQ_EVENT_GCE_IMG1_EVENT4			229
> +#define CMDQ_EVENT_GCE_IMG1_EVENT5			230
> +#define CMDQ_EVENT_GCE_IMG1_EVENT6			231
> +#define CMDQ_EVENT_GCE_IMG1_EVENT7			232
> +#define CMDQ_EVENT_GCE_IMG1_EVENT8			233
> +#define CMDQ_EVENT_GCE_IMG1_EVENT9			234
> +#define CMDQ_EVENT_GCE_IMG1_EVENT10			235
> +#define CMDQ_EVENT_GCE_IMG1_EVENT11			236
> +#define CMDQ_EVENT_GCE_IMG1_EVENT12			237
> +#define CMDQ_EVENT_GCE_IMG1_EVENT13			238
> +#define CMDQ_EVENT_GCE_IMG1_EVENT14			239
> +#define CMDQ_EVENT_GCE_IMG1_EVENT15			240
> +#define CMDQ_EVENT_GCE_IMG1_EVENT16			241
> +#define CMDQ_EVENT_GCE_IMG1_EVENT17			242
> +#define CMDQ_EVENT_GCE_IMG1_EVENT18			243
> +#define CMDQ_EVENT_GCE_IMG1_EVENT19			244
> +#define CMDQ_EVENT_GCE_IMG1_EVENT20			245
> +#define CMDQ_EVENT_GCE_IMG1_EVENT21			246
> +#define CMDQ_EVENT_GCE_IMG1_EVENT22			247
> +#define CMDQ_EVENT_GCE_IMG1_EVENT23			248
> +/* MDP */
> +#define CMDQ_EVENT_MDP_RDMA0_SOF			256
> +#define CMDQ_EVENT_MDP_RDMA1_SOF			257
> +#define CMDQ_EVENT_MDP_AAL0_SOF				258
> +#define CMDQ_EVENT_MDP_AAL1_SOF				259
> +#define CMDQ_EVENT_MDP_HDR0_SOF				260
> +#define CMDQ_EVENT_MDP_RSZ0_SOF				261
> +#define CMDQ_EVENT_MDP_RSZ1_SOF				262
> +#define CMDQ_EVENT_MDP_WROT0_SOF			263
> +#define CMDQ_EVENT_MDP_WROT1_SOF			264
> +#define CMDQ_EVENT_MDP_TDSHP0_SOF			265
> +#define CMDQ_EVENT_MDP_TDSHP1_SOF			266
> +#define CMDQ_EVENT_IMG_DL_RELAY0_SOF			267
> +#define CMDQ_EVENT_IMG_DL_RELAY1_SOF			268
> +#define CMDQ_EVENT_MDP_COLOR0_SOF			269
> +#define CMDQ_EVENT_MDP_WROT3_FRAME_DONE			288
> +#define CMDQ_EVENT_MDP_WROT2_FRAME_DONE			289
> +#define CMDQ_EVENT_MDP_WROT1_FRAME_DONE			290
> +#define CMDQ_EVENT_MDP_WROT0_FRAME_DONE			291
> +#define CMDQ_EVENT_MDP_TDSHP3_FRAME_DONE		292
> +#define CMDQ_EVENT_MDP_TDSHP2_FRAME_DONE		293
> +#define CMDQ_EVENT_MDP_TDSHP1_FRAME_DONE		294
> +#define CMDQ_EVENT_MDP_TDSHP0_FRAME_DONE		295
> +#define CMDQ_EVENT_MDP_RSZ3_FRAME_DONE			296
> +#define CMDQ_EVENT_MDP_RSZ2_FRAME_DONE			297
> +#define CMDQ_EVENT_MDP_RSZ1_FRAME_DONE			298
> +#define CMDQ_EVENT_MDP_RSZ0_FRAME_DONE			299
> +#define CMDQ_EVENT_MDP_RDMA3_FRAME_DONE			300
> +#define CMDQ_EVENT_MDP_RDMA2_FRAME_DONE			301
> +#define CMDQ_EVENT_MDP_RDMA1_FRAME_DONE			302
> +#define CMDQ_EVENT_MDP_RDMA0_FRAME_DONE			303
> +#define CMDQ_EVENT_MDP_HDR1_FRAME_DONE			304
> +#define CMDQ_EVENT_MDP_HDR0_FRAME_DONE			305
> +#define CMDQ_EVENT_MDP_COLOR0_FRAME_DONE		306
> +#define CMDQ_EVENT_MDP_AAL3_FRAME_DONE			307
> +#define CMDQ_EVENT_MDP_AAL2_FRAME_DONE			308
> +#define CMDQ_EVENT_MDP_AAL1_FRAME_DONE			309
> +#define CMDQ_EVENT_MDP_AAL0_FRAME_DONE			310
> +#define CMDQ_EVENT_MDP_STREAM_DONE_ENG_EVENT_0		320
> +#define CMDQ_EVENT_MDP_STREAM_DONE_ENG_EVENT_1		321
> +#define CMDQ_EVENT_MDP_STREAM_DONE_ENG_EVENT_2		322
> +#define CMDQ_EVENT_MDP_STREAM_DONE_ENG_EVENT_3		323
> +#define CMDQ_EVENT_MDP_STREAM_DONE_ENG_EVENT_4		324
> +#define CMDQ_EVENT_MDP_STREAM_DONE_ENG_EVENT_5		325
> +#define CMDQ_EVENT_MDP_STREAM_DONE_ENG_EVENT_6		326
> +#define CMDQ_EVENT_MDP_STREAM_DONE_ENG_EVENT_7		327
> +#define CMDQ_EVENT_MDP_STREAM_DONE_ENG_EVENT_8		328
> +#define CMDQ_EVENT_MDP_STREAM_DONE_ENG_EVENT_9		329
> +#define CMDQ_EVENT_MDP_STREAM_DONE_ENG_EVENT_10		330
> +#define CMDQ_EVENT_MDP_STREAM_DONE_ENG_EVENT_11		331
> +#define CMDQ_EVENT_MDP_STREAM_DONE_ENG_EVENT_12		332
> +#define CMDQ_EVENT_MDP_STREAM_DONE_ENG_EVENT_13		333
> +#define CMDQ_EVENT_MDP_STREAM_DONE_ENG_EVENT_14		334
> +#define CMDQ_EVENT_MDP_STREAM_DONE_ENG_EVENT_15		335
> +#define CMDQ_EVENT_MDP_WROT3_SW_RST_DONE_ENG_EVENT	336
> +#define CMDQ_EVENT_MDP_WROT2_SW_RST_DONE_ENG_EVENT	337
> +#define CMDQ_EVENT_MDP_WROT1_SW_RST_DONE_ENG_EVENT	338
> +#define CMDQ_EVENT_MDP_WROT0_SW_RST_DONE_ENG_EVENT	339
> +#define CMDQ_EVENT_MDP_RDMA3_SW_RST_DONE_ENG_EVENT	340
> +#define CMDQ_EVENT_MDP_RDMA2_SW_RST_DONE_ENG_EVENT	341
> +#define CMDQ_EVENT_MDP_RDMA1_SW_RST_DONE_ENG_EVENT	342
> +#define CMDQ_EVENT_MDP_RDMA0_SW_RST_DONE_ENG_EVENT	343
> +/* DISP */
> +#define CMDQ_EVENT_DISP_OVL0_SOF			384
> +#define CMDQ_EVENT_DISP_OVL0_2L_SOF			385
> +#define CMDQ_EVENT_DISP_RDMA0_SOF			386
> +#define CMDQ_EVENT_DISP_RSZ0_SOF			387
> +#define CMDQ_EVENT_DISP_COLOR0_SOF			388
> +#define CMDQ_EVENT_DISP_CCORR0_SOF			389
> +#define CMDQ_EVENT_DISP_CCORR1_SOF			390
> +#define CMDQ_EVENT_DISP_AAL0_SOF			391
> +#define CMDQ_EVENT_DISP_GAMMA0_SOF			392
> +#define CMDQ_EVENT_DISP_POSTMASK0_SOF			393
> +#define CMDQ_EVENT_DISP_DITHER0_SOF			394
> +#define CMDQ_EVENT_DISP_CM0_SOF				395
> +#define CMDQ_EVENT_DISP_SPR0_SOF			396
> +#define CMDQ_EVENT_DISP_DSC_WRAP0_SOF			397
> +#define CMDQ_EVENT_DSI0_SOF				398
> +#define CMDQ_EVENT_DISP_WDMA0_SOF			399
> +#define CMDQ_EVENT_DISP_PWM0_SOF			400
> +#define CMDQ_EVENT_DSI0_FRAME_DONE			410
> +#define CMDQ_EVENT_DISP_WDMA0_FRAME_DONE		411
> +#define CMDQ_EVENT_DISP_SPR0_FRAME_DONE			412
> +#define CMDQ_EVENT_DISP_RSZ0_FRAME_DONE			413
> +#define CMDQ_EVENT_DISP_RDMA0_FRAME_DONE		414
> +#define CMDQ_EVENT_DISP_POSTMASK0_FRAME_DONE		415
> +#define CMDQ_EVENT_DISP_OVL0_FRAME_DONE			416
> +#define CMDQ_EVENT_DISP_OVL0_2L_FRAME_DONE		417
> +#define CMDQ_EVENT_DISP_GAMMA0_FRAME_DONE		418
> +#define CMDQ_EVENT_DISP_DSC_WRAP0_CORE0_FRAME_DONE	420
> +#define CMDQ_EVENT_DISP_DITHER0_FRAME_DONE		421
> +#define CMDQ_EVENT_DISP_COLOR0_FRAME_DONE		422
> +#define CMDQ_EVENT_DISP_CM0_FRAME_DONE			423
> +#define CMDQ_EVENT_DISP_CCORR1_FRAME_DONE		424
> +#define CMDQ_EVENT_DISP_CCORR0_FRAME_DONE		425
> +#define CMDQ_EVENT_DISP_AAL0_FRAME_DONE			426
> +#define CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_0		434
> +#define CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_1		435
> +#define CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_2		436
> +#define CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_3		437
> +#define CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_4		438
> +#define CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_5		439
> +#define CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_6		440
> +#define CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_7		441
> +#define CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_8		442
> +#define CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_9		443
> +#define CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_10	444
> +#define CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_11	445
> +#define CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_12	446
> +#define CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_13	447
> +#define CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_14	448
> +#define CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_15	449
> +#define CMDQ_EVENT_DSI0_TE_ENG_EVENT			450
> +#define CMDQ_EVENT_DSI0_IRQ_ENG_EVENT			451
> +#define CMDQ_EVENT_DSI0_DONE_ENG_EVENT			452
> +#define CMDQ_EVENT_DISP_WDMA0_SW_RST_DONE_ENG_EVENT	453
> +#define CMDQ_EVENT_DISP_SMIASSERT_ENG_EVENT		454
> +#define CMDQ_EVENT_DISP_POSTMASK0_RST_DONE_ENG_EVENT	455
> +#define CMDQ_EVENT_DISP_OVL0_RST_DONE_ENG_EVENT		456
> +#define CMDQ_EVENT_DISP_OVL0_2L_RST_DONE_ENG_EVENT	457
> +#define CMDQ_EVENT_BUF_UNDERRUN_ENG_EVENT_0		458
> +#define CMDQ_EVENT_BUF_UNDERRUN_ENG_EVENT_1		459
> +#define CMDQ_EVENT_BUF_UNDERRUN_ENG_EVENT_2		460
> +#define CMDQ_EVENT_BUF_UNDERRUN_ENG_EVENT_3		461
> +#define CMDQ_EVENT_BUF_UNDERRUN_ENG_EVENT_4		462
> +#define CMDQ_EVENT_BUF_UNDERRUN_ENG_EVENT_5		463
> +#define CMDQ_EVENT_BUF_UNDERRUN_ENG_EVENT_6		464
> +#define CMDQ_EVENT_BUF_UNDERRUN_ENG_EVENT_7		465
> +#define CMDQ_EVENT_OUT_EVENT_0				898
> +
> +/* CMDQ sw tokens
> + * Following definitions are gce sw token which may use by clients
> + * event operation API.
> + * Note that token 512 to 639 may set secure
> + */
> +
> +/* end of hw event and begin of sw token */
> +#define CMDQ_MAX_HW_EVENT				512
> +
> +/* Config thread notify trigger thread */
> +#define CMDQ_SYNC_TOKEN_CONFIG_DIRTY			640
> +/* Trigger thread notify config thread */
> +#define CMDQ_SYNC_TOKEN_STREAM_EOF			641
> +/* Block Trigger thread until the ESD check finishes. */
> +#define CMDQ_SYNC_TOKEN_ESD_EOF				642
> +#define CMDQ_SYNC_TOKEN_STREAM_BLOCK			643
> +/* check CABC setup finish */
> +#define CMDQ_SYNC_TOKEN_CABC_EOF			644
> +
> +/* Notify normal CMDQ there are some secure task done
> + * MUST NOT CHANGE, this token sync with secure world
> + */
> +#define CMDQ_SYNC_SECURE_THR_EOF			647
> +
> +/* CMDQ use sw token */
> +#define CMDQ_SYNC_TOKEN_USER_0				649
> +#define CMDQ_SYNC_TOKEN_USER_1				650
> +#define CMDQ_SYNC_TOKEN_POLL_MONITOR			651
> +#define CMDQ_SYNC_TOKEN_TPR_LOCK			652
> +
> +/* ISP sw token */
> +#define CMDQ_SYNC_TOKEN_MSS				665
> +#define CMDQ_SYNC_TOKEN_MSF				666
> +
> +/* DISP sw token */
> +#define CMDQ_SYNC_TOKEN_SODI				671
> +
> +/* GPR access tokens (for register backup)
> + * There are 15 32-bit GPR, 3 GPR form a set
> + * (64-bit for address, 32-bit for value)
> + * MUST NOT CHANGE, these tokens sync with MDP
> + */
> +#define CMDQ_SYNC_TOKEN_GPR_SET_0			700
> +#define CMDQ_SYNC_TOKEN_GPR_SET_1			701
> +#define CMDQ_SYNC_TOKEN_GPR_SET_2			702
> +#define CMDQ_SYNC_TOKEN_GPR_SET_3			703
> +#define CMDQ_SYNC_TOKEN_GPR_SET_4			704
> +
> +/* Resource lock event to control resource in GCE thread */
> +#define CMDQ_SYNC_RESOURCE_WROT0			710
> +#define CMDQ_SYNC_RESOURCE_WROT1			711
> +
> +/* event for gpr timer, used in sleep and poll with timeout */
> +#define CMDQ_TOKEN_GPR_TIMER_R0				994
> +#define CMDQ_TOKEN_GPR_TIMER_R1				995
> +#define CMDQ_TOKEN_GPR_TIMER_R2				996
> +#define CMDQ_TOKEN_GPR_TIMER_R3				997
> +#define CMDQ_TOKEN_GPR_TIMER_R4				998
> +#define CMDQ_TOKEN_GPR_TIMER_R5				999
> +#define CMDQ_TOKEN_GPR_TIMER_R6				1000
> +#define CMDQ_TOKEN_GPR_TIMER_R7				1001
> +#define CMDQ_TOKEN_GPR_TIMER_R8				1002
> +#define CMDQ_TOKEN_GPR_TIMER_R9				1003
> +#define CMDQ_TOKEN_GPR_TIMER_R10			1004
> +#define CMDQ_TOKEN_GPR_TIMER_R11			1005
> +#define CMDQ_TOKEN_GPR_TIMER_R12			1006
> +#define CMDQ_TOKEN_GPR_TIMER_R13			1007
> +#define CMDQ_TOKEN_GPR_TIMER_R14			1008
> +#define CMDQ_TOKEN_GPR_TIMER_R15			1009
> +
> +#define CMDQ_EVENT_MAX					0x3FF
> +/* CMDQ sw tokens END */
> +
> +#endif


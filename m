Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB0652A25F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 14:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346832AbiEQM7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347049AbiEQM7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:59:03 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D954E389
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 05:58:14 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220517125812epoutp03aaa4d2c96fb7409ead87a4158114a8df~v5dVSDiZH0491904919epoutp039
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 12:58:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220517125812epoutp03aaa4d2c96fb7409ead87a4158114a8df~v5dVSDiZH0491904919epoutp039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652792292;
        bh=xWKjt9XN0qVWN3WHoBf9h9eTfyIpb1TvtS6UL/EZBGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U64gPC1YLseVRqNSWc3G6eqnNVc4XSXIOjkNbPSPFIbRyZzCSXGMFvL9AHQA33ZzP
         FFUxYlT8a4ozMnja6ZIkKhnQXVKjbwJ7n/0SQqtF84YaJAs+ekGNIBYT44hCkeshCT
         zIVfBW0G36AqXWyK5E/hFG4tqA9jLHSCaycLcQsE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220517125811epcas5p144c6c027acf250b5eb135e75bb5c6b05~v5dUSOL0a3158031580epcas5p1d;
        Tue, 17 May 2022 12:58:11 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4L2bl41cgkz4x9Pv; Tue, 17 May
        2022 12:58:08 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DA.2C.09762.0EB93826; Tue, 17 May 2022 21:58:08 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220517125615epcas5p200c1b10090dc03e430d720d1435afccf~v5boMhY9p1529715297epcas5p2G;
        Tue, 17 May 2022 12:56:15 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220517125615epsmtrp20f7f7af7d840343d6165a11dadca3748~v5boLVrfK0912609126epsmtrp2R;
        Tue, 17 May 2022 12:56:15 +0000 (GMT)
X-AuditID: b6c32a4b-213ff70000002622-cb-62839be03cae
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        EB.36.08924.F6B93826; Tue, 17 May 2022 21:56:15 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220517125612epsmtip19eb44fef66ad5d8449589e3511ec8e05~v5blErxha1797117971epsmtip1G;
        Tue, 17 May 2022 12:56:12 +0000 (GMT)
From:   Smitha T Murthy <smitha.t@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, stanimir.varbanov@linaro.org,
        dillon.minfei@gmail.com, david.plowman@raspberrypi.com,
        mark.rutland@arm.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        andi@etezian.org, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        Smitha T Murthy <smitha.t@samsung.com>, linux-fsd@tesla.com
Subject: [PATCH 08/20] media: s5p-mfc: Add support for VP9 encoder.
Date:   Tue, 17 May 2022 18:25:36 +0530
Message-Id: <20220517125548.14746-9-smitha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220517125548.14746-1-smitha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTfUxTVxjGd3pvb4uj5IogRxaluQtR3IBWvg4M2BKYuRnLRiKb0UjgAnct
        g7Z3bRHn4kABIwyMy7ItfIMwXDoEVj6tZdSCYtBMCAjbpAIFIjZjH9QBk4prV9j++73v+5zz
        nDznHCHmPUn4C7OVWlatZHIpYgfeMxi0P3i2uihDMu/wQLN1PQRqWn/EQzNNdhyZO7sFqGui
        GkNXhk18VD/0Ix/13rDi6Psl53Ss0oKjR/VtAD2uekgg/fwkH83ZjqJxQw2Byju6+ejqkEWA
        vpka46EWvYOHLnc/EaCS/iEBshh7ACo+P8R7w49urWsFdJ+lGdBTzSsYfa3KIqCbjI95tF5X
        StDTk0aC7mwuoEtuPsXpi106QG+eqxXQZUNTBG3X76NH/rILkr2O58TKWSaLVYtZZaYqK1sp
        i6OSjqQlpEVESqTB0mgURYmVjIKNoxLfTg4+nJ3rTIASn2Ry85ytZEajoULjY9WqPC0rlqs0
        2jiK5bJyuXAuRMMoNHlKWYiS1cZIJZJDEU5heo581Lafm7wETn1ddA4vBM35ZcBDCMlwuNje
        irnYm7wO4POvmDKww8krAFY7DDx3YQewcryDv73iJ+umwD0wALi68udWUcyDMxWLApeKIF+F
        q7/fIVzsQ54FcP6C1sUYuYHByol9ZUAo3EUmQOPiMRfiZCBsXfF1oYiMhtfnTrqtAuB3HSbM
        1fYgY2DtZqrLCJLrQmj89Q5waxKhbeo87uZd0DbcJXCzP7T/1k+4WQZn7EVbeg7WFnbx3Pw6
        NE3U4K79MTIIthtC3e298MuRNp77vF6wYmNhSy6CfXXbTMHLd29vWUF4f7l7Kx0afntvk+/O
        swJAfX/6JbCv6n+HBgB0YA/LaRQyVhPBhSnZ/P8uLFOl0IN/H/jBpD5gnf0jxAx4QmAGUIhR
        PiLJqcIMb1EW8/FpVq1KU+flshoziHCG9znm75upcv4QpTZNGh4tCY+MjAyPDouUUn4i8vnZ
        DG9SxmjZHJblWPX2Op7Qw7+Q93Nqo+Ot+jNRkpbGqxspezuDysXczQcZJeWetwYKOoyxMTXx
        VsNufYr4StZHOV+89+AEMxhmdFiWPf5uqSw+McB9Wvowu7lNt+I3p8iQ6wJ2LzU17Fw/9rTA
        GjAJ+aIDpXsWD532TBgTr4G6JEFDI2eauOXbI55OnC3RXvuMGjwa6kWuWd/pu/CBZtWTGr3h
        s5GwjOuPYC8LG9BML/PsbuHt8cObwfn5gcPd89kDP7wvfbE9UD5aUNu49Mxk6y3Sjgy/8OT+
        u8Rxa78NvGTYWXFvLT7VrIt/UyaXvDL94UVcIefqz6QXHPhkIyVsOaqiDjNPvjbQb1oYi3H8
        krZgWqZwjZyRHsTUGuYfPCjHVmkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LZdlhJTjd/dnOSwfolIhYP5m1js1j84zmT
        xf3Fn1ksDm3eym6x5cpsZovlxw+wWsw/co7VYvvBRywWG18AZS/OvMti8Xz+OkaLl7PusVls
        enyN1eLhq3CLy7vmsFn0bNjKarH2yF12i6XXLzJZLNv0h8li0dYv7Bate4+wW9zds43RoqXt
        CJODuMeaeWsYPXbcXcLocX3JJ2aPnbPusnss3vOSyWPTqk42jzvX9rB5bF5S79F69BeLR9+W
        VYwe/5rmsnt0HbnO5vF5k5zHqa+f2QP4orhsUlJzMstSi/TtErgyLrxSL7g2gbFienMTSwPj
        kvIuRk4OCQETiRuP/rF3MXJxCAnsYJQ4e/ksC0RCQmLl70mMELawxMp/z6GKmpgk+prusYIk
        2AR0JL69P80GkhARaGWUuL6ykwnEYRaYyCIx5fov5i5GDg5hAWeJPU8jQUwWAVWJNZ9EQUxe
        AUuJ3Q/LIObLS6zecACsmFPASmLuv1gQUwio4ul+iwmMfAsYGVYxSqYWFOem5xYbFhjlpZbr
        FSfmFpfmpesl5+duYgTHmZbWDsY9qz7oHWJk4mA8xCjBwawkwmtQ0ZAkxJuSWFmVWpQfX1Sa
        k1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA5PMwb/CXofaeLeIv366IIt7Ubbs
        kUl5nFt53eJNlnRkGth8MjMsvvitwFZSW+bLmUvML91v7JkyeeYbjTs6P34f3RTCx/8z+5jd
        q7QvuVOZQ5mEVvyW8ORzu7pW8drqoq3yMt4Xt3rec/odr/N4Y+Zvw+fid7a/jb+kp9jpViti
        kNN2wdw3wctF8V2MRcxDh2/trj5zTpvcr+B2DD6Vueer0amKji9LEzMy7p07O7+TVV/8DMd5
        LnOpdKO4ymczsiJtxQ/H/Pv16tokrsr3WV390Yv2C32TkmP4b6b55vophw0sdw+oTK1ZqzJd
        eT2jzKrvW/Sv37c6MaOSK9yp2zn3cnrrugnhcfXsdsbf7ZVYijMSDbWYi4oTAf9RkXMiAwAA
X-CMS-MailID: 20220517125615epcas5p200c1b10090dc03e430d720d1435afccf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220517125615epcas5p200c1b10090dc03e430d720d1435afccf
References: <20220517125548.14746-1-smitha.t@samsung.com>
        <CGME20220517125615epcas5p200c1b10090dc03e430d720d1435afccf@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add VP9 encoder support and necessary registers,
V4L2 CIDs, vp9 encoder parameters.

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
---
 .../platform/samsung/s5p-mfc/regs-mfc-v12.h   |   9 +
 .../platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c |   3 +
 .../platform/samsung/s5p-mfc/s5p_mfc_common.h |  27 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_enc.c    | 272 ++++++++++++++++++
 .../platform/samsung/s5p-mfc/s5p_mfc_opr.h    |   2 +
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c | 121 ++++++++
 6 files changed, 433 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h b/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h
index efb77c2bf913..1e2904ab872a 100644
--- a/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h
+++ b/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h
@@ -12,6 +12,10 @@
 #include <linux/sizes.h>
 #include "regs-mfc-v10.h"
 
+/* MFCv12 register definitions*/
+#define S5P_FIMV_E_VP9_OPTION_V12		0xFD90
+#define S5P_FIMV_E_VP9_GOLDEN_FRAME_OPTION_V12	0xFD98
+
 /* MFCv12 Context buffer sizes */
 #define MFC_CTX_BUF_SIZE_V12		(30 * SZ_1K)
 #define MFC_H264_DEC_CTX_BUF_SIZE_V12   (2 * SZ_1M)
@@ -25,6 +29,7 @@
 #define MAX_CPB_SIZE_V12		(7 * SZ_1M)
 #define MFC_VERSION_V12			0xC0
 #define MFC_NUM_PORTS_V12		1
+#define S5P_FIMV_CODEC_VP9_ENC		27
 
 /* Encoder buffer size for MFCv12 */
 #define ENC_V120_BASE_SIZE(x, y) \
@@ -46,4 +51,8 @@
 	(((x + 3) * (y + 3) * 32)       \
 	+ (((y * 128) + 2304) * (x + 3) / 4))
 
+#define ENC_V120_VP9_ME_SIZE(x, y)      \
+	((((x * 2) + 3) * ((y * 2) + 3) * 128)	\
+	+ (((y * 256) + 2304) * (x + 1) / 2))
+
 #endif /*_REGS_MFC_V12_H*/
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c
index f8588e52dfc8..d524815cd38a 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c
@@ -121,6 +121,9 @@ static int s5p_mfc_open_inst_cmd_v6(struct s5p_mfc_ctx *ctx)
 	case S5P_MFC_CODEC_HEVC_ENC:
 		codec_type = S5P_FIMV_CODEC_HEVC_ENC;
 		break;
+	case S5P_MFC_CODEC_VP9_ENC:
+		codec_type = S5P_FIMV_CODEC_VP9_ENC;
+		break;
 	default:
 		codec_type = S5P_FIMV_CODEC_NONE_V6;
 	}
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
index eed4d8f71a3a..04cdfeca13d3 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
@@ -57,7 +57,7 @@
 #define MFC_ENC_CAP_PLANE_COUNT	1
 #define MFC_ENC_OUT_PLANE_COUNT	2
 #define STUFF_BYTE		4
-#define MFC_MAX_CTRLS		128
+#define MFC_MAX_CTRLS		147
 
 #define S5P_MFC_CODEC_NONE		-1
 #define S5P_MFC_CODEC_H264_DEC		0
@@ -77,6 +77,7 @@
 #define S5P_MFC_CODEC_H263_ENC		23
 #define S5P_MFC_CODEC_VP8_ENC		24
 #define S5P_MFC_CODEC_HEVC_ENC		26
+#define S5P_MFC_CODEC_VP9_ENC		27
 
 #define S5P_MFC_R2H_CMD_EMPTY			0
 #define S5P_MFC_R2H_CMD_SYS_INIT_RET		1
@@ -483,6 +484,29 @@ struct s5p_mfc_hevc_enc_params {
 	u8 prepend_sps_pps_to_idr;
 };
 
+/**
+ * struct s5p_mfc_vp9_enc_params - encoding parameters for vp9
+ */
+struct s5p_mfc_vp9_enc_params {
+	u32 rc_framerate;
+	u8 vp9_profile;
+	u8 rc_min_qp;
+	u8 rc_max_qp;
+	u8 rc_frame_qp;
+	u8 rc_p_frame_qp;
+	u8 vp9_goldenframesel;
+	u8 vp9_gfrefreshperiod;
+	u8 hier_qp_enable;
+	u8 hier_qp_layer[3];
+	u8 hier_rc_enable;
+	u32 hier_bit_layer[3];
+	u8 num_refs_for_p;
+	u8 num_hier_layer;
+	u8 max_partition_depth;
+	u8 intra_pu_split_disable;
+	u8 ivf_header;
+};
+
 /*
  * struct s5p_mfc_enc_params - general encoding parameters
  */
@@ -521,6 +545,7 @@ struct s5p_mfc_enc_params {
 		struct s5p_mfc_mpeg4_enc_params mpeg4;
 		struct s5p_mfc_vp8_enc_params vp8;
 		struct s5p_mfc_hevc_enc_params hevc;
+		struct s5p_mfc_vp9_enc_params vp9;
 	} codec;
 
 };
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
index ae2c0977b24e..b5f9e7bbdead 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
@@ -94,6 +94,13 @@ static struct s5p_mfc_fmt formats[] = {
 		.num_planes	= 1,
 		.versions	= MFC_V10_BIT | MFC_V12_BIT,
 	},
+	{
+		.fourcc		= V4L2_PIX_FMT_VP9,
+		.codec_mode	= S5P_FIMV_CODEC_VP9_ENC,
+		.type		= MFC_FMT_ENC,
+		.num_planes	= 1,
+		.versions	= MFC_V12_BIT,
+	},
 };
 
 #define NUM_FORMATS ARRAY_SIZE(formats)
@@ -1055,6 +1062,174 @@ static struct mfc_control controls[] = {
 		.step = 1,
 		.default_value = 0,
 	},
+	{
+		.id = V4L2_CID_MPEG_VIDEO_VP9_PROFILE,
+		.type = V4L2_CTRL_TYPE_MENU,
+		.minimum = V4L2_MPEG_VIDEO_VP9_PROFILE_0,
+		.maximum = V4L2_MPEG_VIDEO_VP9_PROFILE_2,
+		.step = 1,
+		.default_value = V4L2_MPEG_VIDEO_VP9_PROFILE_0,
+	},
+	{
+		.id = V4L2_CID_MPEG_VIDEO_VP9_I_FRAME_QP,
+		.type = V4L2_CTRL_TYPE_INTEGER,
+		.minimum = 1,
+		.maximum = 255,
+		.step = 1,
+		.default_value = 1,
+	},
+	{
+		.id = V4L2_CID_MPEG_VIDEO_VP9_P_FRAME_QP,
+		.type = V4L2_CTRL_TYPE_INTEGER,
+		.minimum = 1,
+		.maximum = 255,
+		.step = 1,
+		.default_value = 1,
+	},
+	{
+		.id = V4L2_CID_MPEG_VIDEO_VP9_MAX_QP,
+		.type = V4L2_CTRL_TYPE_INTEGER,
+		.minimum = 230,
+		.maximum = 255,
+		.step = 1,
+		.default_value = 255,
+	},
+	{
+		.id = V4L2_CID_MPEG_VIDEO_VP9_MIN_QP,
+		.type = V4L2_CTRL_TYPE_INTEGER,
+		.minimum = 1,
+		.maximum = 24,
+		.step = 1,
+		.default_value = 1,
+	},
+	{
+		.id = V4L2_CID_MPEG_VIDEO_VP9_RC_FRAME_RATE,
+		.type = V4L2_CTRL_TYPE_INTEGER,
+		.minimum = 1,
+		.maximum = (1 << 16) - 1,
+		.step = 1,
+		.default_value = 1,
+	},
+	{
+		.id = V4L2_CID_MPEG_VIDEO_VP9_GOLDEN_FRAMESEL,
+		.type = V4L2_CTRL_TYPE_MENU,
+		.minimum = V4L2_CID_MPEG_VIDEO_VP9_GOLDEN_FRAME_USE_PREV,
+		.maximum = V4L2_CID_MPEG_VIDEO_VP9_GOLDEN_FRAME_USE_REF_PERIOD,
+		.step = 1,
+		.default_value = V4L2_CID_MPEG_VIDEO_VP9_GOLDEN_FRAME_USE_PREV,
+	},
+	{
+		.id = V4L2_CID_MPEG_VIDEO_VP9_GF_REFRESH_PERIOD,
+		.type = V4L2_CTRL_TYPE_INTEGER,
+		.minimum = 0,
+		.maximum = ((1 << 16) - 1),
+		.step = 1,
+		.default_value = 0,
+	},
+	{
+		.id = V4L2_CID_MPEG_VIDEO_VP9_HIERARCHY_QP_ENABLE,
+		.type = V4L2_CTRL_TYPE_BOOLEAN,
+		.minimum = 0,
+		.maximum = 1,
+		.step = 1,
+		.default_value = 0,
+	},
+	{
+		.id = V4L2_CID_MPEG_VIDEO_VP9_HIERARCHY_RC_ENABLE,
+		.type = V4L2_CTRL_TYPE_BOOLEAN,
+		.minimum = 0,
+		.maximum = 1,
+		.step = 1,
+		.default_value = 0,
+	},
+	{
+		.id = V4L2_CID_MPEG_VIDEO_VP9_HIER_CODING_L0_QP,
+		.type = V4L2_CTRL_TYPE_INTEGER,
+		.minimum = INT_MIN,
+		.maximum = INT_MAX,
+		.step = 1,
+		.default_value = 0,
+	},
+	{
+		.id = V4L2_CID_MPEG_VIDEO_VP9_HIER_CODING_L1_QP,
+		.type = V4L2_CTRL_TYPE_INTEGER,
+		.minimum = INT_MIN,
+		.maximum = INT_MAX,
+		.step = 1,
+		.default_value = 0,
+	},
+	{
+		.id = V4L2_CID_MPEG_VIDEO_VP9_HIER_CODING_L2_QP,
+		.type = V4L2_CTRL_TYPE_INTEGER,
+		.minimum = INT_MIN,
+		.maximum = INT_MAX,
+		.step = 1,
+		.default_value = 0,
+	},
+	{
+		.id = V4L2_CID_MPEG_VIDEO_VP9_REF_NUMBER_FOR_PFRAMES,
+		.type = V4L2_CTRL_TYPE_MENU,
+		.minimum = V4L2_CID_MPEG_VIDEO_VP9_1_REF_PFRAME,
+		.maximum = V4L2_CID_MPEG_VIDEO_VP9_2_REF_PFRAME,
+		.step = 1,
+		.default_value = V4L2_CID_MPEG_VIDEO_VP9_1_REF_PFRAME,
+	},
+	{
+		.id = V4L2_CID_MPEG_VIDEO_VP9_HIERARCHICAL_CODING_LAYER,
+		.type = V4L2_CTRL_TYPE_INTEGER,
+		.minimum = 0,
+		.maximum = 2,
+		.step = 1,
+		.default_value = 0,
+	},
+	{
+		.id = V4L2_CID_MPEG_VIDEO_VP9_MAX_PARTITION_DEPTH,
+		.type = V4L2_CTRL_TYPE_MENU,
+		.minimum = V4L2_CID_MPEG_VIDEO_VP9_0_PARTITION,
+		.maximum = V4L2_CID_MPEG_VIDEO_VP9_1_PARTITION,
+		.step = 1,
+		.default_value = V4L2_CID_MPEG_VIDEO_VP9_0_PARTITION,
+	},
+	{
+		.id = V4L2_CID_MPEG_VIDEO_VP9_DISABLE_INTRA_PU_SPLIT,
+		.type = V4L2_CTRL_TYPE_BOOLEAN,
+		.minimum = 0,
+		.maximum = 1,
+		.step = 1,
+		.default_value = 0,
+	},
+	{
+		.id = V4L2_CID_MPEG_VIDEO_VP9_HIER_CODING_L0_BR,
+		.type = V4L2_CTRL_TYPE_INTEGER,
+		.minimum = INT_MIN,
+		.maximum = INT_MAX,
+		.step = 1,
+		.default_value = 0,
+	},
+	{
+		.id = V4L2_CID_MPEG_VIDEO_VP9_HIER_CODING_L1_BR,
+		.type = V4L2_CTRL_TYPE_INTEGER,
+		.minimum = INT_MIN,
+		.maximum = INT_MAX,
+		.step = 1,
+		.default_value = 0,
+	},
+	{
+		.id = V4L2_CID_MPEG_VIDEO_VP9_HIER_CODING_L2_BR,
+		.type = V4L2_CTRL_TYPE_INTEGER,
+		.minimum = INT_MIN,
+		.maximum = INT_MAX,
+		.step = 1,
+		.default_value = 0,
+	},
+	{
+		.id = V4L2_CID_MPEG_VIDEO_VP9_DISABLE_IVF_HEADER,
+		.type = V4L2_CTRL_TYPE_BOOLEAN,
+		.minimum = 0,
+		.maximum = 1,
+		.step = 1,
+		.default_value = 0,
+	},
 	{
 		.id = V4L2_CID_MIN_BUFFERS_FOR_OUTPUT,
 		.type = V4L2_CTRL_TYPE_INTEGER,
@@ -1793,6 +1968,36 @@ static void __enc_update_hevc_qp_ctrls_range(struct s5p_mfc_ctx *ctx,
 	}
 }
 
+/*
+ * Update range of all VP9 quantization parameter controls that depend on the
+ * V4L2_CID_MPEG_VIDEO_VP9_MIN_QP, V4L2_CID_MPEG_VIDEO_VP9_MAX_QP controls.
+ */
+static void __enc_update_vp9_qp_ctrls_range(struct s5p_mfc_ctx *ctx,
+						int min, int max)
+{
+	static const int __vp9_qp_ctrls[] = {
+		V4L2_CID_MPEG_VIDEO_VP9_I_FRAME_QP,
+		V4L2_CID_MPEG_VIDEO_VP9_P_FRAME_QP,
+		V4L2_CID_MPEG_VIDEO_VP9_HIER_CODING_L0_QP,
+		V4L2_CID_MPEG_VIDEO_VP9_HIER_CODING_L1_QP,
+		V4L2_CID_MPEG_VIDEO_VP9_HIER_CODING_L2_QP,
+	};
+	struct v4l2_ctrl *ctrl = NULL;
+	int i, j;
+
+	for (i = 0; i < ARRAY_SIZE(__vp9_qp_ctrls); i++) {
+		for (j = 0; j < ARRAY_SIZE(ctx->ctrls); j++) {
+			if (ctx->ctrls[j]->id == __vp9_qp_ctrls[i]) {
+				ctrl = ctx->ctrls[j];
+				break;
+			}
+		}
+		if (WARN_ON(!ctrl))
+			break;
+		__v4l2_ctrl_modify_range(ctrl, min, max, ctrl->step, min);
+	}
+}
+
 static int s5p_mfc_enc_s_ctrl(struct v4l2_ctrl *ctrl)
 {
 	struct s5p_mfc_ctx *ctx = ctrl_to_ctx(ctrl);
@@ -2196,6 +2401,73 @@ static int s5p_mfc_enc_s_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_MPEG_VIDEO_PREPEND_SPSPPS_TO_IDR:
 		p->codec.hevc.prepend_sps_pps_to_idr = ctrl->val;
 		break;
+	case V4L2_CID_MPEG_VIDEO_VP9_PROFILE:
+		p->codec.vp9.vp9_profile = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_VP9_RC_FRAME_RATE:
+		p->codec.vp9.rc_framerate = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_VP9_MIN_QP:
+		p->codec.vp9.rc_min_qp = ctrl->val;
+		__enc_update_vp9_qp_ctrls_range(ctx, ctrl->val,
+			p->codec.vp9.rc_max_qp);
+		break;
+	case V4L2_CID_MPEG_VIDEO_VP9_MAX_QP:
+		p->codec.vp9.rc_max_qp = ctrl->val;
+		__enc_update_vp9_qp_ctrls_range(ctx,
+				p->codec.vp9.rc_min_qp, ctrl->val);
+		break;
+	case V4L2_CID_MPEG_VIDEO_VP9_I_FRAME_QP:
+		p->codec.vp9.rc_frame_qp = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_VP9_P_FRAME_QP:
+		p->codec.vp9.rc_p_frame_qp = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_VP9_GOLDEN_FRAMESEL:
+		p->codec.vp9.vp9_goldenframesel = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_VP9_GF_REFRESH_PERIOD:
+		p->codec.vp9.vp9_gfrefreshperiod = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_VP9_HIERARCHY_QP_ENABLE:
+		p->codec.vp9.hier_qp_enable = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_VP9_HIERARCHY_RC_ENABLE:
+		p->codec.vp9.hier_rc_enable = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_VP9_HIER_CODING_L0_QP:
+		p->codec.vp9.hier_qp_layer[0] = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_VP9_HIER_CODING_L1_QP:
+		p->codec.vp9.hier_qp_layer[1] = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_VP9_HIER_CODING_L2_QP:
+		p->codec.vp9.hier_qp_layer[2] = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_VP9_HIER_CODING_L0_BR:
+		p->codec.vp9.hier_bit_layer[0] = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_VP9_HIER_CODING_L1_BR:
+		p->codec.vp9.hier_bit_layer[1] = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_VP9_HIER_CODING_L2_BR:
+		p->codec.vp9.hier_bit_layer[2] = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_VP9_REF_NUMBER_FOR_PFRAMES:
+		p->codec.vp9.num_refs_for_p = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_VP9_HIERARCHICAL_CODING_LAYER:
+		p->codec.vp9.num_hier_layer = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_VP9_MAX_PARTITION_DEPTH:
+		p->codec.vp9.max_partition_depth = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_VP9_DISABLE_INTRA_PU_SPLIT:
+		p->codec.vp9.intra_pu_split_disable = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_VP9_DISABLE_IVF_HEADER:
+		p->codec.vp9.ivf_header = ctrl->val;
+		break;
 	default:
 		v4l2_err(&dev->v4l2_dev, "Invalid control, id=%d, val=%d\n",
 							ctrl->id, ctrl->val);
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h
index 87ac56756a16..a005623e2daa 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h
@@ -277,6 +277,8 @@ struct s5p_mfc_regs {
 	void __iomem *e_hevc_lf_beta_offset_div2; /* v10 */
 	void __iomem *e_hevc_lf_tc_offset_div2; /* v10 */
 	void __iomem *e_hevc_nal_control; /* v10 */
+	void __iomem *e_vp9_options; /* v12 */
+	void __iomem *e_vp9_golden_frame_option; /* v12 */
 };
 
 struct s5p_mfc_hw_ops {
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
index 98c524688b45..913fe5d5a93a 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
@@ -374,6 +374,17 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 			ctx->chroma_dpb_size + ctx->me_buffer_size));
 		ctx->bank2.size = 0;
 		break;
+	case S5P_FIMV_CODEC_VP9_ENC:
+		mfc_debug(2, "Use min scratch buffer size\n");
+		ctx->me_buffer_size =
+			ALIGN(ENC_V120_VP9_ME_SIZE(lcu_width, lcu_height), 16);
+		ctx->scratch_buf_size = ALIGN(ctx->scratch_buf_size, 256);
+		ctx->bank1.size =
+			ctx->scratch_buf_size + ctx->tmv_buffer_size +
+			(ctx->pb_count * (ctx->luma_dpb_size +
+			ctx->chroma_dpb_size + ctx->me_buffer_size));
+		ctx->bank2.size = 0;
+		break;
 	default:
 		break;
 	}
@@ -429,6 +440,7 @@ static int s5p_mfc_alloc_instance_buffer_v6(struct s5p_mfc_ctx *ctx)
 	case S5P_MFC_CODEC_MPEG4_ENC:
 	case S5P_MFC_CODEC_H263_ENC:
 	case S5P_MFC_CODEC_VP8_ENC:
+	case S5P_FIMV_CODEC_VP9_ENC:
 		ctx->ctx.size = buf_size->other_enc_ctx;
 		break;
 	default:
@@ -1663,6 +1675,102 @@ static int s5p_mfc_set_enc_params_hevc(struct s5p_mfc_ctx *ctx)
 	return 0;
 }
 
+int s5p_mfc_set_enc_params_vp9(struct s5p_mfc_ctx *ctx)
+{
+	struct s5p_mfc_dev *dev = ctx->dev;
+	const struct s5p_mfc_regs *mfc_regs = dev->mfc_regs;
+	struct s5p_mfc_enc_params *p = &ctx->enc_params;
+	struct s5p_mfc_vp9_enc_params *p_vp9 = &p->codec.vp9;
+	unsigned int reg = 0;
+	int i;
+
+	mfc_debug_enter();
+
+	s5p_mfc_set_enc_params(ctx);
+
+	/* profile*/
+	reg = 0;
+	reg |= (p_vp9->vp9_profile);
+	writel(reg, mfc_regs->e_picture_profile);
+
+	reg = 0;
+	reg |= ((p_vp9->ivf_header & 0x1) << 12);
+	reg |= ((p_vp9->hier_qp_enable & 0x1) << 11);
+	reg |= (p_vp9->max_partition_depth & 0x1) << 3;
+	reg |= (p_vp9->intra_pu_split_disable & 0x1) << 1;
+	reg |= (p_vp9->num_refs_for_p - 1) & 0x1;
+	writel(reg, mfc_regs->e_vp9_options);
+
+	reg = 0;
+	reg |= (p_vp9->vp9_goldenframesel & 0x1);
+	reg |= (p_vp9->vp9_gfrefreshperiod & 0xffff) << 1;
+	writel(reg, mfc_regs->e_vp9_golden_frame_option);
+
+	reg = 0;
+	if (p_vp9->num_hier_layer) {
+		reg |= p_vp9->num_hier_layer & 0x3;
+		writel(reg, mfc_regs->e_num_t_layer);
+		/* QP value for each layer */
+		if (p_vp9->hier_qp_enable) {
+			for (i = 0; i < (p_vp9->num_hier_layer & 0x3); i++)
+				writel(p_vp9->hier_qp_layer[i],
+						mfc_regs->e_hier_qp_layer0
+						+ i * 4);
+		}
+		if (p_vp9->hier_rc_enable) {
+			for (i = 0; i < (p_vp9->num_hier_layer & 0x3); i++)
+				writel(p_vp9->hier_bit_layer[i],
+						mfc_regs->e_hier_bit_rate_layer0
+						+ i * 4);
+		}
+	}
+	/* number of coding layer should be zero when hierarchical is disable */
+	reg |= p_vp9->num_hier_layer;
+	writel(reg, mfc_regs->e_num_t_layer);
+
+	/* qp */
+	writel(0x0, mfc_regs->e_fixed_picture_qp);
+	if (!p->rc_frame && !p->rc_mb) {
+		reg = 0;
+		reg &= ~(0xff << 8);
+		reg |= (p_vp9->rc_p_frame_qp << 8);
+		reg &= ~(0xff);
+		reg |= p_vp9->rc_frame_qp;
+		writel(reg, mfc_regs->e_fixed_picture_qp);
+	}
+
+	/* frame rate */
+	if (p->rc_frame) {
+		reg = 0;
+		reg &= ~(0xffff << 16);
+		reg |= ((p_vp9->rc_framerate * FRAME_DELTA_DEFAULT) << 16);
+		reg &= ~(0xffff);
+		reg |= FRAME_DELTA_DEFAULT;
+		writel(reg, mfc_regs->e_rc_frame_rate);
+	}
+
+	/* rate control config. */
+	reg = readl(mfc_regs->e_rc_config);
+	/** macroblock level rate control */
+	reg &= ~(0x1 << 8);
+	reg |= ((p->rc_mb & 0x1) << 8);
+	writel(reg, mfc_regs->e_rc_config);
+
+	/* max & min value of QP */
+	reg = 0;
+	/** max QP */
+	reg &= ~(0xFF << 8);
+	reg |= (p_vp9->rc_max_qp << 8);
+	/** min QP */
+	reg &= ~(0xFF);
+	reg |= p_vp9->rc_min_qp;
+	writel(reg, mfc_regs->e_rc_qp_bound);
+
+	mfc_debug_leave();
+
+	return 0;
+}
+
 /* Initialize decoding */
 static int s5p_mfc_init_decode_v6(struct s5p_mfc_ctx *ctx)
 {
@@ -1784,6 +1892,8 @@ static int s5p_mfc_init_encode_v6(struct s5p_mfc_ctx *ctx)
 		s5p_mfc_set_enc_params_vp8(ctx);
 	else if (ctx->codec_mode == S5P_FIMV_CODEC_HEVC_ENC)
 		s5p_mfc_set_enc_params_hevc(ctx);
+	else if (ctx->codec_mode == S5P_FIMV_CODEC_VP9_ENC)
+		s5p_mfc_set_enc_params_vp9(ctx);
 	else {
 		mfc_err("Unknown codec for encoding (%x).\n",
 			ctx->codec_mode);
@@ -2547,6 +2657,17 @@ const struct s5p_mfc_regs *s5p_mfc_init_regs_v6_plus(struct s5p_mfc_dev *dev)
 	R(e_hevc_lf_tc_offset_div2, S5P_FIMV_E_HEVC_LF_TC_OFFSET_DIV2_V10);
 	R(e_hevc_nal_control, S5P_FIMV_E_HEVC_NAL_CONTROL_V10);
 
+	if (!IS_MFCV12(dev))
+		goto done;
+
+	/* Initialize registers used in MFC v10 only.
+	 * Also, over-write the registers which have
+	 * a different offset for MFC v10.
+	 */
+
+	R(e_vp9_options, S5P_FIMV_E_VP9_OPTION_V12);
+	R(e_vp9_golden_frame_option, S5P_FIMV_E_VP9_GOLDEN_FRAME_OPTION_V12);
+
 done:
 	return &mfc_regs;
 #undef S5P_MFC_REG_ADDR
-- 
2.17.1


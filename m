Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A175AFC8D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiIGGhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiIGGhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:37:16 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9D984EE9
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 23:36:36 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220907063634epoutp03ddcbe2685e262b6f9dde4c8bde81d1c2~SgJYl2tIJ2318323183epoutp03G
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 06:36:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220907063634epoutp03ddcbe2685e262b6f9dde4c8bde81d1c2~SgJYl2tIJ2318323183epoutp03G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1662532594;
        bh=NQWsb4RqKxQPijk9VzjtYpuZhWQOFu052/B3OQdNnMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ICLImu7pr+cg/s1JtUe9IWhAc++tnvM/EmnXWSOe6rQlQvzbDv274bF7R+2KL4DU5
         jJvG1NE4/r9ZBYNDyTSqF2lvk337x4JAXI4oZvKeed9bkHN7mbQuvRI/zZ9tOP0M+R
         Qlug96Bhv1QxULbR/X6tZtHMp5+GrZBcsK6r2Pw4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220907063633epcas5p3e79d620c6d7634ee7ff431b1d98f71e6~SgJXikwKc0368303683epcas5p3-;
        Wed,  7 Sep 2022 06:36:33 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4MMswY5mWqz4x9Q0; Wed,  7 Sep
        2022 06:36:29 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CE.53.53458.AEB38136; Wed,  7 Sep 2022 15:36:26 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220907063340epcas5p2d7eb2452918dfc593c47f48d05cfb83b~SgG2MTIQy0472404724epcas5p2S;
        Wed,  7 Sep 2022 06:33:40 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220907063340epsmtrp273c79c086f3c98874741392dc94b0a6e~SgG2LEffa1916519165epsmtrp2A;
        Wed,  7 Sep 2022 06:33:40 +0000 (GMT)
X-AuditID: b6c32a4a-a5bff7000000d0d2-0c-63183bead58f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        38.DC.14392.44B38136; Wed,  7 Sep 2022 15:33:40 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.109.115.6]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220907063336epsmtip12efc78b19c9eb3abde794aefe4a415f5~SgGyxT-s52432724327epsmtip1c;
        Wed,  7 Sep 2022 06:33:36 +0000 (GMT)
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
        linux-fsd@tesla.com, smitha.t@samsung.com, aakarsh.jain@samsung.com
Subject: [Patch v2 07/15] media: s5p-mfc: Add support for VP9 encoder.
Date:   Wed,  7 Sep 2022 12:17:07 +0530
Message-Id: <20220907064715.55778-8-smitha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220907064715.55778-1-smitha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0xbVRzHPX3dstnlhocemjhJzRbBAS0r9ZTXdOByM/cA1C2bGHZtbwqh
        r/W2uDGMKK+NwB46ojAeCsURNsZWnk4wwKoFhgQmlEyoUJjyCK+tyogwY0uL/vf5/X7f3+P8
        zjlcpredw+emqvWUTk0qBZxtrJZ7gUHB85FQJvzy2m70e1sJG01WtHBQ9doMA01UO1iou7EZ
        Q03D15jouqWTjSrNA2zU2jXFQndmndGhEhsLzVTeAmiu9DcOMk1b2cg+fxz9creMgwpvN7NR
        vdmGoZrRIQb61rTBQFXNf2Iot8OMIVt7C0A5eWbGG5C4WXETEG02IyBGjU+YxHelNoyobp9j
        EKa6Cxxi3NrOIRqNnxC5P/7NIi421QHin8/KMaLAPMohHKadRN9fDix+x8m0qBSKlFO6AEot
        08hT1YpowdvvJMcmh0uEomCRFL0uCFCTKipaEHcoPvhAqtK5BkFAOqk0OF3xJE0LQmOidBqD
        ngpI0dD6aAGllSu1Ym0ITapog1oRoqb0ESKhMCzcKTyVljJlucTWPiwEZ3KtlVgWeEgXAC8u
        xMXw0VIXqwBs43rj3wN4wTqGuY0nAE46Vj3GKoD1pZOMrZS6jqccF3vjHU5VLnJzNgNOZ0e7
        mIPvgavL9zc1vvinAE6f17sKMfFsFrT1r2OugA9+AJYvP94UsfBd8OLyAsvFPFwKxwprWe5m
        L8MbtzuZLvbCI+DQ1R62qxDE871gV7/JI4qDtZWLmJt94LylycN86Fjq4LhZAScc2cDNWlie
        1eQ5zT7YOVzmrMN1ThcIG+6Gut0vweK+W5sSJr4DFq0/8sh5sK1iiwWwqr/H0wrCkcVmtpsJ
        WFM/y3BvrgjA3pw+5mWws/T/Fl8DUAf8KS2tUlB0uDZMTX3037XJNCoT2HzrQQfbgH1yJaQb
        MLigG0AuU+DLk7f5yrx5cvJsBqXTJOsMSoruBuHOBV5h8v1kGudnUeuTRWKpUCyRSMTSvRKR
        4EXe1deAzBtXkHoqjaK0lG4rj8H14mcxYkSH2XmNqsj9K0TsgtEYmiSfW89/5VwCumKgn5/t
        UZ08Js0pCSOOhuMf2gPPB4wUf5N5/dT6q09B9pA1L8JnJqPsLUnLACnrbGrM+EnKbf8itlz+
        a4L53YO89y+ZVh/U2ONm/UmuhWeI3bi3kVBlESUeOzEcEhrhM5L5s/+6bu1y5MSgOE/93oMT
        Z0taKxoOpXcl7m/8uGifbXuKIske+mx8Ip/I8D9T/XmmwSrsXTndYEpLWpIpnw3dqU98PLar
        wHj/cPzeqDfrb+TWbO89Z0kv+cprcHfq+B/8PTbMb2pBS6/xa6tK/XyLbV0vBLUeh8+d7phY
        PGIY+CG/ImbwA6QWsOgUUhTE1NHkv2gIrPl0BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsWy7bCSnK6LtUSywfJZohZPd8xktXgwbxub
        xeIfz5ks7i/+zGJxaPNWdostV2YzWyw/foDVYv6Rc6wW2w8+YrHY+AIoe3HmXRaL5/PXMVq8
        nHWPzWLT42usFg9fhVtc3jWHzaJnw1ZWi7VH7rJbLL1+kcli2aY/TBaLtn5ht2jde4Td4u6e
        bYwWLW1HmBwkPNbMW8PosePuEkaP60s+MXvsnHWX3WPxnpdMHptWdbJ53Lm2h81j85J6j9aj
        v1g8+rasYvT41zSX3aPryHU2j8+b5DxOff3MHsAXxWWTkpqTWZZapG+XwJXx6Hg/a8HNHsaK
        1mvz2RsYbxZ3MXJySAiYSKza+50NxBYS2M0o8eJcMkRcQmLl70mMELawxMp/z9khahqZJFrX
        mILYbAI6Et/enwbq5eIQEWhllLi+spMJxGEWmM0i8WPSAVaQKmEBN4m57z+CbWARUJXoe/+G
        BcTmFbCUuN2zggVig7zE6g0HmEFsTgEriYtTTrBCbLOUeDxjG/sERr4FjAyrGCVTC4pz03OL
        DQsM81LL9YoTc4tL89L1kvNzNzGCI09Lcwfj9lUf9A4xMnEwHmKU4GBWEuFN2SGSLMSbklhZ
        lVqUH19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAOTrIzskwOn3B8sUp9n
        vHj6/Enm6ptvVtu9iZh8WMldfomYYceFGWETXP9mrH115YjIrJrwyEN+63b73fW6nGEQsCT/
        /oEnBVbXlv25oJp7w29X+uy52w+f2ukYF/TyTP6pV6dW2nuoOkZUzJRvXqWjmyQn8tCsfqvv
        sRDTHeXB3/ZUviubd+030yH/exKzJOMKVb5aTpoyMypcKf7b2Qfnw1KNeT5HrtSKsfS407Pa
        1XFlxeI19+6aT+I4cF4qt+lORcj0WMU9zzZcUu811nA7eG9JueKFyeuvbZpc6vjy5ULBk5Yn
        ee9ynnx2pKhUuOYo9/OZa6+ofFQI/ek0obJqiY7dpGjhyg7Ja6f9BTUT4pVYijMSDbWYi4oT
        AQtz3+wrAwAA
X-CMS-MailID: 20220907063340epcas5p2d7eb2452918dfc593c47f48d05cfb83b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220907063340epcas5p2d7eb2452918dfc593c47f48d05cfb83b
References: <20220907064715.55778-1-smitha.t@samsung.com>
        <CGME20220907063340epcas5p2d7eb2452918dfc593c47f48d05cfb83b@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add VP9 encoder support and necessary registers, V4L2 CIDs, vp9
encoder parameters.

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
---
 .../platform/samsung/s5p-mfc/regs-mfc-v12.h   |   8 +
 .../platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c |   3 +
 .../platform/samsung/s5p-mfc/s5p_mfc_common.h |  27 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_enc.c    | 272 ++++++++++++++++++
 .../platform/samsung/s5p-mfc/s5p_mfc_opr.h    |   2 +
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c | 121 ++++++++
 6 files changed, 432 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h b/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h
index 6c68a45082d0..7cb74a9cb769 100644
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
 #define MFC_H264_DEC_CTX_BUF_SIZE_V12	(2 * SZ_1M)
@@ -47,4 +51,8 @@
 	ALIGN((((x + 3) * (y + 3) * 32)       \
 	+ (((y * 128) + 2304) * (x + 3) / 4)), 256)
 
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
index 088fd1c96b96..870d57bcf346 100644
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
index 26e3ed2e2b6f..f15324e64aec 100644
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
+		.id = V4L2_CID_CODEC_VP9_I_FRAME_QP,
+		.type = V4L2_CTRL_TYPE_INTEGER,
+		.minimum = 1,
+		.maximum = 255,
+		.step = 1,
+		.default_value = 1,
+	},
+	{
+		.id = V4L2_CID_CODEC_VP9_P_FRAME_QP,
+		.type = V4L2_CTRL_TYPE_INTEGER,
+		.minimum = 1,
+		.maximum = 255,
+		.step = 1,
+		.default_value = 1,
+	},
+	{
+		.id = V4L2_CID_CODEC_VP9_MAX_QP,
+		.type = V4L2_CTRL_TYPE_INTEGER,
+		.minimum = 230,
+		.maximum = 255,
+		.step = 1,
+		.default_value = 255,
+	},
+	{
+		.id = V4L2_CID_CODEC_VP9_MIN_QP,
+		.type = V4L2_CTRL_TYPE_INTEGER,
+		.minimum = 1,
+		.maximum = 24,
+		.step = 1,
+		.default_value = 1,
+	},
+	{
+		.id = V4L2_CID_CODEC_VP9_RC_FRAME_RATE,
+		.type = V4L2_CTRL_TYPE_INTEGER,
+		.minimum = 1,
+		.maximum = (1 << 16) - 1,
+		.step = 1,
+		.default_value = 1,
+	},
+	{
+		.id = V4L2_CID_CODEC_VP9_GOLDEN_FRAMESEL,
+		.type = V4L2_CTRL_TYPE_MENU,
+		.minimum = V4L2_CID_CODEC_VP9_GOLDEN_FRAME_USE_PREV,
+		.maximum = V4L2_CID_CODEC_VP9_GOLDEN_FRAME_USE_REF_PERIOD,
+		.step = 1,
+		.default_value = V4L2_CID_CODEC_VP9_GOLDEN_FRAME_USE_PREV,
+	},
+	{
+		.id = V4L2_CID_CODEC_VP9_GF_REFRESH_PERIOD,
+		.type = V4L2_CTRL_TYPE_INTEGER,
+		.minimum = 0,
+		.maximum = ((1 << 16) - 1),
+		.step = 1,
+		.default_value = 0,
+	},
+	{
+		.id = V4L2_CID_CODEC_VP9_HIERARCHY_QP_ENABLE,
+		.type = V4L2_CTRL_TYPE_BOOLEAN,
+		.minimum = 0,
+		.maximum = 1,
+		.step = 1,
+		.default_value = 0,
+	},
+	{
+		.id = V4L2_CID_CODEC_VP9_HIERARCHY_RC_ENABLE,
+		.type = V4L2_CTRL_TYPE_BOOLEAN,
+		.minimum = 0,
+		.maximum = 1,
+		.step = 1,
+		.default_value = 0,
+	},
+	{
+		.id = V4L2_CID_CODEC_VP9_HIER_CODING_L0_QP,
+		.type = V4L2_CTRL_TYPE_INTEGER,
+		.minimum = INT_MIN,
+		.maximum = INT_MAX,
+		.step = 1,
+		.default_value = 0,
+	},
+	{
+		.id = V4L2_CID_CODEC_VP9_HIER_CODING_L1_QP,
+		.type = V4L2_CTRL_TYPE_INTEGER,
+		.minimum = INT_MIN,
+		.maximum = INT_MAX,
+		.step = 1,
+		.default_value = 0,
+	},
+	{
+		.id = V4L2_CID_CODEC_VP9_HIER_CODING_L2_QP,
+		.type = V4L2_CTRL_TYPE_INTEGER,
+		.minimum = INT_MIN,
+		.maximum = INT_MAX,
+		.step = 1,
+		.default_value = 0,
+	},
+	{
+		.id = V4L2_CID_CODEC_VP9_REF_NUMBER_FOR_PFRAMES,
+		.type = V4L2_CTRL_TYPE_MENU,
+		.minimum = V4L2_CID_CODEC_VP9_1_REF_PFRAME,
+		.maximum = V4L2_CID_CODEC_VP9_2_REF_PFRAME,
+		.step = 1,
+		.default_value = V4L2_CID_CODEC_VP9_1_REF_PFRAME,
+	},
+	{
+		.id = V4L2_CID_CODEC_VP9_HIERARCHICAL_CODING_LAYER,
+		.type = V4L2_CTRL_TYPE_INTEGER,
+		.minimum = 0,
+		.maximum = 2,
+		.step = 1,
+		.default_value = 0,
+	},
+	{
+		.id = V4L2_CID_CODEC_VP9_MAX_PARTITION_DEPTH,
+		.type = V4L2_CTRL_TYPE_MENU,
+		.minimum = V4L2_CID_CODEC_VP9_0_PARTITION,
+		.maximum = V4L2_CID_CODEC_VP9_1_PARTITION,
+		.step = 1,
+		.default_value = V4L2_CID_CODEC_VP9_0_PARTITION,
+	},
+	{
+		.id = V4L2_CID_CODEC_VP9_DISABLE_INTRA_PU_SPLIT,
+		.type = V4L2_CTRL_TYPE_BOOLEAN,
+		.minimum = 0,
+		.maximum = 1,
+		.step = 1,
+		.default_value = 0,
+	},
+	{
+		.id = V4L2_CID_CODEC_VP9_HIER_CODING_L0_BR,
+		.type = V4L2_CTRL_TYPE_INTEGER,
+		.minimum = INT_MIN,
+		.maximum = INT_MAX,
+		.step = 1,
+		.default_value = 0,
+	},
+	{
+		.id = V4L2_CID_CODEC_VP9_HIER_CODING_L1_BR,
+		.type = V4L2_CTRL_TYPE_INTEGER,
+		.minimum = INT_MIN,
+		.maximum = INT_MAX,
+		.step = 1,
+		.default_value = 0,
+	},
+	{
+		.id = V4L2_CID_CODEC_VP9_HIER_CODING_L2_BR,
+		.type = V4L2_CTRL_TYPE_INTEGER,
+		.minimum = INT_MIN,
+		.maximum = INT_MAX,
+		.step = 1,
+		.default_value = 0,
+	},
+	{
+		.id = V4L2_CID_CODEC_VP9_DISABLE_IVF_HEADER,
+		.type = V4L2_CTRL_TYPE_BOOLEAN,
+		.minimum = 0,
+		.maximum = 1,
+		.step = 1,
+		.default_value = 0,
+	},
 	{
 		.id = V4L2_CID_MIN_BUFFERS_FOR_OUTPUT,
 		.type = V4L2_CTRL_TYPE_INTEGER,
@@ -1791,6 +1966,36 @@ static void __enc_update_hevc_qp_ctrls_range(struct s5p_mfc_ctx *ctx,
 	}
 }
 
+/*
+ * Update range of all VP9 quantization parameter controls that depend on the
+ * V4L2_CID_CODEC_VP9_MIN_QP, V4L2_CID_CODEC_VP9_MAX_QP controls.
+ */
+static void __enc_update_vp9_qp_ctrls_range(struct s5p_mfc_ctx *ctx,
+						int min, int max)
+{
+	static const int __vp9_qp_ctrls[] = {
+		V4L2_CID_CODEC_VP9_I_FRAME_QP,
+		V4L2_CID_CODEC_VP9_P_FRAME_QP,
+		V4L2_CID_CODEC_VP9_HIER_CODING_L0_QP,
+		V4L2_CID_CODEC_VP9_HIER_CODING_L1_QP,
+		V4L2_CID_CODEC_VP9_HIER_CODING_L2_QP,
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
@@ -2194,6 +2399,73 @@ static int s5p_mfc_enc_s_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_MPEG_VIDEO_PREPEND_SPSPPS_TO_IDR:
 		p->codec.hevc.prepend_sps_pps_to_idr = ctrl->val;
 		break;
+	case V4L2_CID_MPEG_VIDEO_VP9_PROFILE:
+		p->codec.vp9.vp9_profile = ctrl->val;
+		break;
+	case V4L2_CID_CODEC_VP9_RC_FRAME_RATE:
+		p->codec.vp9.rc_framerate = ctrl->val;
+		break;
+	case V4L2_CID_CODEC_VP9_MIN_QP:
+		p->codec.vp9.rc_min_qp = ctrl->val;
+		__enc_update_vp9_qp_ctrls_range(ctx, ctrl->val,
+			p->codec.vp9.rc_max_qp);
+		break;
+	case V4L2_CID_CODEC_VP9_MAX_QP:
+		p->codec.vp9.rc_max_qp = ctrl->val;
+		__enc_update_vp9_qp_ctrls_range(ctx,
+				p->codec.vp9.rc_min_qp, ctrl->val);
+		break;
+	case V4L2_CID_CODEC_VP9_I_FRAME_QP:
+		p->codec.vp9.rc_frame_qp = ctrl->val;
+		break;
+	case V4L2_CID_CODEC_VP9_P_FRAME_QP:
+		p->codec.vp9.rc_p_frame_qp = ctrl->val;
+		break;
+	case V4L2_CID_CODEC_VP9_GOLDEN_FRAMESEL:
+		p->codec.vp9.vp9_goldenframesel = ctrl->val;
+		break;
+	case V4L2_CID_CODEC_VP9_GF_REFRESH_PERIOD:
+		p->codec.vp9.vp9_gfrefreshperiod = ctrl->val;
+		break;
+	case V4L2_CID_CODEC_VP9_HIERARCHY_QP_ENABLE:
+		p->codec.vp9.hier_qp_enable = ctrl->val;
+		break;
+	case V4L2_CID_CODEC_VP9_HIERARCHY_RC_ENABLE:
+		p->codec.vp9.hier_rc_enable = ctrl->val;
+		break;
+	case V4L2_CID_CODEC_VP9_HIER_CODING_L0_QP:
+		p->codec.vp9.hier_qp_layer[0] = ctrl->val;
+		break;
+	case V4L2_CID_CODEC_VP9_HIER_CODING_L1_QP:
+		p->codec.vp9.hier_qp_layer[1] = ctrl->val;
+		break;
+	case V4L2_CID_CODEC_VP9_HIER_CODING_L2_QP:
+		p->codec.vp9.hier_qp_layer[2] = ctrl->val;
+		break;
+	case V4L2_CID_CODEC_VP9_HIER_CODING_L0_BR:
+		p->codec.vp9.hier_bit_layer[0] = ctrl->val;
+		break;
+	case V4L2_CID_CODEC_VP9_HIER_CODING_L1_BR:
+		p->codec.vp9.hier_bit_layer[1] = ctrl->val;
+		break;
+	case V4L2_CID_CODEC_VP9_HIER_CODING_L2_BR:
+		p->codec.vp9.hier_bit_layer[2] = ctrl->val;
+		break;
+	case V4L2_CID_CODEC_VP9_REF_NUMBER_FOR_PFRAMES:
+		p->codec.vp9.num_refs_for_p = ctrl->val;
+		break;
+	case V4L2_CID_CODEC_VP9_HIERARCHICAL_CODING_LAYER:
+		p->codec.vp9.num_hier_layer = ctrl->val;
+		break;
+	case V4L2_CID_CODEC_VP9_MAX_PARTITION_DEPTH:
+		p->codec.vp9.max_partition_depth = ctrl->val;
+		break;
+	case V4L2_CID_CODEC_VP9_DISABLE_INTRA_PU_SPLIT:
+		p->codec.vp9.intra_pu_split_disable = ctrl->val;
+		break;
+	case V4L2_CID_CODEC_VP9_DISABLE_IVF_HEADER:
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
index db8ecc2740d7..048950778eee 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
@@ -365,6 +365,17 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
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
@@ -420,6 +431,7 @@ static int s5p_mfc_alloc_instance_buffer_v6(struct s5p_mfc_ctx *ctx)
 	case S5P_MFC_CODEC_MPEG4_ENC:
 	case S5P_MFC_CODEC_H263_ENC:
 	case S5P_MFC_CODEC_VP8_ENC:
+	case S5P_FIMV_CODEC_VP9_ENC:
 		ctx->ctx.size = buf_size->other_enc_ctx;
 		break;
 	default:
@@ -1654,6 +1666,102 @@ static int s5p_mfc_set_enc_params_hevc(struct s5p_mfc_ctx *ctx)
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
@@ -1775,6 +1883,8 @@ static int s5p_mfc_init_encode_v6(struct s5p_mfc_ctx *ctx)
 		s5p_mfc_set_enc_params_vp8(ctx);
 	else if (ctx->codec_mode == S5P_FIMV_CODEC_HEVC_ENC)
 		s5p_mfc_set_enc_params_hevc(ctx);
+	else if (ctx->codec_mode == S5P_FIMV_CODEC_VP9_ENC)
+		s5p_mfc_set_enc_params_vp9(ctx);
 	else {
 		mfc_err("Unknown codec for encoding (%x).\n",
 			ctx->codec_mode);
@@ -2538,6 +2648,17 @@ const struct s5p_mfc_regs *s5p_mfc_init_regs_v6_plus(struct s5p_mfc_dev *dev)
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


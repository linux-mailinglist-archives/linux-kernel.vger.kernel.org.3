Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192575AFC89
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiIGGgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiIGGg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:36:26 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF95832C0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 23:36:18 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220907063616epoutp0200cf642ceb6c4887cc46e3daaaa1504a~SgJHSnJr90480504805epoutp02X
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 06:36:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220907063616epoutp0200cf642ceb6c4887cc46e3daaaa1504a~SgJHSnJr90480504805epoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1662532576;
        bh=nueslptotCAgDC8OPRlSZu+dMlDrdFPchYG7E2CeFW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I9ItpwexZQ7ZSNyDUyVSOCUwOvmhYiEz7Nbj844luzvJR/FsMs+w/hXqLN9qDABfp
         jaPxqrTuU4NITbsyQHjMjUlyGvnngt9dS8fOKeItEfzGsCU+XIjclpZVCjR61fmEKA
         ZX5lEwyHG5awbelz3HjGPRzeqsrhp0wrQFlBkDRA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220907063615epcas5p1bdabdb80017da53c559fae12031a1279~SgJGpUlzo0745007450epcas5p1g;
        Wed,  7 Sep 2022 06:36:15 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4MMswD2gxMz4x9Pw; Wed,  7 Sep
        2022 06:36:12 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5C.43.53458.CDB38136; Wed,  7 Sep 2022 15:36:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220907063336epcas5p3511dcc3393c7bd5fe44f37889dd754df~SgGytQ6M_1696316963epcas5p38;
        Wed,  7 Sep 2022 06:33:36 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220907063336epsmtrp10e7b29cfbef62e13a83046dbea4bbbc7~SgGyr6awT0506905069epsmtrp1_;
        Wed,  7 Sep 2022 06:33:36 +0000 (GMT)
X-AuditID: b6c32a4a-caffb7000000d0d2-c5-63183bdc8716
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F4.DC.14392.04B38136; Wed,  7 Sep 2022 15:33:36 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.109.115.6]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220907063332epsmtip158584d60b47324290209b8411dc12e14~SgGugX4xs2478824788epsmtip1e;
        Wed,  7 Sep 2022 06:33:32 +0000 (GMT)
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
Subject: [Patch v2 06/15] media: v4l2: Add v4l2 control IDs for VP9 encoder.
Date:   Wed,  7 Sep 2022 12:17:06 +0530
Message-Id: <20220907064715.55778-7-smitha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220907064715.55778-1-smitha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTa1ATVxTH5242m4Q2zBJQr3SkdFunQgkkNIGLgHZaxm7BD3T4QIc+6DbZ
        ASQkmWyordqCIKgpoMzQWkCgBUpnECFieAhBA/IyIi3y6oMoDx3EoeoYtRZbbEKw/fY75/zP
        Pff+771CnmSW8BdmaI2sQctoKMILb78YFCydiYYq2WmTBN3sLOej2ep2AtU9XsTQ9TonjvrO
        tgmQZaKSh34csvFRTf8oH3X0zuPozC1XdazcgaPFmmaAliquEah1YYqP5m4no/GukwQqMrfx
        0el+hwD9MD2GoYbWvzFU2/ZAgAp6+gXIYW0H6FBhP/YGpJuqmwDd6agH9HT9fR59rsIhoOus
        Sxjd2niUoGemrAR9tj6HLhhYwekSSyOgV/OqBLSpf5qgna0BtP2hU5DonZIZk84yatYQyGpV
        OnWGNi2WSkhKfStVGSGTS+VRKJIK1DJZbCwVtztRuitD47KBCvyU0WS7UokMx1FhO2IMumwj
        G5iu44yxFKtXa/QKfSjHZHHZ2rRQLWvcLpfJwpUu4ceZ6Yvdq4S+RflZ90wRngvmQ01AJISk
        AvaWmoEJeAklZDeAl76/yfcE9wG8Yp8jPMEjAIsWDglMQLjW0uwI8+R7AFwYqFrvyMeg9eHP
        uHtdggyBj+5eJtzsRx50qY4Y3SIemY9Dx8gTgbvgS+6Gv1aOY27Gya1w4moTz81iMgouWqv5
        ng2+CE+ZbWt5EbkdjpUNr02D5GERrOy+R3hEcfDauBN42BfeHrIIPOwPl44VrnMavO7MX9fo
        YVWuBfPwTmibOIm7j8Yjg2BLV5gnvQV+bW9ek/BIb1j85Ma6XAw7q58xBWtHhteXh3Dyjza+
        xyEaXhj18phSDKBlJQ8/DgIq/p/wHQCNYDOr57LSWE6pD9eye/+7NZUuqxWsPfXg+E4wN3sv
        tA9gQtAHoJBH+YnVnX4qiVjNfL6PNehSDdkalusDSpd/pTz/DSqd669ojalyRZRMERERoYh6
        PUJObRKXvQZUEjKNMbKZLKtnDc/6MKHIPxczPR+pzhsumS0uyz9x/u67K/s7NoFjtvMwv2aH
        z0u+x4sGQV324P4jkQlP+aDOm9sS949l21NZr2Wq/epHn1AXznwwMB80k/P7yC3lcLLwYqwg
        LOlDdcbGENnhaP6JkRfkxZPFK3ubG17dljR1oD4l9U55inbKNhZjXhyUdxcyX8SHv/ml/uXx
        b+1NzI2u594fXZVI98w1KLp+SpjcUzNUumvyldo75vjlS44l63LhL79JBh57PeA08hWwtaMh
        KeDolT/3OR3Lb2tbKjcuSOPe2RBtOnXZR1JAiert5m9qe0Rx56S2nBL6r4KD3mGi2rEqLOS9
        r4rEEweSgu3TAe07xcmbfSicS2fkwTwDx/wLHI7zA3MEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0xSYRjHfQ/nJhN3BrTerKzILraimNVeu9jl02nZ1v26loRnRAGyA3ax
        Lc3SipiVK8s0tSQdalaYgElFREuzm+WkG3axQluti+ZcOUt0ffs/v9//2fPhoQXiM3gUrdGb
        OF6v1MpIIe64I4uetnAuVM04ejgGfXTlE+htkYNEpb1BDL0p7cKRt6aWQtdaCgSo/J6HQMW+
        RwRy3n6Po6sdA7Y5P4CjYHE1QJ1n20hkb28l0LvP69Cz64UkslypJdAlX4BCF/3NGCqz92Ho
        Qm03hbJu+CgUcDsAOpjtwxZCtqqoCrCugBWwfutPAVt3NkCxpe5OjLVXHCHZ161ukq2xprNZ
        d3/jbM61CsD2Z56jWLPPT7Jd9mj2/q8uannkRuG8ZE6r2cnx0xOShNuC9f2k4fKs3fWvLXgG
        eC83A5qGzExYHZhuBkJazNQDuN//kzSD8AEOoe1PLhjKEmjrD1JDpf0YPFRTIAgJkpkKe741
        kSEhZbIA9NuOYKFBwBTgsDfXQ4RaEiYRvih4hoUyzkyALU+rBrdFTDwMuouIoRNjYOUVzyAP
        Z+bA5pMNg1w80Gk/46COg8gSEFYBRnAGo06tMyoMCj23S25U6oyperVclaKzg8HnTYl1AWfF
        d7kXYDTwAkgLZFJRskuqEouSlXvSOD5lC5+q5YxeMJLGZcNFT8yNW8SMWmnidnCcgeP/W4wO
        j8rA4oikZalfyiZ3mwmNri0QG7FAestfh7fZ8sXZfQ9scTGZxcrOY6siA/pPbQkTx5rGjTaF
        XR31bd7xw64HN9SWkhb9S9HIXVmn5q8o7ADnV6ZeNAGwOm9J4fhXwtYDh7jKRb/og2NrMmyR
        CWUbL6lvzk5qODCx8K84ffXWJu+IeCt1Jw22O1WbmrR9c3MalzYqPmrjoyt/hPUMczi3atb/
        SZfHd/FqQjdVsrQjiovrfvXWr3rxKRNfU71DcismJ4//kHjauiyiZLMmu9mpHWdPyyuxbMC3
        y3smGRoS6mYqVob/lS6+l1u+VxXxvFzy1f2w57Fl7YlYfsy5fdW9nhSRR4YbtykVUwS8UfkP
        ZDkTTysDAAA=
X-CMS-MailID: 20220907063336epcas5p3511dcc3393c7bd5fe44f37889dd754df
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220907063336epcas5p3511dcc3393c7bd5fe44f37889dd754df
References: <20220907064715.55778-1-smitha.t@samsung.com>
        <CGME20220907063336epcas5p3511dcc3393c7bd5fe44f37889dd754df@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add V4l2 controls for VP9 encoder

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
---
 drivers/media/v4l2-core/v4l2-ctrls-defs.c | 44 +++++++++++++++++++++++
 include/uapi/linux/v4l2-controls.h        | 33 +++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
index e22921e7ea61..2d92e93158bd 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
@@ -577,6 +577,21 @@ const char * const *v4l2_ctrl_get_menu(u32 id)
 		"Cyclic",
 		NULL,
 	};
+	static const char * const vp9_golden_framesel[] = {
+		"Use previous",
+		"Use refresh period",
+		NULL,
+	};
+	static const char * const vp9_ref_num_for_pframes[] = {
+		"1",
+		"2",
+		NULL,
+	};
+	static const char * const vp9_max_partition_depth[] = {
+	"No CU partition depth",
+	"Allow 1 CU partition depth",
+	NULL,
+	};
 
 	switch (id) {
 	case V4L2_CID_MPEG_AUDIO_SAMPLING_FREQ:
@@ -708,6 +723,12 @@ const char * const *v4l2_ctrl_get_menu(u32 id)
 		return hevc_decode_mode;
 	case V4L2_CID_STATELESS_HEVC_START_CODE:
 		return hevc_start_code;
+	case V4L2_CID_CODEC_VP9_GOLDEN_FRAMESEL:
+		return vp9_golden_framesel;
+	case V4L2_CID_CODEC_VP9_REF_NUMBER_FOR_PFRAMES:
+		return vp9_ref_num_for_pframes;
+	case V4L2_CID_CODEC_VP9_MAX_PARTITION_DEPTH:
+		return vp9_max_partition_depth;
 	case V4L2_CID_CAMERA_ORIENTATION:
 		return camera_orientation;
 	case V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE:
@@ -950,6 +971,26 @@ const char *v4l2_ctrl_get_name(u32 id)
 	case V4L2_CID_MPEG_VIDEO_VP8_PROFILE:			return "VP8 Profile";
 	case V4L2_CID_MPEG_VIDEO_VP9_PROFILE:			return "VP9 Profile";
 	case V4L2_CID_MPEG_VIDEO_VP9_LEVEL:			return "VP9 Level";
+	case V4L2_CID_CODEC_VP9_I_FRAME_QP:		return "VP9 I Frame QP Value";
+	case V4L2_CID_CODEC_VP9_P_FRAME_QP:		return "VP9 P Frame QP Value";
+	case V4L2_CID_CODEC_VP9_MAX_QP:			return "VP9 Frame QP MAX Value";
+	case V4L2_CID_CODEC_VP9_MIN_QP:			return "VP9 Frame QP MIN Value";
+	case V4L2_CID_CODEC_VP9_RC_FRAME_RATE:		return "VP9 Frame Rate";
+	case V4L2_CID_CODEC_VP9_GOLDEN_FRAMESEL:	return "VP9 Indication of Golden Frame";
+	case V4L2_CID_CODEC_VP9_GF_REFRESH_PERIOD:	return "VP9 Golden Frame Refresh Period";
+	case V4L2_CID_CODEC_VP9_HIERARCHY_QP_ENABLE:	return "VP9 Hierarchical QP Enable";
+	case V4L2_CID_CODEC_VP9_REF_NUMBER_FOR_PFRAMES:	return "VP9 Number of Reference Pictures";
+	case V4L2_CID_CODEC_VP9_HIERARCHICAL_CODING_LAYER:return "VP9 Num of Hierarchical Layers";
+	case V4L2_CID_CODEC_VP9_MAX_PARTITION_DEPTH:	return "VP9 Maximum Coding Unit Depth";
+	case V4L2_CID_CODEC_VP9_DISABLE_INTRA_PU_SPLIT:	return "VP9 Disable Intra PU Split";
+	case V4L2_CID_CODEC_VP9_HIERARCHY_RC_ENABLE:	return "VP9 Hierarchical BitRate Enable";
+	case V4L2_CID_CODEC_VP9_HIER_CODING_L0_BR:	return "VP9 Hierarchical Layer 0 BitRate";
+	case V4L2_CID_CODEC_VP9_HIER_CODING_L1_BR:	return "VP9 Hierarchical Layer 1 BitRate";
+	case V4L2_CID_CODEC_VP9_HIER_CODING_L2_BR:	return "VP9 Hierarchical Layer 2 BitRate";
+	case V4L2_CID_CODEC_VP9_HIER_CODING_L0_QP:	return "VP9 Layer0 QP Value";
+	case V4L2_CID_CODEC_VP9_HIER_CODING_L1_QP:	return "VP9 Layer1 QP Value";
+	case V4L2_CID_CODEC_VP9_HIER_CODING_L2_QP:	return "VP9 Layer2 QP Value";
+	case V4L2_CID_CODEC_VP9_DISABLE_IVF_HEADER:	return "VP9 IVF header generation";
 
 	/* HEVC controls */
 	case V4L2_CID_MPEG_VIDEO_HEVC_I_FRAME_QP:		return "HEVC I-Frame QP Value";
@@ -1366,6 +1407,9 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
 	case V4L2_CID_MPEG_VIDEO_HEVC_LOOP_FILTER_MODE:
 	case V4L2_CID_STATELESS_HEVC_DECODE_MODE:
 	case V4L2_CID_STATELESS_HEVC_START_CODE:
+	case V4L2_CID_CODEC_VP9_GOLDEN_FRAMESEL:
+	case V4L2_CID_CODEC_VP9_REF_NUMBER_FOR_PFRAMES:
+	case V4L2_CID_CODEC_VP9_MAX_PARTITION_DEPTH:
 	case V4L2_CID_STATELESS_H264_DECODE_MODE:
 	case V4L2_CID_STATELESS_H264_START_CODE:
 	case V4L2_CID_CAMERA_ORIENTATION:
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index 5f46bf4a570c..eebd1b59cccc 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -716,6 +716,38 @@ enum v4l2_mpeg_video_vp9_level {
 	V4L2_MPEG_VIDEO_VP9_LEVEL_6_1	= 12,
 	V4L2_MPEG_VIDEO_VP9_LEVEL_6_2	= 13,
 };
+#define V4L2_CID_CODEC_VP9_RC_FRAME_RATE	(V4L2_CID_CODEC_BASE+514)
+#define V4L2_CID_CODEC_VP9_MIN_QP		(V4L2_CID_CODEC_BASE+515)
+#define V4L2_CID_CODEC_VP9_MAX_QP		(V4L2_CID_CODEC_BASE+516)
+#define V4L2_CID_CODEC_VP9_I_FRAME_QP	(V4L2_CID_CODEC_BASE+517)
+#define V4L2_CID_CODEC_VP9_P_FRAME_QP	(V4L2_CID_CODEC_BASE+518)
+#define V4L2_CID_CODEC_VP9_GOLDEN_FRAMESEL	(V4L2_CID_CODEC_BASE+519)
+enum v4l2_mpeg_vp9_golden_framesel {
+	V4L2_CID_CODEC_VP9_GOLDEN_FRAME_USE_PREV           = 0,
+	V4L2_CID_CODEC_VP9_GOLDEN_FRAME_USE_REF_PERIOD     = 1,
+};
+#define V4L2_CID_CODEC_VP9_GF_REFRESH_PERIOD (V4L2_CID_CODEC_BASE+520)
+#define V4L2_CID_CODEC_VP9_HIERARCHY_QP_ENABLE (V4L2_CID_CODEC_BASE+521)
+#define V4L2_CID_CODEC_VP9_REF_NUMBER_FOR_PFRAMES (V4L2_CID_CODEC_BASE+522)
+enum v4l2_mpeg_vp9_ref_num_for_pframes {
+	V4L2_CID_CODEC_VP9_1_REF_PFRAME     = 0,
+	V4L2_CID_CODEC_VP9_2_REF_PFRAME     = 1,
+};
+#define V4L2_CID_CODEC_VP9_HIERARCHICAL_CODING_LAYER (V4L2_CID_CODEC_BASE+523)
+#define V4L2_CID_CODEC_VP9_HIER_CODING_L0_BR	(V4L2_CID_CODEC_BASE+524)
+#define V4L2_CID_CODEC_VP9_HIER_CODING_L1_BR	(V4L2_CID_CODEC_BASE+525)
+#define V4L2_CID_CODEC_VP9_HIER_CODING_L2_BR	(V4L2_CID_CODEC_BASE+526)
+#define V4L2_CID_CODEC_VP9_HIER_CODING_L0_QP	(V4L2_CID_CODEC_BASE+527)
+#define V4L2_CID_CODEC_VP9_HIER_CODING_L1_QP	(V4L2_CID_CODEC_BASE+528)
+#define V4L2_CID_CODEC_VP9_HIER_CODING_L2_QP	(V4L2_CID_CODEC_BASE+529)
+#define V4L2_CID_CODEC_VP9_MAX_PARTITION_DEPTH	(V4L2_CID_CODEC_BASE+530)
+enum v4l2_mpeg_vp9_num_partitions {
+	V4L2_CID_CODEC_VP9_0_PARTITION     = 0,
+	V4L2_CID_CODEC_VP9_1_PARTITION	= 1,
+};
+#define V4L2_CID_CODEC_VP9_DISABLE_INTRA_PU_SPLIT	(V4L2_CID_CODEC_BASE+531)
+#define V4L2_CID_CODEC_VP9_DISABLE_IVF_HEADER	(V4L2_CID_CODEC_BASE+532)
+#define V4L2_CID_CODEC_VP9_HIERARCHY_RC_ENABLE	(V4L2_CID_CODEC_BASE+533)
 
 /* CIDs for HEVC encoding. */
 
@@ -826,6 +858,7 @@ enum v4l2_mpeg_video_frame_skip_mode {
 #define V4L2_CID_MPEG_VIDEO_DEC_DISPLAY_DELAY		(V4L2_CID_CODEC_BASE + 653)
 #define V4L2_CID_MPEG_VIDEO_DEC_DISPLAY_DELAY_ENABLE	(V4L2_CID_CODEC_BASE + 654)
 
+
 /*  MPEG-class control IDs specific to the CX2341x driver as defined by V4L2 */
 #define V4L2_CID_CODEC_CX2341X_BASE				(V4L2_CTRL_CLASS_CODEC | 0x1000)
 #define V4L2_CID_MPEG_CX2341X_VIDEO_SPATIAL_FILTER_MODE		(V4L2_CID_CODEC_CX2341X_BASE+0)
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3456152A25C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 14:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244193AbiEQM7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbiEQM67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:58:59 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2824DF41
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 05:58:01 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220517125759epoutp02ec73e803ec70bee19ed5e1db652e6f9d~v5dJF_CqX1124911249epoutp02f
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 12:57:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220517125759epoutp02ec73e803ec70bee19ed5e1db652e6f9d~v5dJF_CqX1124911249epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652792279;
        bh=crA0yr3cVcaZppYCAPoQL5spijojPGTodvsobyWSZ2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UFhTAEV0ltAYW0jbP7A/UfDnF6btt5QFyxipXqgpa4XPx2LKiWSKEQAx05CAwvv7n
         zJ1JhP26oq6HlPRG2/JKBHGhWbUYvv5U/yGZC1Bw33hKtYgaVLe03biUksloZsbfBS
         eMyy/1ZsnpsDlfGkvY1Q5k4PW31ru9j5VVXiuL9I=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220517125758epcas5p3fd89996c0a68e223d81c309ef3158f64~v5dIAkYlT2692026920epcas5p3E;
        Tue, 17 May 2022 12:57:58 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4L2bkr1ZKJz4x9Pv; Tue, 17 May
        2022 12:57:56 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        40.2F.10063.3DB93826; Tue, 17 May 2022 21:57:56 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220517125608epcas5p48b5d2f91c711e5728f993169b1d4b9a1~v5bhwXQLP2591625916epcas5p45;
        Tue, 17 May 2022 12:56:08 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220517125608epsmtrp195557ac40a9638a6ee54bd05e56b2e06~v5bhvLMeA3276532765epsmtrp1T;
        Tue, 17 May 2022 12:56:08 +0000 (GMT)
X-AuditID: b6c32a49-4cbff7000000274f-90-62839bd322b5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        08.36.08924.86B93826; Tue, 17 May 2022 21:56:08 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220517125605epsmtip1376c86dd6f2dca6e781d24857ba6534d~v5bestEzs1797117971epsmtip1E;
        Tue, 17 May 2022 12:56:05 +0000 (GMT)
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
Subject: [PATCH 06/20] Documention: v4l: Documentation for VP9 CIDs.
Date:   Tue, 17 May 2022 18:25:34 +0530
Message-Id: <20220517125548.14746-7-smitha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220517125548.14746-1-smitha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTf1BUVRTHve/tvl3QlTeIwwUV6DmWMAG7sKwXhFCj5qGYMORYTrQ+4LUQ
        y+7OviWgnEJXkGWkyCGHH/Ij2bKQFBaW30xAa4RCAxPCNLmBoRGWRYImEdiuD+q/zznne37M
        OfeKcffvCW9xusbA6jWMmiJcBa1f+fsHjlUak6VlQxiaqm4lUN2jGQxN1s0LUH+zVYRaxipx
        dHGgV4hqbN8KUVvfTwLU9IsjOlpuF6CZmssAzVb8SCDL9LgQ3bp7BH3XeZ5AZxqtQvSFzS5C
        n0yMYuhTyz8YumBdEKH8HpsI2btbATpVYMP2eNIN1Q2AbrebAT1hvo/THRV2EV3XPYvRlnoT
        Qd8c7yboZvN7dP7VvwX0+y31gF45WSWii2wTBD1v8aGvPZgXxW88mhGZxjKprN6P1aRoU9M1
        qijqQKLyeWWYQioLlIWjXZSfhslko6iYuPjAF9PVjg1Qfm8x6iyHK57hOCr4uUi9NsvA+qVp
        OUMUxepS1Tq5LohjMrksjSpIwxoiZFJpSJhDeCwjzXKO0BllOU1zRSAPTD1TBFzEkJRDc2MD
        7mR3sgvA32qzi4Crg+8DWNvYRfDGPIClv5fjaxk9MwuAD3QCaK23YrxxCoMXy+49URHks/Dh
        H9cJJ3uQJwCcLjQ4GSeXcFg+5uPkTWQMPD3cDJwsIHfAqut9mJMlZDj8c+SskO/mCy819jpq
        isUuZASsWkly9oLkYzH8/MoUwWtiYLHRJOJ5E7w70LLK3nD2g4JVVsHJeSPgWQer8lownqNh
        79h5gbM+TvrDK53BvHsb/OjaZYwfeSMsXrq9KpfA9uo1puCFoW9Wy0N44551dWQaLrSO4PxO
        igF8aPxBUAJ8Kv5vUQtAPfBidVymiuXCdDINm/3fzVK0mRbw5I0HxLYD+9RcUD/AxKAfQDFO
        eUikOXnJ7pJUJvdtVq9V6rPULNcPwhz7+xD33pyidXwSjUEpk4dL5QqFQh4eqpBRnhLy8Ylk
        d1LFGNgMltWx+rU8TOzinYdRPyuYdfZDT3s29U8sPvL6Fb8qd1l8Y/RmRPCd7We35njvOBxd
        uahLP1hGlu67Mx1St3tFg+DmV80Ha97Zim3L17e/G2kbL9m59HFCgceIf0D+cnPKsXJ3ifp4
        rWvh+jrgETu8QK1LyjhEmSZDDnd17Ocqdr6uPCdIqtZObXCLVsU3Fc68lBDy5eDwpQd43L6/
        sLCje1GzdW/Kad9Yr1DUEfK1puWFGxvctE8d6ItLz+7x2D5Y9plvYuAMccv6cqUpbbDApy10
        bP0eLrfTJ3dLAsYt22Nby0xuuxZ226e3vHZEN3e8NPGVof0nz5gHRmCJrq3ozWH5sFG9HA3t
        t5WwWEgJuDRGFoDrOeZfADax6WwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTYRiA+87Ozo6ryWkWfi40WmigZWoRn2ZpZXHAyKKwCLqsPE3TzbFZ
        WnSZTq1GdJGhTZtaWqaZ6HRqOsnLNMq8oW1Ermwmc0mlaVIqIy/073l5Ht73x0uy+PdxARkn
        TWLkUlGCkODitW1Cr02xeaozAbYKTzSUX0ugoj92DH0umsRRa7WBg2oG8lio5HUzGxWYutmo
        rsWGo6rRedunteLIXlABkCP3E4H0w2Y2+vLtKOpveEig25UGNnphsnLQE0sfhp7q5zD02DDF
        QRlNJg6yGmsBSs80YeHudHl+OaDrrcWAthT/YtEvc60cusjowGh92S2CHjQbCbq6+Dqd0T6D
        03dqygDtTNNxaLXJQtCTei/67e9JzkHX49zQGCYh7iIj37zzNDdWn03IVIEpVeNqoARDG9TA
        hYTUVthknwJqwCX5VD2A3eYW1pKAsHQ2CyyxGyx12jlLURoGs+zOxYigNsLpn53EglhFZQBo
        Kb2FLQws6j4ONZaZxcqNioA3uqoXV+GUN9R1tmALzKOC4URvFnvpxFr4vLJ5vidJFyoE6pwn
        FpA/n4y8QveAayFYVgY8GJlCIpYoAmVBUibZXyGSKC5Ixf5nEyV6sPg1X996YCwb928FGAla
        ASRZwlW8gBTlGT4vRnTpMiNPPCW/kMAoWsEaEhe683rVb07xKbEoiYlnGBkj/28x0kWgxIpf
        y4aCtn1M2ONT3uiqrN41Nxyj2bXNsWO38VwEc3VAdfsk5HG1bgYjmBtsSg9/iL1/bG4X+N85
        Xtrx0bxSnBv5c8XAlRHNsE9EScQ1SY2b5oW7dwzWnyqoD56ZLkyKFufIyNzM3t09f/NqYcXI
        xnLCdmTsneYas1/oHOixr9VK8z7QvXGe2PfzbfuSuKK9Q1PsyWiX5Ecexh+NXz23h72d0Dpa
        DOS0KnG97VnPiq5s17svv+zV1R3I0TpzNtE3okINY6rLyjq/5vW67I7MYzZBoNfBQ4MlGnnU
        jM/qhvjR8dmb75eLbKGRIevG4lLDDrH8oiYOD/9xaA4/2MLtFuKKWFGgL0uuEP0D8Nwq5SQD
        AAA=
X-CMS-MailID: 20220517125608epcas5p48b5d2f91c711e5728f993169b1d4b9a1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220517125608epcas5p48b5d2f91c711e5728f993169b1d4b9a1
References: <20220517125548.14746-1-smitha.t@samsung.com>
        <CGME20220517125608epcas5p48b5d2f91c711e5728f993169b1d4b9a1@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds V4l2 controls for VP9 encoder documention.

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
---
 .../media/v4l/ext-ctrls-codec.rst             | 167 ++++++++++++++++++
 1 file changed, 167 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
index 4cd7c541fc30..1b617a08f973 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
@@ -2165,6 +2165,16 @@ enum v4l2_mpeg_video_vp8_profile -
     * - ``V4L2_MPEG_VIDEO_VP8_PROFILE_3``
       - Profile 3
 
+VP9 Control Reference
+---------------------
+
+The VP9 controls include controls for encoding parameters of VP9 video
+codec.
+
+.. _vp9-control-id:
+
+VP9 Control IDs
+
 .. _v4l2-mpeg-video-vp9-profile:
 
 ``V4L2_CID_MPEG_VIDEO_VP9_PROFILE``
@@ -2231,6 +2241,163 @@ enum v4l2_mpeg_video_vp9_level -
     * - ``V4L2_MPEG_VIDEO_VP9_LEVEL_6_2``
       - Level 6.2
 
+``V4L2_CID_MPEG_VIDEO_VP9_I_FRAME_QP``
+    Quantization parameter for an I frame for VP9. Valid range: from 1 to 255.
+
+``V4L2_CID_MPEG_VIDEO_VP9_P_FRAME_QP``
+    Quantization parameter for an P frame for VP9. Valid range: from 1 to 255.
+
+``V4L2_CID_MPEG_VIDEO_VP9_MAX_QP``
+    Maximum quantization parameter for VP9. Valid range: from 1 to 255.
+    Recommended range for MFC is from 230 to 255.
+
+``V4L2_CID_MPEG_VIDEO_VP9_MIN_QP``
+    Minimum quantization parameter for VP9. Valid range: from 1 to 255.
+    Recommended range for MFC is from 1 to 24.
+
+``V4L2_CID_MPEG_VIDEO_VP9_RC_FRAME_RATE``
+    Indicates the number of evenly spaced subintervals, called ticks, within
+    one second. This is a 16 bit unsigned integer and has a maximum value up to
+    0xffff and a minimum value of 1.
+
+``V4L2_CID_MPEG_VIDEO_VP9_GF_REFRESH_PERIOD``
+    Indicates the refresh period of the golden frame for VP9 encoder.
+
+.. _v4l2-vp9-golden-frame-sel:
+
+``V4L2_CID_MPEG_VIDEO_VP9_GOLDEN_FRAMESEL``
+    (enum)
+
+enum v4l2_mpeg_vp9_golden_framesel -
+    Selects the golden frame for encoding. Valid when NUM_OF_REF is 2.
+    Possible values are:
+
+.. raw:: latex
+
+    \footnotesize
+
+.. tabularcolumns:: |p{9.0cm}|p{8.0cm}|
+
+.. flat-table::
+    :header-rows:  0
+    :stub-columns: 0
+
+    * - ``V4L2_CID_MPEG_VIDEO_VP9_GOLDEN_FRAME_USE_PREV``
+      - Use the (n-2)th frame as a golden frame, current frame index being
+        'n'.
+    * - ``V4L2_CID_MPEG_VIDEO_VP9_GOLDEN_FRAME_USE_REF_PERIOD``
+      - Use the previous specific frame indicated by
+        ``V4L2_CID_MPEG_VIDEO_VP9_GF_REFRESH_PERIOD`` as a
+        golden frame.
+
+.. raw:: latex
+
+    \normalsize
+
+
+``V4L2_CID_MPEG_VIDEO_VP9_HIERARCHY_QP_ENABLE``
+    Allows host to specify the quantization parameter values for each
+    temporal layer through HIERARCHICAL_QP_LAYER. This is valid only
+    if HIERARCHICAL_CODING_LAYER is greater than 1. Setting the control
+    value to 1 enables setting of the QP values for the layers.
+
+.. _v4l2-vp9-ref-number-of-pframes:
+
+``V4L2_CID_MPEG_VIDEO_VP9_REF_NUMBER_FOR_PFRAMES``
+    (enum)
+
+enum v4l2_mpeg_vp9_ref_num_for_pframes -
+    Number of reference pictures for encoding P frames.
+
+.. raw:: latex
+
+    \footnotesize
+
+.. tabularcolumns:: |p{9.0cm}|p{8.0cm}|
+
+.. flat-table::
+    :header-rows:  0
+    :stub-columns: 0
+
+    * - ``V4L2_CID_MPEG_VIDEO_VP9_1_REF_PFRAME``
+      - Indicates one reference frame, last encoded frame will be searched.
+    * - ``V4L2_CID_MPEG_VIDEO_VP9_GOLDEN_FRAME_USE_REF_PERIOD``
+      - Indicates 2 reference frames, last encoded frame and golden frame
+        will be searched.
+
+.. raw:: latex
+
+    \normalsize
+
+
+``V4L2_CID_MPEG_VIDEO_VP9_HIERARCHICAL_CODING_LAYER``
+    Indicates the number of hierarchial coding layer.
+    In normal encoding (non-hierarchial coding), it should be zero.
+    VP9 has upto 3 layer of encoder.
+
+``V4L2_CID_MPEG_VIDEO_VP9_HIERARCHY_RC_ENABLE``
+    Indicates enabling of bit rate for hierarchical coding layers VP9 encoder.
+
+``V4L2_CID_MPEG_VIDEO_VP9_HIER_CODING_L0_BR``
+    Indicates bit rate for hierarchical coding layer 0 for VP9 encoder.
+
+``V4L2_CID_MPEG_VIDEO_VP9_HIER_CODING_L1_BR``
+    Indicates bit rate for hierarchical coding layer 1 for VP9 encoder.
+
+``V4L2_CID_MPEG_VIDEO_VP9_HIER_CODING_L2_BR``
+    Indicates bit rate for hierarchical coding layer 2 for VP9 encoder.
+
+``V4L2_CID_MPEG_VIDEO_VP9_HIER_CODING_L0_QP``
+    Indicates quantization parameter for hierarchical coding layer 0.
+    Valid range: [V4L2_CID_MPEG_VIDEO_VP9_MIN_QP,
+    V4L2_CID_MPEG_VIDEO_VP9_MAX_QP].
+
+``V4L2_CID_MPEG_VIDEO_VP9_HIER_CODING_L1_QP``
+    Indicates quantization parameter for hierarchical coding layer 1.
+    Valid range: [V4L2_CID_MPEG_VIDEO_VP9_MIN_QP,
+    V4L2_CID_MPEG_VIDEO_VP9_MAX_QP].
+
+``V4L2_CID_MPEG_VIDEO_VP9_HIER_CODING_L2_QP``
+    Indicates quantization parameter for hierarchical coding layer 2.
+    Valid range: [V4L2_CID_MPEG_VIDEO_VP9_MIN_QP,
+    V4L2_CID_MPEG_VIDEO_VP9_MAX_QP].
+
+.. _v4l2-vp9-max-partition-depth:
+
+``V4L2_CID_MPEG_VIDEO_VP9_MAX_PARTITION_DEPTH``
+    (enum)
+
+enum v4l2_mpeg_vp9_num_partitions -
+    Indicate maximum coding unit depth.
+
+.. raw:: latex
+
+    \footnotesize
+
+.. tabularcolumns:: |p{9.0cm}|p{8.0cm}|
+
+.. flat-table::
+    :header-rows:  0
+    :stub-columns: 0
+
+    * - ``V4L2_CID_MPEG_VIDEO_VP9_0_PARTITION``
+      - No coding unit partition depth.
+    * - ``V4L2_CID_MPEG_VIDEO_VP9_1_PARTITION``
+      - Allows one coding unit partition depth.
+
+.. raw:: latex
+
+    \normalsize
+
+
+``V4L2_CID_MPEG_VIDEO_VP9_DISABLE_INTRA_PU_SPLIT``
+    Zero indicates enable intra NxN PU split.
+    One indicates disable intra NxN PU split.
+
+``V4L2_CID_MPEG_VIDEO_VP9_DISABLE_IVF_HEADER``
+    Indicates IVF header generation. Zero indicates enable IVF format.
+    One indicates disable IVF format.
+
 
 High Efficiency Video Coding (HEVC/H.265) Control Reference
 ===========================================================
-- 
2.17.1


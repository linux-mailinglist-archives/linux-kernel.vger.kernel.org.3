Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC205AFC88
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiIGGg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiIGGgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:36:22 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441B682D1B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 23:36:16 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220907063613epoutp02b005aec5ba84add90a903cf0985920d5~SgJE1bDZd0592205922epoutp02i
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 06:36:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220907063613epoutp02b005aec5ba84add90a903cf0985920d5~SgJE1bDZd0592205922epoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1662532573;
        bh=4rKiVK/6Yt3Vra5nARLFQQ/Jb6sJP/fyfKEUXWR6JbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PprOqZnN2dJ6sMVEc1Td43usXE5FvdyMi95cBeu7WJF7kE7xvzAaBwmnJup5K41C/
         Uj8eDwQVPEdrtTVudHP7RhWajRyc9eO4OYLmdJJ0aQvL7KxwbkC2LDH4irdL4B8gZT
         1fvpedMFUq9hJLmLGOKhBhkR76CPo2EHcYYT2PI8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220907063612epcas5p222bde16ed3bca83cd759d384bdaf6aad~SgJD6dXXT3085930859epcas5p2q;
        Wed,  7 Sep 2022 06:36:12 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4MMsw90lbHz4x9Q2; Wed,  7 Sep
        2022 06:36:09 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        97.80.54060.4DB38136; Wed,  7 Sep 2022 15:36:04 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220907063332epcas5p2d3c4258885b17c6765658702d833a782~SgGueEPZr0898708987epcas5p2R;
        Wed,  7 Sep 2022 06:33:32 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220907063332epsmtrp13cf8a7b0e65db68ae99df0f0b42daac6~SgGubtvgI0507305073epsmtrp13;
        Wed,  7 Sep 2022 06:33:32 +0000 (GMT)
X-AuditID: b6c32a4b-be1ff7000000d32c-b5-63183bd4d5ee
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F2.DC.14392.B3B38136; Wed,  7 Sep 2022 15:33:31 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.109.115.6]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220907063328epsmtip19963bb3f35ef783ebbe8ec25fc279b91~SgGqtqlg32625726257epsmtip1w;
        Wed,  7 Sep 2022 06:33:27 +0000 (GMT)
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
Subject: [Patch v2 05/15] Documention: v4l: Documentation for VP9 CIDs.
Date:   Wed,  7 Sep 2022 12:17:05 +0530
Message-Id: <20220907064715.55778-6-smitha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220907064715.55778-1-smitha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VTe0xTVxj33Hv7ZLA7hHnonDZdZIEJtErrgcFG5usKTnE+lswMrOWmEPpa
        HwxcFnkHGl5uNQsglADbHKJjPCugvGpAZ4h1jP4xikxkiAJTHkZwkfWB23+/7/s9vpzvnMPG
        fSeYPHaKSk9rVVKFgMkl2geC3g0ZeR/KhLM1fDRlKWegiep2Jqp7Po2he3WLBOpvaWOh1pFK
        HP042MtAZuswA3X03SfQLw+drK3cQaBp8xWAZirGmah5cpSB/nz0Kfqt8wITFTW1MdBlq4OF
        vrfbMPRD8z8Yqm1bYqG8a1YWcnS3A5Sbb8ViINVY3Qgoi6MeUPb6BZy6WuFgUXXdMxjV3FDI
        pMZGu5lUS/1ZKu/GKkGVtDYA6mV2FYsyWu1MarF5C3VreZEV7/NZalQyLU2itXxaJVMnpajk
        0YK4o4m7E8USoShEFIF2CfgqqZKOFuw5GB+yL0XhXIOAnyZVGJyteKlOJwj7IEqrNuhpfrJa
        p48W0JokhSZcE6qTKnUGlTxUResjRULhDrFTeCo12TrfxNKMh6XbV/IZmaAr0AjYbEiGw+LW
        VCPgsn3JLgDXyky4p1gA0Fg6ADzFMwBN9T1MI+C4HUsl5nXiGoD5S7WYp8jBYEF+Ie5SMcnt
        8Nnfv7odfmQWgJMFepcIJ3MI6Lj9guUiNpL74cqajXBhgtwGx81/ubE3GQG78oZZnnFb4aWm
        Xncoh4yENtMQwxUEyRwONGVdZnlOsQcOD/l69Bvho8HWdS8PzpTmr2M5vLeYAzxYA6syWzEP
        /hD2jlwgXDE4GQR/7gzztN+G529dcUtw0gcWv3iwLveGlupXWABrbw+tx0P4+1wbw4MpOPdg
        jeFZSjGA9uFSvAxsqfh/RA0ADSCA1uiUclon1uxU0V/+d2sytbIZuJ96cJwF3J94EtoPMDbo
        B5CNC/y8kyx+Ml/vJGnGGVqrTtQaFLSuH4id+zuH8/xlaudfUekTReERwnCJRBIesVMiEmzy
        Nr0HZL6kXKqnU2laQ2tf+TA2h5eJ3Rl4SJQUX7QpiZiYnrqLQYdfEqubSyIDjdzHkYf2Xd10
        YE779KhqdkRy8IsdU7Gf1HzMiUoYvVl5Mjf9iHX3vIo+Uf7tEzChIHjHzlVO8DefLf/uyPWt
        84w7aSbEPbXtqxX55/vnxZb0jrwbfTcvTa0Zg5fjMFFsz2tTsm9mg7OlaZHcjONj5oTj0529
        /I+yW1LWxDb5lsG2vlX/4bGiwUNe1cJJR8CJuLLFky01Cz/lGje8WdWh5JSdTghU+SwPdgxk
        /hHhtWHGcOb6+N7tz+1vTReZ8xq55wsXRuLfeLxLknVY3IDlnjb487ItBV/Pjt99PSDjwN1a
        r/qed3KexloHjvkICF2yVBSMa3XSfwF0Enh4cwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRbUxSYRSAey+XewGHuyLma5o1+nC51NxS38q1zD5u60etcs1qM9KbOQUN
        tK+ZWZMamNasVWpJE9IJ6AzFTLGUaKUtF+VkVmhWatJKTS0zZoXWv+fsec7Oj8NhCW7gCzgp
        0kxGJhWniQge3vBIFBgSvQ4mrtLsQwONxWz0rqyBQJqpIQz1acZxZKkzkai+q5SFKp+0spHa
        2slG99re4+jup7/WVuzA0ZC6BqDhkl4CGT90s1G/cy961XSTQBdrTWxUbXWQ6I7dhqEKowtD
        5aYJEilarCRymBsAyjtvxTZA2lBmAHSjQwtou/Ybi75f4iBpjXkYo406JUG/7TYTdJ32DK14
        PI3ThfU6QM+cu0XSKqudoMeNgXTH5Di503MfLzqJSUs5xsjC1h/kHbF+rSUzesNO2H+eZ+eC
        5uUqwOVAajWcKFQDFeBxBFQzgM+7teScgLDqVxGYY29YNTNEzkVnMThjmIsIaiX8PvKMcAsh
        pQDQXqXE3AOLKsXhVFEr2115U1vhz9823M04tQz2qgdnmU+tgc2Kzn/nFkF9bSvLzVxqLbRd
        fTq7K/jbfLjRQF4GnrfBPB3wYzLkkmSJPDwjXMocD5WLJfIsaXJoYrrECGafF7yiEdzTjYZa
        AMYBFgA5LJGQn9QoTBTwk8QnTzGy9ARZVhojtwB/Di7y5b9QtScIqGRxJpPKMBmM7L/FONwF
        uVhM9Y7ovF/fH0TZI7009VkuNfvg1/Iml2fEGKGdfD71ObLaYB6Nu7UlZ3jMN39EudERVdB5
        pbekcklO5SUv58e01gsT7dE9OkMoV7/5x8fFXbGbfKIoD2nT0vIly7dVfJaYs+O2H/dwZhfH
        n5imkiY2jmbra0T3r/lqCg48KBpw6ge1fSZZQEzuxWMxD9XqDbHh5QXTJvtL29sDyzLb4oK6
        T4s6vAekQuXvH/Y3+btcQf0eTt5In5K6nq+wzJuvEqrXFLbs3FMGfHriDg36oy+TIIqvvOvh
        8tE/TLEcjcjBDoed3d1fm+9nToCfXscvtL4J0KbOnNwfWRHSHuMTYhTh8iPi8GCWTC7+A0Ed
        5wErAwAA
X-CMS-MailID: 20220907063332epcas5p2d3c4258885b17c6765658702d833a782
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220907063332epcas5p2d3c4258885b17c6765658702d833a782
References: <20220907064715.55778-1-smitha.t@samsung.com>
        <CGME20220907063332epcas5p2d3c4258885b17c6765658702d833a782@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 2a165ae063fb..2277d83a7cf0 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
@@ -2187,6 +2187,16 @@ enum v4l2_mpeg_video_vp8_profile -
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
@@ -2253,6 +2263,163 @@ enum v4l2_mpeg_video_vp9_level -
     * - ``V4L2_MPEG_VIDEO_VP9_LEVEL_6_2``
       - Level 6.2
 
+``V4L2_CID_CODEC_VP9_I_FRAME_QP``
+    Quantization parameter for an I frame for VP9. Valid range: from 1 to 255.
+
+``V4L2_CID_CODEC_VP9_P_FRAME_QP``
+    Quantization parameter for an P frame for VP9. Valid range: from 1 to 255.
+
+``V4L2_CID_CODEC_VP9_MAX_QP``
+    Maximum quantization parameter for VP9. Valid range: from 1 to 255.
+    Recommended range for MFC is from 230 to 255.
+
+``V4L2_CID_CODEC_VP9_MIN_QP``
+    Minimum quantization parameter for VP9. Valid range: from 1 to 255.
+    Recommended range for MFC is from 1 to 24.
+
+``V4L2_CID_CODEC_VP9_RC_FRAME_RATE``
+    Indicates the number of evenly spaced subintervals, called ticks, within
+    one second. This is a 16 bit unsigned integer and has a maximum value up to
+    0xffff and a minimum value of 1.
+
+``V4L2_CID_CODEC_VP9_GF_REFRESH_PERIOD``
+    Indicates the refresh period of the golden frame for VP9 encoder.
+
+.. _v4l2-vp9-golden-frame-sel:
+
+``V4L2_CID_CODEC_VP9_GOLDEN_FRAMESEL``
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
+    * - ``V4L2_CID_CODEC_VP9_GOLDEN_FRAME_USE_PREV``
+      - Use the (n-2)th frame as a golden frame, current frame index being
+        'n'.
+    * - ``V4L2_CID_CODEC_VP9_GOLDEN_FRAME_USE_REF_PERIOD``
+      - Use the previous specific frame indicated by
+        ``V4L2_CID_CODEC_VP9_GF_REFRESH_PERIOD`` as a
+        golden frame.
+
+.. raw:: latex
+
+    \normalsize
+
+
+``V4L2_CID_CODEC_VP9_HIERARCHY_QP_ENABLE``
+    Allows host to specify the quantization parameter values for each
+    temporal layer through HIERARCHICAL_QP_LAYER. This is valid only
+    if HIERARCHICAL_CODING_LAYER is greater than 1. Setting the control
+    value to 1 enables setting of the QP values for the layers.
+
+.. _v4l2-vp9-ref-number-of-pframes:
+
+``V4L2_CID_CODEC_VP9_REF_NUMBER_FOR_PFRAMES``
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
+    * - ``V4L2_CID_CODEC_VP9_1_REF_PFRAME``
+      - Indicates one reference frame, last encoded frame will be searched.
+    * - ``V4L2_CID_CODEC_VP9_GOLDEN_FRAME_USE_REF_PERIOD``
+      - Indicates 2 reference frames, last encoded frame and golden frame
+        will be searched.
+
+.. raw:: latex
+
+    \normalsize
+
+
+``V4L2_CID_CODEC_VP9_HIERARCHICAL_CODING_LAYER``
+    Indicates the number of hierarchial coding layer.
+    In normal encoding (non-hierarchial coding), it should be zero.
+    VP9 has upto 3 layer of encoder.
+
+``V4L2_CID_CODEC_VP9_HIERARCHY_RC_ENABLE``
+    Indicates enabling of bit rate for hierarchical coding layers VP9 encoder.
+
+``V4L2_CID_CODEC_VP9_HIER_CODING_L0_BR``
+    Indicates bit rate for hierarchical coding layer 0 for VP9 encoder.
+
+``V4L2_CID_CODEC_VP9_HIER_CODING_L1_BR``
+    Indicates bit rate for hierarchical coding layer 1 for VP9 encoder.
+
+``V4L2_CID_CODEC_VP9_HIER_CODING_L2_BR``
+    Indicates bit rate for hierarchical coding layer 2 for VP9 encoder.
+
+``V4L2_CID_CODEC_VP9_HIER_CODING_L0_QP``
+    Indicates quantization parameter for hierarchical coding layer 0.
+    Valid range: [V4L2_CID_CODEC_VP9_MIN_QP,
+    V4L2_CID_CODEC_VP9_MAX_QP].
+
+``V4L2_CID_CODEC_VP9_HIER_CODING_L1_QP``
+    Indicates quantization parameter for hierarchical coding layer 1.
+    Valid range: [V4L2_CID_CODEC_VP9_MIN_QP,
+    V4L2_CID_CODEC_VP9_MAX_QP].
+
+``V4L2_CID_CODEC_VP9_HIER_CODING_L2_QP``
+    Indicates quantization parameter for hierarchical coding layer 2.
+    Valid range: [V4L2_CID_CODEC_VP9_MIN_QP,
+    V4L2_CID_CODEC_VP9_MAX_QP].
+
+.. _v4l2-vp9-max-partition-depth:
+
+``V4L2_CID_CODEC_VP9_MAX_PARTITION_DEPTH``
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
+    * - ``V4L2_CID_CODEC_VP9_0_PARTITION``
+      - No coding unit partition depth.
+    * - ``V4L2_CID_CODEC_VP9_1_PARTITION``
+      - Allows one coding unit partition depth.
+
+.. raw:: latex
+
+    \normalsize
+
+
+``V4L2_CID_CODEC_VP9_DISABLE_INTRA_PU_SPLIT``
+    Zero indicates enable intra NxN PU split.
+    One indicates disable intra NxN PU split.
+
+``V4L2_CID_CODEC_VP9_DISABLE_IVF_HEADER``
+    Indicates IVF header generation. Zero indicates enable IVF format.
+    One indicates disable IVF format.
+
 
 High Efficiency Video Coding (HEVC/H.265) Control Reference
 ===========================================================
-- 
2.17.1


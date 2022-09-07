Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9FB5AFCA2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiIGGis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiIGGih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:38:37 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FF4A060B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 23:38:21 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220907063735epoutp04aaba190249715b8cf8bb396fb1ad3a3a~SgKQvE0Qw1257012570epoutp04z
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 06:37:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220907063735epoutp04aaba190249715b8cf8bb396fb1ad3a3a~SgKQvE0Qw1257012570epoutp04z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1662532655;
        bh=NYNVtJwc1Bayn3z6Bj59yHz3KYKrbxjKso4iH8BQb5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lqLcirbhFEquNIK+q3lbAskV6WxnvYDecF+Smpsc9EzoW4qWN3I8tLfV351bDwIRA
         Ym2pHwyp+zpy4fCROlIY/8xlA/z/7BHT5aihShIxLCtIQmNHMBXos5AyeLGc7/ccLF
         NlMUD+fatCsBuAKnrBnJZhO7A9CXv05wbmmRcuEw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220907063734epcas5p139b3c01b09bac81b772a2c1ab1ce3d57~SgKQSHV6f0397303973epcas5p1m;
        Wed,  7 Sep 2022 06:37:34 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4MMsxk2xqGz4x9QH; Wed,  7 Sep
        2022 06:37:30 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B1.C3.53458.A2C38136; Wed,  7 Sep 2022 15:37:30 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220907063408epcas5p4285be9e4db0a64b396da8d66fb5ab2ad~SgHQfRqqt1751017510epcas5p4L;
        Wed,  7 Sep 2022 06:34:08 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220907063408epsmtrp28cf0b96460fe58e409622c9fa2d557cc~SgHQeODVf1916619166epsmtrp2f;
        Wed,  7 Sep 2022 06:34:08 +0000 (GMT)
X-AuditID: b6c32a4a-caffb7000000d0d2-22-63183c2a0fed
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5B.EC.14392.06B38136; Wed,  7 Sep 2022 15:34:08 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.109.115.6]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220907063404epsmtip1dcc688070decc938cb39160a4d9b2d27~SgHM7t-R12432724327epsmtip1h;
        Wed,  7 Sep 2022 06:34:04 +0000 (GMT)
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
Subject: [Patch v2 14/15] media: s5p-mfc: DPB Count Independent of
 VIDIOC_REQBUF
Date:   Wed,  7 Sep 2022 12:17:14 +0530
Message-Id: <20220907064715.55778-15-smitha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220907064715.55778-1-smitha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0xTVxzHOffe3haTspsWs7PGMtJMFzqBFku5GNicArmDLSMasoVMS1Pu
        CkIfactDZzImc9mqMDSgA6VugDM8itKXCNTxKNPx2MZWZBlUcE5RCG4DcQ4YW9uL23/f/L6f
        3+P8zjkclDeFCzj5WhNt0CoLRfgmzDUQJY4WJ0GVpM/HJ+921rLIGYsLJxufzCLkdOMSRvbb
        nWzS4T2Lkhev97LI855vWeSVvl8wsuO+3x2r9WHk7Pl2QD6ou4WTtjs3WeTtubfIH7vO4eSJ
        y04WafX42OSFiTGE/NK2hpANzkds8pjbwyZ9PS5AfviRB9kFqTZLG6A6fU2AmmhaRKmrdT42
        1djzAKFsLZ/g1NTNHpyyN71PHRtcwahKRwug1o/WsymzZwKnlmwR1NDyEjszLLsgKY9W5tKG
        SFqr0uXma9XJoox9ij2KeLlEGi1NJBNEkVqlhk4WpbyeGZ2WX+hfgyiyWFlY5A9lKo1GUezL
        SQZdkYmOzNMZTckiWp9bqJfpY4xKjbFIq47R0qadUokkLt4P5hTk/T1rRvVnhaWTVS5QBs5A
        MwjlQEIGbfMO1Aw2cXhEN4B95tNYwOARiwDOH1czxmMAL0ya/QYnmOFYBAzjBtBZm8Iw5Qj0
        dczgAQMntsPHvw0HdTjxAYB3PjYFIJQox6BvZJUdMPjEXthlb0YDGiO2wuWfh4IJXGInrFqu
        R5jxnoetl3uDTKg/PlZ9gxUoBInyUDj6WS3CTJQC3Z9KGJ4P56472IwWwKWHbpzRaji9VA4Y
        rYf1ZY6N+q/AXu+54MFQIgpe6oplwkJYM9QeRFAiDFas/rqBc2Gn5akWwYaRGxutIBxfcLKY
        aSjYPZXC7KcCwPGG16pARN3/DT4HoAU8R+uNGjVtjNfHaemS/25MpdPYQPCZi9M7we2Z32P6
        AcIB/QByUFE4N7czXMXj5ioPHaYNOoWhqJA29oN4//ZOooLNKp3/n2hNCqksUSKTy+WyxB1y
        qehZbvVLQMUj1EoTXUDTetrwNA/hhArKkOS9g6lCzR8Xz0RYdnOt3+xLGhZQ328WDnDRmC/W
        Ln1nYb34xkJLbxaKCXyoorrk67WD1sEZPN26ezLW4hko4OwSyluzeKeA6wXr3bSS9JytxvWj
        Zug2lP4Dck7IxJWjD8P2UPyVV1ffPjA60N7eJOx754l3/6PiGP2Vv6qjpvDu90KvteVve/Pg
        NWzlq/n15EoNO2Nkfb7Ge/i+Y8GOtvLHFGFbopqNw3GIabs54cC7FWvOUrsjFd2Wah0ZKN7x
        jHRRXPznkazs7MHpU95pt5XDz9gy11V2K8ExM3+14V6zi+sV2ce5P8VhP1TVaRQhNfdOFvE6
        QsqPdO0/HpJ2SIQZ85RSMWowKv8FwHEanW8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTYRjHe8/OzjmbLE5T6S1JbaSlpGVYvea6EEEn6oNIZFihUw9z3hqb
        VmqkmSs2QkSim1mmy7zG2tzUWqZzqSlakjjUZqXIusFSs5s2c0rffs/z/z38PzwUR3gdX0vJ
        MjJZRYYkTUTwcVOHyDckPhImbm2tXI8mm29x0fu7JgJV/nJg6F3lDI4sBiOJGgdLOehhVxsX
        3bP2c1FT+ziOHn9cTAdu2XHkuPcIoE+3xwiknxjiog+fY9CbJ3cIdFVn5KIGq51ED2wDGKrS
        z2OowvidRKpnVhLZzSaACi9bsX2Qqb9bD5hmuxYwNu00h2m5bSeZSvMnjNHXqgnm7ZCZYAza
        PEb14g/OFDXWAsZVUEYyGquNYGb0vkzP7AwZtTKWL05i02RnWMWWPfH85L8ODUdeuu7caLEJ
        5IMbUAMoCtLhsHEaaACPEtJPAfzRkOpmSENYM1cCltkT1rgc5LJzEYNtFsLNBL0Z/nD2LjKf
        8qJVANpq1Jh74NClOPxV0sZ1W550FBz/UsVxM04HwNmRnqVrAb0LFs+WYcsNfrBO17bk8Bb3
        A9e6ucttEXDipoksBivLwYpasIaVK9Ol6coweVgGezZUKUlXZmVIQxNPp+vB0uuCg5pBU+23
        UAvAKGABkOKIvARJzV6JQkGSJDuHVZyOU2SlsUoL8KFw0WrBa83LOCEtlWSyqSwrZxX/U4zi
        rc3H2J+5AVKR5hI3JFDWpEs5POWZL0z0l2cXh6o8arbyc9RjV7aIpdNBwQcSfu9jK8RYtybu
        ZLXNc/T+Nb9OQxJw5qzob9He8X7q8pLPCWVd+1/46bb7OA0zsjy/E53ykfOWHdnJ8b67va8m
        qHwdhDmAxwyXuTqOdbdsqDKMPPTvVV93jW97NfpgZ55p5znv50d0qwv6yqODdfULkF/H0x8k
        omGMsr3DvDHWeGg4odyZGzn/59ScYFOJUVJe6L9QPdgXHjsXgS5HH3dKwK7hveJArZCPC1TU
        z1efx756P/4dMKVuPTO5tzXHI6soKPBo1VdZYdCFFJFInFBkiVglwpXJkrBgjkIp+Qe3jd5p
        KQMAAA==
X-CMS-MailID: 20220907063408epcas5p4285be9e4db0a64b396da8d66fb5ab2ad
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220907063408epcas5p4285be9e4db0a64b396da8d66fb5ab2ad
References: <20220907064715.55778-1-smitha.t@samsung.com>
        <CGME20220907063408epcas5p4285be9e4db0a64b396da8d66fb5ab2ad@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows allocation of DPB buffers based on MFC requirement
so codec buffers allocations has been moved after state
MFCINST_HEAD_PRODUCED. It is taken care that codec buffer allocation
is performed in process context from userspace IOCTL call.

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
---
 .../platform/samsung/s5p-mfc/s5p_mfc_enc.c      | 17 ++---------------
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c   |  9 ++++++++-
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
index 404bce3641b9..9fdce20b69e2 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
@@ -1339,7 +1339,6 @@ static int enc_post_seq_start(struct s5p_mfc_ctx *ctx)
 	struct s5p_mfc_dev *dev = ctx->dev;
 	struct s5p_mfc_enc_params *p = &ctx->enc_params;
 	struct s5p_mfc_buf *dst_mb;
-	unsigned int enc_pb_count;
 
 	if (p->seq_hdr_mode == V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE) {
 		if (!list_empty(&ctx->dst_queue)) {
@@ -1361,10 +1360,8 @@ static int enc_post_seq_start(struct s5p_mfc_ctx *ctx)
 			set_work_bit_irqsave(ctx);
 		s5p_mfc_hw_call(dev->mfc_ops, try_run, dev);
 	} else {
-		enc_pb_count = s5p_mfc_hw_call(dev->mfc_ops,
+		ctx->pb_count = s5p_mfc_hw_call(dev->mfc_ops,
 				get_enc_dpb_count, dev);
-		if (ctx->pb_count < enc_pb_count)
-			ctx->pb_count = enc_pb_count;
 		if (FW_HAS_E_MIN_SCRATCH_BUF(dev)) {
 			ctx->scratch_buf_size = s5p_mfc_hw_call(dev->mfc_ops,
 					get_e_min_scratch_buf_size, dev);
@@ -1730,14 +1727,6 @@ static int vidioc_reqbufs(struct file *file, void *priv,
 		}
 		ctx->capture_state = QUEUE_BUFS_REQUESTED;
 
-		ret = s5p_mfc_hw_call(ctx->dev->mfc_ops,
-				alloc_codec_buffers, ctx);
-		if (ret) {
-			mfc_err("Failed to allocate encoding buffers\n");
-			reqbufs->count = 0;
-			ret = vb2_reqbufs(&ctx->vq_dst, reqbufs);
-			return -ENOMEM;
-		}
 	} else if (reqbufs->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
 		if (reqbufs->count == 0) {
 			mfc_debug(2, "Freeing buffers\n");
@@ -1753,15 +1742,13 @@ static int vidioc_reqbufs(struct file *file, void *priv,
 			return -EINVAL;
 		}
 
-		if (IS_MFCV6_PLUS(dev)) {
+		if (IS_MFCV6_PLUS(dev) && (!IS_MFCV12(dev))) {
 			/* Check for min encoder buffers */
 			if (ctx->pb_count &&
 				(reqbufs->count < ctx->pb_count)) {
 				reqbufs->count = ctx->pb_count;
 				mfc_debug(2, "Minimum %d output buffers needed\n",
 						ctx->pb_count);
-			} else {
-				ctx->pb_count = reqbufs->count;
 			}
 		}
 
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
index db06e3387d14..866cf44ef003 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
@@ -379,7 +379,6 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 	default:
 		break;
 	}
-
 	/* Allocate only if memory from bank 1 is necessary */
 	if (ctx->bank1.size > 0) {
 		ret = s5p_mfc_alloc_generic_buf(dev, BANK_L_CTX, &ctx->bank1);
@@ -2257,6 +2256,14 @@ static inline int s5p_mfc_run_init_enc_buffers(struct s5p_mfc_ctx *ctx)
 	struct s5p_mfc_dev *dev = ctx->dev;
 	int ret;
 
+	ret = s5p_mfc_hw_call(ctx->dev->mfc_ops,
+			alloc_codec_buffers, ctx);
+	if (ret) {
+		mfc_err("Failed to allocate encoding buffers\n");
+		return -ENOMEM;
+	}
+	mfc_debug(2, "Allocated Internal Encoding Buffers\n");
+
 	dev->curr_ctx = ctx->num;
 	ret = s5p_mfc_set_enc_ref_buffer_v6(ctx);
 	if (ret) {
-- 
2.17.1


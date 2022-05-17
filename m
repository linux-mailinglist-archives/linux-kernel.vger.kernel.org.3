Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E78352A284
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbiEQNCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346650AbiEQM7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:59:52 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAD04D9F8
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 05:59:04 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220517125902epoutp046395d426f69eb2148cbe4ad07fe2575f~v5eDrrQUh1722717227epoutp04B
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 12:59:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220517125902epoutp046395d426f69eb2148cbe4ad07fe2575f~v5eDrrQUh1722717227epoutp04B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652792342;
        bh=kQwMfewmaeemKkPMLK3QaaIIfudtvDkBerG8dubWFwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pH8Z1OVBOsQ3aQul88Dw8RkMjv3E/pNFjh2wUdMlz34paD3qxyrTs4LF1TGimWlNQ
         Lx+6hPbRriSRpJTS3t+zPDhaOupd5S13eM3ZqhtMTPg5YdhSVJIkQwY28yNNSMW3xj
         4XvnUAsXGX70bG0AmxhkGAsNUUuK1K0bd5Fr5yc4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220517125900epcas5p3f491ff7893a0a70dcdf759ed66c56bd4~v5eCUJ4lE2692026920epcas5p3t;
        Tue, 17 May 2022 12:59:00 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4L2bm13Ztnz4x9Pv; Tue, 17 May
        2022 12:58:57 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4E.3C.09762.11C93826; Tue, 17 May 2022 21:58:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220517125641epcas5p48fc3d48ad5e4a02879a1063da36c0063~v5cAMwLZL1555515555epcas5p4b;
        Tue, 17 May 2022 12:56:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220517125641epsmtrp251c414bcc5fef9d6e67df6055416fa84~v5cALn2yT0912609126epsmtrp2X;
        Tue, 17 May 2022 12:56:41 +0000 (GMT)
X-AuditID: b6c32a4b-1fdff70000002622-29-62839c112f38
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DA.AA.11276.98B93826; Tue, 17 May 2022 21:56:41 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220517125637epsmtip19055417ca0e867abfa564a3ef8f7d459~v5b88Ub941800118001epsmtip1O;
        Tue, 17 May 2022 12:56:37 +0000 (GMT)
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
Subject: [PATCH 15/20] media: s5p-mfc: DPB Count Independent of
 VIDIOC_REQBUF
Date:   Tue, 17 May 2022 18:25:43 +0530
Message-Id: <20220517125548.14746-16-smitha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220517125548.14746-1-smitha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0xTdxTH87ttb29NKtcC4QcRxu42XxFoodQLEbdsuN2FZeJmRsJC6gVu
        WqS0TR/K2DJA6eLI3MCwIG9GERR5lodIwTGo0yDTOYG6xcpDhsIAh52sWRHW0rr99znfc07O
        93d+vx/GEvyKBmEZSh2jUdIKAt3C7hnevStsW+WpVGH+j5Ccqu5BSaPjEUJOGu1scqizm0t2
        jVWwyMbrgxyyxnKLQ17+YYZNdjx2Ze+U2djko5pWQM6XP0BJ08MJDjm9kETe7atEya/auzlk
        i8XGJc9b7yBkg2kNIeu6/+KShgELl7T19wCy4AsL8kYA1VzdDKheWz2grPVPWdSVchuXMvbP
        I5Sp6UuUuj/Rj1Kd9bmU4do/bOrrriZArZ+s4lKFFitK2U0h1MgzOzdxa3LmfjlDpzOaUEaZ
        pkrPUMriiIQPpW9JoyVCUZgohtxHhCrpLCaOiH8vMeztDIVrA0TocVqhd0mJtFZLRBzYr1Hp
        dUyoXKXVxRGMOl2hFqvDtXSWVq+UhSsZXaxIKIyMdhUezZRbzy2y1d8FZzsq7Nw8UA4LAYZB
        XAz/uPlZIdiCCXAzgNU/V7I9wVMA11Y6OJ5gFcDis0PcQsDb7CgunUA9iQEAzUXLiCcoQOCU
        8xlwV6H4Xrj65CbqZj88H8CHp3VuZuFOFiwbC3GzL34I3m19znIzG38Ndsw7WG5PfDwWOkqC
        PcNegpfaBzdlnkuuWk9xj4L4BgZXlhe9huLh1Ogwx8O+cOF6l1cPgvblAdTDMjhpPwU8rIZV
        eV2Ih1+Hg2PuI2Mua7thW1+ERw6G3460Ih7HW+EZ56y3nA97q18wAetGb3hHQTi+1O21QEHD
        hefexZ0BcN1gZRWBkPL/R9QC0AQCGbU2S8Zoo9VRSubEf3eWpsoygc03viehF8xM/Rk+BBAM
        DAGIsQg/vjA7L1XAT6c/yWE0KqlGr2C0QyDatb5iVpB/msr1SZQ6qUgcIxRLJBJxTJRERATw
        8Y38VAEuo3VMJsOoGc2LPgTjBeUhu34p//xAcPyxE+eHz0YY34xQFYHaiXfG+0Lwo6uTmYEt
        H22bDT/tH8hjLxhyP2i+2D6zvdoasFGiWZ/LoK/4pDQOhjgjpZ1HHMkFNj/LwbmfTj7Oaz50
        byX9d8U+wuhjfOBoqFvaYS6le9rKtgUcnm283dx7cMV4/5v1hltTFeYaS1TKmnna/zac97UM
        bz/ewx/k30uX5+j9pWA0crkrnpe7s/Rqwct7Lxrk+qTfMmjJok+2g3fu3b8nB8TY1cs3/A4n
        vfJpwhNnbss1/++PXbiE1sbkvNqvMc9NCJLjSvmCoB2ykeIl3k5TwxFHW8m0clzkRyCRmfrV
        cPv72MftzliCrZXToj0sjZb+F9kUn29sBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRaUwTURSFfTPTmaGROikuT41LatCIUmlCzFPRaHB5khhNDGJMtBaYApFC
        aUVRE0URTOu+JGIBF1o01AWsUJBFBasICrGK1IXiyia4xEppQIsU4r/vni/n/LksKT5JTWET
        knbymiRFooQWUtaHkunBupyM6JDvtwTow0UrjYyeTgK9N7ooVHunlEElzTkkulb3QIAu2ZoE
        qKzmE4Vudw1b+wUnhTov3QKo29BGI8vnFgH6+DUKvazIpdGx4lIBumlzMqjAYSfQVcsfAuWX
        /mZQZrWNQc4qK0CHs2zE8kn4xsUbAJc7TQA7TL9IfNfgZLCxqpvAFrOOxq0tVTS+YzqAMx8N
        UPhEiRlg76E8ButtDhq7LNNxQ5+L2SDaIgyL5RMTdvGaBcu2C+Md2b2U+sq0NE+Oi0kHBqgH
        fizkQuHp8y20HghZMVcJYFl+AzkqICwcPANGOQAWejsZH4u5QwS86VX6mObmQ/ePpyPl8Vwm
        gI5CHeE7SO40Bc85BoaXWDaAWwfNxiW+AsUFwtvdnpHYn1sMPeemje7PgNeLH4zEfsNxnner
        D8XcIth+H50CostgjBlM5tVaVZxKK1PLkvjdUq1CpU1NipPGJKssYORnQXPLQZn5p7QWECyo
        BZAlJeP9Q9LSo8X+sYo9e3lNslyTmshra8FUlpJM8n+ur5eLuTjFTn4Hz6t5zX9LsH5T0gly
        0CnCb8tjnM0Hctf/Tq3cnRClW9hhJpfGxAeuyHg2UxIhqnSH5RYJsmq8Bx3qscWz13R8WaEO
        vx65uTHjYcXCeRxTnWq1K1v7pV/rWl0tYQrZ6y5pm8FdPyu/6GzPUF+PNapjbbVssvRj/8RV
        Rz55XhVGF9BzHjW5PX/TUqJXvzO9y66W992L3JcDa4p6w7mUvPVK9zFp0IcdvLzHXmF6vOdp
        b8A3dVvzG/k+A6AbnoQK2leBevQTF1xQRigJoZHWBG7EW18MZasOLy3mjreKNj9puBtZUJLw
        ckC/pGmBfX9nRN7ajK7+bcbH4zrm1E3AuqOKuJXNjZtC/gS3SyhtvEIWRGq0in9xiP7qIgMA
        AA==
X-CMS-MailID: 20220517125641epcas5p48fc3d48ad5e4a02879a1063da36c0063
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220517125641epcas5p48fc3d48ad5e4a02879a1063da36c0063
References: <20220517125548.14746-1-smitha.t@samsung.com>
        <CGME20220517125641epcas5p48fc3d48ad5e4a02879a1063da36c0063@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows allocation of DPB buffers based
on MFC requirement so codec buffers allocations
has been moved after state MFCINST_HEAD_PRODUCED.
And it is taken care that codec buffer allocation
is performed in process context from userspace IOCTL
call.

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
---
 .../platform/samsung/s5p-mfc/s5p_mfc_enc.c      | 17 ++---------------
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c   |  9 ++++++++-
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
index 57b4397f2b03..95e18f1cabb0 100644
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
@@ -1729,14 +1726,6 @@ static int vidioc_reqbufs(struct file *file, void *priv,
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
@@ -1752,15 +1741,13 @@ static int vidioc_reqbufs(struct file *file, void *priv,
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
index 2b6d6259a209..44058827eaa3 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
@@ -388,7 +388,6 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 	default:
 		break;
 	}
-
 	/* Allocate only if memory from bank 1 is necessary */
 	if (ctx->bank1.size > 0) {
 		ret = s5p_mfc_alloc_generic_buf(dev, BANK_L_CTX, &ctx->bank1);
@@ -2266,6 +2265,14 @@ static inline int s5p_mfc_run_init_enc_buffers(struct s5p_mfc_ctx *ctx)
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


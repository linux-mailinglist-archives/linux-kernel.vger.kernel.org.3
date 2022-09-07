Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFC25AFC9B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiIGGi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiIGGiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:38:24 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A007583061
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 23:38:09 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220907063713epoutp026d7727e89831570b0a439c807403553a~SgJ8bABWH0842308423epoutp02B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 06:37:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220907063713epoutp026d7727e89831570b0a439c807403553a~SgJ8bABWH0842308423epoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1662532633;
        bh=nTNsBJA3qb8qF+JtemjCjYRUKpNMm73/rXh7jxwbqjc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YNiKrCUiUKUUpiA3IOybWCwZJswNKLT0z0ge0HgIQqQuqbCfncqUJg7DRUfI+IDAi
         iqOoJejJF4EO/cvaaI0EOH7HY6LjegrcEMEZr7tpRleIeBJohEvc2SE8osumMSKMC+
         tAcPS8ZcrBPJMDyemrf4htpaIortUb7Jy3yA1Op8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220907063712epcas5p44b7646fb97979cbe51084cb64d2be298~SgJ7utnn12954329543epcas5p4u;
        Wed,  7 Sep 2022 06:37:12 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4MMsxF1gYcz4x9QH; Wed,  7 Sep
        2022 06:37:05 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        36.93.53458.01C38136; Wed,  7 Sep 2022 15:37:05 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220907063355epcas5p4738968135cdc376beb4a8c621131e2f1~SgHEm0avT0161801618epcas5p4G;
        Wed,  7 Sep 2022 06:33:55 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220907063355epsmtrp2aa9a532f7eafdb0e8733a340d424449e~SgHElu0Mm1916619166epsmtrp2N;
        Wed,  7 Sep 2022 06:33:55 +0000 (GMT)
X-AuditID: b6c32a4a-caffb7000000d0d2-a9-63183c1055a4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        91.EC.14392.35B38136; Wed,  7 Sep 2022 15:33:55 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.109.115.6]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220907063352epsmtip10ceff6624ed0d28849c7b02bf8fa426c~SgHBQQTHf2639226392epsmtip1p;
        Wed,  7 Sep 2022 06:33:52 +0000 (GMT)
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
Subject: [Patch v2 11/15] media: s5p-mfc: Add support for DMABUF for encoder
Date:   Wed,  7 Sep 2022 12:17:11 +0530
Message-Id: <20220907064715.55778-12-smitha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220907064715.55778-1-smitha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0xTZxjG95225xSzuiOw+a067M4mkTuFUg8EmAsEzxzJqmwzboHurD1r
        GdA2vSgsWUQY6piICjjt5CIwl2FBKJeV66BUBUQzosBcrAhYQZIJoRsjw116we2/3/O+z5sn
        eb5zuCzfKZTPzVTpGa2KzibQDeyOwaCgsE3xUBb5i450WM5zyAdVHShZtzqHkFN1TjZpbW3H
        yLY737DI7673c8hq2y0O+cPADJtsmXdtx87b2eRcdRMgHxvvo6R5doJDTi/sJ293XUDJE83t
        HLLRZsfIbyfHEPKS+SlC1rb/hpFFvTaMtPd0APKLozZkF6RMVSZAWez1gJqsX2ZRnUY7RtX1
        PEYoc8OXKHVvogelWusPU0VX/2RTJ9saAPV3QSVGFdsmUcppDqBGfndiko0fZMUrGVrOaAWM
        SqaWZ6oUCcTbadIkaYw4UhgmjCV3EgIVncMkEMmpkrCUzGxXC4TgIJ1tcI0ktE5HRCTGa9UG
        PSNQqnX6BILRyLM1Ik24js7RGVSKcBWjjxNGRkbFuIwfZSn7Zm9imp9gbnNXej4o9y8GXC7E
        RXBmaUcx2MD1xbsBHB9eRbxiGcBjxU1sr1gBcPBRnUv4eC5WL/6DeRe9AJZda+F4RSECe+7l
        I24XiofClcUbqJv98SMAzh7Xu00svJAN7aNrmHvhh6fCtZ+nWG5m49uho97iOeDhcdBU3svy
        xm2Dl5v7Pezjmo+VD3nSIF7oA/8amF03JcPbFTbEy35w4Xob5mU+dD7pRb2sgFPOQuBlDazM
        b1v3vwH771xgu9tg4UHwSleEd/wKrBhp8lhY+EZYsvZw3c6DlqpnTMDa0aH1KAjHf23neJmC
        q53V60WWANg7uMY6BQKM/0fUANAAXmY0uhwFo4vRRKmYQ/+9mkydYwaeLz14jwVMP1gKtwKE
        C6wAclmEP09u8Zf58uR03meMVi3VGrIZnRXEuAo8zeK/KFO7fhWVXioUxUaKxGKxKDZaLCQ2
        88pDgMwXV9B6JothNIz22R3C9eHnI28thmUS19RPF5ICS8KiR4LTL0kHFFd+7DZcjgs9WMPO
        OM2UpWcZ9zw0towlfVVUHuDnH/3IGCvuHErD5tH2J6s79+bRmwKPd7x3oPXE+2VvTpr5IXgP
        /fzw3U+7hw1bEgtCTnIO5a2EfzzCvHbsQ24xP4s2mETLRyu43yePzpwJ3GxSHN0ekepo9OUv
        zX2yY9fXDRmHPz8rCUzZ/dzrDutErbW1UEbdHRcotwlSak4VSJWDN97pLZW+UPZq8829Qc2V
        8prpdw9IjtwXcFodGeGZLYrci/g5Semt5TO8+dJEUcui00fcaWpc2Np1bsu+3P2Cs322fX1d
        UQOOqy/9sTVUtZRGsHVKWhjM0urofwEVtHtfcgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTYRjHe885O2cuJocp9GZluLIynDqReCspi8pDFxALpKB0bge13Fyb
        3Yk0UtKsTIak5bzNclNzTjenzbA16W5Z1gpaW1ktg8hylabdpvXt9zy//5/nw8PFBeeJEG6W
        IpdVKSTZQpJHWG4IQ0VbV0JpjFMfjd5aKzjIo7WQqH7MiyF3/SiB7O1mCnUMXsDR5Zu9HFTt
        6OegzuuvCdT2/q8dqHARyFt9BaDhypckMg095aBXH1LQ4+6LJCoxmjmoxeGiUINzAEOXTJMY
        qjP7KFTQ46CQy2YB6EShA0uATLO2GTBWlw4wTt0XnOmqdFFMvW0YY0yGIpJ58dRGMu26Y0xB
        3w+COdNhAMyv41UUU+xwksyoKZS583WUSgrcwYuXsdlZ+1lV9Ko0Xua1ofuU8iE8aOzemQc0
        wcUggAvpODhW+5sqBjyugL4K4MfBWmxaQKifKAPTHAT1v7z/QvkYNA6eIf2CpCPht093Sb8I
        pgsAdOqLMP+A0xcIOFbWy/GngujNcOKZG/czQYfDtzrrVJtPr4DNmh58+sR82GTsneKAv/sB
        za2proBeDofOW6hSEFgDZhjAbFaplmfI1WKlWMEeiFJL5Op9iowoaY7cBKaetzTCCjoNI1F2
        gHGBHUAuLgzmy6zBUgFfJjl0mFXlpKr2ZbNqO5jDJYSz+A+Lb6cK6AxJLruHZZWs6r/FuAEh
        eVi1cm1AYcNJOsl3KvaIt0J2VpNWHtf5M6enzzF+LqX0qjvB44yuWVyjEI3kTAYWJWZq2zKv
        dc50t+1cGxZzqS+jasEyc6LGvmRueu33PWJ9ZKtp1DNWc0zKK+MYLnt081rORXwMSVoUKhDH
        K4fNuG0Jf8097eCGiVQqPjWxdEtWAr9S9qGksd1NF2S9S29tuVnxu/d5OMc7krxR/oRYx2zL
        ja2btJR3ib6uLqwyVYbCeJHvs3I4KH91/4PEQ48mPLRpd2P+LpjgS8ZKhmYcXW98/wY7sqIJ
        rSP7y8I2hQ3E2ESx9JfWvPL9Wh+6dVrqGH+2oGlhyfaI/PG4vXVWIaHOlIiX4iq15A8EcOph
        KwMAAA==
X-CMS-MailID: 20220907063355epcas5p4738968135cdc376beb4a8c621131e2f1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220907063355epcas5p4738968135cdc376beb4a8c621131e2f1
References: <20220907064715.55778-1-smitha.t@samsung.com>
        <CGME20220907063355epcas5p4738968135cdc376beb4a8c621131e2f1@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dmabuf support for mfc encoder

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
---
 .../media/platform/samsung/s5p-mfc/s5p_mfc.c  |  4 ++--
 .../platform/samsung/s5p-mfc/s5p_mfc_enc.c    | 21 +++++++++++--------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
index c483a95d5e92..2987f8984553 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
@@ -850,7 +850,7 @@ static int s5p_mfc_open(struct file *file)
 		q->io_modes = VB2_MMAP;
 		q->ops = get_dec_queue_ops();
 	} else if (vdev == dev->vfd_enc) {
-		q->io_modes = VB2_MMAP | VB2_USERPTR;
+		q->io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF;
 		q->ops = get_enc_queue_ops();
 	} else {
 		ret = -ENOENT;
@@ -877,7 +877,7 @@ static int s5p_mfc_open(struct file *file)
 		q->io_modes = VB2_MMAP;
 		q->ops = get_dec_queue_ops();
 	} else if (vdev == dev->vfd_enc) {
-		q->io_modes = VB2_MMAP | VB2_USERPTR;
+		q->io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF;
 		q->ops = get_enc_queue_ops();
 	} else {
 		ret = -ENOENT;
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
index 119e55c6f759..404bce3641b9 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
@@ -1704,9 +1704,10 @@ static int vidioc_reqbufs(struct file *file, void *priv,
 	struct s5p_mfc_ctx *ctx = fh_to_ctx(priv);
 	int ret = 0;
 
-	/* if memory is not mmp or userptr return error */
+	/* if memory is not mmp or userptr or dmabuf return error */
 	if ((reqbufs->memory != V4L2_MEMORY_MMAP) &&
-		(reqbufs->memory != V4L2_MEMORY_USERPTR))
+		(reqbufs->memory != V4L2_MEMORY_USERPTR) &&
+		(reqbufs->memory != V4L2_MEMORY_DMABUF))
 		return -EINVAL;
 	if (reqbufs->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
 		if (reqbufs->count == 0) {
@@ -1783,9 +1784,10 @@ static int vidioc_querybuf(struct file *file, void *priv,
 	struct s5p_mfc_ctx *ctx = fh_to_ctx(priv);
 	int ret = 0;
 
-	/* if memory is not mmp or userptr return error */
+	/* if memory is not mmp or userptr or dmabuf return error */
 	if ((buf->memory != V4L2_MEMORY_MMAP) &&
-		(buf->memory != V4L2_MEMORY_USERPTR))
+		(buf->memory != V4L2_MEMORY_USERPTR) &&
+		(buf->memory != V4L2_MEMORY_DMABUF))
 		return -EINVAL;
 	if (buf->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
 		if (ctx->state != MFCINST_GOT_INST) {
@@ -2841,11 +2843,12 @@ static int s5p_mfc_start_streaming(struct vb2_queue *q, unsigned int count)
 						S5P_MFC_R2H_CMD_SEQ_DONE_RET,
 						0);
 		}
-
-		if (ctx->src_bufs_cnt < ctx->pb_count) {
-			mfc_err("Need minimum %d OUTPUT buffers\n",
-					ctx->pb_count);
-			return -ENOBUFS;
+		if (q->memory != V4L2_MEMORY_DMABUF) {
+			if (ctx->src_bufs_cnt < ctx->pb_count) {
+				mfc_err("Need minimum %d OUTPUT buffers\n",
+						ctx->pb_count);
+				return -ENOBUFS;
+			}
 		}
 	}
 
-- 
2.17.1


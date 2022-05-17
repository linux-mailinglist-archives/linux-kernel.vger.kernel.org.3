Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72F152A26A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347222AbiEQM76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347073AbiEQM7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:59:44 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906A54EF49
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 05:58:41 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220517125836epoutp027072e75946c6ce49df46f6b2303b2489~v5drUa2ma1344913449epoutp02R
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 12:58:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220517125836epoutp027072e75946c6ce49df46f6b2303b2489~v5drUa2ma1344913449epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652792316;
        bh=wksUEOOixEoJf+qUS9NTctY/uVgxqstDTAlEr0YTLg8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QSLIMPgrjWwgbsfIimaHdQjztEXgYbFna6Vy7Lxbmuw895ZtmiNCVhmIMekOxhaN7
         FUXw6fzS2iQIz/Tcv3qAcLBCZbUgbfZAlXQJjTaD9PsmZcndOQ1+/DN5N5dYi+6B/j
         XB8gSfrcvjT3n6K3JwPCqt8SjZ7r9QcCd/Tyk70k=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220517125834epcas5p1e93a035cefd90fe02a76421c084b7769~v5dqBgx1u1659716597epcas5p16;
        Tue, 17 May 2022 12:58:34 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4L2blW20FFz4x9Pt; Tue, 17 May
        2022 12:58:31 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C7.3C.09762.7FB93826; Tue, 17 May 2022 21:58:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220517125629epcas5p4c99993ea5e464b296ff6dfec85b4c441~v5b0zi5Qn1555515555epcas5p4G;
        Tue, 17 May 2022 12:56:29 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220517125629epsmtrp1808d294c8a1c859dd031f084186f6da6~v5b0yYx2r3276532765epsmtrp1f;
        Tue, 17 May 2022 12:56:29 +0000 (GMT)
X-AuditID: b6c32a4b-213ff70000002622-00-62839bf78b1c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8F.36.08924.C7B93826; Tue, 17 May 2022 21:56:28 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220517125625epsmtip15dfdf361e5a98fcfcd651138a8597f84~v5bxp9J0t1799817998epsmtip1Q;
        Tue, 17 May 2022 12:56:25 +0000 (GMT)
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
Subject: [PATCH 12/20] media: s5p-mfc: Add support for DMABUF for encoder
Date:   Tue, 17 May 2022 18:25:40 +0530
Message-Id: <20220517125548.14746-13-smitha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220517125548.14746-1-smitha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTf0xbVRTHve/157TkBVDuGD9fhgYi0EIpFwLzB2CeYSaYxSwRFAu8FaS0
        XV/BOafrBmzQDIdzSEaBNYBWESeUn+taBdYJ25QMQdDJr1EnYz+UUAYbkM3WFv3vc77ne+45
        OfdeHu59nePPK1BoaLVCKic521g9F8Ofi1zTl+YIy+1cNNfYw0HNDxYwNNvsYKHBzm4u6hrX
        48g41M9GZ20jbNQ7MM9CHbec2dEz0yy0cPYcQIt1Mxxksk+w0Y3be9GYuZ6DTrR3s9E3tmku
        +nxyFENfmDYx1NS9wkXlVhsXTVt6ACo7ZsNe9KPaGtsA1TfdAqjJlmWcOl83zaWaLYsYZWqt
        5FBTExYO1dlymCq/tM6iPu5qBdSjow1cSmeb5FAOUxB15b6Dm+H1ZmFSPi3No9UhtCJXmVeg
        kCWT6XuyU7LjJEJRpCgBxZMhCmkRnUym7s6IfKVA7twAGVIilRc7pQwpw5DRu5LUymINHZKv
        ZDTJJK3Kk6vEqihGWsQUK2RRClqTKBIKY+KcxncK8+dmJzHVNXjgvNHA1oLTvjrA50FCDNse
        jnB0YBvPm7gAYM2IEbiDZQCrOzpxd+AAsLf7Ar5VMmr8wZMwA3i//idPUIbBnusNmMvFIZ6H
        q39f5bjYlzgCoL1C42Kc2MDhmfEgF/sQr8LOWovTz+OxiDBYa4txyQIiEVYt3+G6mwXDr9v7
        cZeF79QbHr3lagWJxzzY/JWd7fakwi+Pz7Dc7ANvD3V5av3h4sljHpbBWUcpcLMKNmi7MDe/
        APvH61mu83EiHH5rjnbLgbDmyjnMPbEXrNr4w2MXwL7GLSZh04/DnuMh/OVet2ccCrZUNGHu
        lVQBOKTTs6tBUN3/LQwAtILttIopktFMnCpWQb/336XlKotM4N9HHpHeB+bnlqIGAcYDgwDy
        cNJXIDygzfEW5EnfP0irldnqYjnNDII45/o+wf2fzlU6f4lCky0SJwjFEolEnBArEZF+AuLx
        kRxvQibV0IU0raLVW3UYj++vxbKMlSWbjZej99cH6HoTwp6tXbvR3hE/T3qNPqHJ1HmF96/m
        C6JkrKV9h3U0ih8WBX+4a70qVx/5snl7k/XuyAo11PVu8wlrTtn8KS5/p+DnqQczh0L3Zjqy
        WIaNlB0Ro6LQYOa7PzP3RYfe8w+4+uS1ipXMmPGXjHue8rl11MFu+K00DcZLIkdW/pr5QF65
        IylqNeRgKZ3yjGC3JTCz6fjd14PtjcyE3/efLVkH9Fr1hjW2JgWrZgepfdYNeWEfWcjsizdX
        Ty1slvATx6xZm5eGXxubXej/3Z5qUj38dYMxl7592Xxn/2mQHk+LxwPS+J8GqnYOhEnXbqZp
        9FOGQ28YSBaTLxVF4GpG+g9/PQ3gbQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRW1CMYRzGe79z22w+q5leMqmdQZKlWN7UYFzwhQsX5DATNn2KdtfaTRSR
        KMq5KZ0UKdLqwGYTs6JaORRTw7Qju2pVFlFNK0NRWo2753l+v5n/xZ/BRReJacxuZQyvVsrk
        YkpAVDeIPecdzjsevqDnUwDqLKimUNFPG4Y6iuwEqq/S0+jumzwclTx9TKIrxlckulf3gUB3
        Po3T1hwLgWxXKgD6nPueQrquNhJZv2xCrx9cptCZ23oSlRstNLpuasXQDd1vDF3Tf6dR8kMj
        jSyGaoBOpBixFe5cWUEZ4GosxYAzFQ/i3P1cC80VGT5jnE6bSnHmNgPFVRUf5ZKfDBPcubta
        wI0m5dNcmtFEcXadJ/diyE6vd90qCI7g5btjefX8ZTsEUZ0dJkzVAg/eL7lKJoIMtzTgzEB2
        EWwtacTTgIARsTUADtdlkRMAwtKRdDCRp8DSURs9ISVh8EZvE+YAFOsHf/Q3UQ7gxiYDaCpN
        xRwFZy8SMMM0jDusKWwIrMoyjAOGIdiZMMsY4JiF7FJ4drCXnrgwA966/Rh3KM7je/5omCOK
        2EDY8whdAK5XgZMWTOVVGkWkQuOvClDyByQamUKzXxkp2blXoQP/vubrWwMM2gFJPcAYUA8g
        g4vdhAsOJoaLhBGyuHhevXe7er+c19QDD4YQuwtb0p5vF7GRshg+mudVvPo/xRjnaYlY4+nV
        SzzI5XREenS/30ks2Gz9/ZX8ssod71tYMBZUK27PKRRsOXxMsz700XTJmkztjEOlLuVhrxNu
        Kr1tRc4KuVdTi3ho5J2P1Eva4lM5+USH9xwpv0FOftu1r/AXXvKRDrT3T/9z/hJm9X5Qkb+4
        IcfsReS4fTzrUnkhPOjZkYaYMa88Qe3GyFfCSbxt6Usqvsd9stNQxts5538eCjJ3v9j2NsHc
        bEvd4KHAjy/rk2RbPaOTrMv9LhUP6OedCgxt/i5QZ9bZmc1O3enRlYJ9/m3mk7H+K4/deVM1
        qyt7NATN/QCb9TNrY1WDs9tTGuOkUWuP7gEhqnVxe9qloVpTnpjQRMn8fXG1RvYXtHuRiSQD
        AAA=
X-CMS-MailID: 20220517125629epcas5p4c99993ea5e464b296ff6dfec85b4c441
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220517125629epcas5p4c99993ea5e464b296ff6dfec85b4c441
References: <20220517125548.14746-1-smitha.t@samsung.com>
        <CGME20220517125629epcas5p4c99993ea5e464b296ff6dfec85b4c441@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
index a4e3df24b4ae..a6e50981bdd6 100644
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
index 9b624f17e32b..57b4397f2b03 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
@@ -1703,9 +1703,10 @@ static int vidioc_reqbufs(struct file *file, void *priv,
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
@@ -1782,9 +1783,10 @@ static int vidioc_querybuf(struct file *file, void *priv,
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
@@ -2840,11 +2842,12 @@ static int s5p_mfc_start_streaming(struct vb2_queue *q, unsigned int count)
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


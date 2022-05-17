Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E1452A282
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346821AbiEQNCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347137AbiEQM76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:59:58 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954264DF58
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 05:59:11 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220517125909epoutp0219f41956456914fb838986defb288e35~v5eKTtVSO1345213452epoutp02R
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 12:59:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220517125909epoutp0219f41956456914fb838986defb288e35~v5eKTtVSO1345213452epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652792349;
        bh=OldiMTeUcbpXynmP7pPQyTALOI1a+d6YmUHMBKBXCDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GwRo2/9+EHz0MuUfjuT/U1RT0XUdwHjCn/DvRKhdpUc5KOHfk0KbGJUGWCrdaPK0G
         qDVo5XW31uLpBz4yks6a4SGBLI3lZVR2NApRUAr0m7zOMQ/leJEPiYzWhAJbF7JQm8
         jQmSzJTkHlXyaMHjwShoWa1U7a4h6Aw4TcJAUqns=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220517125908epcas5p27239522f2c8b7dc302a0bbefedc65c57~v5eJQuvap2513725137epcas5p2M;
        Tue, 17 May 2022 12:59:08 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4L2bm865zrz4x9Pp; Tue, 17 May
        2022 12:59:04 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2B.4F.10063.81C93826; Tue, 17 May 2022 21:59:04 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220517125644epcas5p3fcabdc953c042cc9f2697f7fbfc74121~v5cDT1pr-2689826898epcas5p3Z;
        Tue, 17 May 2022 12:56:44 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220517125644epsmtrp1fe798bda133481bb9eb94fae817c14a2~v5cDSwpAu0134401344epsmtrp1C;
        Tue, 17 May 2022 12:56:44 +0000 (GMT)
X-AuditID: b6c32a49-4cbff7000000274f-1c-62839c183b7a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D1.46.08924.C8B93826; Tue, 17 May 2022 21:56:44 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220517125641epsmtip1a0559998fd6160a501f0c4db7140a5d4~v5cANMVb32352323523epsmtip1j;
        Tue, 17 May 2022 12:56:41 +0000 (GMT)
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
Subject: [PATCH 16/20] media: s5p-mfc: Fix to handle reference queue during
 finishing
Date:   Tue, 17 May 2022 18:25:44 +0530
Message-Id: <20220517125548.14746-17-smitha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220517125548.14746-1-smitha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0xbVRzHc+4tt4VZcnlMDhBqvY7ENTzarbADAd0yQq7RP3BzAjMTL3AD
        hNLWPhSMhvIaDoXhpkMYr46nCGwrzyEY6GqmzGHIKq3RwjbUWRYfocjYKMyWdvO/z+93vr/f
        95ffOYeHB/5MhPEK5BpWJWdkFOHHGb26VxQNmyuyxQ1bsehW6yiBOjbuYmipw8FBxqERLho2
        n8dRz7VpH9RmmvNBYzN3OOjyH67T+UYbB91tGwTI3rRIIMPygg+6vZKObk40E+jjSyM+aMBk
        46IuyzyGug1ODF0YWeOiqikTF9kmRwGqPGnCDobQ/a39gB63dQLa0rmK01eabFy6Y9KO0Ya+
        UwT9y8IkQQ91ltJV3zzk0HXDfYDeLm/h0jUmC0E7DAJ69l8HN83/eGFSPsvksiohK89R5BbI
        85Kpl49mHc6KixdLoiUJ6AAllDNFbDKV8kpadGqBzLUBSvgOI9O6UmmMWk3FvpCkUmg1rDBf
        odYkU6wyV6aUKmPUTJFaK8+LkbOaRIlYvC/OJXyrMF9XYcaVtQHFuuUuXAcG/WuALw+SUvjD
        VA1eA/x4geRXANbdvukNVgFsH98CnsABYFO5hfukpMLhVU0AaPzUgXmCSgxuj1lxt4ogo+D6
        39cJNweTZQAuf6hxM05u4rDRLHBzEJkOzfrVHQ2HjIQj7Rs7zCcT4YJz1cfj9gz88tK0qyeP
        5+vKt2yfcHtBcoMH9X+ZCI8mBc6U9wMPB8GVa8PeScOg/fRJL+fBJUeFV6OELbphzMMvwmlz
        M8fdHyf3wosTsZ50BPxsdhDzjOwPazd/9cr5cLz1MVPwwvffettD+OOfI96RaeicXfEuqBbA
        7e56vB4Imv63aAegD4SySnVRHquOU0rk7LtPbi1HUWQAO69c9NI4sN36J8YIMB4wAsjDqWC+
        uFiXHcjPZUreY1WKLJVWxqqNIM61v0/wsN05Ctc3kWuyJNIEsTQ+Pl6asD9eQoXwyUdl2YFk
        HqNhC1lWyaoe12E83zAdRv6+hmdI9Xv0lVnOeqnQHBIlurz+08rps3R2epk8+EZ73YPec2ca
        L9JTMwPrVqcRRUBtZlvN12RnfmRJdJkq8HrlUx/JStdK+w6FP3ukICAo40jMvurU+UzD/YY7
        qSmRlYKD/K2q3atLb6Tbq/1EvZmxizcGT2QGN+daX7uXJD10TOBLNOwZkFBzoWfsgsyjDaJH
        b3It/HubfV091u+efjVc9fwDq6S3fCjNIshonz4fUL24S/t+ScfVqOaCU4lb+8324rMHelRF
        zLly8eHqNnnKuk2f5NSu/1Z1/Lnpt78YwEK2El5XHNPXaj9XBhWP3V8UfmDv3lXxMGJo7kpP
        bXgoxVHnMxIRrlIz/wGNOdukbgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRf0yMcRzH+z6/u63b42IembJntXGIjO0bIsY8/BFmt7awPNWzau5Ouycp
        K12lplt+dGL9OqFC59h1XIrLJUd+Dal101wh7ZTWb0Q0XfHf6/N5vT+fzx8fCpXpMT8qUZ0s
        aNS8kiUkWN0j1n9FQVlOzKoXVxfBDxfrCFg54UZgd+UYBptvW0l4p70MhddamnBY4XiFw7sP
        P2Gw9su0bS1xYdBdcQvAvtIuAlp6OnD4sT8Stt0rJ2CB2YrDmw4XCaudrQi8avmNwCvWcRLm
        NjpI6LLVAXgiz4GEz+dMF02Aq3dVAc5ZNYpyDaUukqu09SGcxZhPcO87bAR3uyqTy338C+NO
        3zECbirbQHI6h5Pgxiz+3PNvY+RuaZRkQ5ygTEwRNCs3HpQkaHPa0aRTc1K1PdWoFtyS6oA3
        xdBrmNc5Y6gOSCgZXQ8Y5/hZMCsYpmZS/499mZopNzkbykaY7Kxu1CMIejnzfegF4RFz6dzp
        6Zp8xFOgdCHGFDl/zaR8aQVj/1IzswqjgxjrpQnCwz70Oqbj9yg+eyKAuWFums5TlPd03zB1
        wIMyOpTptcOzQHoJeBnBAiFJVMWrxJCk1WrhaLDIq8Qj6vjg2MMqC5h5m1xeD2zG4eBmgFCg
        GTAUys71WZWqjZH5xPFpxwTN4WjNEaUgNoOFFMbO93mjexYto+P5ZOGQICQJmv8Wobz9tEgy
        m9YSjIasTSvqXZJBKlNS6rq+8b17Wb1UsaV2xP3JfazTq1NlJ2M1UvnAuc++qpJdxyF+IWTg
        JDEetikz7l3XSFCYKWZdhKvz0H1DwPWmGBPOqPNadeUHdA07Km8oAtbrp5raW/ZJnk+GebFZ
        BQObakcLJYq39u0Z2J+hhTvxfnESfkgPf0K/dD/YM8K2BbpGIiOil/7oDjIQ13v07Q1bF5v2
        /1wjtlbYcQSgnXmjPF69OWGPZktxBrosvW3J037/4af5QbbBLmW6fO/ygkRD8eLo1PPFPTaK
        9x48Zc01BpakmbdVRTUueBSmMp+Z03d5npCjiA39+tYcyGJiAh8iRzUi/xelkmlTJQMAAA==
X-CMS-MailID: 20220517125644epcas5p3fcabdc953c042cc9f2697f7fbfc74121
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220517125644epcas5p3fcabdc953c042cc9f2697f7fbfc74121
References: <20220517125548.14746-1-smitha.t@samsung.com>
        <CGME20220517125644epcas5p3fcabdc953c042cc9f2697f7fbfc74121@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On receiving last buffer driver puts MFC to
MFCINST_FINISHING state which in turn skips
transferring of frame from SRC to REF queue.
This causes driver to stop MFC encoding and
last frame is lost.

This patch guarantees safe handling of frames
during MFCINST_FINISHING and correct clearing
of workbit to avoid early stopping of encoding.

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
---
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
index 95e18f1cabb0..91b7ff07feff 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
@@ -1411,6 +1411,7 @@ static int enc_post_frame_start(struct s5p_mfc_ctx *ctx)
 	unsigned long mb_y_addr, mb_c_addr, mb_c_1_addr;
 	int slice_type;
 	unsigned int strm_size;
+	bool src_ready;
 
 	slice_type = s5p_mfc_hw_call(dev->mfc_ops, get_enc_slice_type, dev);
 	strm_size = s5p_mfc_hw_call(dev->mfc_ops, get_enc_strm_size, dev);
@@ -1464,7 +1465,8 @@ static int enc_post_frame_start(struct s5p_mfc_ctx *ctx)
 			}
 		}
 	}
-	if ((ctx->src_queue_cnt > 0) && (ctx->state == MFCINST_RUNNING)) {
+	if ((ctx->src_queue_cnt > 0) && (ctx->state == MFCINST_RUNNING ||
+				ctx->state == MFCINST_FINISHING)) {
 		mb_entry = list_entry(ctx->src_queue.next, struct s5p_mfc_buf,
 									list);
 		if (mb_entry->flags & MFC_BUF_FLAG_USED) {
@@ -1495,7 +1497,13 @@ static int enc_post_frame_start(struct s5p_mfc_ctx *ctx)
 		vb2_set_plane_payload(&mb_entry->b->vb2_buf, 0, strm_size);
 		vb2_buffer_done(&mb_entry->b->vb2_buf, VB2_BUF_STATE_DONE);
 	}
-	if ((ctx->src_queue_cnt == 0) || (ctx->dst_queue_cnt == 0))
+
+	src_ready = true;
+	if ((ctx->state == MFCINST_RUNNING) && (ctx->src_queue_cnt == 0))
+		src_ready = false;
+	if ((ctx->state == MFCINST_FINISHING) && (ctx->ref_queue_cnt == 0))
+		src_ready = false;
+	if ((!src_ready) || (ctx->dst_queue_cnt == 0))
 		clear_work_bit(ctx);
 
 	return 0;
-- 
2.17.1


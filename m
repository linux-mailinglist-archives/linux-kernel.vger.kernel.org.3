Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC2652A287
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347064AbiEQNCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346964AbiEQNAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:00:17 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D724E398
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 05:59:23 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220517125921epoutp048595cef5882ac01181785a30d8860dce~v5eVuwdlS1722717227epoutp04G
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 12:59:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220517125921epoutp048595cef5882ac01181785a30d8860dce~v5eVuwdlS1722717227epoutp04G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652792361;
        bh=0zS0aSZ2KeTou4QZbPw0Se44QW6AzkaGDCCxNu9HzrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eQkRGuTH+DTorAmKT2exHdGcY4Jbt8GzuiuBbCTpHRN3vk6dLM8g/GgK7n7nbT/dJ
         f2DM65+wetGyxTmFv9GianKYhWW+kEoVnnakOGfPWtIx5QHPWj0EJ7gxiMphkAgwxG
         yRqfEcP7o6S+0PEFHApNnxTrtmRxeHUmSf9LNnAQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220517125920epcas5p3f17f96dabfca21fc21e4769a30b4e8a3~v5eU794Iq0661806618epcas5p3R;
        Tue, 17 May 2022 12:59:20 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4L2bmP4WVdz4x9Q4; Tue, 17 May
        2022 12:59:17 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F6.4C.09762.52C93826; Tue, 17 May 2022 21:59:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220517125652epcas5p31abe2138fbff6218c9031da714bfb448~v5cLEDG892689826898epcas5p3o;
        Tue, 17 May 2022 12:56:52 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220517125652epsmtrp21535de7dfaf3366486575648922ebd77~v5cLC_0tx0914309143epsmtrp2U;
        Tue, 17 May 2022 12:56:52 +0000 (GMT)
X-AuditID: b6c32a4b-1fdff70000002622-4f-62839c256f57
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        14.46.08924.49B93826; Tue, 17 May 2022 21:56:52 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220517125649epsmtip122aabb00b1566a161985589e178af6ed~v5cHvpZ-E1797117971epsmtip1L;
        Tue, 17 May 2022 12:56:48 +0000 (GMT)
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
Subject: [PATCH 18/20] media: s5p-mfc: Correction in register read and write
 for H264
Date:   Tue, 17 May 2022 18:25:46 +0530
Message-Id: <20220517125548.14746-19-smitha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220517125548.14746-1-smitha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTf1CTdRzH7/s8z54NrtnTgPMrGXIrvIMENhzzOw8Iw/Oeomx3dNGPMxjw
        CMTY5n6YkdYE+SGGRp1eEIMSCA/RYGzEz1xrJgepGSimID+0CA6Q2+LHgWAbD9Z/r8/7+/nx
        vs/3++XhgtukPy9TpWe0KoVSSHoTLT8Hh4QGVeSliEp/34JGKltIVL04jqHhaheB7M1WLrL0
        f42juis2DqpyXOOgH34aI1DT3+7TG2VDBBqvugjQRPk9Epnv3+Kg0clE1NdeQaLPGq0cdMEx
        xEW1Azcw9J35EYbOWv/hovwuBxcNdbYAdKzAgcVupBsqGwDdOlQD6IEaJ063lQ9x6erOCYw2
        1x8n6cFbnSTdXPMpnX95iaBPWuoBvZpr4tLFjgGSdpkD6J45F1e+4d2sqAxGkcZoAxlVqjot
        U5UeLYxPSIpLipSKxKFiGdohDFQpsplo4e7X5KF7MpXuDQgDDyqUBrckV+h0wvCYKK3aoGcC
        M9Q6fbSQ0aQpNRJNmE6RrTOo0sNUjH6nWCSKiHQnJmdlFAyacM0p30NffbvIMYIpqhh48SAl
        gQVX/ySKgTdPQHUAuNC5uB44Aez66xGXDVwA/njmN7IY8NZKSuwHWb0dwIbJ4zgbHMPgF0U2
        rqcvSW2D8w97SQ/7UkcBvF+k9zBOLeOwrD/Awz5UIrQ97CQ8TFBB8MuV9rV8PrUTTnfVcVh/
        W+D5RhvuGezl1k2r+1g5zwtWLBCsn93w7vn9rOwDJ69YuCz7Q9dMF8lyOhx25QGWNdBktGAs
        vwRt/RVrbXAqGH7fHs7Kz8HTPRcx1vAGWLL8YD2dD1srn7AQnv21e30UhDenreuGaTg+V0Wy
        GykBcNxUiH0OAsr/H/ENAPVgE6PRZaczukjNdhXz4X9XlqrONoO1Jx4S3wrGRmbD7ADjATuA
        PFzoyxcdMqYI+GmKj3IYrTpJa1AyOjuIdG+vFPf3S1W7/4hKnySWyEQSqVQqkW2XioUb+dTj
        oykCKl2hZ7IYRsNon9RhPC9/Izb5QL0NTCp31W593pJ6OEQ2fcSICrVj+ededDm9n2WMr+b6
        WrOCDZcH5UsRe0bCIqZ8zM6kUMFcjNVH1kEWLTo/bm/Zfc975a2p4YXNdZsMJ5ngzD/eyf/E
        2fhB8o7HS7qEvhNBZT1ZzEp9Xhdf4rVLPh81dqmu0LZQVrh6ui+3daY73PtE29JM09Y3NZVP
        TcVnn7o5m/vG2P7EA2fsocw+6eH695pff3q6t6lW8EsbleM3euCC45UjinlX03jMpcjZ3oQX
        3o9Lvv72ddG1CTl/yrRsjPaPLZ2fu9u8aOm4Q5iGzzXlRISP+q6kXU14ZrOfjHu7ICFWQEjj
        uu/stb1s3asWEroMhTgE1+oU/wJ4nuJ/awQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7bCSnO6U2c1JBu9OG1k8mLeNzWLxj+dM
        FvcXf2axOLR5K7vFliuzmS2WHz/AajH/yDlWi+0HH7FYbHwBlL048y6LxfP56xgtXs66x2ax
        6fE1VouHr8ItLu+aw2bRs2Erq8XaI3fZLZZev8hksWzTHyaLRVu/sFu07j3CbnF3zzZGi5a2
        I0wO4h5r5q1h9Nhxdwmjx/Uln5g9ds66y+6xeM9LJo9NqzrZPO5c28PmsXlJvUfr0V8sHn1b
        VjF6/Guay+7RdeQ6m8fnTXIep75+Zg/gi+KySUnNySxLLdK3S+DKaLszl7mgX6RixsIfrA2M
        bwS6GDk4JARMJHoPlXUxcnEICexglPiwcBpjFyMnUFxCYuXvSVC2sMTKf8/ZIYqamCR+Xp7A
        BpJgE9CR+Pb+NBtIQkSglVHi+spOJhCHWWAii8SU67+YQaqEBUIl5k3ZyAJiswioSkz+uwus
        m1fASuLt3uWsECvkJVZvOMAMchInUHzuv1gQU0jAUuLpfosJjHwLGBlWMUqmFhTnpucWGxYY
        5aWW6xUn5haX5qXrJefnbmIEx5qW1g7GPas+6B1iZOJgPMQowcGsJMJrUNGQJMSbklhZlVqU
        H19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVANTi2OZluSWWA3xvXGLm04w
        WxixPylPWPNTU0pzzb+VYk8SCu2/PFlsZl5n1DvTq35nOv+0t8LPtBq4J+Wue+l2pPL1n3Xd
        v5b7tj5OzPidvVBHyvzJ3Auf1ORNsw22rAxI/Dr9tePK0l47J7fSqu1iwln1M7cdu7bz9Xcn
        aUcNtxlOjR/9T4UqJ+evv/eSwY734071D8+MHtumF4pNOzvxyhV58TO7C/bo8smybJ37+KoM
        l9S25kdmTdMuGiQt/9VocvmIbnxZwulXIfcO90bmZ3HYH12wZ/OR24zajnc5N2YIBT++dyE3
        Yp5vhKZSq8SylDkM8x5NY5x7xVnzid3TfI+6y3sCIuNuBi9pzqpTYinOSDTUYi4qTgQAWmNz
        yiQDAAA=
X-CMS-MailID: 20220517125652epcas5p31abe2138fbff6218c9031da714bfb448
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220517125652epcas5p31abe2138fbff6218c9031da714bfb448
References: <20220517125548.14746-1-smitha.t@samsung.com>
        <CGME20220517125652epcas5p31abe2138fbff6218c9031da714bfb448@epcas5p3.samsung.com>
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

Few of the H264 encoder registers written were not
getting reflected since the read values was not
stored and getting overwritten.

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
---
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c      | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
index 44058827eaa3..40e4cb5bf3ae 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
@@ -1268,7 +1268,7 @@ static int s5p_mfc_set_enc_params_h264(struct s5p_mfc_ctx *ctx)
 	}
 
 	/* aspect ratio VUI */
-	readl(mfc_regs->e_h264_options);
+	reg = readl(mfc_regs->e_h264_options);
 	reg &= ~(0x1 << 5);
 	reg |= ((p_h264->vui_sar & 0x1) << 5);
 	writel(reg, mfc_regs->e_h264_options);
@@ -1291,7 +1291,7 @@ static int s5p_mfc_set_enc_params_h264(struct s5p_mfc_ctx *ctx)
 
 	/* intra picture period for H.264 open GOP */
 	/* control */
-	readl(mfc_regs->e_h264_options);
+	reg = readl(mfc_regs->e_h264_options);
 	reg &= ~(0x1 << 4);
 	reg |= ((p_h264->open_gop & 0x1) << 4);
 	writel(reg, mfc_regs->e_h264_options);
@@ -1305,23 +1305,23 @@ static int s5p_mfc_set_enc_params_h264(struct s5p_mfc_ctx *ctx)
 	}
 
 	/* 'WEIGHTED_BI_PREDICTION' for B is disable */
-	readl(mfc_regs->e_h264_options);
+	reg = readl(mfc_regs->e_h264_options);
 	reg &= ~(0x3 << 9);
 	writel(reg, mfc_regs->e_h264_options);
 
 	/* 'CONSTRAINED_INTRA_PRED_ENABLE' is disable */
-	readl(mfc_regs->e_h264_options);
+	reg = readl(mfc_regs->e_h264_options);
 	reg &= ~(0x1 << 14);
 	writel(reg, mfc_regs->e_h264_options);
 
 	/* ASO */
-	readl(mfc_regs->e_h264_options);
+	reg = readl(mfc_regs->e_h264_options);
 	reg &= ~(0x1 << 6);
 	reg |= ((p_h264->aso & 0x1) << 6);
 	writel(reg, mfc_regs->e_h264_options);
 
 	/* hier qp enable */
-	readl(mfc_regs->e_h264_options);
+	reg = readl(mfc_regs->e_h264_options);
 	reg &= ~(0x1 << 8);
 	reg |= ((p_h264->open_gop & 0x1) << 8);
 	writel(reg, mfc_regs->e_h264_options);
@@ -1342,7 +1342,7 @@ static int s5p_mfc_set_enc_params_h264(struct s5p_mfc_ctx *ctx)
 	writel(reg, mfc_regs->e_h264_num_t_layer);
 
 	/* frame packing SEI generation */
-	readl(mfc_regs->e_h264_options);
+	reg = readl(mfc_regs->e_h264_options);
 	reg &= ~(0x1 << 25);
 	reg |= ((p_h264->sei_frame_packing & 0x1) << 25);
 	writel(reg, mfc_regs->e_h264_options);
-- 
2.17.1


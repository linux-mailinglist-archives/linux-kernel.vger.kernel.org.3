Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922CE52A277
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243629AbiEQNAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347116AbiEQM7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:59:45 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9EB4EF62
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 05:58:44 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220517125842epoutp03264a06ce8ad3a80cd80eca0434c1d093~v5dxKeeND0631206312epoutp03c
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 12:58:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220517125842epoutp03264a06ce8ad3a80cd80eca0434c1d093~v5dxKeeND0631206312epoutp03c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652792322;
        bh=eQWhvo0/26Op8Gp4Xd1DKPNSgbfiQhLLhKzi6R2xW/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=secE2tRtGHp4F1yd2jkLCjepDUz+bVYQTvrt3gxSBk5A+yCoHImbkvDgwYHYzyadN
         zZz/HNDLQ2+CUY20vs2Xxk4ocP0aDXyJfQ+xrmZZNa8LBSWQwj2PY2mGN8VBsubejb
         aGobBJletrjNxMMyioLWUcX9w3fiB5GEattOHcYU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220517125841epcas5p2b0102154b4ee3b782b4403a4ee75ff66~v5dwi_NLx0253602536epcas5p2j;
        Tue, 17 May 2022 12:58:41 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4L2blf1Jnzz4x9Ps; Tue, 17 May
        2022 12:58:38 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        49.3C.09762.DFB93826; Tue, 17 May 2022 21:58:38 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220517125634epcas5p40259b75a9ea07495330144310d61a5c9~v5b5w6iLk3255032550epcas5p4E;
        Tue, 17 May 2022 12:56:34 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220517125634epsmtrp10b4f06432e6bc6f5b1aee3b22e9f9bfb~v5b5vqDia3276532765epsmtrp1i;
        Tue, 17 May 2022 12:56:34 +0000 (GMT)
X-AuditID: b6c32a4b-1fdff70000002622-09-62839bfd5bdd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        37.AA.11276.28B93826; Tue, 17 May 2022 21:56:34 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220517125629epsmtip1ab5ffa7d0d955ffe1e82f62b8673eefc~v5b0yjnYy2359123591epsmtip1U;
        Tue, 17 May 2022 12:56:28 +0000 (GMT)
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
Subject: [PATCH 13/20] media: s5p-mfc: Set context for valid case before
 calling try_run
Date:   Tue, 17 May 2022 18:25:41 +0530
Message-Id: <20220517125548.14746-14-smitha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220517125548.14746-1-smitha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTf0xTVxTHc19fX1tn3bNIvJIMSRfjICu0oy0XBptjzDxlcRji/BEnFHgp
        hNLWvnZUgln5vaFsOGMmv8WyLUEUhuU3GCggiI7JZHQ6C4wfIoRNQwfBqbiWVvff557z/Z5z
        cu69XJbgHuHDTVHraZ1aoRISG/DmXn9/0VpZToJ4ZRigycpmAplX5zA0YXbgyHq1iYMso2Us
        9ONANxtV9Q2zUUvPFI5+eujMjpTYcTRXdQWg+dJxAjVOj7HRnwsH0Z32cgKdbmhio8t9dg76
        3jaCoR8an2HoYtM/HJTX1cdB9s5mgHLz+7BdW6m6yjpAtdprAGWrWWJRbaV2DmXunMeoxtqv
        COr+WCdBXa35gsrr/xenvrbUAmotu4JDFfbZCMrR6EsNLTs4MZuOpIYn04okWudHqxM1SSlq
        ZYQwOjbuwziZXCwRSUJRiNBPrUijI4RRH8eIdqeonBsQ+n2uUBmcoRgFwwiD3gvXaQx62i9Z
        w+gjhLQ2SaWVagMZRRpjUCsD1bQ+TCIWvyNzCuNTk+fOZuHaIp5xpsmEm4CdUwh4XEhKYWFH
        NrsQbOAKyA4Ah3J7MPdhCcCJsics92EFwMnx1VcW8+Jd3J3ocqou/erx52LwWkE34VIR5Ntw
        5dHNdd5CZgE4/aXexSzyKQuWjPq62Is8Am2D59kuxskdsLfavM58MgxW56x4um2Hlxq6nWNw
        uTxnvGLtM1cvSL7gwuobDuDWRMHZbycwN3vBhQGLx+sD57/J97ASTjhyPHotrDBZPPr3Yfdo
        Oe6qzyL9YX17kDv8Bjw3dAVzj7wJFj2d8cj5sLXyJQvhxVuDnvIQ/vZXE9tVBpIUNDkk7pUU
        AVixepsoBr6l/3e4AEAt2EZrmTQlzci0wWo6/dWlJWrSGsH6Iw+IbgVTk48DrQDjAiuAXJZw
        C19sNCUI+EmKExm0ThOnM6hoxgpkzvWdYfl4J2qcv0Stj5NIQ8VSuVwuDQ2WS4Rb+eSLrAQB
        qVTo6VSa1tK6lz6My/MxYcEf/J2XVLIPGJdN+zWq7Ne2rzyIP+XwPj5Sr844GXm9/63EoFzL
        nslIw8AvD4pHjAE3u+zGGE1Vy5MwrzBwfShHfnvUsH9WE2s9N/tcT1obemkB1QymH2fGhGTK
        TNNt3q+ni3ZuFMV2SJeDMoa6C8JP7olMnAm6t/hMVvPRbkD6rO3kHbLFHwtl/143wczvuxF9
        1rFXYB9hKXmbfe9ee/cEMbYjdo4MOSya68y7wOdsM9vOG5dlu4p7yu/sLWg/eFQyHHVq88bw
        rOf2o/318wdw5a2pN8Ox4+OcxYfmy+n5x5YO4G2nv/uEDH50aCGTl/Pz4Kft9fcrWwYOm3QZ
        SzN/CHEmWSEJYOkYxX8yutZtbQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7bCSnG7T7OYkg8WneSwezNvGZrH4x3Mm
        i/uLP7NYHNq8ld1iy5XZzBbLjx9gtZh/5ByrxfaDj1gsNr4Ayl6ceZfF4vn8dYwWL2fdY7PY
        9Pgaq8XDV+EWl3fNYbPo2bCV1WLtkbvsFkuvX2SyWLbpD5PFoq1f2C1a9x5ht7i7ZxujRUvb
        ESYHcY8189Yweuy4u4TR4/qST8weO2fdZfdYvOclk8emVZ1sHneu7WHz2Lyk3qP16C8Wj74t
        qxg9/jXNZffoOnKdzePzJjmPU18/swfwRXHZpKTmZJalFunbJXBlPJ/cyFLQy1nxZGsDSwPj
        XfYuRk4OCQETicVvbrKA2EICuxklVuypgYhLSKz8PYkRwhaWWPnvOVA9F1BNE5PEy3NnwZrZ
        BHQkvr0/zQaSEBFoZZS4vrKTCcRhFpjIIjHl+i9mkCphgQiJW59Wg41iEVCVOLxwMSuIzStg
        JbGw+RvUGfISqzccAKrn4OAEis/9FwtiCglYSjzdbzGBkW8BI8MqRsnUguLc9NxiwwLDvNRy
        veLE3OLSvHS95PzcTYzgWNPS3MG4fdUHvUOMTByMhxglOJiVRHgNKhqShHhTEiurUovy44tK
        c1KLDzFKc7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamCKONKtO+NYzdcXx205z16R79BX
        mTzrNXd7dK1C7MToEwfu8d007rVPLg/9s5Zn39kLbak/D18P9C/Omfl0ro7ms0fh8mZ+wQaR
        f70Xzl+d8N3ow0TrVyuYjjoY3H27mt9pgoRLWvjxG82Llq2rzPTv+bRpyZFDFn8kPsX8YzjE
        pc/UypP99n9oyYvGd0o2tja7/5scFKhLOBhzwLqdi/tJpcrZ9SdOfl/r0Xb/y/VPunyFCz9s
        4BTJWvbiujVv2MQ9x85uayj0v7mjVrsq9J3OZM2Zr5MFH273a53QqepjpFe62+JB3pzktNCy
        B8evLOs/8Cbdx2tx0dGexYLXSmsrY1JLOKwv/5kiW9Wpe9pFiaU4I9FQi7moOBEApE2MryQD
        AAA=
X-CMS-MailID: 20220517125634epcas5p40259b75a9ea07495330144310d61a5c9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220517125634epcas5p40259b75a9ea07495330144310d61a5c9
References: <20220517125548.14746-1-smitha.t@samsung.com>
        <CGME20220517125634epcas5p40259b75a9ea07495330144310d61a5c9@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Context bit is set for hardware execution if there is a buffer
in source and destination queue before calling try_run in the
init_buffers function. Now there will be a new context created
and hardware will be invoked for the buffer queued instead of
waiting for another buffer to be queued from userspace to set
this context bit for hw execution.

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
---
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
index a6e50981bdd6..3483be832f2e 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
@@ -589,6 +589,8 @@ static void s5p_mfc_handle_init_buffers(struct s5p_mfc_ctx *ctx,
 		s5p_mfc_clock_off();
 
 		wake_up(&ctx->queue);
+		if (ctx->src_queue_cnt >= 1 && ctx->dst_queue_cnt >= 1)
+			set_work_bit_irqsave(ctx);
 		s5p_mfc_hw_call(dev->mfc_ops, try_run, dev);
 	} else {
 		WARN_ON(test_and_clear_bit(0, &dev->hw_lock) == 0);
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACA75ADF97
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 08:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238444AbiIFGPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 02:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238424AbiIFGOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 02:14:15 -0400
Received: from mail-m973.mail.163.com (mail-m973.mail.163.com [123.126.97.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93A7C6FA00;
        Mon,  5 Sep 2022 23:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=HjvYw
        +38zUy2OoiuWKdvZZc1dc1eVjkFxjz5keaFep8=; b=WHEn5qCcxLAtGGzIeo25k
        GI6OprpJiHj1HPb5N+Y2RPiWksHitgmoCIfCR3EKi2UG93eCQgEC29TQr6IECvd5
        xC9wTMWqwhhYSLVFhp7CvOVKEonI2z/bt6yMrMJJbP61hJXGy2gUz1cheot+5fu+
        M2woCt/OQcr4rBcFGXn0WI=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by smtp3 (Coremail) with SMTP id G9xpCgCH1Yce5RZj4Qg3bQ--.43239S2;
        Tue, 06 Sep 2022 14:13:51 +0800 (CST)
From:   Jiangshan Yi <13667453960@163.com>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     linuxdrivers@attotech.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] scsi: esas2r: esas2r_vda: fix spelling typo in comment
Date:   Tue,  6 Sep 2022 14:13:30 +0800
Message-Id: <20220906061330.2574340-1-13667453960@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgCH1Yce5RZj4Qg3bQ--.43239S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrury7Jr47ZFy5JF4kAr4fZrb_yoWfWFc_GF
        WxtwsF9rW7CFsayr1xKryYvFWqyw4q9rZ8GryFvayfZayDWanrAFZ8JFs0v3srJrWFgasr
        uws0qFy5ArnFyjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU80JPtUUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/1tbiVwB0+1etoMFWHAAAsJ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiangshan Yi <yijiangshan@kylinos.cn>

Fix spelling typo in comment.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 drivers/scsi/esas2r/esas2r_vda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/esas2r/esas2r_vda.c b/drivers/scsi/esas2r/esas2r_vda.c
index 30028e56df63..bcbbf95f6b37 100644
--- a/drivers/scsi/esas2r/esas2r_vda.c
+++ b/drivers/scsi/esas2r/esas2r_vda.c
@@ -416,7 +416,7 @@ void esas2r_build_mgt_req(struct esas2r_adapter *a,
 	}
 }
 
-/* Build a VDA asyncronous event (AE) request. */
+/* Build a VDA asynchronous event (AE) request. */
 void esas2r_build_ae_req(struct esas2r_adapter *a, struct esas2r_request *rq)
 {
 	struct atto_vda_ae_req *vrq = &rq->vrq->ae;
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus


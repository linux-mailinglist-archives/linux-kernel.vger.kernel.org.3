Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C8A58FDD8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 15:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbiHKN4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 09:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbiHKN4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 09:56:22 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C129C7E314;
        Thu, 11 Aug 2022 06:56:20 -0700 (PDT)
X-QQ-mid: bizesmtp81t1660226157t4rprdd2
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 11 Aug 2022 21:55:56 +0800 (CST)
X-QQ-SSF: 01000000002000G0V000B00A0000020
X-QQ-FEAT: zT6n3Y95oi3bVIXAbHMtSOZADe/8+tTl6FBI+nkFergHEQ/tIvg/IiXMtb3p5
        v+WG4L5QGH2A9B8eNWbvKjjv/NWnfr8WfMwNqw+LndVOaOJgTDsNdruK/K5Klea4R7cyGA1
        bvFWb46Ot8J69EGuChV6Xzvly2C115SoEbqCjzXkQTOAAN//kuYbqW6f3VFReZwPb6vWqXZ
        eNnt+IrgU4lg77v7/xR/zMeaI3VE+OZKqwfyOs2iIqZ/83W02tPVZF2s+Des+dQQYCkcQwm
        T6e08rmM9w/Oc5StGVADkGdEBDUi+YiuwArxRr0gNSzOBvBhY9sddhcEbJFFPDuZKPpzGD/
        nPUcXdO2gyrOsKQU8KNTf6S55twm6YtZdoVweTpDg54wBJjFAW3oESHQ3G4ZCVZnBIbZQf0
        doe6Z/LmZn4=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     aliakc@web.de
Cc:     oliver@neukum.org, lenehan@twibble.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, dc395x@twibble.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] scsi: dc395x: Fix comment typo
Date:   Thu, 11 Aug 2022 21:55:49 +0800
Message-Id: <20220811135549.23965-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `the' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/scsi/dc395x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
index 670a836a6ba1..7c7fd511cffe 100644
--- a/drivers/scsi/dc395x.c
+++ b/drivers/scsi/dc395x.c
@@ -2052,7 +2052,7 @@ static void data_in_phase0(struct AdapterCtlBlk *acb, struct ScsiReqBlk *srb,
 		/*
 		 * KG: We should wait for the DMA FIFO to be empty ...
 		 * but: it would be better to wait first for the SCSI FIFO and then the
-		 * the DMA FIFO to become empty? How do we know, that the device not already
+		 * DMA FIFO to become empty? How do we know, that the device not already
 		 * sent data to the FIFO in a MsgIn phase, eg.?
 		 */
 		if (!(DC395x_read8(acb, TRM_S1040_DMA_FIFOSTAT) & 0x80)) {
-- 
2.36.1



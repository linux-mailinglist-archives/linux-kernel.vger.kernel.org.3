Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573CD575E49
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 11:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbiGOJQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 05:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbiGOJQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 05:16:10 -0400
Received: from m12-16.163.com (m12-16.163.com [220.181.12.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6313010578;
        Fri, 15 Jul 2022 02:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=fyFNc
        QNYCyFBpknjFCUUPQ3zekHBnb0d0LNY2pr0Pgc=; b=Q09WJ3SiHiFao93P6X8m5
        nkYxsOr7YKw6XvreuIsA+PaHcLL8PIKGyH8rCYeuOPFuHuETcweNOGNv4Swj78sp
        FJP8baTXIif/U5fUUUd+8P7tWm2yNwcuQBlWev2+halw/L1SF5C8rX9ocVAZlYpL
        vwEImIvHoGiHOl+pQGmQUk=
Received: from localhost.localdomain (unknown [111.48.58.12])
        by smtp12 (Coremail) with SMTP id EMCowABnILoiMNFiUm9+Bw--.10365S2;
        Fri, 15 Jul 2022 17:15:25 +0800 (CST)
From:   Jiangshan Yi <13667453960@163.com>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com
Cc:     MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] scsi: mpt3sas: Fix spelling typo in comment
Date:   Fri, 15 Jul 2022 17:15:03 +0800
Message-Id: <20220715091503.1003482-1-13667453960@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowABnILoiMNFiUm9+Bw--.10365S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrury7Jr47ZFy5Gry8uw13twb_yoW8JF1kpa
        yqkF98AryDJr1UWr1UGryDZF17tw1rJrWUtr4jkw18tas8J34Dtr17Jr1UJ3WUtF4rt3ya
        qr1DJryYga1UJFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jxmi_UUUUU=
X-Originating-IP: [111.48.58.12]
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/1tbiVw4-+1etnrR7CAAAs+
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
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
 drivers/scsi/mpt3sas/mpt3sas_ctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index 84c87c2c3e7e..d0b8db59ba30 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -3491,7 +3491,7 @@ host_trace_buffer_enable_store(struct device *cdev,
 }
 static DEVICE_ATTR_RW(host_trace_buffer_enable);
 
-/*********** diagnostic trigger suppport *********************************/
+/*********** diagnostic trigger support *********************************/
 
 /**
  * diag_trigger_master_show - show the diag_trigger_master attribute
@@ -3794,7 +3794,7 @@ diag_trigger_mpi_store(struct device *cdev,
 
 static DEVICE_ATTR_RW(diag_trigger_mpi);
 
-/*********** diagnostic trigger suppport *** END ****************************/
+/*********** diagnostic trigger support *** END ****************************/
 
 /*****************************************/
 
-- 
2.25.1


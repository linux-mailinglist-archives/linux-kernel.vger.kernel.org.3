Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B34C5ADD4E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 04:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbiIFC2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 22:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbiIFC2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 22:28:51 -0400
Received: from mail-m975.mail.163.com (mail-m975.mail.163.com [123.126.97.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8A066B17F;
        Mon,  5 Sep 2022 19:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=RszKb
        mJQMUpZ5unihsN11xSDWrvsPjIXsmsDeEprHb4=; b=ocbMGQOzxcWmji2Dpl9/M
        57nPw9SZ/ibD7Hn5J7Q3eB8BYTPu18HTcn8kJSsxw6aG6ZH1XM7hFe4FYGfoWcIF
        fLrMtltbTF/P+9keNgyeCq/Y1KtS4eSVoZjXhLDrJ9heKCMLBnKD8NgH+HgZvkrr
        dIQqoQWiRZWk4IZF/vCc0U=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by smtp5 (Coremail) with SMTP id HdxpCgB3fv44sBZj0qC7aA--.37989S2;
        Tue, 06 Sep 2022 10:28:10 +0800 (CST)
From:   Jiangshan Yi <13667453960@163.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] scsi: mpt3sas: mpt3sas_warpdrive: fix spelling typo in comment
Date:   Tue,  6 Sep 2022 10:27:55 +0800
Message-Id: <20220906022755.217835-1-13667453960@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HdxpCgB3fv44sBZj0qC7aA--.37989S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrury7Jr47ZFy5Gry8uw13twb_yoWDurgE93
        42vrW7W348CFsayF1Fyr4xZrWjy3W8Xa4kCrs09wn8Aw47Zw4DXrZrZr17K34DJ3yUta43
        WayDJ3yruw1UWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8ebytUUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/1tbi8Bp0+1uoiEnxmwAAs9
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
 drivers/scsi/mpt3sas/mpt3sas_warpdrive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_warpdrive.c b/drivers/scsi/mpt3sas/mpt3sas_warpdrive.c
index cc07ba41f507..2d35a5948bf3 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_warpdrive.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_warpdrive.c
@@ -250,7 +250,7 @@ mpt3sas_init_warpdrive_properties(struct MPT3SAS_ADAPTER *ioc,
  * @ioc: per adapter object
  * @scmd: pointer to scsi command object
  * @raid_device: pointer to raid device data structure
- * @mpi_request: pointer to the SCSI_IO reqest message frame
+ * @mpi_request: pointer to the SCSI_IO request message frame
  */
 void
 mpt3sas_setup_direct_io(struct MPT3SAS_ADAPTER *ioc, struct scsi_cmnd *scmd,
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus


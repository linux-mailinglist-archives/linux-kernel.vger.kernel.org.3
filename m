Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7E4554FAD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359374AbiFVPoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbiFVPoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:44:08 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA5824BEE;
        Wed, 22 Jun 2022 08:44:00 -0700 (PDT)
X-QQ-mid: bizesmtp76t1655912586t6gfe52b
Received: from ubuntu.localdomain ( [106.117.78.84])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 23:43:02 +0800 (CST)
X-QQ-SSF: 01000000008000B0C000E00A0000000
X-QQ-FEAT: HaQ7ngX2kzCMYYIAtkeLymuyO89n70SxXQaq2mBTCqmGM4CSsv4Hh3pVneDCt
        0G9BM7D9q4yTTD99M67TfZ+9ufZ6wmM44I9xPuTojN3apBpNuRTvsk1tKPVK62lYsDk3OL+
        XuCOt0zWeh3//ZfgyzPxXDHGq0qr0+pqAIpDm7dk/AyvsVElIoQuB6YYH/DKOd+iD/xqW2N
        fZhmFyEe3zxx3LKE/PysCeDlAOpaXiwUEAKCHzsHF5JtOcVVyhVnDpQpaV4lpnKVRfdvcUc
        XC/Epp+jsK1c9d71Cu5z5ZTGaqBDjySkF6CpUZoszk9N7qkRZATQK9tnxP0t4Xn7PZB1mv3
        HC1aSuNevZKWjQhwNHfMAkJp6yi1OnErm2SAHGEtF67/K4fk0E=
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     artur.paszkiewicz@intel.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] scsi: isci: drop unexpected word 'is' in the comments
Date:   Wed, 22 Jun 2022 23:43:00 +0800
Message-Id: <20220622154300.5782-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word 'is' in the comments that need to be dropped

file: drivers/scsi/isci/remote_device.h
line: 211

* device.  When there are no active IO for the device it is is in this

changed to:

* device.  When there are no active IO for the device it is in this

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/scsi/isci/remote_device.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/isci/remote_device.h b/drivers/scsi/isci/remote_device.h
index 3ad681c4c20a..dae5f6410a35 100644
--- a/drivers/scsi/isci/remote_device.h
+++ b/drivers/scsi/isci/remote_device.h
@@ -208,7 +208,7 @@ enum sci_status sci_remote_device_reset_complete(
  * This state is entered from the STARTING state.
  *
  * @SCI_STP_DEV_IDLE: This is the idle substate for the stp remote
- * device.  When there are no active IO for the device it is is in this
+ * device.  When there are no active IO for the device it is in this
  * state.
  *
  * @SCI_STP_DEV_CMD: This is the command state for for the STP remote
-- 
2.17.1


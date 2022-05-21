Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BE152FBC9
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 13:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355039AbiEULUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 07:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354658AbiEULMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 07:12:39 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72591369E6;
        Sat, 21 May 2022 04:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KxLxJK4VOX7mHM48ak0sH0Qf6XuYFijUuIB0IUsxg3c=;
  b=Pql/802JQPyh4rPCmRCgVDVIBEkS+wVVlZ2X1tphoXpKdnPiubrnVR5A
   wLZ5SMMNxms0hs+Cgn7xNm3q9oR2JeJlsAzL8ljcQy92sAY3y0pQbaFD2
   iMvVKN9rgbUAKi16vJcMrkjf9Dd76vWH8ooEwhoRVY0VkiJhS4m8awEUa
   8=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14727946"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:12:00 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     kernel-janitors@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: arm_scmi: fix typos in comments
Date:   Sat, 21 May 2022 13:10:58 +0200
Message-Id: <20220521111145.81697-48-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spelling mistakes (triple letters) in comments.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/firmware/arm_scmi/driver.c |    2 +-
 drivers/firmware/arm_scmi/smc.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index c1922bd650ae..3846b46eb8f7 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1117,7 +1117,7 @@ struct scmi_msg_resp_domain_name_get {
  *	  stored as a NULL terminated string.
  * @len: The len in bytes of the @name char array.
  *
- * Return: 0 on Succcess
+ * Return: 0 on Success
  */
 static int scmi_common_extended_name_get(const struct scmi_protocol_handle *ph,
 					 u8 cmd_id, u32 res_id, char *name,
diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
index 745acfdd0b3d..13d59a1d7844 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/smc.c
@@ -236,7 +236,7 @@ const struct scmi_desc scmi_smc_desc = {
 	 * once the SMC instruction has completed successfully, the issued
 	 * SCMI command would have been already fully processed by the SCMI
 	 * platform firmware and so any possible response value expected
-	 * for the issued command will be immmediately ready to be fetched
+	 * for the issued command will be immediately ready to be fetched
 	 * from the shared memory area.
 	 */
 	.sync_cmds_completed_on_ret = true,


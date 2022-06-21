Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF455534CC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 16:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351573AbiFUOrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 10:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350580AbiFUOrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 10:47:22 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFC125299
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 07:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=oHTCCv5/X/lta9hsJSyCndv/MFD
        1kIrGhr6jtZIV+zM=; b=djVxJnvrGaHDxeNMk/8YHE5IHfZzgYhAURgz26VR9Cu
        5qUUItGT6AXZFbKpw2GdGpWQ4J+222YjEaWpyG2FLSC1sIRWgCrXAuwYA8Qdaed6
        /Jl9xex9Pb/mp39naVBes32t3WM3+BvtgBvTcWT3UNOCL0SSZlj3CNtgOdzODr2s
        =
Received: (qmail 193593 invoked from network); 21 Jun 2022 16:47:15 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Jun 2022 16:47:15 +0200
X-UD-Smtp-Session: l3s3148p1@ntLnS/bhJDlZD+65
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ufs: core: fix typos in error messages
Date:   Tue, 21 Jun 2022 16:46:53 +0200
Message-Id: <20220621144653.62630-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Should be "retries" instead of "retires".

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/ufs/core/ufshcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index bb6cbd514a69..288f20dcb2b2 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -3065,7 +3065,7 @@ static int ufshcd_query_flag_retry(struct ufs_hba *hba,
 
 	if (ret)
 		dev_err(hba->dev,
-			"%s: query attribute, opcode %d, idn %d, failed with error %d after %d retires\n",
+			"%s: query attribute, opcode %d, idn %d, failed with error %d after %d retries\n",
 			__func__, opcode, idn, ret, retries);
 	return ret;
 }
@@ -3233,7 +3233,7 @@ int ufshcd_query_attr_retry(struct ufs_hba *hba,
 
 	if (ret)
 		dev_err(hba->dev,
-			"%s: query attribute, idn %d, failed with error %d after %d retires\n",
+			"%s: query attribute, idn %d, failed with error %d after %d retries\n",
 			__func__, idn, ret, QUERY_REQ_RETRIES);
 	return ret;
 }
-- 
2.35.1


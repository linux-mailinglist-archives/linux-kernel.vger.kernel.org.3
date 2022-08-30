Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C79B5A5E18
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbiH3Ias (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiH3Iah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:30:37 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D813252E65;
        Tue, 30 Aug 2022 01:30:35 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 76so10656442pfy.3;
        Tue, 30 Aug 2022 01:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=QeKpSNFySHjpFiEd0sNIh8LOq1qKfN6ztJE6GynOB7M=;
        b=Ffuh2oMzMyFeksYhzqQ0IU0DZqsglNRMgfaknYKcSUVXPq4Kpk7W747DKQ7Arj66w1
         EUjZDBkCielYYrtnn1hP7MvVMkh+VVE+zpmxWaHS/3jfITtpMP0seqpD7n0Caf+4CgJj
         Reb03pNmOk6BWGE6ET1qVdlOJ5xRGD+Jm4jSVIvt6IZJg7MXEriycy8lejU+DYjdW4Zv
         aITU3uLnJFbVlC+Mm8ZUgX236O8Wu0mzUj1aykU6By4CFfMdEIjxhLnHaOvHg3xKcdhC
         1rhgN+dOnHltmrVWXQ4ei6WQdaBGDIRLhmOW8FUQzeg5f0GhfOXWxRhDvEhn0Vznmkcx
         RBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=QeKpSNFySHjpFiEd0sNIh8LOq1qKfN6ztJE6GynOB7M=;
        b=GOSU66XwZ/eMIVX3KuvDrQlApEU4DgAWfR8Sb+mPOms8bhjvPulOfbPwohXtdpFMmd
         Fw6GY52d+xHA6tf7UNh4RU/YwWYFZeUNbiRVJYw+podfeUL1z3asM/iqb3hNn0ONG3OX
         61IgUz+aQpQX7Y1CS7DxrJMCzlNt6rkpIHAbch3tLnAwvkvhVKDN7dOpTkTHqyQq2hLh
         HJS/TDxkUhU5w8kAKCt8P8xXd666ABPobEacdcPjD5FomfSD2A0HDItpi/xCarcXBML6
         LsLOAK4Oc4Qn5EwtGAMyMzzTqMWqn3CBOzxzAWoOOh50MCaHNHxBTHEVrRe/LSxZfAxS
         TImg==
X-Gm-Message-State: ACgBeo3kSGSYKbizn6MHmeiYHsnUgUBxqF4R8ZfoYx2TZ8kD9qC7mbTr
        do+W8DYTL/Kay8xYmTuIYIxw4MNIJ1A=
X-Google-Smtp-Source: AA6agR5a4/X9nPFm9WIK0dAzpjRcyUYm2uDgGItk0K8cMRZ5BYFSd8CUxK/Q7XeQtrrIzLQ+o/tbVg==
X-Received: by 2002:a63:90c7:0:b0:42b:6b68:3655 with SMTP id a190-20020a6390c7000000b0042b6b683655mr16837088pge.335.1661848235441;
        Tue, 30 Aug 2022 01:30:35 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 126-20020a620484000000b0053617cbe2d2sm8657344pfe.168.2022.08.30.01.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 01:30:34 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     mchehab@kernel.org
Cc:     sean@mess.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] media: imon: Remove the unneeded result variable
Date:   Tue, 30 Aug 2022 08:30:27 +0000
Message-Id: <20220830083027.276291-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value send_packet() directly instead of storing it in another
redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/media/rc/imon.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
index 735b925da998..5edfd8a9e849 100644
--- a/drivers/media/rc/imon.c
+++ b/drivers/media/rc/imon.c
@@ -684,7 +684,6 @@ static int send_packet(struct imon_context *ictx)
  */
 static int send_associate_24g(struct imon_context *ictx)
 {
-	int retval;
 	const unsigned char packet[8] = { 0x01, 0x00, 0x00, 0x00,
 					  0x00, 0x00, 0x00, 0x20 };
 
@@ -699,9 +698,8 @@ static int send_associate_24g(struct imon_context *ictx)
 	}
 
 	memcpy(ictx->usb_tx_buf, packet, sizeof(packet));
-	retval = send_packet(ictx);
 
-	return retval;
+	return send_packet(ictx);
 }
 
 /*
-- 
2.25.1

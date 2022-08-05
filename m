Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD43658AA66
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 13:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240603AbiHEL47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 07:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236059AbiHEL4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 07:56:55 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F637646E;
        Fri,  5 Aug 2022 04:56:54 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r1-20020a05600c35c100b003a326685e7cso3813362wmq.1;
        Fri, 05 Aug 2022 04:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=GtM/cD7hflcv6BD0/3bodvkpI0nOjm8qfPi0VHcfBA8=;
        b=GQCxOQ9ymOiXtZRK5e3o3fqq3FRHxzS+LX8p/DO5szFAXxNc0eflCk59DGneDzPMJA
         8T/TzsnPGz/HjiT/6kUrffGCTgcqb9r/wGCZGG+ZrCXdH1S/Yp7Ro50FFysg3pzb+iVy
         bx5rL2lGTC8tzdcVt5iDHHSJsidzmMgF7xjQFRk6J2x3m8lOvgxkxegpfGm3kxpGa06C
         O3WQGolRr9lQwuXj3WPh77go0vp4tRw9LyL8DdEcVYWbGrv2Eq5HXhAQeU03D40I843+
         wcyPd5lVJrpJmrWUYjty40nuRMIuduErV3RFyTNPpqE/OrvVqAJi7kUDEHHYgxWd2dNO
         Z3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=GtM/cD7hflcv6BD0/3bodvkpI0nOjm8qfPi0VHcfBA8=;
        b=cd/vnEXxpeyWyC+V7HoqX7/+stdq7thouqyWRlZv0av/v6hoTz8YOheJEEoXzumNdl
         0jPkTWqH82lY2u2W4nGZYdvsmwij9LTxDHGpRNLrixQB+f6E73g1DoAlUXlrGxYMCxbn
         dVAsj6O1Hav+PPmBlHoMgVkH3tt+YQyhT3FGHPeCZl6WRogF5+IEaHXFsJWVQxnb/IiT
         vYDdr5k0VEKLePnMtEIh3b6WwR+JcPfmvIpWU/qCHgJXV1NE4GBx07EuSVSJ6Q6Ip9vP
         2E6IVU9ud1LkH7ux+jTQB1LbK5TaTlBo98e7RVhRXKuJ7PYZZqcV3XmJO8wWx2eIrghH
         jQzQ==
X-Gm-Message-State: ACgBeo2sicjurEzSo/48wCpOHh5dH1e6n1oz5BSKs5wDMNBrOI3gj/6d
        o2IPGEQO5YK2EjtQZmcIVHhLWg5N3HYInd0G
X-Google-Smtp-Source: AA6agR5CaTanmJoi83t6yf9QMs9jyIizyAaIYrJvx6dNOdWDPmKbY11fIfYuAHeW5xn6H8e8oUaKxA==
X-Received: by 2002:a05:600c:501e:b0:3a3:4a04:fdb5 with SMTP id n30-20020a05600c501e00b003a34a04fdb5mr9556965wmr.168.1659700613091;
        Fri, 05 Aug 2022 04:56:53 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id i17-20020a05600c355100b003a2e92edeccsm9108432wmq.46.2022.08.05.04.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 04:56:52 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     =?UTF-8?q?Kai=20M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: st: remove redundant variable pointer stp
Date:   Fri,  5 Aug 2022 12:56:52 +0100
Message-Id: <20220805115652.2340991-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Variable stp is assigned a value that is never read, the assignment
and the variable stp are redundant and can be removed.

Cleans up clang scan build warning:
drivers/scsi/st.c:4253:7: warning: Although the value stored to 'stp'
is used in the enclosing expression, the value is never actually
read from 'stp' [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/scsi/st.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 850172a2b8f1..65f521b036c1 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -4246,11 +4246,10 @@ static int st_probe(struct device *dev)
 	struct st_partstat *STps;
 	struct st_buffer *buffer;
 	int i, error;
-	char *stp;
 
 	if (SDp->type != TYPE_TAPE)
 		return -ENODEV;
-	if ((stp = st_incompatible(SDp))) {
+	if (st_incompatible(SDp)) {
 		sdev_printk(KERN_INFO, SDp,
 			    "OnStream tapes are no longer supported;\n");
 		sdev_printk(KERN_INFO, SDp,
-- 
2.35.3


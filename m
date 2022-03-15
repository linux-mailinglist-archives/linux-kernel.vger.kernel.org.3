Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8614DA469
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 22:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351237AbiCOVQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 17:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241843AbiCOVQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 17:16:22 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68B55B3F2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 14:15:09 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id kj21so467985qvb.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 14:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=northvilleschools.net; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=zt1OL2xVjdGJFHy645jKL0xvPay0033GOEEzUn5jKUk=;
        b=JA2HFkl3fdUjf7ZUvsQjSrBfMjNMYm45ExJngSlwKbgHuGZ6gAuggePkU4GaS8G5Yr
         t8t2rv8yK6YrP9CocZTAS0BYabjqpfxeY5+jmITqSPQk+0b6fhvTh0JqkF7/C8qPwFyG
         UUB9U+111KZI9Cc2+4klhNj0Y8XBX2GGkYUcAW9RyRlq8+zpUDBXxyK9Tg9JGtzBstW1
         608BqV+ykIUOjhq3hp4PXJ8YlAZKNJE60W7acWsABP79xoipU3EedX7I/xw6w8WCuhOC
         9tx79V8FOskkWxFrwBlhootPqYh/siYqpVnB7BDm3DBWM71JqCSMR41Ftww2nQqVTCXm
         velw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=zt1OL2xVjdGJFHy645jKL0xvPay0033GOEEzUn5jKUk=;
        b=Cq9Trx1Uny3zvzBYuAS03A3NJhtbKe/SLRaYKM1FK7njA51ZKWUybePkwrjsEq2PRS
         RM1GEFICaf981g3Icy3qimBpamx7xEkyHXUmpC9c2DzPFuDllf7yzmsOzhyWECNm3tMu
         8k2+mepeE9+jhY5CqUqv/X2kA4RyAjoHflbwDE1uH4EMsKIPEWrc5WF34VTivzegam+A
         okucpwo0YzRGwB9liIAxtl2Icro5i9g//xLiDqsG2Lb69hQyeh+G1Ww8WsZgTc5ToTAa
         H21/bjjVW72zDUYOXQbW9SCFENvujZXCJeN1MT8iy1H3ngG8nAFfdfYj9pkbMiUu9E0X
         yU4Q==
X-Gm-Message-State: AOAM530v6wtdFoYNob2A7d/6m6rmkhSwI1iAhN0RtT1Ihe2qSM5q21SH
        5E+tXl9zCZEByGUr8Xyb2fbf3GgHOkkvSdPlCzk=
X-Google-Smtp-Source: ABdhPJw92dYbx3bTvF1/mjzabEzXu4uY4Sg0EurCPJyw1tU73GVyCe9WguChpVIbDumk5rWpihQtqA==
X-Received: by 2002:a05:6214:2309:b0:435:374d:4bbb with SMTP id gc9-20020a056214230900b00435374d4bbbmr22022590qvb.105.1647378908702;
        Tue, 15 Mar 2022 14:15:08 -0700 (PDT)
Received: from sckzor-linux (d4-50-247-168.col.wideopenwest.com. [50.4.168.247])
        by smtp.gmail.com with ESMTPSA id k10-20020a05622a03ca00b002e0684cf81fsm58022qtx.73.2022.03.15.14.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 14:15:08 -0700 (PDT)
Date:   Tue, 15 Mar 2022 17:15:07 -0400
From:   Charlie Sands <sandsch@northvilleschools.net>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rts5208: Resolve checkpath.pl issues.
Message-ID: <YjEB27xzf+krm3ew@sckzor-linux.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Always test-build your patches. Applying this change results in a build 
> failure :(
My apologies, I ran a build test on a copy of the repository with my changes
stashed in order to look at the original checkpatch warnings.

> Please fix up and resend.
It should now fix the below issues without build warnings.

WARNING: Unnecessary ftrace-like logging - prefer using ftrace
+ dev_info(&dev->pci->dev, "%s called\n", __func__);

WARNING: Unnecessary ftrace-like logging - prefer using ftrace
+ dev_info(&dev->pci->dev, "%s called\n", __func__);

WARNING: Unnecessary ftrace-like logging - prefer using ftrace
+ dev_info(&pci->dev, "%s called\n", __func__);

Signed-off-by: Charlie Sands <sandsch@northvilleschools.net>
---
 drivers/staging/rts5208/rtsx.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx.c b/drivers/staging/rts5208/rtsx.c
index 5a58dac76c88..2284a96abcff 100644
--- a/drivers/staging/rts5208/rtsx.c
+++ b/drivers/staging/rts5208/rtsx.c
@@ -159,8 +159,6 @@ static int command_abort(struct scsi_cmnd *srb)
 	struct rtsx_dev *dev = host_to_rtsx(host);
 	struct rtsx_chip *chip = dev->chip;
 
-	dev_info(&dev->pci->dev, "%s called\n", __func__);
-
 	scsi_lock(host);
 
 	/* Is this command still active? */
@@ -186,10 +184,6 @@ static int command_abort(struct scsi_cmnd *srb)
  */
 static int device_reset(struct scsi_cmnd *srb)
 {
-	struct rtsx_dev *dev = host_to_rtsx(srb->device->host);
-
-	dev_info(&dev->pci->dev, "%s called\n", __func__);
-
 	return SUCCESS;
 }
 
@@ -968,8 +962,6 @@ static void rtsx_remove(struct pci_dev *pci)
 {
 	struct rtsx_dev *dev = pci_get_drvdata(pci);
 
-	dev_info(&pci->dev, "%s called\n", __func__);
-
 	quiesce_and_remove_host(dev);
 	release_everything(dev);
 	pci_release_regions(pci);
-- 
2.35.1


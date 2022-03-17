Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9B04DBD41
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 03:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348007AbiCQCyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 22:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237023AbiCQCya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 22:54:30 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9174FD37
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 19:53:14 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id i4so3411082qti.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 19:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=northvilleschools.net; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=hOTvV/BSKqVkGgoGdzHd4gweYpV9pcJ3dB6vvIoE2gU=;
        b=BVTlqSXDh/6F0/7cr+KPmDGtn27xHshwmogWqP00WdmxLteEOSwZlNSaJOBLvd+qb8
         qDa/rgK6dn+meP1EArL1V2duBZi3GoiYWlb3tRa7rbmwb3AVfAY0EjJiPH4g58yZwV+j
         hXQ6fFN9lyxmI35PDNl0E7mn2MH1ILNXdkVdC8FVSw+vvZPTwQlgpKZXPpOq7eQnaUp9
         A1YNDqvQ1teAgSYR/v6hGxb/FJTFaSYmMjuxnUReFY/sUGPw16VtSK7XCc1CCT5OPs5r
         +5IrEj060hA7qwHGOCxcOm+3D2dSqsAPi98UwulgRarYityfafdUH25Swou844UKQNCa
         bUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=hOTvV/BSKqVkGgoGdzHd4gweYpV9pcJ3dB6vvIoE2gU=;
        b=PvTj7753zXOWoSel31uBvd5cTAOF2wB7/czCfQmkBFzxMJH1KPpGgY2ArF9Du1hPMI
         sEfb0lQh3JYmtOk+uk4U7JlMRwT3JjaYBtgbl86OR16cM/uT6RTc6UfMuQ7jFY5ThCRa
         cIeF4SndXRha4MUwQR9nmLM+HbBcNT1JAYzHGar3fPiDhVlh5aLrbh8Z5hFT39PNMEAj
         rIJ3iO16pKORpmQxMUC3PlwTHuVF+dd6tw7fbT034anVrVZBWZzdYD10SNxekGNIUeua
         ivuVl3xo/cRVTCN8ZnR6Px5BQ5guFSMzJOTgxPt832W9jvvnDx1Zoh9OrolFcO6Th4v2
         UilQ==
X-Gm-Message-State: AOAM531jCZdvU76QAhpgR7sEQy2ehieDE7L7PR/Urv2PY0A3V8WBGj1r
        T1bRtd/TzSPnwp6gFOjcHl25hzbYwLYM/O5PGdY=
X-Google-Smtp-Source: ABdhPJxcSCr7rDUc/YBUZSvGfZQOTDxzd+GR7tv+xBZ0n9tA0G7tmJVSHCMEVmU70JPw4w7J13sEYA==
X-Received: by 2002:ac8:4b61:0:b0:2d1:cfc7:2989 with SMTP id g1-20020ac84b61000000b002d1cfc72989mr2184228qts.416.1647485593603;
        Wed, 16 Mar 2022 19:53:13 -0700 (PDT)
Received: from sckzor-linux (d4-50-247-168.col.wideopenwest.com. [50.4.168.247])
        by smtp.gmail.com with ESMTPSA id j4-20020a37c244000000b0067d79a3fd0esm1817540qkm.106.2022.03.16.19.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 19:53:13 -0700 (PDT)
Date:   Wed, 16 Mar 2022 22:53:12 -0400
From:   Charlie Sands <sandsch@northvilleschools.net>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH V2] staging: rts5208: Resolve checkpatch.pl issues.
Message-ID: <YjKimAdiRfRVfGl8@sckzor-linux.localdomain>
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

This patch removes unwanted use of dev_info for ftrace-like functionality
as suggested by checkpatch.pl.

Signed-off-by: Charlie Sands <sandsch@northvilleschools.net>
---
V2: fixed bad commit message and compiler warning

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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4EBA5A2559
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244690AbiHZKCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343716AbiHZKBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:01:31 -0400
Received: from smtpout140.security-mail.net (smtpout140.security-mail.net [85.31.212.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D781ED5996
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:01:29 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by fx601.security-mail.net (Postfix) with ESMTP id 53A243ACEDD
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 12:01:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1661508088;
        bh=SCDpeIxVyYrv4kQNpVeu9eSc75msKnazn+ZKlH00Qhs=;
        h=From:To:Cc:Subject:Date;
        b=ntkYtSdvKd2e/vfTvdKnWB8GqJvlxkzB/PJvcZmEx+VzRD2TEMeMBMU76UUzCXP3n
         VxklrdrXEz5RURA8yyZ3qPsMouMtF2BmoX9u1wxT9L8QoMDxZbYe5erQX3xtijmAPY
         h/K7wMTSb2+53p4CT3UcGdBAjL0B/DHNCQkuOFjQ=
Received: from fx601 (localhost [127.0.0.1])
        by fx601.security-mail.net (Postfix) with ESMTP id 950463ACEB9;
        Fri, 26 Aug 2022 12:01:27 +0200 (CEST)
X-Virus-Scanned: E-securemail
Secumail-id: <5f8a.630899f6.c2f5d.0>
Received: from zimbra2.kalray.eu (unknown [217.181.231.53])
        by fx601.security-mail.net (Postfix) with ESMTPS id C46AF3ACEA3;
        Fri, 26 Aug 2022 12:01:26 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTPS id A718A27E02FA;
        Fri, 26 Aug 2022 12:01:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 90AAD27E0392;
        Fri, 26 Aug 2022 12:01:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 90AAD27E0392
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1661508086;
        bh=NaiqwpRbXRdjsNpz1W2XnsBstSv/EPGUYAQ6UVixNRI=;
        h=From:To:Date:Message-Id;
        b=CrvT1Yda4Cy03jf7mLVYm3A34sAUXbvdJdiZ6S9TKuhCxm8vouJ+kpZngmBuUkDOc
         YhcTcfGlNvBV2p7UJnbwAG5O2JmRwJ2v5L8WUzjUNgGrq1a1Z+1ZyOk950oLICzNiw
         kSstF6EKR8/gSIkUgMmoWXrQjdQyz1AudI15K4mc=
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9n1S3QpK0Pxj; Fri, 26 Aug 2022 12:01:26 +0200 (CEST)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id 7766127E02FA;
        Fri, 26 Aug 2022 12:01:26 +0200 (CEST)
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Jules Maselbas <jmaselbas@kalray.eu>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org
Subject: [PATCH] media: i2c: Fix repeated word in comments
Date:   Fri, 26 Aug 2022 12:00:50 +0200
Message-Id: <20220826100052.22945-22-jmaselbas@kalray.eu>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: by Secumail
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant word `the`.

CC: Jacopo Mondi <jacopo@jmondi.org>
CC: linux-media@vger.kernel.org
Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
---
 drivers/media/i2c/mt9v111.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/mt9v111.c b/drivers/media/i2c/mt9v111.c
index 2dc4a0f24ce8..7beca0b70b72 100644
--- a/drivers/media/i2c/mt9v111.c
+++ b/drivers/media/i2c/mt9v111.c
@@ -633,7 +633,7 @@ static int mt9v111_hw_config(struct mt9v111_dev *mt9v111)
 
 	/*
 	 * Set pixel integration time to the whole frame time.
-	 * This value controls the the shutter delay when running with AE
+	 * This value controls the shutter delay when running with AE
 	 * disabled. If longer than frame time, it affects the output
 	 * frame rate.
 	 */
-- 
2.17.1


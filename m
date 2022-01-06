Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5869548618F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 09:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236892AbiAFImm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 03:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236839AbiAFImc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 03:42:32 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51ABC061245;
        Thu,  6 Jan 2022 00:42:31 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id u20so1929139pfi.12;
        Thu, 06 Jan 2022 00:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yt0rtZoVf/LFU96gxwDi5D6C9OB9ceL1t7u8+Oncfhg=;
        b=XNb74cgNPAWvdk2PghjCprJe0xxYmSb0Ayh8CJ46Tro1mzO6k22rEpFuPHtTM7N9G7
         GinjHvictuSMtNiPpvZjG+YtIY6ZMqchNfmyFqdxVqM2mCuyNwmYV0ei4gYDbhbzBel4
         nDvKCiWpew53QXCEznn1oaY3yJkD7JIzVRqtivRcVlAElDi2B5r/8OE7lqv85qavUM96
         FHXEqQxg+9Wrx/ECeInAxD3Lvgk+SQVrQ5eILQCyfzud6FxLHKWQRQJV6fEjyTkxqQy8
         kg04OuG3P5UZO3Jm35wIGvjCJRoq8wWlISvxQUHC4ED6yZkmEmUJYi5smefHDszg49tT
         Jk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yt0rtZoVf/LFU96gxwDi5D6C9OB9ceL1t7u8+Oncfhg=;
        b=MJm/yjFskb3SJiLxVvMLoGH9af19dFiMeapDns5JGJAS/B1hJc3TIx+AbyrL1XwJta
         CZPaGxP8RuiO7LbJ9nXEUjVFFiFOn2k975M0fZkmtS0Pr4mnBuaqdCOMxJ/SOd1gz8JJ
         tmCGUlYZDHReDb6bwfRgfKRhpCNavX4ppcjMGAjXTVz6isqVyf1s34YcrVmcuLKLSXIP
         J+n3jdggNBDOl0/Y5OR4tcNh+01Mm/UX5KpUuMpPGLkf5rPe8KnZP8pj7nCdwBgIg+6D
         ec7vtYmncDIQ6zziojyZJhqYlq81yWAr0lZEY1T82cpyPnk/BrmQ4cEdJoF0BTn27EIu
         INVQ==
X-Gm-Message-State: AOAM532/3+wgbGwr1u+0Sge3G/0BcARLDUmxcxBpADwS/vusmBlILpSu
        K18tqDgIA/8K2ob4uMU4Efg=
X-Google-Smtp-Source: ABdhPJxiL4Id4MVmdReZ96UdALca1Yhtw4nImcfjBO2n/RsuyBNfCPuGMPqyd87/59K92lRspbn//g==
X-Received: by 2002:a63:b245:: with SMTP id t5mr5981223pgo.231.1641458551416;
        Thu, 06 Jan 2022 00:42:31 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.151])
        by smtp.googlemail.com with ESMTPSA id mu2sm1696200pjb.43.2022.01.06.00.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 00:42:31 -0800 (PST)
From:   Qinghua Jin <qhjin.dev@gmail.com>
Cc:     Qinghua Jin <qhjin.dev@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: ti_am335x_tsc: Fix typo
Date:   Thu,  6 Jan 2022 16:42:14 +0800
Message-Id: <20220106084215.355295-1-qhjin.dev@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

change 'postion' to 'position'

Signed-off-by: Qinghua Jin <qhjin.dev@gmail.com>
---
 drivers/input/touchscreen/ti_am335x_tsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index 83e685557a19..d77555e0571e 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -310,7 +310,7 @@ static irqreturn_t titsc_irq(int irq, void *dev)
 			/*
 			 * Calculate pressure using formula
 			 * Resistance(touch) = x plate resistance *
-			 * x postion/4096 * ((z2 / z1) - 1)
+			 * x position/4096 * ((z2 / z1) - 1)
 			 */
 			z = z1 - z2;
 			z *= x;
-- 
2.30.2


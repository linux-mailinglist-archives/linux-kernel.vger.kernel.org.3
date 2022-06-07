Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7692542346
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241584AbiFHCXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 22:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444908AbiFHCLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 22:11:41 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10C319EC3A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:26:37 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id i29so13079038lfp.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 12:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7a/Vr1nOHr0fdDem7DkzJVpMhvssXRRyxw7xup5e79I=;
        b=DfruFfsNeZwf5QHWRX3tl2wx4WCbK5YG3dRedjaUTJcnKKzbeWm3OI+O6GWuK1V8WZ
         R2cVADOtKEjE6rwstxA/aSOEX84upsZTEltFqI1i4cDc9pt32h9ZI2ZTikTBmoANe6rQ
         Fe9AQ4otShRqgXhtohsBeMtR/tJktVZhA+HpLrvI3D/5g08qT8vExdO4ei/rWac7lDND
         8hZS3mL6zwKyrdiK13QeXtpqKCYXJ6gEMpG+duT/YJ3HGrHk18KGzw9M1c5QSmzYRCXx
         sAhtBQvKehi2NrqQdfTFSzkitswebZAXA9ycCxWqPcPSY0t5z2DrqoVAX1ByApVeS7Qi
         g6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7a/Vr1nOHr0fdDem7DkzJVpMhvssXRRyxw7xup5e79I=;
        b=4WRmnQXYiXQpmzZpsbgLNLoVb8vWjZlssO3lAZBUwJg917m6eV3sL0Kcuom29gFEdM
         /V39kk8h/4MDc7hQ0v/qzpvaoVkJw0pbg7eFdLJ8QFyinno/GRxYgfmW5c4ZXziHpA03
         TbrqvyHhs/JjZuyyOo1mtrG5w169fF+pqWQ5abB4ZM9H1tIE+I7NR66J3w4K+7EqU6ip
         9RvJk5zSE4dTVvKmRtms8BjbWmoRFrdQ6LbmWNOfDUTJKmiRPwFMsEvLS2VJRkjPU0LF
         9srbgvaJV+I1F/bVD3DP/6MgNBHXVG8LXSknIxhW7I409aiRXzboqlNcaLHGKiLsYk2z
         Yomw==
X-Gm-Message-State: AOAM533wj1gEwgD9g6jA5fmec0CegYc44859Q3lnAQcWr1ufnhBaQ4DA
        JUi0V6gegVXbWJpKqfXil4Q=
X-Google-Smtp-Source: ABdhPJwrX47Y3YIqgEzQI+Z6/heU8hdGTYhoZaqHpiJucG3APs43e/cTPUq4MmfmFa90H7KIPhnkew==
X-Received: by 2002:ac2:488b:0:b0:479:2674:f1b0 with SMTP id x11-20020ac2488b000000b004792674f1b0mr11586089lfc.118.1654629996066;
        Tue, 07 Jun 2022 12:26:36 -0700 (PDT)
Received: from localhost.localdomain ([94.103.229.27])
        by smtp.gmail.com with ESMTPSA id t28-20020a05651c205c00b00253b24a90b6sm2982603ljo.17.2022.06.07.12.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 12:26:35 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com,
        dan.carpenter@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH v4 4/4] MAINTAINERS: add myself as r8188eu reviewer
Date:   Tue,  7 Jun 2022 22:26:31 +0300
Message-Id: <d6f6420a0d5ceff6bb50d268023f7d2e117027c5.1654629778.git.paskripkin@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654629778.git.paskripkin@gmail.com>
References: <cover.1654629778.git.paskripkin@gmail.com>
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

I was reviewing r8188eu patches for a while, but I am missing some of
them, since I am not in CC list. I want to be CC'ed to help reviewing
and testing more patches.

Acked-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Acked-by: Phillip Potter <phil@philpotter.co.uk>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a6d3bd9d2a8d..60e5e4007844 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18920,6 +18920,7 @@ F:	drivers/staging/olpc_dcon/
 STAGING - REALTEK RTL8188EU DRIVERS
 M:	Larry Finger <Larry.Finger@lwfinger.net>
 M:	Phillip Potter <phil@philpotter.co.uk>
+R:	Pavel Skripkin <paskripkin@gmail.com>
 S:	Supported
 F:	drivers/staging/r8188eu/
 
-- 
2.36.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75791466A5E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 20:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348572AbhLBT0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 14:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237532AbhLBT0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 14:26:40 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E54C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 11:23:17 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id g14so2069738edb.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 11:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mfKnny9KVQR03wUe/TjPaew5YqnQrIYv/BbMYPEX/1U=;
        b=CoxXgjtTG7vUL/q8+NRIbn0VGZmAxln8NpMPooVqx6dUxTtA5LNnvJ6CvQEEfU/XgN
         T/Es89MqUKNbDKa6Qa41lXciCGiD9q5UTPU5eqrlIt4zj6xG+aWcuqFFhS1rxR8aJ4dG
         evnrYLdB8yzNvFBeab4A/sRU42EYUMu0+lPa3sVJohAP/neuSooib08JY8151BMTytx2
         5hYgEf7vlxvabIbKN7ZaT8IfX296tGIi0nwSjx6kzKUwRLWHlr5OdG9QF5AnorC0DdL/
         L4m+BSerUCFMXjLVcYRDmOZJCBgSbRQe18C3HgXBeoJ2S+BCfxohG7ZC+LZ09y0WS4pb
         TOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mfKnny9KVQR03wUe/TjPaew5YqnQrIYv/BbMYPEX/1U=;
        b=ZA7rmBm+916wm6anachRIZd6EGmUJbGNFAl6pLXlWL10mdJ1K++GeP+hKg9hn2kJFs
         eYnYGQTgICTIUd9jQ6Vyd7Iu/Q/iLbvdlOeC2bIYp7FCryz2YGDD+I10vfLWTqOAFKyB
         JOrW15VhbXQx9GyLzukkuhUREi895vJNGehAy9E+VK3b8gx3lzL98O2l5Vy9DHYe486A
         Vp2Dk+o5XH7/9wJ1A6sIwVvyY2SEiHBtsq8qVLVKRWXJnUeMckc68mKUVtLtko51IUe+
         Y5X3py+72XpiHuRgmfAvLEdkSsevfVvyDxeRmZWl44rjJs5szk5jhzqeRwwscRiSHlr0
         FtAQ==
X-Gm-Message-State: AOAM5309KmUWF/dtUDvbaW4KOhf6AZsQ9LHZIR3ExBNMo/AUHtb7lbGl
        I5wcceQen0eYG1+rcWoz+Ok=
X-Google-Smtp-Source: ABdhPJx0GBFZgjEPftkpPHJx/kv1itUDZURNwpTtuuFx3Tv5mGeTKaS8rqdGaoe6xQbbZUieIOjgHA==
X-Received: by 2002:a05:6402:134a:: with SMTP id y10mr20120777edw.241.1638472996301;
        Thu, 02 Dec 2021 11:23:16 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::5a05])
        by smtp.gmail.com with ESMTPSA id jg36sm432530ejc.44.2021.12.02.11.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 11:23:16 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/5] staging: r8188eu: odm cleanups
Date:   Thu,  2 Dec 2021 20:23:04 +0100
Message-Id: <20211202192309.9362-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes unused and some set but never used variables
from the odm_dm_struct structure.

Tested on x86_64 with InterTech DMG-02.

Michael Straube (5):
  staging: r8188eu: remove unused variables from odm_dm_struct
  staging: r8188eu: pbNet_closed is set but never used
  staging: r8188eu: pSecurity is set but never used
  staging: r8188eu: pNumTxBytesUnicast is set but never used
  staging: r8188eu: pNumRxBytesUnicast is set but never used

 drivers/staging/r8188eu/hal/odm.c         | 12 ----
 drivers/staging/r8188eu/hal/rtl8188e_dm.c |  4 --
 drivers/staging/r8188eu/include/odm.h     | 73 +----------------------
 3 files changed, 1 insertion(+), 88 deletions(-)

-- 
2.34.0


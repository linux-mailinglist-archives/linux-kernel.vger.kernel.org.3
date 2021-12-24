Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793FE47EEC1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 13:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352652AbhLXMLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 07:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbhLXMLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 07:11:16 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A46C061401
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 04:11:16 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id x15so6550609plg.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 04:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eLRsIPs2YlObaX94PJ2gtnsp2s66ALN3C2c1+XvIaAA=;
        b=LJDZsQ7rVTVbdZzMSvllJ2ILUIgHVKV2b9P1Y/Mu2j80ULnPrnUK3JeUbwPS/Bo8Cs
         wcoAoVpLTbdRDa0y4R/K6K30413Ox9cEJmzgkVfBNhdhVW6Xs9+Ho7VvfCqjEvFGD1i+
         3cXZuuW6AnPAABGURM3oUdSWb2M9M4qTEKsUNla7OSy5xF2IbfoRQdWDtAnx2OtZoqci
         SzWihexL6btxoBM+r9TpWYviAJoqW8VB7X8tWE43NmxlXBa9saD/z/+f3hfq4nG1umFS
         zZ396rYVT3LntD6rP0+fl6csSIoY9Rs4xDZpMIC/Hv+QW77NRj2+5xCI8sldGMB9YBjv
         fm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eLRsIPs2YlObaX94PJ2gtnsp2s66ALN3C2c1+XvIaAA=;
        b=XrFH/8ZhLjeyhWuSjrSf07K8yeEUkKO1hGcUaCyXmPdtS5MKnwKr+/Wj9kph6Yo7Ye
         7kz15pArBoHHv9iucEEQFrMPnPMcn0RVIi0MGfkjppoCvo2E+2atgryV0IwS7CzNbq0e
         AFX229+nABjQt3LgsvrRYbwbkwOaeQshkRI8vNdx1GOb76AySLOZwlqyJfsdoBPcH6DJ
         KnQGj4VNG3ycFrU835IUxiFNUztozhrFlyMeqmpMPEAHy0+IjT+PENen/uR2r1l6qw8F
         o+CgrL9I6hQbmfjW+gEeAU79AG++CJ2oA3pCfdBHXDNrrmLxy1lK5YBe6e24b0mgVWnH
         izZQ==
X-Gm-Message-State: AOAM531T6Vq0AHQKj6qhFmcdorskXaQHSLlPy4kuvwDXFyy36zFeVJk9
        wC/50h5D4jUhrXQDrECSamcXXjPCSnQ=
X-Google-Smtp-Source: ABdhPJwVKis/iBpumb86o3yaM2fzVdi4PSkxzjKNzY2lHBVVSiauCuKydNExi9UYyvL2yFd3o0OL1Q==
X-Received: by 2002:a17:902:8a84:b0:148:a2f7:9d8d with SMTP id p4-20020a1709028a8400b00148a2f79d8dmr6374310plo.172.1640347875602;
        Fri, 24 Dec 2021 04:11:15 -0800 (PST)
Received: from localhost.localdomain ([122.164.161.127])
        by smtp.googlemail.com with ESMTPSA id h17sm3729047pfv.217.2021.12.24.04.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 04:11:14 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        abdun.nihaal@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: r8188eu: include variable declarations from Hal8188EPwrSeq.h
Date:   Fri, 24 Dec 2021 17:40:43 +0530
Message-Id: <20211224121043.175650-1-abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable declarations of rtl8188E_power_on_flow, rtl8188E_card_disable_flow
and rtl8188E_enter_lps_flow are present in Hal8188EPwrSeq.h.

A previous commit changed Hal8188EPwrSeq.c to include HalPwrSeqCmd.h
directly instead of Hal8188EPwrSeq.h, causing these sparse warnings:
- symbol 'rtl8188E_power_on_flow' was not declared. Should it be static?
- symbol 'rtl8188E_card_disable_flow' was not declared.Should it be static?
- symbol 'rtl8188E_enter_lps_flow' was not declared. Should it be static?

This patch reverts the include line to include the declarations.

Fixes: 4f458ec5f497 ("staging: r8188: move the steps into Hal8188EPwrSeq.c")
Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c b/drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c
index 566a1701302c..6505e1fcb070 100644
--- a/drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c
+++ b/drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2007 - 2011 Realtek Corporation. */
 
-#include "../include/HalPwrSeqCmd.h"
+#include "../include/Hal8188EPwrSeq.h"
 #include "../include/rtl8188e_hal.h"
 
 struct wl_pwr_cfg rtl8188E_power_on_flow[] = {
-- 
2.34.1


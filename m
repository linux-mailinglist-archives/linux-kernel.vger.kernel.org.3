Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE00468C59
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 18:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbhLERSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 12:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236589AbhLERSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 12:18:03 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315FEC061714
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 09:14:36 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id l25so33340100eda.11
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 09:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HPuzYR8QORZOgJOB4QKAyq9QStxUBqC+STv8VWMkX4c=;
        b=CG2HB7LopIBU5jwG6lIma8FW/NdPPlyEWwA1lE084PT+MLH1MB3il3YcfV2VQVNidF
         1HeNC7dwnEwsUc+BzyOls/7s6awQEUPoo6jQH/VfNmzM6kfqP1L4OOH1MJPasTTfrmar
         ZMV0IyB5+bGEUTS7+7Xl58k6QU8gMzZaC/9sJBHLVhdllTch+CKBMAWX2MpiOxbhcrMI
         gkxeIfVvYnGpIRlqSUORCVcqKKkKzbI3O0x08p6b799Cg0ded/c0UULvyNYrIAK3qbT0
         dh+Xc/m4uJUpkwaaW+nBRTD5EN6y9Qs78nc9rRv/88lWy9MzLfmuZz+1tQ+w2U5X7GnU
         EQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HPuzYR8QORZOgJOB4QKAyq9QStxUBqC+STv8VWMkX4c=;
        b=lLfVbLFw2untIZRtExSII0lTn6eXJ0I+O+bFcgBkxoUlpQdgJVVn3cCbXLcUFnMiGo
         n6nlVUU0J6yL8yoCCYAEfopYUTTKTLNOayg2KweNKXmdAkHeGHL/CNl/fV4xeTVeA7FF
         somZtNnMkpbGpveXbQp2r4dYYBJdok0woE0a5VzDBrHWxZUY/YKwX/TPicEfp4Hpvzk0
         D5g3FMQ+yRrwERRM5dRL4qEqnwbiL3Y65hCqpUtX+FTQZ0z+xqTbnMfumdhJIt+vRqxK
         DT+v4ZgQwev4+6tHUgc1AlPKGjr6FoFQ7Dd3rwjoFzo0b0Pl5y+Qy9r/O8fvxCrLF3kB
         Eseg==
X-Gm-Message-State: AOAM530IRsYfwE2M2Pxa8UzRnBalgof77CpVm9ULyxoJh7U5AcaA4+d0
        1G3Fe5V/9T9LdK6xLfgO6aA=
X-Google-Smtp-Source: ABdhPJwGbG9giBBeKm09u0oBeCOBmzzHQA266FTsJZ0fTqrJJBIREfPRX8Nm5fiF/1M/6sXSiXGaGw==
X-Received: by 2002:a05:6402:4312:: with SMTP id m18mr45812945edc.273.1638724474823;
        Sun, 05 Dec 2021 09:14:34 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::b792])
        by smtp.gmail.com with ESMTPSA id ch28sm6071773edb.72.2021.12.05.09.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 09:14:34 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 02/10] staging: r8188eu: struct odm_mac_status_info is not used
Date:   Sun,  5 Dec 2021 18:13:34 +0100
Message-Id: <20211205171342.20551-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205171342.20551-1-straube.linux@gmail.com>
References: <20211205171342.20551-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The structure odm_mac_status_info is not used. Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/odm.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index df232867eac8..f83b94a74b70 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -176,10 +176,6 @@ struct odm_per_pkt_info {
 	bool	bPacketBeacon;
 };
 
-struct odm_mac_status_info {
-	u8	test;
-};
-
 enum odm_ability {
 	/*  BB Team */
 	ODM_DIG			= 0x00000001,
-- 
2.34.1


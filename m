Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBAB47F851
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 17:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbhLZQrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 11:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbhLZQrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 11:47:12 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8E3C06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 08:47:12 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id f8so1683229pgf.8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 08:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ansSlz8HDsJB8ecrOJ3F72s+yUKx5QSDGORnGt8rLcg=;
        b=LTMafr+N1w+Gnu1qx/mswRZsY++dpxOT1v/3jtQOnzAAiDCVlm/Rw9C5qFtLrEo9Uh
         YNOk1Gz8KnuYJMLKjFi1VLkduP63K7hhYL7Z7UZQVKp6qxTjhimXCRa0PaX7qcpTa83R
         Qvg9K/MGDoE/KfTydpyETWdLQNfEaMWM3ZuwHC7mvxPG9qjJpyDERY+7jNT1a/1FRcsc
         qXCsj0C7huUmVT0KTMF0q1+vWYopFY0zokA0aiPW4Ssf7WE3Fk8DEgvJoQZxtOCGO9IB
         AQa2U6iY3ToVdFXfCszXz58sXKC4+0+lK79tnh4fzAtgSW+oenucTm9er+ZxMDsWqNHf
         3gwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ansSlz8HDsJB8ecrOJ3F72s+yUKx5QSDGORnGt8rLcg=;
        b=r7nkExMmmwpp7t8zeorxBVjQKDbvH5nih5jK0hhEPvCJVbCeMnLsVC/nkZQ7+/WlVE
         ha9d/8gym0EDUmoBiyA9NAwmjFXpXIVHf/840w4X82GLjvXrDWITyIfw11VjXqacaqX1
         mC8Ach4ArfPZcvaA1iJlngFjvZ0LXwAoZHsns7QqhlZ42K9MPONCiaKZLWzDYyW5v9jF
         1mMLba8ZRsbB/b/tVAeOAjh22QKzQfFwJ7LwxGK0geJGb3LNQs4IbjcwfWWodS6FInvM
         OwXR1hBMYFQoSTd5knUpTF3Tu4SGBg0yr+NGwN1y17o9VKgH0L56EHi8n8ltO368ELYN
         ouzg==
X-Gm-Message-State: AOAM532HsWU1hendZmXVYiC1bAFXaPIOhJPu7+OmaQm4mV4sKKA/h7Dn
        Ct1DxZbJRkrT12Uy79Q3EAU=
X-Google-Smtp-Source: ABdhPJy5FOMhkI4iy6O+TYeQ+qNRJhhIbEpvKYFdzOgbG+ObnTYy4gslK29ZKTC/77nLlYOZ7AIbqA==
X-Received: by 2002:a63:7d3:: with SMTP id 202mr12617172pgh.120.1640537231877;
        Sun, 26 Dec 2021 08:47:11 -0800 (PST)
Received: from localhost.localdomain ([103.230.148.190])
        by smtp.gmail.com with ESMTPSA id n14sm12236759pgd.80.2021.12.26.08.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 08:47:11 -0800 (PST)
From:   Gautam Menghani <gautammenghani14@gmail.com>
To:     nsaenz@kernel.org, gregkh@linuxfoundation.org,
        stefan.wahren@i2se.com, gascoar@gmail.com, ojaswin98@gmail.com
Cc:     Gautam Menghani <gautammenghani14@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] Remove repeated word in vchiq log warning
Date:   Sun, 26 Dec 2021 22:16:32 +0530
Message-Id: <20211226164632.48952-1-gautammenghani14@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gautam Menghani <gautammenghani14@gmail.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index c650a32bcedf..6759a6261500 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -1661,7 +1661,7 @@ vchiq_dump_service_use_state(struct vchiq_state *state)
 				  service_data[i].clientid, service_data[i].use_count,
 				  service_data[i].use_count ? nz : "");
 	}
-	vchiq_log_warning(vchiq_susp_log_level, "----- VCHIQ use count count %d", peer_count);
+	vchiq_log_warning(vchiq_susp_log_level, "----- VCHIQ use count %d", peer_count);
 	vchiq_log_warning(vchiq_susp_log_level, "--- Overall vchiq instance use count %d",
 			  vc_use_count);
 
-- 
2.25.1


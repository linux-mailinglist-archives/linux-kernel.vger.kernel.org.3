Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3868049E347
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241862AbiA0NXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241803AbiA0NWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:22:52 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A607C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:22:52 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id x23so5421718lfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xpVlgTajQnqvJqRBDECMdTOPT5OH4VewpY+I2k89SJw=;
        b=Fc7RyjvN2P/MMNY+073yQvT0fuI5+/QBlZLBP4WGdpj05lpGHeUbxdUbtfWtGgtSG8
         9ldcb8VjtZXqCtNgd7bg6/pLb357CdIJTg5lIpDepmG3aE4jGVmeR4ellyebalknS252
         uMETIjWVpmjcKxplVluodcNqbn0RjLFCmkDj/Wou99EjgiBBlk/Bed+9NnzfFj29JjiH
         ijUwOgRg8l0NNhIZcfYml4qunWGLqwCW05JGwI3vjuQzLjENs0tksQaI7dNhhlEleiWc
         U4yR8iMSI5wpkPSjK8/O6BdIZaZ6nN50szfAqQccYqfeKjCXq/B1ceBo5h9VcJxeMASo
         gEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xpVlgTajQnqvJqRBDECMdTOPT5OH4VewpY+I2k89SJw=;
        b=drXhYHbqp73I5KOey/lmDFwTm2RfoTa2aLcJMexvnlGW/7C5xNTSmE5woXgivNRJF7
         a5hr1unN0ufW9DOfdUvVd8yLfc4s8y9pguUqN0VNxTmlDzSZuu5hvLRUiOVCJGKTExD/
         NC5ntvCtTlYUtiCZFZM4Sy0NSpOhJ/sBa/4EA6jgDna0KxzMZZ1Dt2IqB/g4zNnORXIW
         VufDCsIUqYoHkMeHrky3jPiPUE0XC+0ROY9gptF6t/0LAD4YqAOl3mo7esf5B6hAtNp4
         o3cH9x+6QY/w/4Iq5HuLXkF+xN2NOsISu5Cm/QQwHijHD6Sg2DLuE+tHzPLyrbCzAXCY
         jwPg==
X-Gm-Message-State: AOAM530P6AnSomFpGwPVYiHZUlOmXWo5YM+buVZ4zzlVfF3KaZWTeiP3
        jCJWqh1E86r0Xjb1KtwkxnA=
X-Google-Smtp-Source: ABdhPJzeX3TZdWKhhlRjwG4LqWA2iq8Of5FsUyIyEWBOvklizbRwHs2mLSF1sgLqvjbEIbno0nwMWA==
X-Received: by 2002:ac2:4196:: with SMTP id z22mr3065815lfh.36.1643289770688;
        Thu, 27 Jan 2022 05:22:50 -0800 (PST)
Received: from elysium.toya.net.pl (staticline-31-183-166-172.toya.net.pl. [31.183.166.172])
        by smtp.gmail.com with ESMTPSA id s16sm1306918lfp.197.2022.01.27.05.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 05:22:50 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, mike.rapoport@gmail.com,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 09/16] tools/include: Add debugfs.h stub
Date:   Thu, 27 Jan 2022 14:21:27 +0100
Message-Id: <c1c09d86c80a72423d51c01fb26028902796d709.1643206612.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1643206612.git.karolinadrobnik@gmail.com>
References: <cover.1643206612.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a dummy debugfs.h header.

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 tools/include/linux/debugfs.h | 5 +++++
 1 file changed, 5 insertions(+)
 create mode 100644 tools/include/linux/debugfs.h

diff --git a/tools/include/linux/debugfs.h b/tools/include/linux/debugfs.h
new file mode 100644
index 000000000000..4ba06140b1be
--- /dev/null
+++ b/tools/include/linux/debugfs.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TOOLS_DEBUGFS_H
+#define _TOOLS_DEBUGFS_H
+
+#endif
-- 
2.30.2


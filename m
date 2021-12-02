Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74EE466E0F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 00:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377666AbhLCACd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 19:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377631AbhLCACb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 19:02:31 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DDEC061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 15:59:08 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id i12so1144403pfd.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 15:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nIUP/oAsb0deaFx8AiRlWHzAVs+zgWpixaimUD3qmrI=;
        b=X3R16PW7OZ05cI2BycEvEhKV6404CptCVWmUtqALdwE60RHH2rI5gn1Cz1VybHjkKs
         VLZn/yCRfpFLoH6DermEDDQ1qBlW58lqG1ztmMRGKFDb9/nKcxuKJQGSB1T0Fu8FMPKH
         uYCkAHAevtRwlmk6Bw2q0NAuSbqMqU58YBZ4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nIUP/oAsb0deaFx8AiRlWHzAVs+zgWpixaimUD3qmrI=;
        b=xEvHFBZLQkEbMHsPrkWY+fB1B7Swb3gGIeHDkQYGpayV+JwSlWFkS3RwfPFqWWiSu3
         25E420CCT4GUwmoPOmgouSNyDB3jR5OGz8vUssInI1HsaRGSI+F0c/oD6Ykcx9/IRPVI
         KiFwih/rYgDm3OibJHqUvKxsMI3cmSiJKzR/6q4FMNYAb8MD14EpnKCL2uWmXpxcSxAe
         xe//eo4uQ8EBYvvGrvu/caCsONKr9qUB09+sNg2AfRsh+axJ5WZc0kzkvpfW5EgT7kpX
         FFLwEKJ7jXeDyF+GzWRrsuPB3DFzWa5jj9yEmet+IkWnEhuU8jRM3lqUR9THxA4JkBB9
         /+Lg==
X-Gm-Message-State: AOAM532WhUjFKYn6/e5Tqi1Xj1PTsk/extym6yRGuO7WnlYGauLgsqQU
        xR+qdkPDLxeufmfBRMlSvDsYvazl8Aco0/8=
X-Google-Smtp-Source: ABdhPJyijRpuHUEwYC+fSPcV7Pavlt3yxKQGIknMGkSIRN08drUDyCrE2zeOer+XT4M/eoJFfSEuLg==
X-Received: by 2002:a05:6a00:10c5:b0:49f:de2c:1b23 with SMTP id d5-20020a056a0010c500b0049fde2c1b23mr15583424pfu.41.1638489548310;
        Thu, 02 Dec 2021 15:59:08 -0800 (PST)
Received: from fedora.ba.rivosinc.com (99-13-229-45.lightspeed.snjsca.sbcglobal.net. [99.13.229.45])
        by smtp.gmail.com with ESMTPSA id lr6sm553598pjb.0.2021.12.02.15.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 15:59:08 -0800 (PST)
From:   Atish Patra <atishp@atishpatra.org>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@atishpatra.org>, anup.patel@wdc.com,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v3] MAINTAINERS: Update Atish's email address
Date:   Thu,  2 Dec 2021 15:58:23 -0800
Message-Id: <20211202235823.1926970-1-atishp@atishpatra.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am no longer employed by western digital. Update my email address to
personal one and add entries to .mailmap as well.

Signed-off-by: Atish Patra <atishp@atishpatra.org>
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 6277bb27b4bf..23f6b0a60adf 100644
--- a/.mailmap
+++ b/.mailmap
@@ -50,6 +50,7 @@ Archit Taneja <archit@ti.com>
 Ard Biesheuvel <ardb@kernel.org> <ard.biesheuvel@linaro.org>
 Arnaud Patard <arnaud.patard@rtp-net.org>
 Arnd Bergmann <arnd@arndb.de>
+Atish Patra <atishp@atishpatra.org> <atish.patra@wdc.com> <atishp@rivosinc.com>
 Axel Dyks <xl@xlsigned.net>
 Axel Lin <axel.lin@gmail.com>
 Bart Van Assche <bvanassche@acm.org> <bart.vanassche@sandisk.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 5250298d2817..6c2a34da0314 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10434,7 +10434,7 @@ F:	arch/powerpc/kvm/
 
 KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv)
 M:	Anup Patel <anup.patel@wdc.com>
-R:	Atish Patra <atish.patra@wdc.com>
+R:	Atish Patra <atishp@atishpatra.org>
 L:	kvm@vger.kernel.org
 L:	kvm-riscv@lists.infradead.org
 L:	linux-riscv@lists.infradead.org
-- 
2.33.1


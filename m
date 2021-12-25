Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894C847F243
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 06:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhLYFnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 00:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbhLYFms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 00:42:48 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22D2C061401
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 21:42:47 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id v22so9078299qtx.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 21:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gzGDrxyZOUv2+4eFD82inPU+4YJ/HvJmZp3BDWThsJU=;
        b=JF9ZUl/RiZTqfjreecexg0OBfIjjGqjumHHF1vQq+pjiQrSGxdkhRLwjfTwMGoKxxe
         lfILnth1D0zSub2we1RG6VY4plGnBhmAq/82Cdzay3p4k3SNKr1ZwKvzMazFX+OTTkwG
         D1fr4dNl+pSuQQ8icYxokCSJ+DOMUq3RhKQDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gzGDrxyZOUv2+4eFD82inPU+4YJ/HvJmZp3BDWThsJU=;
        b=B8c0pr/XL3vg+fgRO9L26v/jH1JBiWyJjxy8cnI+Cdapp/fgRC8WBB2JcpgVJuFds/
         MYeG1APsq/MYJ0AMvQPV8HDM4XmxQmM/Kf8UKN/Ubs7KWvXZyQKPxvuw/W+S7dHWJlum
         D6kF0NlzzOXiGFvTuW3zs3Hi39LcQeMPlrGaheeUTlULsKePgOEvdGawOgl1dyDM4dsF
         FWxysuA8JBuqE6mE0U2eRJEH0NsXDxSiGumT3Wyf22h04ea0fNs534TGMiHGf9fWUbQA
         +Dlp3SJ+h8blTog+Woqhm0sru4IOUDfRiLBOHn5O+avy8djSXk59JQ+VRvnRpjGxR1JI
         w/zg==
X-Gm-Message-State: AOAM530oOt2aZeawtIkn9qc9kdC2VMGHEHy/gX6jzzjcTabhaEU5zMWM
        UCIlG22mmVAFogkJoS1QMTDooRieaZlA
X-Google-Smtp-Source: ABdhPJz4955v8ZP59lr6RvUA3sR0N9vRQ7aPgsLarEDcrugdiBZ9vhM61wrquSHRs1fbRf09Xmt+gA==
X-Received: by 2002:ac8:538d:: with SMTP id x13mr7968499qtp.648.1640410966905;
        Fri, 24 Dec 2021 21:42:46 -0800 (PST)
Received: from fedora.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id v1sm8438486qtw.65.2021.12.24.21.42.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 21:42:46 -0800 (PST)
From:   Atish Patra <atishp@atishpatra.org>
X-Google-Original-From: Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Subject: [v5 9/9] MAINTAINERS: Add entry for RISC-V PMU drivers
Date:   Fri, 24 Dec 2021 21:42:38 -0800
Message-Id: <20211225054238.1750241-10-atishp@rivosinc.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211225054238.1750241-1-atishp@rivosinc.com>
References: <20211225054238.1750241-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Atish Patra <atish.patra@wdc.com>

Add myself and Anup as maintainer for RISC-V PMU drivers.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9af529acb6a6..6232ae05e12c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16056,6 +16056,15 @@ S:	Maintained
 F:	drivers/mtd/nand/raw/r852.c
 F:	drivers/mtd/nand/raw/r852.h
 
+RISC-V PMU DRIVERS
+M:	Atish Patra <atishp@atishpatra.org>
+M:	Anup Patel <anup@brainfault.org>
+L:	linux-riscv@lists.infradead.org
+S:	Supported
+F:	drivers/perf/riscv_pmu.c
+F:	drivers/perf/riscv_pmu_legacy.c
+F:	drivers/perf/riscv_pmu_sbi.c
+
 RISC-V ARCHITECTURE
 M:	Paul Walmsley <paul.walmsley@sifive.com>
 M:	Palmer Dabbelt <palmer@dabbelt.com>
-- 
2.33.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D2E487AF4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 18:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348457AbiAGRG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 12:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240263AbiAGRGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 12:06:24 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A81C061574;
        Fri,  7 Jan 2022 09:06:24 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id 69so6520837qkd.6;
        Fri, 07 Jan 2022 09:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JSfYoA8K9ZJQ4IJ3jHkMhOqyDuvkxMOUORFbC42JS8E=;
        b=YYSqgfCuj4xBpReNnIgOmHn4Idwo0o35Qoz4prPG6KioDL0YRBolcPA0sIxphczP00
         wuJui5ptTAjzUBTMJzznKb7XN4ejFqZ2kfRP1+asmd9B6Hw9Tn3kmj6bipwMu9Nrqq5w
         eGMOMflzm7sqRrPMzNSq1JZwTB/gRUnF3K2kuYbXTHsTQOEsPY3FVHtCvy3zx0v8PiKv
         dQ5RBvnowkAvzBdULE9crqPb9FzxMIG205JYPOV+lWP38nbONudhu4qjic44GBr5YKkg
         bMAX8bmxaVZk3SNolv7e3A8ACi+BOpSNsUq9j8OXndBrcdIDKlsRMeshEmeZJ/gwLwQO
         Slug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JSfYoA8K9ZJQ4IJ3jHkMhOqyDuvkxMOUORFbC42JS8E=;
        b=XvaJ8lUbzuWzwljo0FW8OIvbK8pwILr2RkRQKEEwOzLl8divQdJ/SVomLZisQF9WQx
         06InMPO27rd0cKAOQ9nSY1OJ2B0k1p+6VwmD5QwQRk6PBP8xG4x9/6tuMT0t+v5/wKBB
         5bWqw7rc3zq+N4wms3O4k23OAmuGS+TBEi6LxTr8KKlLGDF5NowCTslieCXT0qWXonSR
         CJK6uw0pagSSJI48sqxbUwGjly3oQEoKTx6zPz+QUIcHIPHKyWB0TgWEM//g0zkYuaCC
         BSB7nnNwX6Ye7HoisFgGOE/iM4WtODIonNocY4oygiHI7RW5FRfeChsmnf0boESu0i4N
         M4Gg==
X-Gm-Message-State: AOAM533PexK6ua2OytKT9zVJ8pb981mJsaVn4bGbScYwDnOyZBss2WWH
        viIjI9uUxOumTSgtW8oSpUI1NYyLiYOUAw==
X-Google-Smtp-Source: ABdhPJx7I+0BLtZvrSjkBjYZaf+bl+HeO6R8yxIPt9N2aYVSOKlRwJr23w1hLtmAAb5sE4b9Lnupxw==
X-Received: by 2002:a37:650b:: with SMTP id z11mr45639194qkb.538.1641575183339;
        Fri, 07 Jan 2022 09:06:23 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id d9sm3961085qkn.131.2022.01.07.09.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 09:06:23 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        rdunlap@infradead.org, andy.shevchenko@gmail.com
Subject: [PATCH v7 1/3] MAINTAINERS: co-maintain LiteX platform
Date:   Fri,  7 Jan 2022 12:06:14 -0500
Message-Id: <20220107170616.2041589-2-gsomlo@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220107170616.2041589-1-gsomlo@gmail.com>
References: <20220107170616.2041589-1-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the litex_mmc (LiteSDCard) and LiteETH drivers to the list of
files maintained under LiteX.

Add Gabriel Somlo and Joel Stanley as maintainers; Joel authored
the LiteETH driver, and Gabriel is currently curating the LiteX
out-of-tree device drivers as they are tested and prepared for
upstream submission, having also co-authored a number of them.

Cc: Karol Gugala <kgugala@antmicro.com>
Cc: Mateusz Holenko <mholenko@antmicro.com>
Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
Acked-by: Joel Stanley <joel@jms.id.au>
Acked-by: Mateusz Holenko <mholenko@antmicro.com>
---
 MAINTAINERS | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index dd36acc87ce6..88f105711b85 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11012,12 +11012,17 @@ F:	lib/list-test.c
 LITEX PLATFORM
 M:	Karol Gugala <kgugala@antmicro.com>
 M:	Mateusz Holenko <mholenko@antmicro.com>
+M:	Gabriel Somlo <gsomlo@gmail.com>
+M:	Joel Stanley <joel@jms.id.au>
 S:	Maintained
 F:	Documentation/devicetree/bindings/*/litex,*.yaml
 F:	arch/openrisc/boot/dts/or1klitex.dts
-F:	drivers/soc/litex/litex_soc_ctrl.c
-F:	drivers/tty/serial/liteuart.c
 F:	include/linux/litex.h
+F:	drivers/tty/serial/liteuart.c
+F:	drivers/soc/litex/*
+F:	drivers/net/ethernet/litex/*
+F:	drivers/mmc/host/litex_mmc.c
+N:	litex
 
 LIVE PATCHING
 M:	Josh Poimboeuf <jpoimboe@redhat.com>
-- 
2.31.1


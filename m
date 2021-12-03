Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDAA4680C1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 00:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383487AbhLCXpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 18:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354392AbhLCXpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 18:45:31 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54230C061751;
        Fri,  3 Dec 2021 15:42:06 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id 132so5139548qkj.11;
        Fri, 03 Dec 2021 15:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wGXPdAAibHvapEYyiWYm9DiPd3199z1fbEciyKqIT00=;
        b=QTRLsc+vfiUmEo6kLn+qcR0ooQ703YbjGLj6TUM+4rMyA6D+506i5o9BV87b+EMT6m
         N79GylOgeywYhPJiDboGCQKzIEGfOHV7u1YDS0UYmrszTgFpDR+GcYfknfLAc75tPRbH
         bV+ZhsVF40fjBC24us18unemqZ7jZV+LFFsxO4bNUFymj26D4BPWjLtREc06HI7aju/f
         m8c7fHWJDmLooWfdLJN6D3yovhhTueq+k8AvWq+znQKbrekN0NIfW5eHugMSlHsjbJ+u
         0tB+5KVaABglwwXqijCQVdsbKE6RunMYOV9wdR7Kr/ojN6D/Ge5+c1le5mN0OUm5VbL9
         XTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wGXPdAAibHvapEYyiWYm9DiPd3199z1fbEciyKqIT00=;
        b=bzMZ81dFc7a/rn0UVurQwMKrXBy9zlZBRPCAWJQ26L5uOdYAgdenI8cPNXgGY+mXhQ
         we5dobs0XGf32lFLesAHkKsRHTIPXKeRfLj0+tj3LwHeFa2bH49EVqgvjhYHZTLTwzJg
         DQiigbFfR3YdrB7vuRti3PmH8Dfonf6sPiVT+RPliYViBmAaXf840MgRU8r8g6YDFZfN
         kvDn1kvMQ13gMECmpp0mtETYR+aIZOoE/RTJ1adw0Q5P3xY6BRhimzJkHtS1R4ej5vl+
         Hy0m/cDlr0jkchVuLV88z77RmWRkydrHTsS6Yz6YPlX803jI1nIkF/tvVQRlJ6ZecgUV
         LK0Q==
X-Gm-Message-State: AOAM5322xvmGLdSWCneWg+Sx4A6uT8oXmLn0tnQk1KtTFi4acRAf1dMF
        mvS7GH76cc8HOn/hsHn3BtJbsij9aEw=
X-Google-Smtp-Source: ABdhPJwthDcMiwi4YD0Tt4Oxm8D8ZXEBnD9cwi0lTGt56KHMZZW2FwrnjFwAG/URgmQIZ+t3pm2vaA==
X-Received: by 2002:a37:62c5:: with SMTP id w188mr19827979qkb.396.1638574925327;
        Fri, 03 Dec 2021 15:42:05 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id d15sm3495111qtd.70.2021.12.03.15.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 15:42:05 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr
Subject: [PATCH v1 1/3] MAINTAINERS: co-maintain LiteX platform
Date:   Fri,  3 Dec 2021 18:41:53 -0500
Message-Id: <20211203234155.2319803-2-gsomlo@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211203234155.2319803-1-gsomlo@gmail.com>
References: <20211203234155.2319803-1-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the litex_mmc (LiteSDCard) driver to the list of files maintained
under LiteX, and add myself as co-maintainer. I've helped develop some
of the existing drivers, and am currently curating the out-of-tree
drivers as they are tested and prepared for upstream submission.

Cc: Karol Gugala <kgugala@antmicro.com>
Cc: Mateusz Holenko <mholenko@antmicro.com>
Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index faa9c34d837d..5fc65d4c4969 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11012,12 +11012,14 @@ F:	lib/list-test.c
 LITEX PLATFORM
 M:	Karol Gugala <kgugala@antmicro.com>
 M:	Mateusz Holenko <mholenko@antmicro.com>
+M:	Gabriel Somlo <gsomlo@gmail.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/*/litex,*.yaml
 F:	arch/openrisc/boot/dts/or1klitex.dts
 F:	drivers/soc/litex/litex_soc_ctrl.c
 F:	drivers/tty/serial/liteuart.c
 F:	include/linux/litex.h
+F:	drivers/mmc/host/litex_mmc.c
 
 LIVE PATCHING
 M:	Josh Poimboeuf <jpoimboe@redhat.com>
-- 
2.31.1


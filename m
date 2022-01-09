Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3830D488A04
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 15:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbiAIO4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 09:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbiAIO4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 09:56:45 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A29C06173F;
        Sun,  9 Jan 2022 06:56:45 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id b11so4794888qtk.12;
        Sun, 09 Jan 2022 06:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RX0kdsfOklLt24ZT+yjhaSk0YeWPH6hrBAWuhkMAEW0=;
        b=hlGTNyFvi6idKEDLO/5kd7cna/2abkeL6ewSpKdetJISopYDwBxs8POqw75TwFMdiu
         d4xJcW8/g8NG/4G5sP/TLxQTRoAJoYMbySCrH7bP5vYbFvkICGWiD4jOWyf8zaAqDmXt
         sXzpLVupbeJxcBnJU7ub+JOI/R11sO3WB+bzPf9l7qmp7eugRpABVZlTgUOzQoAgzTW0
         XXPryVERf3zBB/hbbYAF8Z8QJDSpfk/LxpXZiYQC4n6H3ry50iFp1M6tbWdpmfwRXn6u
         7qxsDnVsm+Q2g1Pxsjr+ZAqNBBFeGCmsnAv2fPyF5/Hz+fViVjWqp2bZbStgeI4RLAgB
         3NgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RX0kdsfOklLt24ZT+yjhaSk0YeWPH6hrBAWuhkMAEW0=;
        b=y96qp/3Vm0Dv/ek0lG4Fi+NZUhvnwMxD3BU1sl1MzT7N3RJW8HlE//QuIQtc98Ruk6
         2GbGTfnu4/I5tSVrU5d5VUl0sVILbXO9PnQWrGZqxWWMezMGk+EZZ7lMt+5hSxv0VSlN
         m3R9/CO30d8f3aIjWn1weoykcqx5k/rcT8ON5CzcuUBnfKdigfx5a4VHoHifG9EBjsTm
         MBzvBAeQqNN0aj0goeOUJTd5IMP66wyROcat3SFSHb8oEBAISMbpUrE9PwEaHAltrjbo
         4gaXGHUdo5qvTx2PgRkZ5XjOvh6478fzm5JzR5w11zqE/Vv0Xl8bvmcDOVeGaKu6kgP0
         plBA==
X-Gm-Message-State: AOAM532beJWoyiC/Qv6VNZYeSDRTNCTSJcDW/hwHZLLIVekYab+brKmO
        U9oICASVykNIEvpuFVnLleP7U7325RvU3A==
X-Google-Smtp-Source: ABdhPJx2MJdfIfGgj35ZURpSkxdZsjrXAvOaBjkhPEHcc/QNfN/zx4b9sUcgTM8Jq9Acj1b8N4pnDg==
X-Received: by 2002:ac8:5fc4:: with SMTP id k4mr1040139qta.28.1641740204392;
        Sun, 09 Jan 2022 06:56:44 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id j22sm420341qko.117.2022.01.09.06.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 06:56:44 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        rdunlap@infradead.org, andy.shevchenko@gmail.com, hdanton@sina.com
Subject: [PATCH v10 1/3] MAINTAINERS: co-maintain LiteX platform
Date:   Sun,  9 Jan 2022 09:56:35 -0500
Message-Id: <20220109145637.2506583-2-gsomlo@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220109145637.2506583-1-gsomlo@gmail.com>
References: <20220109145637.2506583-1-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the litex_mmc (LiteSDCard) and LiteETH drivers to the list
of files maintained under LiteX.

Add Gabriel Somlo and Joel Stanley as maintainers; Joel authored
the LiteETH driver, and Gabriel is currently curating the LiteX
out-of-tree device drivers as they are tested and prepared for
upstream submission, having also co-authored a number of them.

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


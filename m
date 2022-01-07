Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69EFB487F72
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 00:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbiAGXfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 18:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbiAGXfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 18:35:05 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165DDC061574;
        Fri,  7 Jan 2022 15:35:05 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id a1so7068007qtx.11;
        Fri, 07 Jan 2022 15:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RX0kdsfOklLt24ZT+yjhaSk0YeWPH6hrBAWuhkMAEW0=;
        b=FUgz524pTg6lmH5C0hd1s7NNIp72a6TOn8WGxLd208W+9cmK0tXxP8VB+teiiPEs6y
         L+bcNa/hMJxHG2Stf9XvLQ6Uae3wtAbK/vbHFya0OQrhc8Dyg4vmnbXZdZ1ArTS9NIn+
         23GiNdv7O7W3yhUuzjFqrcEH4p0Eet7cQwVaqioiV4FyFaeHYI3+0t4WJfdmHVH/efNl
         45prOqvkLNgKcdurgeNWfwWdfS64x1VTsQvqfoEmTxP6eeJCrJ9IMcHl9TaEy3Iic5X8
         Nf4X8L//f/EjujihZMuw41QPKL6lB/EXa/jcKYHkfjTjAHChbFUdUPm3KPNhnq7IQYnn
         7Hjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RX0kdsfOklLt24ZT+yjhaSk0YeWPH6hrBAWuhkMAEW0=;
        b=1vZIarMEYntLua2XeeN8crJ1GG7O54r4MQ332x0d2duLh2rq41c/t6WocD23uZaZGF
         9XBOU1kkwJirOVwyk+tCDaCzfQm/hHgfNQAfmLqh+7+3uim7c7vbvWgo9NE2K218Oy6t
         11AOvENkICldvSLBlCEzQt6iBLe2EIjGImvIQDhhXPRBYyN3ez4SRCop7J0eXck+bz74
         IxeWs2ut34uGtVMQ/odkC+CEMa1F0pJmABuF/hrAAZhNeAFfq+850fTFLW9yzLz642Nj
         jmyv/TcJVUHlYOvZX0YRx26TALk3nQVSnnTdC39jdHXkkzHcEWggf55yeNOAgZJjoyRl
         548Q==
X-Gm-Message-State: AOAM531aMWG1+V2w9Ef7t7Fr6rNDiifxJrFU2Fk8RhaLBaxPFbm1fVVD
        jdo0UUvj6MgAKvyZC12YCUpnn1Rx9Z3Kdw==
X-Google-Smtp-Source: ABdhPJzKN9fwsJqXw07YHYfBP8geompcGWX4TzkQE29xxOJ01za/36Th6QzUyyx4Xc5fq6HtT037Rg==
X-Received: by 2002:ac8:7e81:: with SMTP id w1mr6905072qtj.628.1641598504010;
        Fri, 07 Jan 2022 15:35:04 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id l13sm61283qkp.109.2022.01.07.15.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 15:35:03 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        rdunlap@infradead.org, andy.shevchenko@gmail.com
Subject: [PATCH v8 1/3] MAINTAINERS: co-maintain LiteX platform
Date:   Fri,  7 Jan 2022 18:34:56 -0500
Message-Id: <20220107233458.2326512-2-gsomlo@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220107233458.2326512-1-gsomlo@gmail.com>
References: <20220107233458.2326512-1-gsomlo@gmail.com>
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


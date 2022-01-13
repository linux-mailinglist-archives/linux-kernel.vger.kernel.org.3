Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6871948DC7F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 18:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231380AbiAMRDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 12:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237055AbiAMRDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 12:03:10 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930C3C061574;
        Thu, 13 Jan 2022 09:03:09 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id f17so7587295qtf.8;
        Thu, 13 Jan 2022 09:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1VHGcQVlK+G3f4CiZRKyztpAWurKbgW7any4uaUJcQo=;
        b=OxsOPcmTxh4Z8Tt5OdpBcq0YP38sUDB7qs2XndhOuDGSpvPjarT6xThzLv7papl6Xd
         h/d3rfqQo0JJ7GZUreMkUHB5r0SChNv83I/ksBMdD6AzA1p+1q32nl8HQF9AmhoSSmhq
         03ihmft9Ebz9UpKCHHzZZBg/R+fds5CUDLvZ/DNuVIqv4lHMmDR1/7EGCFjyQxDG219y
         59mJoReG+Dz2uXVvikqIogBfj6lvGzVNLosptNkqVBcCCUBwDXT8A7701Dza7hlGlnfx
         RidQMXNK8QBb2UX2+OMybgcsZJKA4zMiJhjxHJ187OtOSxBT6EeCGkkP4XrG731SqGg1
         FHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1VHGcQVlK+G3f4CiZRKyztpAWurKbgW7any4uaUJcQo=;
        b=FjyENEPmFM5auzgi17BrsCB8Gc0PBMASEfpK7kQioNlHzCYidBeM7i91h+V3v7Ld3t
         Ex6mGEa4wy4pfru+/VdhsXElP5Q62A0B6128D1vvfKm55ess4ppDPIn8gvGrPys/te6h
         FU6DLimBgQxlZaKLsTJfiyd2oiEznO2xi9epq+BmlaOM60OKfckS+9yYwDlHequXahqB
         ljmp+Snz8SKKqVkeyCFpM/b4MGEUnyLFMsK1L1FKe2ZMA7+vvL/P6L2bNg5KSfAHeHOv
         KhRyMcvR+crr7+aZdVtxW7ukZA77Hhyj9AzPfcXUUrAoFkvbuoL6jiY3wt0ZW7PcEOz1
         cRrg==
X-Gm-Message-State: AOAM530CN9BzH0kyKCH127d+spxwxLunVkQir3zfI1V6529K9IYUIXmn
        KPLcrgeByzpu1dCRt0wP1HlpG+UEYeiXZw==
X-Google-Smtp-Source: ABdhPJx1L5Xw4Q7q3lCa5fv9NEptJfZm79t6x2Kn9Sx+X54HXzdCBjAv00LxRFoy6FBVc/8EbSbv8A==
X-Received: by 2002:a05:622a:493:: with SMTP id p19mr4382818qtx.162.1642093388556;
        Thu, 13 Jan 2022 09:03:08 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id j22sm2021931qko.117.2022.01.13.09.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 09:03:08 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        rdunlap@infradead.org, andy.shevchenko@gmail.com, hdanton@sina.com
Subject: [PATCH v14 1/3] MAINTAINERS: co-maintain LiteX platform
Date:   Thu, 13 Jan 2022 12:02:58 -0500
Message-Id: <20220113170300.3555651-2-gsomlo@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220113170300.3555651-1-gsomlo@gmail.com>
References: <20220113170300.3555651-1-gsomlo@gmail.com>
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
index e4cecccbd439..d0aa02e9963d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11094,12 +11094,17 @@ F:	lib/list-test.c
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


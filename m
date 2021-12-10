Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E88470336
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 15:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242434AbhLJO6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 09:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242441AbhLJO6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 09:58:14 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6B0C0617A1;
        Fri, 10 Dec 2021 06:54:39 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id t11so8589957qtw.3;
        Fri, 10 Dec 2021 06:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jgVYMpvTv3jnE1Nhy5knxtp0Aq6paPh8Ak3VDHrvuaw=;
        b=LWn55W9qewOx6OdioF/1uY1sFo+YPSLJ1k4koYN9Lnrr1jsEbAygaYifhfwvfHJlc+
         4Jn867u9s4ZLJWpAxZFbBFwZon0Lj0ZkCLGBaIHpFcrXcznZqifCTUIPtHbNiymq1by0
         pACe891bsmrimOhiRDuO+lVESQM1s5kbPM8jhcN3hImDhr+MUw3p3Z2R3Bi+8w2PJ0Qv
         2BG3jQdCB7ahhzBVPVJ7HxBerUJKZUnirdZjwSpighWJeOLrVZqwI/F1Iw3GXpcQa9Se
         NGovg0crkQ0457E3yAdqBMmGEsBocusZkDHFfNnwv5QUReGUgisCp0GhWtsB9+BVgFYn
         4bwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jgVYMpvTv3jnE1Nhy5knxtp0Aq6paPh8Ak3VDHrvuaw=;
        b=znV27zRLwbB1AtqCmnmAWjQAUxunwfT6iQWrDJ2QFl7TqiKf4Iq3bNvpb5KW2YKP/5
         IiIM5cHDve08qlANXidgKqqjKWZkIIKrkQKAOFfX55oEGdKZA6tJeveYB+L6PL81MIdC
         g8i3BJEx5DTMSVpUIYl8U7cJxElcsV6Lf8CxyyVs5CMv6TqMsHrPVPKBmqSs5TnGiBS0
         l81CnDxkRfWDugrY/in8Q0LrPluxZuUUtYeVsJq2rulF4+VwHWhfv+0cz6x4QBaei8bP
         F8qV2+JXpctTPRgAEq+FrnlBV9g2zzoMQJCGPjECBEhD6WtK95RHvULTaRgMtJvgWX1f
         EYqA==
X-Gm-Message-State: AOAM532SrKj80d3FH6f8O+E1BBRzsdj+ypgoK4jiNNGb/hhZOQzOqs+M
        IvhOgGxLUEuD0YWgTPRw97KpdkvyjP9nEg==
X-Google-Smtp-Source: ABdhPJyfnt9i+EUZHWkH++g5Ja8LoxtxRpzQEG+r/3+oJ5pq/J2D6wTf3OTlg1gOyzuQwWeNliY/dA==
X-Received: by 2002:ac8:5e4f:: with SMTP id i15mr27443187qtx.408.1639148078849;
        Fri, 10 Dec 2021 06:54:38 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id a3sm2054681qtx.59.2021.12.10.06.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 06:54:38 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        rdunlap@infradead.org
Subject: [PATCH v4 1/3] MAINTAINERS: co-maintain LiteX platform
Date:   Fri, 10 Dec 2021 09:54:28 -0500
Message-Id: <20211210145430.3707463-2-gsomlo@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211210145430.3707463-1-gsomlo@gmail.com>
References: <20211210145430.3707463-1-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the litex_mmc (LiteSDCard) and LiteETH drivers to the list of files
maintained under LiteX.

Add Gabriel Somlo and Joel Stanley as maintainers; Joel authored
the LiteETH driver, and Gabriel is currently curating the LiteX
out-of-tree device drivers as they are tested and prepared for
upstream submission, having also co-authored a number of them.

Cc: Karol Gugala <kgugala@antmicro.com>
Cc: Mateusz Holenko <mholenko@antmicro.com>
Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
Acked-by: Joel Stanley <joel@jms.id.au>
---

New in v4:
  - n/a

> New in v3:
>   - picked up acked-by Joel
>   - added listing for liteeth driver
>   - added Joel as additional co-maintainer (thanks!)

 MAINTAINERS | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8691c531e297..7f59779bb5eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11011,12 +11011,17 @@ F:	lib/list-test.c
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


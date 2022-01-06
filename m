Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D01D486916
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 18:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242379AbiAFRsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 12:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242346AbiAFRsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:48:13 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD966C061245;
        Thu,  6 Jan 2022 09:48:12 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id l17so3028685qtk.7;
        Thu, 06 Jan 2022 09:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JSfYoA8K9ZJQ4IJ3jHkMhOqyDuvkxMOUORFbC42JS8E=;
        b=MM8STzVQIUgXzx8UNaY0Jkb+cmgcPrn+v0CkGbvgzMWD562PcyVmzPsDbXWGIj39CG
         xQg/0UH+/sfTkMwFZecFlmm3xeG6bqZcXF9xVQFy/j2UbA2q+OjJoAQgJttMlNX0+ab2
         fPbpef2s4f8tam99U3hndgDy1+65jtz+J80HRmhp1CuKMKF47whGfgh1ToP2/eqPi54i
         KS65KjJFt/Rvt3GooE42zL/SXf/6EUlYMmHZOCygL37fDA2MQfeBCc/SEq13VQesSv/+
         XYMREsuSTs5PLTLPBR/gQkEZzw/Zsf6lpB4NPXa+HaIuApJEE1PfAlhfQY+nmogS2Hdu
         xjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JSfYoA8K9ZJQ4IJ3jHkMhOqyDuvkxMOUORFbC42JS8E=;
        b=pvGXlvNIt7l1yBmc6WNsEWlCykKaN1XnLLDwKeRvO/WfLhl7lJBAoPQXAzm1VYa907
         27En1lqMXqYW+mNbejKH1k41TODNv9hfKqBBRg6VxeqMyyAWXL9kEgkGsEA2Nqy/uBK2
         wOXArH/hU6lY05Uu+boG6ZLV2kubrUEZXrZo+Aq7cQW+1Ncq1kKPOiVG9ovB3Z14uRhs
         OIxmn0TQS/FlxsuHa+Ou1ZywNdeNEdPUNl+3wtwIfE9UfztPp8MJ6/NIVrltiIOr8ypa
         UXlV1C1GIryLi/eTakVB3rXmzJ6UakRgxA0oAPOOavZfpWwx0bzhaxyMwO58ThT9dOSf
         bnoA==
X-Gm-Message-State: AOAM533aXDVDt29pHKc4ztLhEFLzh+4qmBxpgO2rwv9S+VWxe4jggEnm
        pZCiySH4WMAM6CHjIOKDC+3g9qUzohdkxA==
X-Google-Smtp-Source: ABdhPJy/lTNtdxV73aWqqIjT8sCYLavHVJedNAzIsFoxlH/y03F8AGUaALkYLb0KbcVHQ7PV2x/l6g==
X-Received: by 2002:a05:622a:193:: with SMTP id s19mr50440199qtw.266.1641491291720;
        Thu, 06 Jan 2022 09:48:11 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id u19sm1709227qke.1.2022.01.06.09.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 09:48:11 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        rdunlap@infradead.org, andy.shevchenko@gmail.com
Subject: [PATCH v6 1/3] MAINTAINERS: co-maintain LiteX platform
Date:   Thu,  6 Jan 2022 12:48:01 -0500
Message-Id: <20220106174803.1773876-2-gsomlo@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220106174803.1773876-1-gsomlo@gmail.com>
References: <20220106174803.1773876-1-gsomlo@gmail.com>
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


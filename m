Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046D5475962
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 14:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242754AbhLONIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 08:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242704AbhLONIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 08:08:36 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEC8C06173F;
        Wed, 15 Dec 2021 05:08:36 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id m192so19883722qke.2;
        Wed, 15 Dec 2021 05:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VzWryQMQXu1HYg1ynBv0/PjpqcrADY+cqKGeEKL596E=;
        b=d0UFWa/snxiPgSHptjSjB0h0SeCov85NNnZ9RHVa+KjMpxgP7LxfPIW8W7yHePIYJP
         zVrR3kILicR9kMsD2enE+ieuymqKTfY0Me6FycLb9/d5EJ4N3BJknlUDQd9m7Q9bVVNt
         LwOtvIsk5LdyBGN1PU9u3tpVZkO33DCFohZuPKzTYwU736yptM4YxgLzGZcXVvhkfV+A
         L9Qomx9QR7ePl4zRxLnupfGWJ/tGjdp7TT7ycFwUhEulgR3N/p75yfb8JfMzlZy5qTDh
         6Lj2YSFtndK4P9hsEMF6nX7fIjSd30dggfqwfob+5szDOkpkcAWFiWlyxymgLE7cBMrY
         X6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VzWryQMQXu1HYg1ynBv0/PjpqcrADY+cqKGeEKL596E=;
        b=xeUUufBoBOBKxdLZfJwl3xDU4GaSZ3dvaOkX6Ae3l+QqUqpcC8Kz9O7MfIx54QVbeP
         tvERr5VB2KTwPUBvW3WT8OwwftWBlDPcq0IrrYiQj1bAsTLte4jD3oWbXRc+Imlc3JMd
         /3CpIXSJiFFdfSRVnqnZpwCHQ0omzn7Z7elhyq+lKGlY9cAXSY8GCApPKoObanUz9ZUf
         z9Z2OlZTObv21MghRXMqqrZgA/0AR8RR5lP97doJn4jh1vv+PjtXHoDo9ti4x/X/BFJn
         kS2Gj053R6TI+HYW5SmTz8muNO4pFLALYyfMgMT2SN5Bf9h1bqqXX5S8PgI7cBl4aq6g
         PhrA==
X-Gm-Message-State: AOAM533+6a/LLqFjjSVOOzB3/LnArWo7wCgZAQFZs8bvW54bTxGK4Psl
        I6PXoqCY54aV9ctPGV1NAl+gQkNxITj3QQ==
X-Google-Smtp-Source: ABdhPJwiIxFq5irBpgv02HJUL8hqMQpIAImtq/9UmMb5zRN6z8/eCzVxuLWaG36TqdbZ9GM9BYk/pw==
X-Received: by 2002:ae9:f710:: with SMTP id s16mr8284277qkg.740.1639573714882;
        Wed, 15 Dec 2021 05:08:34 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id j12sm1594897qta.54.2021.12.15.05.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 05:08:25 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        rdunlap@infradead.org
Subject: [PATCH v5 1/3] MAINTAINERS: co-maintain LiteX platform
Date:   Wed, 15 Dec 2021 08:07:09 -0500
Message-Id: <20211215130711.111186-2-gsomlo@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211215130711.111186-1-gsomlo@gmail.com>
References: <20211215130711.111186-1-gsomlo@gmail.com>
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

Cc: Karol Gugala <kgugala@antmicro.com>
Cc: Mateusz Holenko <mholenko@antmicro.com>
Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
Acked-by: Joel Stanley <joel@jms.id.au>
Acked-by: Mateusz Holenko <mholenko@antmicro.com>
---

New in v5:
  - picked up acked-by Mateusz

>New in v4:
>  - n/a
>
>> New in v3:
>>   - picked up acked-by Joel
>>   - added listing for liteeth driver
>>   - added Joel as additional co-maintainer (thanks!)

 MAINTAINERS | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 13f9a84a617e..fbbeb6281da5 100644
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


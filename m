Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A6446D453
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbhLHNYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 08:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbhLHNYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 08:24:25 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047F1C061746;
        Wed,  8 Dec 2021 05:20:53 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id 8so2137102qtx.5;
        Wed, 08 Dec 2021 05:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dJVlg2oLUowfo45RKI/3MHrMc60k5NUeeQhZQgTnPCA=;
        b=kJyRLSMTy3JYFM0PcrBuPCNan4YLJp+Lt80rTpxMK7oEvfBsV+6pW21uvpo5SA0Qwl
         3NVLuAUy8yeEDPBTvniKdBm8aZCoC9nkpsxMSNY7bwYpl6FDe4MkHNaMKfnJm8MnYafT
         0br7ctWUl1LJhZOiJTeSSsoj7UU9ucD89beZIkuRiFzCv4h0+O+lXzY0qOJnuOpGjurl
         AHy7s14zyYSIBLdjGMQl21f5hJJDugUl8L6C/Yp5gq0FJbdp32Xy+YDfPnQMQ7tSux1P
         qJ4dC+aqhdHbUf1RpEKH+6d5q1oMg1PL1n9NOkd8yeByC0T3CS+xcWXddvdGbZPmvi0y
         pZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dJVlg2oLUowfo45RKI/3MHrMc60k5NUeeQhZQgTnPCA=;
        b=MfgbBgOaq1ZIbiUYrnCjRgyQvx4IHJ/ze7xhG3k4hyb7uHicF2WKRXzCi3Oqw3IiNc
         INg5PpYGDvP8V1iH836T2KxIYqXbvjUMVWTz9fxLDX0c8pw/JJUwJqFz7OJaRjdhh1B+
         IJxVty3yi66IDAJCdAxym5Uv6zRYsawNzslqFyNgiwu+NNJCirYRUJk3DUYEGTB3lqPj
         YF3mkWC6Bh1jR/NPpVSsYKDKt3VEJEDeMIkd2RZajQ/OpyORNmFYrwR9j9y5l5JvuKRc
         hB4aiem1kaBuc16Q8/Pd7EA5VzHK/cL7DEoTt64uXyUoZkDdPe5UiBGaoN1sXi9bB8hS
         p6hA==
X-Gm-Message-State: AOAM532ZnIcAVjvUABBSGGfaE7qGwuMMfz2aOYmjsR3JiKJmDVvLrtDW
        OsKKuTP5+sGxQj3lPbLT8OcPDjnYboS8Gw==
X-Google-Smtp-Source: ABdhPJzz7JvApabMbC5Bm/m8LU1zhtM8yy23c9zz4o+haFT89WzkPcBpWmiSZSQsbWRUh4+KY2HivA==
X-Received: by 2002:a05:622a:1351:: with SMTP id w17mr7660625qtk.276.1638969651963;
        Wed, 08 Dec 2021 05:20:51 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id d6sm1544132qtq.15.2021.12.08.05.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 05:20:51 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        rdunlap@infradead.org
Subject: [PATCH v3 1/3] MAINTAINERS: co-maintain LiteX platform
Date:   Wed,  8 Dec 2021 08:20:40 -0500
Message-Id: <20211208132042.3226275-2-gsomlo@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208132042.3226275-1-gsomlo@gmail.com>
References: <20211208132042.3226275-1-gsomlo@gmail.com>
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

New in v3:
  - picked up acked-by Joel
  - added listing for liteeth driver
  - added Joel as additional co-maintainer (thanks!)

 MAINTAINERS | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 43007f2d29e0..477d993f70df 100644
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


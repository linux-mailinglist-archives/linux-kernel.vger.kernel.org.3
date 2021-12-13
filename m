Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D133472B0E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbhLMLRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbhLMLRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:17:04 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26502C061574;
        Mon, 13 Dec 2021 03:17:04 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id t18so26352031wrg.11;
        Mon, 13 Dec 2021 03:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LUAYxxpwP4VzmElxPUszA36SDJfJVj0YidB6rQcDXBA=;
        b=mDI8lRHnPoZAkQFrvWFGba0482YL71LNhCPJMAjd22pf0utqTt7Ywk+zbe72mLM+HQ
         TeEKC1fTmb8pOqCsnXcapWSbjGic/WlhcTqymIQ2Itu0ee40pXUhQejbMksrl5CDclJx
         i0OeKK4RaLmelGQymwASn8RpANgV68X0xlhKK+9lQ7I8UvYib5czKUBgkndXjRhY272v
         phuJtjt0tWeaJp2zHUcMiCYyC8jc51zSLXV6+yBkvpkEHPlZnR7uPYdJhzyd6MalZMwb
         FGbFU2xNaC2aNbRYhDTQVDqjA8Lcxfo+9IRox4S03NevA6O3VhebQJRGpmEt/RJeEMlC
         QCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LUAYxxpwP4VzmElxPUszA36SDJfJVj0YidB6rQcDXBA=;
        b=2/KWtINVccYeMCWxaDKz2Ov0QwRZBBvX0oMzkdAnY2ViypnLFg9DHrwEJGD0Czs9DP
         ZRvdMP+elE901EzGFWME66juGlznOmW11vfUUEVH/nZ/EHq7QYES5cIm8MXYvmbyZnIf
         fU2IR6bccU9OF/TFDPAXrL/Eye2ElDQLj2oYdXgvQaOb4r8EShrxR2JU4wA7+b2VWT/z
         u9TwKRhn6r0nUilJtb8GvZiJ3A5ik6Z+nye5BKlOKNbahJaYCjPFcB+C6w/mICxiT66Z
         UBRdpxmvnUymb5Rf8QvEXZWJcQHKm8MxTEwcrWC31TPhXjjA+QcziiekjM2OrMJRX2Tz
         BHuQ==
X-Gm-Message-State: AOAM533adtbD0EROkiJIcbzL6j3zt4NwIFVKAk2ZfKTSL7OPbDuWWnZY
        2Fv8wGugtIXetcWjk7oc3mg=
X-Google-Smtp-Source: ABdhPJyC9JHDyXVeUQVDB2kJwJVKcOTb419RMzO3fzUp5Xu7rd2b/BirFVA141GWyvzUNbAejIePbw==
X-Received: by 2002:a5d:648d:: with SMTP id o13mr16110909wri.637.1639394222618;
        Mon, 13 Dec 2021 03:17:02 -0800 (PST)
Received: from DEL01603w.ebgroup.elektrobit.com (eth1-fw1-nbg6.eb.noris.de. [213.95.148.172])
        by smtp.gmail.com with ESMTPSA id t17sm7255255wmq.15.2021.12.13.03.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 03:17:02 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Sander Vanheule <sander@svanheule.net>,
        Bert Vermeulen <bert@biot.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Paul Burton <paulburton@kernel.org>,
        Daniel Silsby <dansilsby@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 3/9] mips: drop selecting non-existing config NR_CPUS_DEFAULT_2
Date:   Mon, 13 Dec 2021 12:16:36 +0100
Message-Id: <20211213111642.11317-4-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211213111642.11317-1-lukas.bulwahn@gmail.com>
References: <20211213111642.11317-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c5eaff3e857e ("MIPS: Kconfig: Drop obsolete NR_CPUS_DEFAULT_{1,2}
options") removed the config NR_CPUS_DEFAULT_2, as with this commit, the
NR_CPUS default value is 2.

Commit 7505576d1c1a ("MIPS: add support for SGI Octane (IP30)") introduces
the config SGI_IP30, which selects the removed config NR_CPUS_DEFAULT_2,
but this has actually no effect.

Fortunately, NR_CPUS defaults to 2 when there is no specific
NR_CPUS_DEFAULT_* config selected. So, the effect of the intended
'select NR_CPUS_DEFAULT_2' is achieved without further ado.

Drop selecting the non-existing config NR_CPUS_DEFAULT_2.

The issue was identified with ./scripts/checkkconfigsymbols.py.

Fixes: 7505576d1c1a ("MIPS: add support for SGI Octane (IP30)")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/mips/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 878affb643e4..e329214ac06c 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -763,7 +763,6 @@ config SGI_IP30
 	select HAVE_PCI
 	select IRQ_MIPS_CPU
 	select IRQ_DOMAIN_HIERARCHY
-	select NR_CPUS_DEFAULT_2
 	select PCI_DRIVERS_GENERIC
 	select PCI_XTALK_BRIDGE
 	select SYS_HAS_EARLY_PRINTK
-- 
2.26.2


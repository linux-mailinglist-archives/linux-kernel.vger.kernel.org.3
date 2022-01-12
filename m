Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63AFE48CE61
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 23:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbiALW15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 17:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbiALW1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 17:27:55 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48050C06173F;
        Wed, 12 Jan 2022 14:27:55 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id hu2so4589871qvb.8;
        Wed, 12 Jan 2022 14:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7LOAyg6audfFSi2lQpqzb/w3AMYVu0rEljgTnv0UhTY=;
        b=TtQcjs0sW7G1hwY5af1KNU3N1tlhhAAwEK9CpQ9Up8Qb0I59tpy4fIOC/cZuxRDRcE
         0ItF3/8DocoYd1PHzY+v4PJq6Q6qlnYzte0/u/HQioxV9CxNZu/FRABXmBJowzbHJZnr
         1dd8Ywh+MXaktwpmu7Og4HUdlGSQFXiVet0feUPAdJ0L70nlQHYE4r/AqYJd+mpG5EXp
         9hCXFO7TyyRKyAzr2gypNlwI1iI86xbzo4N4QaSPRrYlH3D/aKXYJRUi0WFZ/0eb9IR7
         rPz7BVUhnxq+GvAzgk+iUIm9uIcT/5cfYkl5WB3lXngBDuN+fDt4RwdWEdGDh4rGRviq
         kn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7LOAyg6audfFSi2lQpqzb/w3AMYVu0rEljgTnv0UhTY=;
        b=3rlkrIDBwKw6SHB8mQ2/gi4L6DJE3FXjDxpazI6sk23XZf0Ot5XEYDfn2VU6ThtmDC
         lbrLpB90dwiVCroyI6TvHEsENtuYdSiiyp5TPkLW8BPHWNTUoQHPBolR/+3B+qLAkYG7
         +mtKA4MLyel4Wlp4319JeEGEOyEB7OUog0i8gpW50MSrF3KVv4NAb0KRQCUIg2KvPNb9
         V0ScQtEzQ0wlvusgwuurftf7FyyX4PnGEcf7slxrgMPaxYX7bhVgz/2SGUxINKoRwmUf
         SUhKpHc7WsCAHI+ZZXOwK//GKT1euD4SQ7Bm5sMSqaI+ZqgDE25si/AkJBrW4AM3GIkv
         6Oyw==
X-Gm-Message-State: AOAM5324GDMaBR5Es+ELT2AS8IAEE+j42fg3aobQMl8K3MuY3+YfBGJS
        pdba+T8DwiCrhoZk9v9MgfrV+skPYCY9qg==
X-Google-Smtp-Source: ABdhPJzmGRS8RJHtbbmS5UhUGuXce+uMeG0VVuPv/hu3EFhmxLd4zeevlzmShZ2EbMUogcLYMftH5Q==
X-Received: by 2002:a05:6214:1c4d:: with SMTP id if13mr1830852qvb.52.1642026474229;
        Wed, 12 Jan 2022 14:27:54 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id q27sm611842qki.100.2022.01.12.14.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 14:27:53 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        rdunlap@infradead.org, andy.shevchenko@gmail.com, hdanton@sina.com
Subject: [PATCH v13 1/3] MAINTAINERS: co-maintain LiteX platform
Date:   Wed, 12 Jan 2022 17:27:45 -0500
Message-Id: <20220112222747.3135585-2-gsomlo@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220112222747.3135585-1-gsomlo@gmail.com>
References: <20220112222747.3135585-1-gsomlo@gmail.com>
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
index 4430310b46c8..3dd79519b602 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11090,12 +11090,17 @@ F:	lib/list-test.c
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89963468784
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 21:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346078AbhLDUo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 15:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242568AbhLDUo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 15:44:56 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F274CC061751;
        Sat,  4 Dec 2021 12:41:29 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id g28so7253750qkk.9;
        Sat, 04 Dec 2021 12:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wGXPdAAibHvapEYyiWYm9DiPd3199z1fbEciyKqIT00=;
        b=AtYxjBh5EBVWZ8vVktgpd84VgRUvALoA22vCVNCgEZZu4oh2Bbp0hBFanXFZEU3+Tm
         PnNtpaqwK8jePA2eT92JlF85xwWSe6TfydPiM0Ioq01vRoYPg9ThAi6D1f7BlXSqdg12
         luGU2YTlbD+W+JMFzrdRkN32pYpcdRu+E1j6/jb5oCYJAykmpox0SkDs3+EvmPgJKKCi
         dwIevmiAuxPkFM9kmRKCtXrnUgpkxqZu5wyICOCsHcCJ2DzpKcn98i88dnl8D4xDQoQw
         kakZUnabzeSnO45BRxX4ShK/M+rieA/uX+SuePjTnrk1THQQLZXBEwCHGXkgn+lE28X1
         xkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wGXPdAAibHvapEYyiWYm9DiPd3199z1fbEciyKqIT00=;
        b=TV1fdzOYp2XZVbOc+84mOyQ7nyPHJnsyUVsTSOiR8IGvIn/QCahXVVFHzRcYX4nWVP
         i9QRjaHsAcSekb8khtqE4SY35mKxQ+Me2mowej/10h9jQXbBXOi3rBGhZUa0R9CyLvUn
         qYamBtiC9wdhBcs+P9cnnzjZXgxQ7h+Vv+XPWjvAk80x1ZClbfGF1wl8aubm6nlyvu83
         uiwobtvdYvxr9jOksaDtApDYkVbgoY9xjignt53no3qYGuvo4ArEz04TWuxWbEYF+lGO
         2dHBvZzbqwtpC1Wpe7HU3c3rYbj3DWeApMaHXwfEzAJKAezAyFpS+drTFDXThp5ZlURS
         kgnw==
X-Gm-Message-State: AOAM531aeSWhBltYeW4kZicr1+AAE+KPMhnRlv2YUm1Wf2fBOilob1+F
        I4re2ABdLt7BYAASM15TjbSiwvtEOaM3Rg==
X-Google-Smtp-Source: ABdhPJztZ5VBCc1XNPL6Pa7eeAu3IpnJaMQwGRE7rPaCJ1921DJzQ/rHkWyMLLOp31xbDp/BDn3LpQ==
X-Received: by 2002:a05:620a:27d0:: with SMTP id i16mr23774539qkp.440.1638650488944;
        Sat, 04 Dec 2021 12:41:28 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id c22sm4862480qtd.76.2021.12.04.12.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 12:41:28 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        rdunlap@infradead.org
Subject: [PATCH v2 1/3] MAINTAINERS: co-maintain LiteX platform
Date:   Sat,  4 Dec 2021 15:41:19 -0500
Message-Id: <20211204204121.2367127-2-gsomlo@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211204204121.2367127-1-gsomlo@gmail.com>
References: <20211204204121.2367127-1-gsomlo@gmail.com>
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


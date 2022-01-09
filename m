Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D8F488D52
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 00:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbiAIXUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 18:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbiAIXUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 18:20:12 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8692C061748;
        Sun,  9 Jan 2022 15:20:11 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id w27so13048004qkj.7;
        Sun, 09 Jan 2022 15:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RX0kdsfOklLt24ZT+yjhaSk0YeWPH6hrBAWuhkMAEW0=;
        b=T7jjmmaGhmyUDTLgss0QZ8VcOpmQDWO+4OhRf7gm/9acCtS9KZ2nw5eM5H9Gq0B1wM
         SNKf4eNSN4eZrEv7nny1iu6JFCnSS7J1E56n7qt4thnJHGJWn/JUAQl/p6dacxefhulO
         iTx1wP09nie/EWDeWO+M2z+2RewbYFHY/W9sTJZ4XFbmw7wD/+aSNrULGWFJ+lPWliKL
         t7b8WEp+MtAJihsbQhSZoPOoXlIVo7SHCz/1sgfNxun1APuT1gOXXOb2NsgTUo/uSiaM
         iLnF9IKgrW6S0jJXFTWfaNPGybnMQq0NN2iamhWDVOwP+w9M57IxBpG2FiuPj5GCaCpP
         /KPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RX0kdsfOklLt24ZT+yjhaSk0YeWPH6hrBAWuhkMAEW0=;
        b=n9kQ3AemeDf7ZBMuyMqgYiUkyBnDaWFXTGAVbnYLSW6T+ZNu0N70q0t+r2GgOW0jbL
         SmCnC8nXHTEIAq13a+6xxzHE24VqpqAJefvjD7jCrQ9To4pi6ONkFe7Aj61h2LYYIYmJ
         5s/GjcHr++KNAjVtcytxvxwvYhTbWXeMw2NTgyeq4qPbtx5YGKOpeijQStCXZo/YHGFu
         NjCFXFxU7uEhHzGCAzX0vWSr5lOGgfBMrpqlB3NWsM120SlnWc+cY2CE/1F7qgk0924Z
         9+7Xppt/rc1maHgytGtsBa8vSYdsN4rvd1Ko0Kqce3PKVbBMgo+bvLzvNCfmdu1lKSIP
         QMWg==
X-Gm-Message-State: AOAM532dbRfgHs7VVJI2eHr5gjPyG0zPjoMc4NQh/ogwV3J3SUkVeQWS
        oVSEyYlvomDGWF67DLpWGE6C7szVz8ZFBA==
X-Google-Smtp-Source: ABdhPJzqIBoPfa23pR0UgaftuGoUeHPLQiD93VkTh7pVwNDuk74pc6mwH5EfKQglTbTdw7L3DtNrig==
X-Received: by 2002:ae9:eb02:: with SMTP id b2mr50774232qkg.703.1641770410765;
        Sun, 09 Jan 2022 15:20:10 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id h9sm96061qkn.60.2022.01.09.15.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 15:20:10 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        rdunlap@infradead.org, andy.shevchenko@gmail.com, hdanton@sina.com
Subject: [PATCH v11 1/3] MAINTAINERS: co-maintain LiteX platform
Date:   Sun,  9 Jan 2022 18:20:01 -0500
Message-Id: <20220109232003.2573924-2-gsomlo@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220109232003.2573924-1-gsomlo@gmail.com>
References: <20220109232003.2573924-1-gsomlo@gmail.com>
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


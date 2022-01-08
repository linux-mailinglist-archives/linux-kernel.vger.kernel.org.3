Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD658488473
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 17:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbiAHQLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 11:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234649AbiAHQLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 11:11:42 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C446BC06173F;
        Sat,  8 Jan 2022 08:11:41 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id q4so8781685qvh.9;
        Sat, 08 Jan 2022 08:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RX0kdsfOklLt24ZT+yjhaSk0YeWPH6hrBAWuhkMAEW0=;
        b=mtiyk029DTjp9cH3Di76s6fr7vkOISk7f85dKwf9B34FNayOWiCvH9/divAqy51vzY
         RkndPvRkcWuZUSVPZB5QY66+WVFx5RA2ktf5GV4CA8DxosJoRWGm5FNlcUFOAAqnAkyg
         r17spugNj0Box8ZF55TG1ITxgxuyPVMsM1/EWehmnBh02ZvZxiPNFHFy9D5tdFcxOOyc
         zmDJHY4jkiUHX03XTamBK4uSrcthLNu6HTPwEgNo0yuE3hKP8k3tXEOGo+mh0UokHNJJ
         BA3tlXejtDShD0SGRGDQaSrsMfI966Efbx1IgAmwV68ySs5x/M5GnLl2nTH1/r4/haUK
         SfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RX0kdsfOklLt24ZT+yjhaSk0YeWPH6hrBAWuhkMAEW0=;
        b=5Rvsz+VXzFzjI0WkH6mEhM5D3bcq2GCPWL+P67UeroBB0ztVnPZk7xD6XcOoZi5wvi
         8PUxXA6DBxXU+IuZjCnSCkU5peA2yyMXtyYmGom5KljTK1LyMJi77m8vAu6FVnlN3BgW
         +pWaTnb2sl0yB68vHk8kK1Y4pNTrvO4s0DNI+7791D0gWAPeRCAN951MfylrK1tIkZqW
         dkzHoDyCCdMC7AtmNEj8UeT647Ct34EI2xuJpXhVKGjRYqA9jOp1gHE9GxHGpAJ6d/kT
         YwTgo0O2Faw7y6c/aegFpKhrfLLM7ASUifCyGh2c56ABZzreBZI8+1JE9al6nzEtDFPt
         Wteg==
X-Gm-Message-State: AOAM533RyFeMpWkTix9pzY0A1vZGyrAV4orIBGBo0R2VawCi9LtsR8Aw
        K60qaLklHHoPPwQvkTpV0schV1n9Tzy2pg==
X-Google-Smtp-Source: ABdhPJwcSoYlaojFpAp09aTqNjAFAjnfUDshtMcy19xVFnRdqLRy4HLtmBj50n4vtoGave4KnfV/uA==
X-Received: by 2002:a05:6214:f07:: with SMTP id gw7mr9050119qvb.6.1641658300810;
        Sat, 08 Jan 2022 08:11:40 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id bs9sm1207435qkb.87.2022.01.08.08.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 08:11:40 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        rdunlap@infradead.org, andy.shevchenko@gmail.com
Subject: [PATCH v9 1/3] MAINTAINERS: co-maintain LiteX platform
Date:   Sat,  8 Jan 2022 11:11:32 -0500
Message-Id: <20220108161134.2419279-2-gsomlo@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220108161134.2419279-1-gsomlo@gmail.com>
References: <20220108161134.2419279-1-gsomlo@gmail.com>
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


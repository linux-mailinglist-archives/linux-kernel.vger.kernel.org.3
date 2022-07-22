Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99B757E15A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 14:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbiGVMSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 08:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiGVMSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 08:18:39 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0012F01E;
        Fri, 22 Jul 2022 05:18:37 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id sz17so8273270ejc.9;
        Fri, 22 Jul 2022 05:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=CqpBW1kjZKS5TbNlu9QNscZqjrocfBTKosDo2l0WxdM=;
        b=JAgTikgqys0BU5lh0gzJigI2XttDfFyTny+eSxF/HE5AC63ff5bU1uaZ0BzoMpP4Xq
         JijOHnEey6CSg00QFx7kBXCWRoHZJeVGHx7SM6NKU5S411b+gy1U1eHUvAdJDCW67R6g
         5qLgW/UUf/2xJ6sATptZx8BFVPls9lpCi1B3VwFiIUjuo8YXTQcDVv7sZ6SnpG+cQW4g
         hLSqT0hw7HCK2otzTaOmjQbWyoSjmAqpQsXGTDOsgYxe0f56KUqaKGfHmGvKVLlq9MXI
         9QI5hujVJgq5/YQtMUTnX27wHj9gr66lkAAzS/ktZYk8P5rtYeYGdvG5wzNSt3/S73kS
         sd7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CqpBW1kjZKS5TbNlu9QNscZqjrocfBTKosDo2l0WxdM=;
        b=RCUnqUUFuVbP6+49Broo0aBQNhvymUtjnGeEEDrNKxHN7I3iX5tXpl9ZZ4rOYxU+0I
         sIA10YqXQgbv5RKnVBsA2t/Wei+yaPQL/zVio7BSF87MydunyZYTEvs+UHZkBHhcVE7x
         nLHfx2Vtizw/4EWU2oqUAcEBMGQC6N49oXvgG0uwF7G5I7Y2oTFKkX1DdueXVqcGyhVS
         bn3kHAira5T1xeuIJJBA2GZxOfocYU28yIgEdkJZ9HQbp/yCvgcHx9PCH1RQ6w30+ZY8
         tD1oA0+zGMqq3J9BSQp6G6NM3fe+y6wJAqI093zRmdCCxfcS/JV+3J7RmBz1Txj/2FKO
         neQA==
X-Gm-Message-State: AJIora8xrxLs8DfBaImSatWuPsMpQZctSWzDIYGRsC73MHHVNGLzHO4/
        i+qHyP3V0wZQnG+MUHBCt48=
X-Google-Smtp-Source: AGRyM1stUIp4zWap+2uKu/60jfi858DmwklKehCGWFlYeBJxwYCna7Sn7KJH6tNiqiCbk9RB9vW9HQ==
X-Received: by 2002:a17:906:cc52:b0:72b:114e:c56c with SMTP id mm18-20020a170906cc5200b0072b114ec56cmr298824ejb.144.1658492316338;
        Fri, 22 Jul 2022 05:18:36 -0700 (PDT)
Received: from felia.fritz.box (200116b826e64200edeeb77a6a94b0d2.dip.versatel-1u1.de. [2001:16b8:26e6:4200:edee:b77a:6a94:b0d2])
        by smtp.gmail.com with ESMTPSA id f21-20020a17090631d500b0072ee7b51d9asm1964129ejf.39.2022.07.22.05.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 05:18:35 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] x86/configs: update configs in x86_debug.config
Date:   Fri, 22 Jul 2022 14:18:15 +0200
Message-Id: <20220722121815.27535-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4675ff05de2d ("kmemcheck: rip it out") removes kmemcheck and its
corresponding build config KMEMCHECK.

Commit 0f620cefd775 ("objtool: Rename "VMLINUX_VALIDATION" ->
"NOINSTR_VALIDATION"") renamed the debug config option.

Adjust x86_debug.config to those changes in debug configs.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 kernel/configs/x86_debug.config | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/configs/x86_debug.config b/kernel/configs/x86_debug.config
index dcd86f32f4ed..6fac5b405334 100644
--- a/kernel/configs/x86_debug.config
+++ b/kernel/configs/x86_debug.config
@@ -7,12 +7,11 @@ CONFIG_DEBUG_SLAB=y
 CONFIG_DEBUG_KMEMLEAK=y
 CONFIG_DEBUG_PAGEALLOC=y
 CONFIG_SLUB_DEBUG_ON=y
-CONFIG_KMEMCHECK=y
 CONFIG_DEBUG_OBJECTS=y
 CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
 CONFIG_GCOV_KERNEL=y
 CONFIG_LOCKDEP=y
 CONFIG_PROVE_LOCKING=y
 CONFIG_SCHEDSTATS=y
-CONFIG_VMLINUX_VALIDATION=y
+CONFIG_NOINSTR_VALIDATION=y
 CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
-- 
2.17.1


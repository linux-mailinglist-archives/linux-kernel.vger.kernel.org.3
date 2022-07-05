Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B66566454
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 09:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbiGEHfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiGEHfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:35:10 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6153B13D2D;
        Tue,  5 Jul 2022 00:35:06 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g1so6524867edb.12;
        Tue, 05 Jul 2022 00:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=KFPReaWp4iE0d89rtMax+2rkd3ntUoznFB0WH//1SAU=;
        b=m3uILjjSJQCijcu1qUuoP3VOpsJ/Ubs4YcdgIBxpLPJKDw3l2snMT9W9/rbNdMBmGf
         /wbRZ0Vw+SBbmhicz+q0GY2eBHsBBQgtooCRRrcOCsxr/Z2qSJCqI17G9DJy/GmAKHUo
         BsaDJ0/67EcJnI9IeOTzWqwbiBlUks9bqteMjHuXTmiESC6NFiaK1gxe1wB3yDLEJmtn
         ml6QgN78n2oyKaQJbtaG3TuT66l7zq1CP5Frj0aP6lv7odq1Z8v6Yw8FgiMOQ62r8Sz0
         AN61lEh0kCwEL3aHkmodoa25g1QwbTvUFm+j/GWePT/gprOB79/jb5dSWpBrJiQg6Hkx
         BqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KFPReaWp4iE0d89rtMax+2rkd3ntUoznFB0WH//1SAU=;
        b=vjhJzrRKW65TY7jsLzMnCWXXP2LsS84HDBygT73BwVF9zEYTMXu0vo0+iQMSwrHQc8
         m9Hu61eJqXVaTxIqv1GMkCXWPMRye/cPbxM8BLXi37A68wyXi88+lCcb0zFH3hTBplcu
         6qSy3T1pwwGvwTIj4NXTnkmrHcrPtKy7aomcAgBnJfka/t4hkG/yFEzz92SCdkKKHI05
         Y/jfW5swbgv31WYCSd0aV0wdXoLxx8o523mvhW9iWFXrFSnN/Z6m8fXHMmUjN0h4pso5
         TMZ2Qamtlgoqs+rmYB/gUa48MhE1Tl0PSkolGnyvOTg4aXj3No3emq9Fq0jIMqZXHt0d
         ewdw==
X-Gm-Message-State: AJIora86cRmp9LHpxXaQ35aDHVT+xCnMz2gO4PjE8iCkpO2e+ctSYX4n
        9S2qsTix/Kdfd2O3pLS+Bnc=
X-Google-Smtp-Source: AGRyM1uRbTO5Hpq4pxJ0UjNa6FgGHVzoucgx5VAEsPXEiOToUzZLC69YAUmavOMzr5GzK5LRstnFOQ==
X-Received: by 2002:aa7:cf89:0:b0:43a:4e6b:50e4 with SMTP id z9-20020aa7cf89000000b0043a4e6b50e4mr13244256edx.108.1657006504765;
        Tue, 05 Jul 2022 00:35:04 -0700 (PDT)
Received: from felia.fritz.box (200116b82698ad00a9019cf0f015ae6b.dip.versatel-1u1.de. [2001:16b8:2698:ad00:a901:9cf0:f015:ae6b])
        by smtp.gmail.com with ESMTPSA id w3-20020a1709067c8300b00722fc0779e3sm15369282ejo.85.2022.07.05.00.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 00:35:04 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] LoongArch: drop these obsolete selects in Kconfig
Date:   Tue,  5 Jul 2022 09:34:05 +0200
Message-Id: <20220705073405.29618-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit fa96b57c1490 ("LoongArch: Add build infrastructure") adds the new
file arch/loongarch/Kconfig.

As the work on LoongArch was probably quite some time under development,
various config symbols have changed and disappeared from the time of
initial writing of the Kconfig file and its inclusion in the repository.

The following four commits:

  commit c126a53c2760 ("arch: remove GENERIC_FIND_FIRST_BIT entirely")
  commit 140c8180eb7c ("arch: remove HAVE_COPY_THREAD_TLS")
  commit aca52c398389 ("mm: remove CONFIG_HAVE_MEMBLOCK")
  commit 3f08a302f533 ("mm: remove CONFIG_HAVE_MEMBLOCK_NODE_MAP option")

remove the mentioned config symbol, and enable the intended setup by
default without configuration.

Drop these obsolete selects in loongarch's Kconfig.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Huacai Chen, please pick this minor clean-up patch.

 arch/loongarch/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 2dee595bf4b6..9be4d0eef299 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -54,7 +54,6 @@ config LOONGARCH
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_ENTRY
-	select GENERIC_FIND_FIRST_BIT
 	select GENERIC_GETTIMEOFDAY
 	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_IRQ_PROBE
@@ -77,7 +76,6 @@ config LOONGARCH
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_CONTEXT_TRACKING_USER
-	select HAVE_COPY_THREAD_TLS
 	select HAVE_DEBUG_STACKOVERFLOW
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_EXIT_THREAD
@@ -86,8 +84,6 @@ config LOONGARCH
 	select HAVE_IOREMAP_PROT
 	select HAVE_IRQ_EXIT_ON_IRQ_STACK
 	select HAVE_IRQ_TIME_ACCOUNTING
-	select HAVE_MEMBLOCK
-	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI
 	select HAVE_PERF_EVENTS
-- 
2.17.1


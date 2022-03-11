Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBB74D643C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 16:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245606AbiCKPDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 10:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348567AbiCKPDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 10:03:03 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29611A41C4;
        Fri, 11 Mar 2022 07:01:59 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id j26so13388609wrb.1;
        Fri, 11 Mar 2022 07:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=1yVENyOQOecnCsSm/L9M6oucS2QvVZWZizJODtkoods=;
        b=lP9AH/Mq+lqnhMiX7+ICJiv5rA2Rx6dYjSaD5FoDvC2n4AvxAqlCcD+GSYGDqLa5uG
         aBG6YNxasUJzJFQ5IwOkQQXKGDgXCzhnQQuu5e0vSNxHlZ29VIbyiZLVJrkJP7qpOgKR
         Rd7ABrWFT9x/4l2uwwxPVEp5r/LPOgXcNpUaSlJ+ZnYhbW5A1Vz5SjKVtbhZypJfdxf0
         QkquxXqZT4+CunOwCJ0DWdAS0JXkFFB1e7KppdivbCJDnG68vA/7JvUrrQ+BFykidqi/
         HxuMBIl4Pv6YHF+qY/XkC2A9++g6dQRP3qOxiA48UaAFdpCJUW52P5PKTOI7KNZ87A7y
         BXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1yVENyOQOecnCsSm/L9M6oucS2QvVZWZizJODtkoods=;
        b=foLJAce+7up76TS2KaXCl8rWKWd0OdZtZ4ChRJ1wKxuY2N31yAODCBaZ4Y/GuqumiJ
         qF5mTxQSOuWN2B2m8851KDh0TjIIFMhZM4F67cjPH2kYWJjBusWaIk+veYEpsuN91GYs
         GVWb1wU/cEfIEgz5PThV70rnJCcKNwaNnNhk2POhLPM0KkWpv9dwHNJxYBapuBYLo/8O
         88XcUPhJTfSMSdpxOOdcmTSr/l5uWnmXHW0gsCaltVDNtNIXdhnfMN/8PJG1R/ajeNCm
         On4KuicYGc5h33A+74m54XUmLO1uWNGZU/F1CBkm4n0P0twerk+Ev4NIbHQf0Q8rG+rz
         /QMg==
X-Gm-Message-State: AOAM531H0+zr3E6dtQcDF5gst++YqKSTCWQCfD0e9R6ptFaCXfA+K/Ra
        WAC5SnXKBzHagXZ4dFRmoo4=
X-Google-Smtp-Source: ABdhPJzRBzpsbQodY/pB/Rj59OPH2lLArF5pQU/85Pld/wnjXEm40fySqS3rCMmJaarhSqDiPpoocA==
X-Received: by 2002:adf:db43:0:b0:1ef:7195:43cd with SMTP id f3-20020adfdb43000000b001ef719543cdmr7664546wrj.495.1647010918239;
        Fri, 11 Mar 2022 07:01:58 -0800 (PST)
Received: from felia.fritz.box (200116b826a9a900147fc2a0771e144b.dip.versatel-1u1.de. [2001:16b8:26a9:a900:147f:c2a0:771e:144b])
        by smtp.gmail.com with ESMTPSA id a8-20020a05600c068800b00389bdc8c8c2sm6925800wmn.12.2022.03.11.07.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 07:01:57 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alan Kao <alankao@andestech.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] clocksource: remove left-over from removing the timer-atcpit100 driver
Date:   Fri, 11 Mar 2022 16:01:22 +0100
Message-Id: <20220311150122.23010-1-lukas.bulwahn@gmail.com>
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

Commit 3edb65f4e8fd ("nds32: Remove the architecture") removes the config
ATCPIT100_TIMER and its corresponding source file timer-atcpit100.c, but it
misses to remove the corresponding line in the clocksource Makefile.

So, remove this left-over of this driver removal in the Makefile now.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Arnd, please pick this minor clean-up to your nds32 architecture removal.

 drivers/clocksource/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index fa5f624eadb6..9c85ee2bb373 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -81,7 +81,6 @@ obj-$(CONFIG_INGENIC_SYSOST)	+= ingenic-sysost.o
 obj-$(CONFIG_INGENIC_TIMER)		+= ingenic-timer.o
 obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
 obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
-obj-$(CONFIG_ATCPIT100_TIMER)		+= timer-atcpit100.o
 obj-$(CONFIG_RISCV_TIMER)		+= timer-riscv.o
 obj-$(CONFIG_CLINT_TIMER)		+= timer-clint.o
 obj-$(CONFIG_CSKY_MP_TIMER)		+= timer-mp-csky.o
-- 
2.17.1


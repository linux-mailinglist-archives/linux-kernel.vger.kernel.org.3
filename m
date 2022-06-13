Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C15954997E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241524AbiFMREj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244014AbiFMRDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:03:10 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328F3E15C9;
        Mon, 13 Jun 2022 05:02:18 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id m24so6818923wrb.10;
        Mon, 13 Jun 2022 05:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=iAGGMDO3RCjpuDnI12s4tp/U5muUk3K/RmYbixGZ5cY=;
        b=j+Yp1Y4cfSfJ+AVrsnjA5ETWh4QdGa67V5H3ARF0m2zwsPeGShbVT/A0rxLFgS7AE0
         B+p6QFJQAaE8fSt1zafzR9UZz4dHWbcKCDUXgl9LvHF+LNUyubjgj1wdxuibfUQVIhks
         Sb7fIv4nDkYVEy2M3B9oaulLLD4zxcopEk7RNQnVkM/KPcx8zvoacWn8x7a54pyipETU
         j+eWgGryN0jSxoU510/DRai6znER5XoTmB6XxjZVN0NBL903fgFPzJITO96udsNy2Zd7
         sqSaHhLeI6KNgmBr1RVXlMqH2015r3QCdktca5AWw+QcpI4UU1BFPEoh+Jwg93RXshlW
         HP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iAGGMDO3RCjpuDnI12s4tp/U5muUk3K/RmYbixGZ5cY=;
        b=Jw6k0XYQ27MRtYqcQJb9Ddp4MI2hmz6IdJ85QQMEYEDVHy9vlfU2w8Z2xynWn3CMN8
         sUzzZq+n56BPavFJ/Ygv7e7g9i1jLeUaLMUMeXXVYkmALK8hZW6DEgUSjnI9HnffL6u6
         fRJ+HWdcMGRltHi8izdjLJZnZjukTtal4O67pqa9dkB/6486mDoDKQKbRm9cETmqeffv
         ItV9WFZ3hHqwtqDpTy+btQ8Umsy7fz/sUUWHD8eYGsT9OyhzI3nE917S4Uqhnm6JbHmj
         71fBpFzPFElfLT2GAnIOjz8Y1EV+DL2oKM0RBuoEwGYl9MGoi5hlaG/2BbUIcuNSvSQO
         RoOQ==
X-Gm-Message-State: AOAM532ka1v0xT8CLk5iMKNDeDN57NuUrgML3LApC43z3z6U876GTjFS
        /8anK2GsKdrZ5YTzKO0Trkgh6QyASFo=
X-Google-Smtp-Source: ABdhPJw6IDp5GNuZncI3s0NeFl8BYG40OMdVjI/u5bAvFe5hXAGcozpvJTybpIK+LUARmdlKWbENOg==
X-Received: by 2002:a05:6000:12c8:b0:213:584:3d7 with SMTP id l8-20020a05600012c800b00213058403d7mr57282336wrx.125.1655121736420;
        Mon, 13 Jun 2022 05:02:16 -0700 (PDT)
Received: from felia.fritz.box (200116b8260df50011e978c0f780de03.dip.versatel-1u1.de. [2001:16b8:260d:f500:11e9:78c0:f780:de03])
        by smtp.gmail.com with ESMTPSA id q1-20020adff501000000b002117ef160fbsm8437077wro.21.2022.06.13.05.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 05:02:16 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: add include/dt-bindings/interrupt-controller to IRQCHIP DRIVERS
Date:   Mon, 13 Jun 2022 14:02:05 +0200
Message-Id: <20220613120205.31311-1-lukas.bulwahn@gmail.com>
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

Maintainers of the directory
Documentation/devicetree/bindings/interrupt-controller are also the
maintainers of the corresponding directory
include/dt-bindings/interrupt-controller.

Add the file entry for include/dt-bindings/interrupt-controller to the
appropriate section in MAINTAINERS.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Thomas, Marc, please pick this MAINTAINERS addition to your section.

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 262ed53d544a..30f80e8fe775 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10490,6 +10490,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
 F:	Documentation/devicetree/bindings/interrupt-controller/
 F:	drivers/irqchip/
+F:	include/dt-bindings/interrupt-controller/
 
 ISA
 M:	William Breathitt Gray <vilhelm.gray@gmail.com>
-- 
2.17.1


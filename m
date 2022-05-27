Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FF5535BE4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241205AbiE0IrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349939AbiE0IrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:47:11 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5620911A02;
        Fri, 27 May 2022 01:47:06 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id x2-20020a17090a1f8200b001e07a64c461so6540617pja.4;
        Fri, 27 May 2022 01:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1jpCtih8HJgyW68o6KR64V8GJ0VawxK3es6v7QRKyJw=;
        b=dABeN5IhaNbT0d/E0jQ6AQ+j/QJ2a/m+7l8zd3WnZsxikFHdXpKZ/l5IYlu7MISXy8
         pH1PdzQ/aY9uvdYdNicd8qSKn4x/McWBOvcwpwEZ7tquvUyTax5relYVFD+ScaB4eVpU
         iZAbCp/rbiWxE/XUYqqWoPF+95qJWaDEbRIuP5W1NvJAl9lqHTGJJBrmauATwFtNJaeY
         3GHtjEH1zTnINj4jvLbqyR+03jv6vOkUQnp8tbUVItc3v7HYcyOiWxfarWfPC1Dm5yEy
         PHcSN6B7uSI2LXPhqgmUoS6o1LmBRAJDaQbeDMR7XnUKrc8RsVtS+PkI/lLuCr+/InaS
         YkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1jpCtih8HJgyW68o6KR64V8GJ0VawxK3es6v7QRKyJw=;
        b=1JE5Xs+3uhnHaWmwDD6kF2USQ1cpr/nxAWup8PkUM7M1oIkelqTIMtfT/QAmdIhvTo
         sfNuK+4bfZuS6wALd4EVqSPbydnGuZlCifGwTDWJY4ll2VvqI7yHgWzqvzs81XpN3Rqe
         eIEpRfF3OP6L/Pwud5UO8pN7LZVdU6Z5o9VNiymJmelUpyRO7QKLq3iNsdmA/KCILzX6
         cJgEYTwxXbGrpP6SzL55XNjsNbyKxASumU8BdkXxB7xvmWdFAhG0VE414kbFNH+eCqXv
         VtH9/ZgavgeAno0JfkMIPDAz9cCyTIeKr5nwUUroKVfoEoQm0s7QUWfwzvWnf5d+HBdV
         8odQ==
X-Gm-Message-State: AOAM531KRW5ZoWQlL04g19dS8gXhvA9Yk2+ahmFTe4DBxxmwNduEL6zB
        GDQYiZYw0biLumQaDzkVoto=
X-Google-Smtp-Source: ABdhPJx6GvW0RO3NwO0M/fzfJ3EnUsw1iHAYB7WXItKjDWOstPlptVPAkObWMd/Krn0l+S7ZVFGHSA==
X-Received: by 2002:a17:90b:224a:b0:1e0:f91:3a3f with SMTP id hk10-20020a17090b224a00b001e00f913a3fmr7217159pjb.62.1653641225636;
        Fri, 27 May 2022 01:47:05 -0700 (PDT)
Received: from localhost.localdomain ([116.89.143.231])
        by smtp.gmail.com with ESMTPSA id k12-20020a170902d58c00b0015e8d4eb1ebsm3003254plh.53.2022.05.27.01.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 01:47:05 -0700 (PDT)
From:   medadyoung@gmail.com
X-Google-Original-From: ctcchien@nuvoton.com
To:     benjaminfair@google.com, yuenn@google.com, venture@google.com,
        tali.perry1@gmail.com, tmaimon77@gmail.com, avifishman70@gmail.com,
        robh+dt@kernel.org, alexandre.belloni@bootlin.com,
        a.zummo@towertech.it, KWLIU@nuvoton.com, YSCHU@nuvoton.com,
        JJLIU0@nuvoton.com, KFTING@nuvoton.com, ctcchien@nuvoton.com
Cc:     openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: [PATCH v3 2/3] ARM: dts: nuvoton: Add nuvoton RTC3018Y node
Date:   Fri, 27 May 2022 16:46:46 +0800
Message-Id: <20220527084647.30835-3-ctcchien@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220527084647.30835-1-ctcchien@nuvoton.com>
References: <20220527084647.30835-1-ctcchien@nuvoton.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Medad CChien <ctcchien@nuvoton.com>

Add nuvoton real time clock RTC3018Y in I2C node

Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
---
 arch/arm/boot/dts/nuvoton-npcm750-evb.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
index 0334641f8829..d59fcd558665 100644
--- a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
+++ b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
@@ -202,6 +202,10 @@
 		reg = <0x48>;
 		status = "okay";
 	};
+	rtc0: rtc@6f {
+		compatible = "nuvoton,nct3018y";
+		reg = <0x6f>;
+	};
 };
 
 /* lm75 on EB */
-- 
2.17.1


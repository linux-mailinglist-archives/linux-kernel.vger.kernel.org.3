Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25E657109D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 05:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbiGLDFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 23:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbiGLDFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 23:05:30 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC3B61D68;
        Mon, 11 Jul 2022 20:05:26 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id fz10so6449664pjb.2;
        Mon, 11 Jul 2022 20:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=05adq9e2iMCT+akFGqC1jijiEVT2oaWGy/uJ53ipCKA=;
        b=e2CnBfGjGyKQC/pNJKfHZAbKF1cIH8PIgt/TuZnqtd2T3UxUwAn9GteVMJTFtbtgci
         R9lO2NsTRxSaPonPwhXWaUoYuLTs96d1VQLz+O/L1wUicriqDzv2x78WJXI1md/ytsDy
         4ybNrB1xNsJlGiaS2XAQbUIB/N3WncfFT3BBG28pUOGouy3scF8qTqP1s/0BzEpSabfA
         JBOgWF0vU3clgA1Y4WBIzmxxjYr/YqdRAYqQyEZgZq+B1/R3BzfEuQe16FNT+vLMuazC
         yT1Bw1k6mIamopWL5eYYFRukyZvdas7XfQ+ZsdF18VMsmZutNMoqz2u7H5cn00BKEUy7
         CcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=05adq9e2iMCT+akFGqC1jijiEVT2oaWGy/uJ53ipCKA=;
        b=nWoeTSSar1Yvcggbn9uw+eKlxAThqpqPYOP8AYhqIc5ctfVRh6L+bn+kZohS+of2FT
         Ae/CQboSj4NY3qE5nsVKqTHyrYJyR0RSnqK04AbjzsDNQTYchae+zXUC6VkwCQ8B+A94
         9SEnc0xIwaGHsqJqSebe0QEFBk1qhGkXdlxqcGDjWrDbYVnLU17RTgg1iXTP+5Im6bYr
         7q2zVTjPLZ7ZRB3ADBw/kfGwssSotcVBA+4DT1vqXSje+0hlG6lC+Y5byeJKMpv34X9c
         VKTxIr+4nDICZvq6kuattwguGLbaovKp+Mw6khSPhzIgxh6buUHnqX6zY1yYpxAfgliz
         43vw==
X-Gm-Message-State: AJIora+u5roe9E1FhA4DVCxqwzEA59e610nIOdoJ0+2U+BIoVBPjY8Y1
        SiDRALVdlSRt9QV/bNJV4Ho=
X-Google-Smtp-Source: AGRyM1u1HUBjsLpUEO3STtFbE3ZazJYVV6Oto91CMCYjE26Gbgl5aOUCcWttZSCYbBU4MO4vCMF6bw==
X-Received: by 2002:a17:90a:6b45:b0:1e3:3cfa:3104 with SMTP id x5-20020a17090a6b4500b001e33cfa3104mr1746254pjl.113.1657595126238;
        Mon, 11 Jul 2022 20:05:26 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id i68-20020a626d47000000b005255263a864sm5467642pfc.169.2022.07.11.20.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 20:05:25 -0700 (PDT)
From:   Mia Lin <mimi05633@gmail.com>
To:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        ctcchien@nuvoton.com, medadyoung@gmail.com, mimi05633@gmail.com,
        KWLIU@nuvoton.com, YSCHU@nuvoton.com, KFTING@nuvoton.com,
        JJLIU0@nuvoton.com, mylin1@nuvoton.com
Cc:     openbmc@lists.ozlabs.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/3] ARM: dts: nuvoton: Add nuvoton RTC3018Y node
Date:   Tue, 12 Jul 2022 11:05:08 +0800
Message-Id: <20220712030509.23904-3-mimi05633@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220712030509.23904-1-mimi05633@gmail.com>
References: <20220712030509.23904-1-mimi05633@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nuvoton real time clock RTC3018Y in I2C node

Signed-off-by: Mia Lin <mimi05633@gmail.com>
---
 arch/arm/boot/dts/nuvoton-npcm750-evb.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
index 3dad32834e5e..589aadb67688 100644
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


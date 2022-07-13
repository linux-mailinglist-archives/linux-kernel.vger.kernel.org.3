Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA7C57320A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbiGMJHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235303AbiGMJHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:07:06 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD0EEA160;
        Wed, 13 Jul 2022 02:07:05 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id i8-20020a17090a4b8800b001ef8a65bfbdso2555569pjh.1;
        Wed, 13 Jul 2022 02:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4V5vh8DXeM0COdtFgoDP2qDwOY6Wrz0D8EvRqSBB7X8=;
        b=SNGEFGGcQLJsDZ7sHgtHXmK7NehDk55BHCztWTNOq8nGsxZYeLEd1+gwfOOr1RW7wf
         o0ctWHOHg/I/Je69BYhpj5qoxeVpy7A7SWsbGvGM7yy3gGULUxRCwObwKpIaurShpN7w
         tSuUu1Rsupd8sY9LPbYj7OytcN9+6X4/x4Hd8g7s913kmT9/NQn/UAQkGYnaQ3K9liVX
         fNp/FN/3cVk4j9N3nPx+Lo+ALAsx1u7a4PcybM/K4pb9QBP/a0dVVTSlmNuwER2jU0hm
         974/dVydRJ5WiSImF3nmLBzm8vtge1nUoCtTsYTaf0Cc5QBKfBUBkrRxqWSe5D3xPtr2
         i1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4V5vh8DXeM0COdtFgoDP2qDwOY6Wrz0D8EvRqSBB7X8=;
        b=JyhptwTCbKsH8PI/zsRvY30Oala2LuD30Sf4LFq54/XnQxGRzrszHHzyifkK4r9gYj
         MbUVraBPT9OHdvCte5QvJ1RHF2RncNy/+Kg87GMkkRiml8JibX4MITe7j6fi8alCPU6l
         hn5sZ+AugNodA1qnNdSurNUJlMTLuVFRUTH+dJHPmNnvNqUM6BAqXvfSmpcxGDZuYJms
         b68uud8dJNMz7VUUq8Ey0SRnnfu5xMlgMyowgqpJyXYtpYCk1cRZo7J+l8MoVBKdDm8S
         5A4RT2mP9N81Lgv2FJzAfpaDZ2c1kljtui9wj6fIPb3vzosmZGPk4fXRhV/kZVheU/zn
         5iGA==
X-Gm-Message-State: AJIora9vYdx5/QtgBcoEVHMXzjZqkIpNpiT2ityVsD7UpVeSNU+oSoWK
        U/HKkxVWy0oFFVUALkOyWtg=
X-Google-Smtp-Source: AGRyM1vTiNDy6PQzA0eiQxZP9EmoR2z6AwboFWsD0r4yqcmTYeyR50aauJEXi1HK3ZfXdEWgWk6zyA==
X-Received: by 2002:a17:902:ecca:b0:16b:d519:d1df with SMTP id a10-20020a170902ecca00b0016bd519d1dfmr2144404plh.170.1657703224668;
        Wed, 13 Jul 2022 02:07:04 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id gg10-20020a17090b0a0a00b001ef917f1c30sm1051975pjb.6.2022.07.13.02.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 02:07:04 -0700 (PDT)
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
Subject: [PATCH v6 2/3] ARM: dts: nuvoton: Add nuvoton RTC3018Y node
Date:   Wed, 13 Jul 2022 17:06:46 +0800
Message-Id: <20220713090647.8028-3-mimi05633@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220713090647.8028-1-mimi05633@gmail.com>
References: <20220713090647.8028-1-mimi05633@gmail.com>
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
 arch/arm/boot/dts/nuvoton-npcm750-evb.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
index 3dad32834e5e..2b0597d7b109 100644
--- a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
+++ b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
@@ -202,6 +202,11 @@
 		reg = <0x48>;
 		status = "okay";
 	};
+
+	rtc0: rtc@6f {
+		compatible = "nuvoton,nct3018y";
+		reg = <0x6f>;
+	};
 };
 
 /* lm75 on EB */
-- 
2.17.1


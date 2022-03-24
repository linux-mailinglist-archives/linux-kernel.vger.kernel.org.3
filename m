Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2F64E6395
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 13:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350320AbiCXMqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 08:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350282AbiCXMqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 08:46:15 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116FE3B3FD
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 05:44:33 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id e5so4579183pls.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 05:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V3tFbH35BFupdR5bw1hQ7Wrji66feBlGYcQAWCV7aQM=;
        b=ceyT+O0AlPmogMlbBEf0jmw/Z26cnyOFpgkiYjvQXlXJoHkP8J4lAjcaMJIqY+EBTY
         y5AYcKxoM0O+vEtt4C60iahHShQ9MeHn7EVXj4LTs4JIfw9c9et361Uhy/nUAXJW+/xT
         +sbe0c9Tzke8XuUiPnnO6pXrp0TwLsjlFskgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V3tFbH35BFupdR5bw1hQ7Wrji66feBlGYcQAWCV7aQM=;
        b=0Ic+uAO4HsuGA0IWhBcu02z1Fs/kERB4FEV5HDxuvyVMiRAvi8NtXSj+rvml6DiG/p
         r22lITFdtDe34UjVGxfXLt7qTHJBUscu1QF2Buee/SNmIz8HmazdgqIwrQGAoW+wy9Su
         FgKlmMcqHMK2ydFo8pcFkgdlXybRkJE7QiJTP0yxEaZkQBo2w3aXZ15iiCvikExzPqIC
         atvjBA/FgmpNtzqO/Qz4elnm5+WM4PGYqwI18wSfgpPkQmMY05nuLT4sep0+Qgm+Wwg+
         EgsPcwkHcuE1M2fCv91T6P++zaKLrow24xYI5jrvRnoHrgccLkYoi2rIXmS/A0UEspVs
         c2sQ==
X-Gm-Message-State: AOAM531Se4f0sfPfO7YBoIIOqV/9vYB4jOL2+XLtrecWCBG0Sni4Vysd
        PhjDKh/HOkHxnpN6qCNGnlpiNA==
X-Google-Smtp-Source: ABdhPJxP42NMb0GQrTrXWtdr66SfCJdveNo9QEKIWJol7H+ZIpB+Eao3a8ALGd36qKQJGXCtv+cUHA==
X-Received: by 2002:a17:902:f291:b0:153:caaf:17fd with SMTP id k17-20020a170902f29100b00153caaf17fdmr5655877plc.89.1648125872376;
        Thu, 24 Mar 2022 05:44:32 -0700 (PDT)
Received: from shiro.work ([2400:4162:2428:2f01:7285:c2ff:fe8e:66d7])
        by smtp.googlemail.com with ESMTPSA id t10-20020a056a00138a00b004fa9c9fda44sm3786924pfg.89.2022.03.24.05.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 05:44:32 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        robh+dt@kernel.org, andriy.shevchenko@linux.intel.com,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        romain.perier@gmail.com, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 4/4] ARM: dts: mstar: Add second UART to base dtsi.
Date:   Thu, 24 Mar 2022 21:44:02 +0900
Message-Id: <20220324124402.3631379-5-daniel@0x0f.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220324124402.3631379-1-daniel@0x0f.com>
References: <20220324124402.3631379-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the second UART to the base dtsi.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mstar-v7.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-v7.dtsi
index 8464a8f1b136..baf2422b9854 100644
--- a/arch/arm/boot/dts/mstar-v7.dtsi
+++ b/arch/arm/boot/dts/mstar-v7.dtsi
@@ -182,6 +182,14 @@ pm_uart: uart@221000 {
 				clock-frequency = <172000000>;
 				status = "disabled";
 			};
+
+			uart1: uart@221200 {
+				compatible = "mstar,msc313-uart", "snps,dw-apb-uart";
+				reg = <0x221200 0x100>;
+				reg-shift = <3>;
+				interrupts-extended = <&intc_irq GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
 		};
 
 		imi: sram@a0000000 {
-- 
2.35.1


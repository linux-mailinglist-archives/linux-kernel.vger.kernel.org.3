Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FC24E62E7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 13:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241040AbiCXMF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 08:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240561AbiCXMFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 08:05:25 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEB773058
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 05:03:53 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id kk12so3480674qvb.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 05:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sudomaker-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:cc:content-transfer-encoding;
        bh=Kz4iA6KqJV9uzV+BYANL/gXvpw1uEKQkCs0gn42rH14=;
        b=y7ZwZVBZHuA4z4ti4u+ZOBr/58NfwmM1J/nd1+movFumZ8sbUJnSXf7zqWHTYzDk+M
         V2WNhMzccWHE41jy9TUraA7cIBCCPzNieQcZOmuGLUCZFkT8+EtjoG2Nc1t33jkrUkMx
         ZZqZ8t0oDuTj+LSR4f8997BZjx9/I7JFQQ+xBUROKWhETM0qgU2RRbYjXPMHNmq05qkw
         IXwTIgAVB5ZYTA2xYYL98uUXR9TH1jqs2iUJnZ5sfWaG1KqvdDl2BKJUMcrk+OgdtRjs
         C+82yQ5ttNA1f95DmBN/H8AmLaEafP4fo8LTNoD2EjtXhXebJnLqZD9uxZbbB/Hgkx7V
         Glrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:cc:content-transfer-encoding;
        bh=Kz4iA6KqJV9uzV+BYANL/gXvpw1uEKQkCs0gn42rH14=;
        b=I23Tfj+VDk/2NW8EzqiLjudFHD0ejP9BU3w95HHLWLGP56OTtdMurgR0r9U5l4GwmL
         jDF48seT0/3iKZiVy3t1nJ/9TzcWgiVxPjp+oYQdSmtsvhlP6LkVP91skgWPAIMqr28q
         UWbTKU8/S0SwNIlUBVcQf+xfQfK1yotiHH4yJiPZQ81f5ABHQIelbpJPqLvJC1z00DCO
         4u7kR9MCj0U720yVkYcN0f+EqpnjoocTgbCpIps4kmvAvQst712czqEO38pGey9/0Qg+
         tIpqwY3DhTNK9TTJQ5Jx2pa7ZQMnj+wcagHgQioadw8mg9SaKFtyoz59+fqqYW62QKpa
         Unmw==
X-Gm-Message-State: AOAM530IEuAVMqRFLHKX6DkldtRG/ynQuLnQMEEGz7HI4Zf5K1O74sWN
        qlOHjqgJHnuNodpiMZT81kTnYg==
X-Google-Smtp-Source: ABdhPJwsjr1NlcuiJRHLf1ye/k1lyNAx4jJu2Os1jFdqbUIturc2qoNSbpyBwQhWuktI6x+OaMzftg==
X-Received: by 2002:ad4:5945:0:b0:441:72ae:b6c0 with SMTP id eo5-20020ad45945000000b0044172aeb6c0mr1198641qvb.11.1648123432002;
        Thu, 24 Mar 2022 05:03:52 -0700 (PDT)
Received: from [172.16.24.11] ([91.219.212.226])
        by smtp.gmail.com with ESMTPSA id v5-20020a05622a144500b002e1c7d027b1sm2115461qtx.66.2022.03.24.05.03.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 05:03:51 -0700 (PDT)
Message-ID: <ea710c27-00e9-065c-77a3-78e3c5f73ed3@sudomaker.com>
Date:   Thu, 24 Mar 2022 20:04:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     linux-mips@vger.kernel.org
From:   Yunian Yang <reimu@sudomaker.com>
Subject: [PATCH] pinctrl: Ingenic: Add missing UART2 group C for X1000/E
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

X1000/E has a third UART2 pin group selection, which uses the TDI(G2) as RX
and TDO(G1) as TX. This configuration is becoming increasingly popular in
newer core boards, such as the Halley2 v4.1. This is done by enabling
function 1 of a "virtual pin" PC31. See section 19.3.3 of the X1000
Programming Manual for details.

Signed-off-by: Yunian Yang <reimu@sudomaker.com>
---
 drivers/pinctrl/pinctrl-ingenic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
index 2712f51eb238..29709059d62b 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -1982,6 +1982,7 @@ static int x1000_uart1_data_a_pins[] = { 0x04, 0x05, };
 static int x1000_uart1_data_d_pins[] = { 0x62, 0x63, };
 static int x1000_uart1_hwflow_pins[] = { 0x64, 0x65, };
 static int x1000_uart2_data_a_pins[] = { 0x02, 0x03, };
+static int x1000_uart2_data_c_pins[] = { 0x5f, 0x5f, };
 static int x1000_uart2_data_d_pins[] = { 0x65, 0x64, };
 static int x1000_sfc_data_pins[] = { 0x1d, 0x1c, 0x1e, 0x1f, };
 static int x1000_sfc_clk_pins[] = { 0x1a, };
@@ -2058,6 +2059,7 @@ static const struct group_desc x1000_groups[] = {
        INGENIC_PIN_GROUP("uart1-data-d", x1000_uart1_data_d, 1),
        INGENIC_PIN_GROUP("uart1-hwflow", x1000_uart1_hwflow, 1),
        INGENIC_PIN_GROUP("uart2-data-a", x1000_uart2_data_a, 2),
+       INGENIC_PIN_GROUP("uart2-data-c", x1000_uart2_data_c, 1),
        INGENIC_PIN_GROUP("uart2-data-d", x1000_uart2_data_d, 0),
        INGENIC_PIN_GROUP("sfc-data", x1000_sfc_data, 1),
        INGENIC_PIN_GROUP("sfc-clk", x1000_sfc_clk, 1),
@@ -2115,7 +2117,7 @@ static const char *x1000_uart0_groups[] = { "uart0-data", "uart0-hwflow", };
 static const char *x1000_uart1_groups[] = {
        "uart1-data-a", "uart1-data-d", "uart1-hwflow",
 };
-static const char *x1000_uart2_groups[] = { "uart2-data-a", "uart2-data-d", };
+static const char *x1000_uart2_groups[] = { "uart2-data-a", "uart2-data-c", "uart2-data-d", };
 static const char *x1000_sfc_groups[] = { "sfc-data", "sfc-clk", "sfc-ce", };
 static const char *x1000_ssi_groups[] = {
        "ssi-dt-a-22", "ssi-dt-a-29", "ssi-dt-d",
-- 
2.30.2

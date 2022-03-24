Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0513C4E6423
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 14:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350469AbiCXNeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 09:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347487AbiCXNea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 09:34:30 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D4C673F5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 06:32:58 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id b8so4725675pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 06:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sudomaker-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=75FAhg7ylyX6XEBGLysUXp5VSnyJLA+NWdXC9mRc8EU=;
        b=pkT6l00uQAYufLH6x0kHxfpvetooqkrAw2dkiXm6VDiWZ5KRP7TSFbVqCDOJFet3oN
         pMlQnJlo0UoKurs+3+XFhu6Q7cToGDwmXiDu66D/8co2f192WyWuvWq/qSMDS2ieOjJU
         EBrIB2MWGteb2P3VeXWbKfEUT//bGlIZj0sacaxe0itk7ggoGRUwrG9PmIOW+OtcfBye
         IOA3xYv78dOebNL1eQiSs82M+Q3RXq8HLNmrUSsAd5w0GwnRMJzeNLrScHB8fEE8sRZp
         AzfEdIXBWbldTEq3T1Rj1PXhgYxD3ivLueQtU2XsCMMbl9z1/PO24Qx5SFpmtkc5d8XE
         wrtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=75FAhg7ylyX6XEBGLysUXp5VSnyJLA+NWdXC9mRc8EU=;
        b=Nt3P3s643/vNiChi34G6JgvEaV+xPyXJZQshsMFMnarf/kXoArSN6byluyamWRKcMr
         Rr5rsVEMQlWMNPC+z9JUK1dO7WgvnbS4ZFpWpG/nsnXQBKxNkaPFWtqmkIkmkuTMb+Mj
         FUvER0R5Yf0FIJt/kUZtysn8mrM9KHzIdkWmOyqQmLtxbUvWDrbLvYu5W0q2Hh5kD9V4
         fNCmldis/DBIPDqLLX/ISbKdht7X49tgppj12c8hNlh/mPlX0Ia99LablSXIPYahlHYy
         dezHOlhnp2HGC9ezgVLuofxEzN+ebTwuro13xe1SZDKHDiUpvv7DAHpyiWEpSW9Tdhrd
         jlqQ==
X-Gm-Message-State: AOAM532y95flOT7+3Dpm1goaK+R8QRjNSzYk9vcDeRTxKfzbIlBS9EPn
        A6UCvH7JZmP/iYmF3YyIlS2O2Q==
X-Google-Smtp-Source: ABdhPJzoXRy49uxDBJA3UKKT2I008OKXOBombfEYT3bbvuPIhL41CCvrku4Dwmig5kKyDYefEmYZgA==
X-Received: by 2002:a17:90a:7147:b0:1bd:24ac:13bd with SMTP id g7-20020a17090a714700b001bd24ac13bdmr18453689pjs.70.1648128777770;
        Thu, 24 Mar 2022 06:32:57 -0700 (PDT)
Received: from [172.16.24.11] ([91.219.212.226])
        by smtp.gmail.com with ESMTPSA id f21-20020a056a00239500b004fb02a7a45bsm489463pfc.214.2022.03.24.06.32.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 06:32:57 -0700 (PDT)
Message-ID: <fd813c7d-888a-ce53-b1e5-d9b41003b58b@sudomaker.com>
Date:   Thu, 24 Mar 2022 21:33:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   Yunian Yang <reimu@sudomaker.com>
Subject: [PATCH v2] pinctrl: Ingenic: Add missing UART2 group C for X1000/E
To:     linux-mips@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Language: en-US
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

v2: Define PC31 pin only once, noted by Paul Cercueil <paul@crapouillou.net>
    Confirmed to work on hardware. Although the Ingenic folks did this twice
    in their 4.4 kernel fork; not sure why.

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
+static int x1000_uart2_data_c_pins[] = { 0x5f, };
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

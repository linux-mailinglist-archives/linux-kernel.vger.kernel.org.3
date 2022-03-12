Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A514D6E7D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 12:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbiCLLkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 06:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiCLLkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 06:40:13 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995501FE55B;
        Sat, 12 Mar 2022 03:39:08 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id c11so9630891pgu.11;
        Sat, 12 Mar 2022 03:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e0KrcMLcDxteHgAIf4ui0oBzzkOeXMM4aMrLQw5t4BE=;
        b=cQzFdPJ9/wKcoTjQ4dVMyC96JqGRGgFzJTG8bMN+/1wZoGAMzmDmI6jc3e2JLvpaz3
         grL59IoNtXNsetC8ui76w6dHRJKhwqA0cdKTTB5p4j27j7Zk6qLaxpJNFsuVrTL9WU4I
         VD3TySc0sbQrGLkrNG+4BX36RskeIs3BClFygo94CBes1mzeJ3NPsGShJSLkQyL0f66m
         QGxqRkThsfcvUbqQ+zQKO8Ges6ctaFpzWzgnBqET2vR5jO4UP/ke2dCoTUEPPT0VchQK
         vJA1q6uiwgrzlH3B4SzKYsRGjpjBSjm75Frs2Jh9u37ONx85EAunyHMu9I1N7mXfLxD3
         gV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e0KrcMLcDxteHgAIf4ui0oBzzkOeXMM4aMrLQw5t4BE=;
        b=qEl0RgQ2eYaqBC/tVy14BccJqk7A8L98XM51KkNpCU+HSBuqg0P/a4QnSoGdDdkpyO
         fme6VNG6mjUQLNft83FlGyMsUnb2bLsl8i5nrrG0NvmRC/cW2vOrmhUE6JFlzQ60aA6S
         gPmbOPAskBtrqHrm4P7lhgCWwnz5/btOT2iUiC5K7HyV2LpkS7CmpkjLUqI8d3bX8PnP
         n0PgNk7bgxP0c/XiogeYE7rY9maSLZswmn/gL1U6XMd9LPqv+XB1GZIgiUxVxbX8vKyN
         UM0NxL4Pf6T+/yrt48idrygV627GUnGsF71t9Y4HWQ1EVhApnRcqPhvYyf1CwNK70/EG
         2v0A==
X-Gm-Message-State: AOAM531Sj79GlNaHfX0PmbjlFtPhRf3trjfhXW+sNo7f2hC//1/bkuAX
        lvYNysFKvdCugg2v2L+5/eg=
X-Google-Smtp-Source: ABdhPJzl4neb3XZV80ydO7yZBVq3plfQEep1GVJ6n8lvPZ1G2tBv1Ott75dG4F0qY73dzwQDMgwmag==
X-Received: by 2002:aa7:968b:0:b0:4f6:fa51:c239 with SMTP id f11-20020aa7968b000000b004f6fa51c239mr14738133pfk.48.1647085148128;
        Sat, 12 Mar 2022 03:39:08 -0800 (PST)
Received: from localhost.localdomain ([122.161.53.68])
        by smtp.gmail.com with ESMTPSA id h6-20020a636c06000000b00363a2533b17sm11065191pgc.8.2022.03.12.03.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 03:39:07 -0800 (PST)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] ARM: dts: versatile: Update spi clock-names property
Date:   Sat, 12 Mar 2022 17:08:52 +0530
Message-Id: <20220312113853.63446-4-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220312113853.63446-1-singh.kuldeep87k@gmail.com>
References: <20220312113853.63446-1-singh.kuldeep87k@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that spi pl022 binding only accept "sspclk" as clock name, versatile
platform with "SSPCLK" clock name start raising dtbs_check warnings.
Make necessary changes to update this property in order to make it
compliant with binding.

clock-names:0: 'sspclk' was expected

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
v3:
- Reword commit message

v2:
- Split patches as per platform

 arch/arm/boot/dts/versatile-ab.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/versatile-ab.dts b/arch/arm/boot/dts/versatile-ab.dts
index 79f7cc241282..a520615f4d8d 100644
--- a/arch/arm/boot/dts/versatile-ab.dts
+++ b/arch/arm/boot/dts/versatile-ab.dts
@@ -391,7 +391,7 @@ spi@101f4000 {
 			reg = <0x101f4000 0x1000>;
 			interrupts = <11>;
 			clocks = <&xtal24mhz>, <&pclk>;
-			clock-names = "SSPCLK", "apb_pclk";
+			clock-names = "sspclk", "apb_pclk";
 		};
 
 		fpga {
-- 
2.25.1


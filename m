Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5D44D090C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 21:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241455AbiCGU4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 15:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245555AbiCGUzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 15:55:49 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE63C43389;
        Mon,  7 Mar 2022 12:54:07 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id z12-20020a17090ad78c00b001bf022b69d6so355810pju.2;
        Mon, 07 Mar 2022 12:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RQY33zFzPEcdA0rxFIRnz2QKmvyggwGuYCR89ghIkIQ=;
        b=ek2XwL6fSGdye1Xk4tLCfDcBvfNxdfUY+yqyJrKgM58C/hSwgBQhDQfWah3tcikXO+
         8imiqLtad55T8sP2E2gehgBGU2ove04Ahz3EfxG0uNbjnOH7L0J7ZgxtTiqM+bYhCaHr
         TaClv8T17aLPSxeBKAQIQkKr3lTQSKBBkmYistJB8FvhsLC7RdNvI3fLAvfa8WDE4qtO
         CR2poraGbQ7+KRK7VOZr0wBfZePbUWJhXKsySrLy6PuoYQzihSFRTyuzX50jf1RmPN4E
         yg/rmZGn4eZO3j78xTbAXTySt0wVEb0VcJMJFOluq1ZhXk6q3OMKRyp+xEW6szIFf4js
         rFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RQY33zFzPEcdA0rxFIRnz2QKmvyggwGuYCR89ghIkIQ=;
        b=u/2fGnZQLsh895tjUCrCWndcgX1VrvjcVMkoJdCQMXL2MXQ1YhRMs90EAyHAhL4eF6
         vQbyg3mmwpsOPSOqQ1V8u773XQHWgbX5IM09NfNxHUsY1By+SOHvUfpZ9jHWpV2+Cc4U
         rgBQj8ygNenJ84C6njcZ+Sof3Y8cJr0LEiBb18jTS1bxYUHqpvJ+ePnbd7nWaxEGWebv
         ZZjrqjQFBwzQagkUuvE9nF91yn2n7+L/DPKf7JPgD0JJtGeoCEq9ZNP6399W1r4hb/7a
         nnsatTBqgjOeC4M8oR7yVbNt50pDnQjTBv86r/T4rKE2CG6IbtemSjKZM3yXXrN2oOdB
         hffQ==
X-Gm-Message-State: AOAM530KQLiIHM6ySQ4nydJp/XPDONoiMSmvgGt6/mwQvTaTFaehNN/6
        yNTMJeZMiNTwCkJdEvEepwE=
X-Google-Smtp-Source: ABdhPJxe91dZpSDQcdiquNcLG+LPczYkSJlASZrWSq8UtX6OrvzmP9hEP5+NwVQX4EbIQ1vxnmdxpA==
X-Received: by 2002:a17:90a:5d93:b0:1bc:4f9c:8eed with SMTP id t19-20020a17090a5d9300b001bc4f9c8eedmr901969pji.180.1646686446961;
        Mon, 07 Mar 2022 12:54:06 -0800 (PST)
Received: from localhost.localdomain ([122.161.53.68])
        by smtp.gmail.com with ESMTPSA id a12-20020a056a000c8c00b004e1a76f0a8asm17676794pfv.51.2022.03.07.12.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 12:54:06 -0800 (PST)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 2/2] arm: dts: integrator: Update spi node properties
Date:   Tue,  8 Mar 2022 02:23:57 +0530
Message-Id: <20220307205357.66322-3-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307205357.66322-1-singh.kuldeep87k@gmail.com>
References: <20220307205357.66322-1-singh.kuldeep87k@gmail.com>
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

SPI clock name for pl022 is "sspclk" and not "spiclk".
Fix below dtc warning:
clock-names:0: 'spiclk' is not one of ['SSPCLK', 'sspclk']

Also, update node name to spi instead of ssp to enable spi bindings
check.

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
 arch/arm/boot/dts/integratorap-im-pd1.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/integratorap-im-pd1.dts b/arch/arm/boot/dts/integratorap-im-pd1.dts
index d47bfb66d069..ebe938556645 100644
--- a/arch/arm/boot/dts/integratorap-im-pd1.dts
+++ b/arch/arm/boot/dts/integratorap-im-pd1.dts
@@ -178,12 +178,12 @@ uart@200000 {
 		clock-names = "uartclk", "apb_pclk";
 	};
 
-	ssp@300000 {
+	ssp0: spi@300000 {
 		compatible = "arm,pl022", "arm,primecell";
 		reg = <0x00300000 0x1000>;
 		interrupts-extended = <&impd1_vic 3>;
 		clocks = <&impd1_sspclk>, <&sysclk>;
-		clock-names = "spiclk", "apb_pclk";
+		clock-names = "sspclk", "apb_pclk";
 	};
 
 	impd1_gpio0: gpio@400000 {
-- 
2.25.1


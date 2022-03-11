Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CBF4D5FC9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 11:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348036AbiCKKht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 05:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241650AbiCKKhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:37:45 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7891BD9B3;
        Fri, 11 Mar 2022 02:36:43 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id h5so5982441plf.7;
        Fri, 11 Mar 2022 02:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c1ArGb132dwkOm4680FsYBXBNSi2Z/rYOpSaV1vjGQc=;
        b=fUjlExSM51+EYddf3Dug3I1A6EYczq8OONkhZYkXLG/tSYB2leTFbYBULrKHMaN4yZ
         vKIqNLJdZ0dsfXHHytWI8Y0LKL06sA4KGnJS6fOeMPchx500cJnNneeTu3wxtlCewz0U
         pCN/yG21OgPbFAM+z57OxGyJU8p8R36ho+VKaHfkA2C8BVBd24cxzyKDUo9EKTrcG6iU
         /Sdo+KvEDTMjHd80soSFfgEZ3ETr9hAnX+V3IO0tBNKb5iB54gMMna62uBP3Uouynoy1
         BJ+kcaZDjQwejzpLb9E1MovAy5gdxXAGRB6SSVMVX6GJ/FIXgB3Li9T/o9+qPnAMOg4F
         g4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c1ArGb132dwkOm4680FsYBXBNSi2Z/rYOpSaV1vjGQc=;
        b=JHt5ifYbyUpEMYTwmKiHIZPkUtVi3nnI21g2VXCsx81DpjbRrMSPy7CcAUolnB0wpz
         NZG4jU9TdFjffMAFnJup6FRUzOOuMUqyYo2tsrkz4uNooUnjIrqZs8RDjPlYVquIFIsP
         /6gE5TH/SNBZnstSTu6PZZb+nGUjf0aj2uYhiM3pppKMISJFqgr06WIs5gUQcsQLLL5q
         o60PDTMRQ+UVhiPpsDqC7IWcm0r7AF4IS8jxWE+nOdLhjWIMDxAqxcn83RqTKBM7FdWc
         ezaowPZmiNwmZqnWKUThgJiDcKTavu30IE92otNxkwJHOZW9pW2lEp8hu9EntjLPomsn
         0CUQ==
X-Gm-Message-State: AOAM530Zekas2+rqVkRQ80/Ch2PHuAIPeGzei2Hwz2IHqtfBAdx08gpj
        GhupzCgff08z01mUFL+Ed4Y=
X-Google-Smtp-Source: ABdhPJyltkBl+POalprKbrbegrEZEV6BZyHcC5VIU6NyQsAzCOdgQCCIb6X8b7jD8pwtA6DIYOybMQ==
X-Received: by 2002:a17:90a:4809:b0:1bf:72b5:af9c with SMTP id a9-20020a17090a480900b001bf72b5af9cmr10074844pjh.190.1646995002532;
        Fri, 11 Mar 2022 02:36:42 -0800 (PST)
Received: from localhost.localdomain ([122.161.53.68])
        by smtp.gmail.com with ESMTPSA id u10-20020a63b54a000000b00380ea901cd2sm4445892pgo.6.2022.03.11.02.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 02:36:42 -0800 (PST)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] ARM: dts: integratorap: Update spi node properties
Date:   Fri, 11 Mar 2022 16:06:32 +0530
Message-Id: <20220311103635.39849-2-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220311103635.39849-1-singh.kuldeep87k@gmail.com>
References: <20220311103635.39849-1-singh.kuldeep87k@gmail.com>
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

As per spi pl022 binding, SPI clock name is "sspclk" and not "spiclk".
Fix it.

Also, update ssp node name to spi to enable spi bindings check.

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
v2:
- Remove ssp alias
- Rebase to tip

 arch/arm/boot/dts/integratorap-im-pd1.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/integratorap-im-pd1.dts b/arch/arm/boot/dts/integratorap-im-pd1.dts
index d47bfb66d069..4c22e4436271 100644
--- a/arch/arm/boot/dts/integratorap-im-pd1.dts
+++ b/arch/arm/boot/dts/integratorap-im-pd1.dts
@@ -178,12 +178,12 @@ uart@200000 {
 		clock-names = "uartclk", "apb_pclk";
 	};
 
-	ssp@300000 {
+	spi@300000 {
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


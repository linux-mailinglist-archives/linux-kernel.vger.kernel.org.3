Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB51571194
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 06:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiGLEzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 00:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiGLEz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 00:55:27 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D2F823B9;
        Mon, 11 Jul 2022 21:55:26 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id j3so6527622pfb.6;
        Mon, 11 Jul 2022 21:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BFOrJaWXvi0DqhRlp99UPmVUJdpi6ScFAHb6ROwRm6E=;
        b=nJvubQugpDq2k9gbxnx+1G/1bvHl+OWetwKOeXL0cI8iBOM46Ez+L5WAvx/RLj/3pl
         MRJTDWVgrv8QzfCOJgxlW00UmlfwxamebeU0OuH8C7sZUYf2a5rNjJ3TuHiS6h+ywwpZ
         tC2mHqg44dou/FUkw26wRtxVcwFkK7toLsaL97/n1IcnfjKxpWnun3kPRI1d6jfSsWko
         H3xaYzCmmyZGOX3M+MWcOj+Wdk+5w+jeTVOuDwA758p1vI0HrYfVhDMb8oBuIW0dwAqa
         W9IsCa07pAyotrTcyBBRYCJ1NemAf6aTSvhaomz22HMqs47Mc4vh1blg1wPu2H4Ltqyn
         o1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BFOrJaWXvi0DqhRlp99UPmVUJdpi6ScFAHb6ROwRm6E=;
        b=wb+E2XEaDgP44OxWVGT6f4293ht3U9P0Nud8zk3XPfq9hYjLMlWSRxaVZGcrkZOJIS
         hjJIIw307s6b/0Wrl5aqHCGYyJ++zkgEMYO6EfFvqzmlg6FBbdzL0OtdB8Aar6Tbkco4
         Chnont6l394oY+IgBPFVogID9t4168hyFy2GLuqRBoyhVhY34ZE78pglAp0opKJKblXp
         qWUcJIpMk0Pch96+fnqCTtg2cvIvTCVUDGkaG8m+ViJxfRtKgEeM9ostjrdAqx870BG5
         zpVLT/n2uK3CbetsrljhcAeRnoqw4cyKiBce1TvOytjuxB4d1eikJveti96giQZ2ZfXR
         7MZw==
X-Gm-Message-State: AJIora9UOBmE92MXA11c/TGsvqLquGZ526JRKU5b11J4herryMAAbA4h
        B2IXjob0p49kfFmPoIxVCDE=
X-Google-Smtp-Source: AGRyM1v7R+JxpTuvpSs1udBiley5qMQinP0NBUn2NKEEpLpaqs2XH7p3e+m9spSKa8g9TvamnJtvoQ==
X-Received: by 2002:aa7:8896:0:b0:52a:c018:9d7d with SMTP id z22-20020aa78896000000b0052ac0189d7dmr14100143pfe.82.1657601726409;
        Mon, 11 Jul 2022 21:55:26 -0700 (PDT)
Received: from debian.moxa.com ([123.51.145.104])
        by smtp.gmail.com with ESMTPSA id n6-20020a170903110600b0016be0d5483asm5664677plh.252.2022.07.11.21.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 21:55:26 -0700 (PDT)
From:   Jimmy Chen <u7702045@gmail.com>
X-Google-Original-From: Jimmy Chen <jimmy.chen@moxa.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>
Cc:     Jimmy Chen <jimmy.chen@moxa.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: arm: fsl: Add Moxa UC8210/8220 series
Date:   Tue, 12 Jul 2022 12:55:03 +0800
Message-Id: <20220712045505.4500-2-jimmy.chen@moxa.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220712045505.4500-1-jimmy.chen@moxa.com>
References: <20220712045505.4500-1-jimmy.chen@moxa.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moxa UC8210/8220 use Freescale i.MX7d CPU

Signed-off-by: Jimmy Chen <jimmy.chen@moxa.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index ef524378d449..0746801aeb27 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -767,6 +767,9 @@ properties:
               - toradex,colibri-imx7d-emmc    # Colibri iMX7D 1GB (eMMC) Module
               - zii,imx7d-rmu2            # ZII RMU2 Board
               - zii,imx7d-rpu2            # ZII RPU2 Board
+              - moxa,uc-8210              # MOXA UC-8210 board
+              - moxa,uc-8220              # MOXA UC-8220 board
+
           - const: fsl,imx7d
 
       - description: TQ-Systems TQMa7D SoM on MBa7x board
-- 
2.20.1


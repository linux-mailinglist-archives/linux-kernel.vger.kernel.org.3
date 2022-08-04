Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFAA55899EA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 11:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239177AbiHDJ1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 05:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237862AbiHDJ1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 05:27:33 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0A66715D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 02:27:32 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id t1so29943811lft.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 02:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OJotf0HZBChiqOdSpVJcpoR3PKqFSTdoHnx5y+sK0/0=;
        b=DSK+zIe+VEWbWa1wiAKrQxddLG3z4XWvG+XYGyfbk3A0rusyYZnlbyrHEb0BhV8+wD
         fyaGTI97X5R9hyZEfG9oFO83WDKRXBjvODa9QPYQxLtB9WWoW412QOSOqb/fWAIYWo2A
         3Z0rFddpnFhETHZVEqstzlmBf+D9gcZCdzfTaq+XOL/8KSClU2KSLMQjMsas/QqN0nWX
         D4XLDHWRWxtWJ5iZFVb9r3weaIe5X/lgxLJJ8yAXrxvUFe0+NqyEJNBMCrLdMU9f4An2
         hxnAEvDJHdj6IRL8uF+9og4HbHjZDi5TmBbFVg4lmYouhrt4zoLfGmEy5McU67T9yng3
         IuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OJotf0HZBChiqOdSpVJcpoR3PKqFSTdoHnx5y+sK0/0=;
        b=n7GYNok8IEwZVb5lzsOENWWGRYh7ykJD9WRuhFSzI/jny3SUaaRrGVqZ2LUZY1IUBE
         3artyUAPEhRf02nl2TqRRs6Wco5eJprGOiSxeqec8F40J3t1yOd53EDYvKEWgu7UdlIK
         yjlKXUj00bzDF5OPjAFvyGEYcXdo0jvWEAh/Xz82nTnbu22++BAEHE7yTi5izBdE2Wqg
         ngSzcnjwnN2xcfiF3QcI+uFmOEquPrdsAEYXFxsgYVRYPmXFIaKteAiuoDixHWIMqeDE
         JH2muhVp62zFjbURlgZCm1ZtzLbP5blD7q8TY19vdkBpLLw2SUmsJHkJozJPXwA7m39i
         wVOg==
X-Gm-Message-State: ACgBeo2taJmKt9SKGtahoVHoHFGi7LqcWTYIgdbVva+cVqHzqFuQzOTV
        SuexhN45Res/zb5z4M5wjPK8Gg==
X-Google-Smtp-Source: AA6agR7mBuWmXmnE3pRiVNzwdYq9T871uzpNb8JjH3t051iQCWBIBId1ePt8fD9RVD5LslkMQDfMxA==
X-Received: by 2002:a05:6512:b82:b0:488:6aa6:509b with SMTP id b2-20020a0565120b8200b004886aa6509bmr418657lfv.637.1659605250897;
        Thu, 04 Aug 2022 02:27:30 -0700 (PDT)
Received: from krzk-bin.. ([77.222.167.48])
        by smtp.gmail.com with ESMTPSA id a24-20020ac25e78000000b0048b3768d2ecsm59623lfr.174.2022.08.04.02.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 02:27:30 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: ast2600-evb: correct compatible (drop -a1)
Date:   Thu,  4 Aug 2022 11:27:27 +0200
Message-Id: <20220804092727.64742-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to copy-paste, the ast2600-evb and ast2600-evb-a1 got the same
compatible.  Drop the '-a1' suffix from the first to match what is
expected by bindings.

Fixes: aa5e06208500 ("ARM: dts: ast2600-evb: fix board compatible")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/aspeed-ast2600-evb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
index c698e6538269..2010e3cb6158 100644
--- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
@@ -8,7 +8,7 @@
 
 / {
 	model = "AST2600 EVB";
-	compatible = "aspeed,ast2600-evb-a1", "aspeed,ast2600";
+	compatible = "aspeed,ast2600-evb", "aspeed,ast2600";
 
 	aliases {
 		serial4 = &uart5;
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5396C51132F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 10:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359281AbiD0IHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 04:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243567AbiD0IHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 04:07:39 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172301569C3;
        Wed, 27 Apr 2022 01:04:28 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id k14so894690pga.0;
        Wed, 27 Apr 2022 01:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sdE5D/NFm6EL4D7kLaA7WFrnjkrixiSgSiYt0rJZh70=;
        b=MGeF7tD52MnfDX/Z/6UYAEgwVwA9Be1BNBo4elYwAPuAiH/DJKVMfjGt+T5rSr7KUA
         xD6PF9fRNjxzV3HEZ5jNQYS1DLu+3X0CtAP2GjQN6WKwOLVyCc/fS7RsXwRA84+n4nYT
         LpDixKzoP+jREpLfkesvfhP7EBktomPjx2KAry7Gk47YVOrndRupDudSod91uqhOFCKC
         0QUfE57ttG/4EZ1UVw9cqyPD8PCskYfMzoi1l+u6S4ePeknt+V4cMSCYrduyqK34u5EG
         FrXcICDtdrtJJGkYgyoWSxJTZsAIwuhNKMhHuvyZMZyBS7lwEZ2ky31ATZ6lOopSP4UI
         0SHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sdE5D/NFm6EL4D7kLaA7WFrnjkrixiSgSiYt0rJZh70=;
        b=xit2I+sWvAOng0B7v26U1VqcCFHLg3DE43slJa0HmUt667FdAIOcYW7XX7nR8cCwtO
         9eGm/DWIrAygnLubSWI0T8q+1xqd5ojjHQc188K/51wH+VQpe4qYUVCEYhS775esBr+K
         upvdF3+/b1Cd133AQ0FJMVqWZw4r8HY8/XF0LahBztaa1vUe0R522dKUrc9FqQDSSpik
         UTJpyAYlg/7GP8E3plcV4JVS9txEvELoWQIRUKJh3lGTsQyGQN7WW9022Hn3ui+gP+cp
         vRu40jktoWp03VH8STF2CGxccisdR4RnOvU4uDyltUJpEOXwo5TjyOXFfKD3LsdL1Caz
         luhQ==
X-Gm-Message-State: AOAM533/GD/XR7kpdEwk6bHb0pbw8T/FEBpgaKFyPnjbORfZ3zl5/cI3
        ug6uvMMr6pQ648baNU7wIyQ=
X-Google-Smtp-Source: ABdhPJz83wCLBKFmPRVZ22y1Us8FE68DAbcSOI5389m6GK5CGqEy+kIVEjJOf03zVCH6+eRXayNldw==
X-Received: by 2002:a05:6a00:228b:b0:50d:3c82:911a with SMTP id f11-20020a056a00228b00b0050d3c82911amr15993320pfe.16.1651046667497;
        Wed, 27 Apr 2022 01:04:27 -0700 (PDT)
Received: from genechen-System-Product-Name.richtek.com ([2402:7500:469:f77c:f4fa:b753:7807:4e40])
        by smtp.gmail.com with ESMTPSA id a11-20020a17090a70cb00b001cd4989ff50sm1746750pjm.23.2022.04.27.01.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 01:04:27 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        pavel@ucw.cz
Cc:     devicetree@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, cy_huang@richtek.com
Subject: [PATCH 1/2] dt-bindings: leds: Fix binding document for the Mediatek MT6360 LED
Date:   Wed, 27 Apr 2022 16:03:29 +0800
Message-Id: <20220427080330.40136-2-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220427080330.40136-1-gene.chen.richtek@gmail.com>
References: <20220427080330.40136-1-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Fix binding document for the Mediatek MT6360 LED

Link: https://lore.kernel.org/lkml/YmHK02g1pC19Oyh6@robh.at.kernel.org/
Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 Documentation/devicetree/bindings/leds/leds-mt6360.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-mt6360.yaml b/Documentation/devicetree/bindings/leds/leds-mt6360.yaml
index b2fe6eb89389..10f95bf1d666 100644
--- a/Documentation/devicetree/bindings/leds/leds-mt6360.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-mt6360.yaml
@@ -43,8 +43,6 @@ patternProperties:
           - 4 # LED output FLASH1
           - 5 # LED output FLASH2
 
-unevaluatedProperties: false
-
 required:
   - compatible
   - "#address-cells"
-- 
2.25.1


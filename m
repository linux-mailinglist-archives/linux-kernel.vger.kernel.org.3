Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FF04F682D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239680AbiDFR6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239703AbiDFR45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:56:57 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC503BD268
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 09:07:35 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bq8so5233667ejb.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 09:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q5SnuaC22PldZRl1d3Eesck9g+lJ9ywG2BO0iv4qtAA=;
        b=mGeKs2QuURmKkxOKfwU7nymtX1Z4tONudklyyl8lXb6C7L+tbbrRLnIboUqmAEuSaD
         Xmm7fNbVrmcLMuiXw7ANrqGt/jxkiaaZmK7sYjE66WgBurnW5w8HXYnHzHfdME9bVvaI
         raxaj9z3Qxul/sAOy6YCTHtEIWLZtV++HOPw7kIU/RbLW354/u+1ngukB8fntfn8heUG
         HXpyDuPaE5HCg9FeEkHwriJYNBo2lndx65zlX79DBmQq6pDc33aBTrKtJ6D55JfcR0qC
         WOUGXvQNqHXKdsoK7XLaRyyk8x75+2C1AoGrlmn8wWtF2JRU05e5WFtrp4gOsoVR5+xG
         PCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q5SnuaC22PldZRl1d3Eesck9g+lJ9ywG2BO0iv4qtAA=;
        b=iMwXCJ4fZwg9qYr3U2BjjdsY+ox4m4YixTfq2n4NittBPqm0MkSDek6Fg1O29WR1JP
         1iXpV1AqjSKM0A4NlhDPJdgw2JMtSHGwjA8HdM1gcDBtEis8S0H8486MN3X3wIXwqzZs
         959QkfnLB5ai5VWa4F1A+utlaRGGuLv8SD/C3xYQEclzmLUdLhoPsBBJ7eGjSKwoSIhK
         NGL92W67z6dpWwUZ1mdVkraAHHUwRZZzMKWUXbWHer8TGApHo9KO3RWApXLeTYCNog+X
         39rvvlr2ZgUk3lxqUB/GqPRIN6pFRXinvwmC8giwK6lHVJm/AF1ToLXPXNPwlo3B18CL
         ev3Q==
X-Gm-Message-State: AOAM531GbwieHfdCpO4X5iP4tC/IXLe9ULm2fFw3jEusLc4fHdDjcloi
        WD7VUxJ0prH3x85FkYGpc8xRCQ==
X-Google-Smtp-Source: ABdhPJyNn39Uw60jASVPnLd8b+rNxkCM7+kvFHVOPHbddwf86sq0l+rzrRi8lRWBlgeWUZ/dN8N72g==
X-Received: by 2002:a17:906:1603:b0:6ce:362:c938 with SMTP id m3-20020a170906160300b006ce0362c938mr9100103ejd.253.1649261254169;
        Wed, 06 Apr 2022 09:07:34 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id lb4-20020a170907784400b006e0d13f65e5sm6680044ejc.167.2022.04.06.09.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 09:07:33 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: vendor-prefixes: add Enclustra
Date:   Wed,  6 Apr 2022 18:07:28 +0200
Message-Id: <20220406160728.720902-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
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

Add vendor prefix for Enclustra GmbH (https://www.enclustra.com).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Hi Rob,

Could you pick it up directly?

This was missed from old patchset:
https://lore.kernel.org/linux-devicetree/20211227133131.134369-1-krzysztof.kozlowski@canonical.com/
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 01430973ecec..113ff50eb46e 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -383,6 +383,8 @@ patternProperties:
     description: Empire Electronix
   "^emtrion,.*":
     description: emtrion GmbH
+  "^enclustra,.*":
+    description: Enclustra GmbH
   "^endless,.*":
     description: Endless Mobile, Inc.
   "^ene,.*":
-- 
2.32.0


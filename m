Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB31957A976
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 23:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240621AbiGSVvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 17:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbiGSVvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 17:51:39 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271DB63922;
        Tue, 19 Jul 2022 14:51:34 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id q14so12915343iod.3;
        Tue, 19 Jul 2022 14:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uljj5MmXlYXK2K1NyL8aqQUp+7bgEAbnVce27GY0DdY=;
        b=iXuyXooCfcgR8Agmkvlpn5OaGt693nd2Fg7ju7rNkudjND3xEFY+h4HHbcxYdmdkfT
         s9cE5R749MLn5WlFaUwtAOEMQGylhex3R1mp5CEswgTCYHXs4FMQ3GqfCC7t7VvI9VUD
         +oFuhUmv5yROuOcmzdJ5IJzP0YEh21Yj22O8+TKjengnyDWNVXWrtzaDK5pPIEqF8PUk
         fWuT0e85eSN69tPjbogTKJWG7I6Tal22lJ2wKMkHrNLFUj79Olh3IR3cqxcwnd2xd/Ca
         1YAvH4KdclA/lmKJ2LjET1hEhKi4IkLT3uP5Jr+Qo69gW6cFcOzodJ0JJyCbCDufKimR
         finw==
X-Gm-Message-State: AJIora843wtC+YDZSNUM8AlsIlLtBGEY5OvwYQ2ErI0qa0a5sYmOTrVg
        MhM5IwvxJgJ6x1r1/YdMXA==
X-Google-Smtp-Source: AGRyM1sRs6EyfwqSDyGC0ktRY+m63qPeGrFUDEqOmtSv4Uq2SP67KzCW8IJGDeGx96KzZjM1q1abfg==
X-Received: by 2002:a05:6638:3387:b0:33c:9f9e:5a17 with SMTP id h7-20020a056638338700b0033c9f9e5a17mr18432803jav.12.1658267492959;
        Tue, 19 Jul 2022 14:51:32 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id y18-20020a056602049200b0067c09fd0b53sm3674183iov.21.2022.07.19.14.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 14:51:32 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mfd: st,stm32-timers: Correct 'resets' property name
Date:   Tue, 19 Jul 2022 15:51:25 -0600
Message-Id: <20220719215125.1877138-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The correct property name for the reset binding is 'resets', not 'reset'.
Fix the name.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml b/Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml
index 10b330d42901..4baa2b746814 100644
--- a/Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml
+++ b/Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml
@@ -33,7 +33,7 @@ properties:
     items:
       - const: int
 
-  reset:
+  resets:
     maxItems: 1
 
   dmas:
-- 
2.34.1


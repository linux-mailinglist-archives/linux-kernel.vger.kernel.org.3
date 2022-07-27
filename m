Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43E9582F1E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 19:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241908AbiG0RVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 13:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241955AbiG0RTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 13:19:23 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF97260ED
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:44:30 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id w18so9375787lje.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TsOv4pGaUtCcXXEbEcGrs3Nq1JuLEmKn5+ZRivl7r0g=;
        b=nyyy+baCowjfPIvpfSbsrhQV+q0K8U8uz1CA1PLUUUz4T2n1/8FSSnLJsqMfbVixYi
         B+TTz3I7q0hcq0nR3M8hR+W87i3nN6paIfJDSycE77YRK+9lG40C3NV6m/3puZ7uEyf6
         r9MuuTBhgUNEeDF/LTZG/kguQykzRRqU1tCz7P4W95C/W60q6KW5wiWWdA6GUjsD4BhE
         8WE7WEmvvz6RvTlD30YNmx28d9dRIq8x0yM1lDHh6WlHD5gtc4OoBOXs4qc7hROchAXg
         j25xPI90HGyvnGYLyzJ83uWpId4zzXSAY8HSEqMSraEuJXmEC4nn28Of4h8LIiDDgL9o
         g+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TsOv4pGaUtCcXXEbEcGrs3Nq1JuLEmKn5+ZRivl7r0g=;
        b=Cv0WxtYuobaovLvN8cziR1Zn9LatFgDJslqWjjqRzTHUJ2l0gDBDDZimmorW2al4N1
         MtY1AKSRJrRneoOGNchbBNLZzUuQrmgcYGxAuKTeYucRmhm+l3AdjPbcoFXTRo85oJAV
         KNIp4Uvxa8Iodc4C17Vyez4uYFZEZ3Vp1khvCIZ1OIB9KxSo/SSZ19ANKIzp1oSRHG1d
         4C4uS7HYBN8SvIy3vriqQsUjMCq5tEUJefqR+KiljQ3jLQ9X8uLPRgdD2ToRykvLHGUi
         gnTPm8/E4HG8wN7BP2Sm+M8e61ay8aZD1FmrxIkDPfx1qBokcdkekLPZNe4lJ1DUHHq3
         EKnQ==
X-Gm-Message-State: AJIora9pPlw5IFPWqJbigrr2CLYy9QCjjIfYTm5jvC+g3tiYgTvYswEU
        lBKocCPumWJvJng5q4q34gLaGO8SRFh6GzYb
X-Google-Smtp-Source: AGRyM1toaXYDXjtrsFJEuaoLzZbKB9hARAFNZbfriEELIYeEy1MaWz1uam6OLi1/Pnhb+2WGoLw1ng==
X-Received: by 2002:a2e:3919:0:b0:25e:566:89cf with SMTP id g25-20020a2e3919000000b0025e056689cfmr6011961lja.73.1658940269126;
        Wed, 27 Jul 2022 09:44:29 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id m4-20020a056512358400b0048a95ffc6a2sm1462673lfr.123.2022.07.27.09.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 09:44:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Christian Eggers <ceggers@arri.de>,
        Cory Tusar <cory.tusar@pid1solutions.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] dt-bindings: eeprom: microchip,93lc46b: move to eeprom directory
Date:   Wed, 27 Jul 2022 18:44:24 +0200
Message-Id: <20220727164424.386499-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220727164424.386499-1-krzysztof.kozlowski@linaro.org>
References: <20220727164424.386499-1-krzysztof.kozlowski@linaro.org>
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

Move the Atmel/Microchip 93xx46 SPI compatible EEPROM family bindings
from misc to eeprom directory to properly match subsystem.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../{misc/eeprom-93xx46.yaml => eeprom/microchip,93lc46b.yaml}  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/{misc/eeprom-93xx46.yaml => eeprom/microchip,93lc46b.yaml} (95%)

diff --git a/Documentation/devicetree/bindings/misc/eeprom-93xx46.yaml b/Documentation/devicetree/bindings/eeprom/microchip,93lc46b.yaml
similarity index 95%
rename from Documentation/devicetree/bindings/misc/eeprom-93xx46.yaml
rename to Documentation/devicetree/bindings/eeprom/microchip,93lc46b.yaml
index 43ac2376a453..0c2f5ddb79c5 100644
--- a/Documentation/devicetree/bindings/misc/eeprom-93xx46.yaml
+++ b/Documentation/devicetree/bindings/eeprom/microchip,93lc46b.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/misc/eeprom-93xx46.yaml#
+$id: http://devicetree.org/schemas/eeprom/microchip,93lc46b.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Microchip 93xx46 SPI compatible EEPROM family dt bindings
-- 
2.34.1


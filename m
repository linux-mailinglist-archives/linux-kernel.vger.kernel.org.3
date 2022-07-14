Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB585574C19
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238930AbiGNL2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238858AbiGNL2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:28:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D7D57253;
        Thu, 14 Jul 2022 04:28:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6149661CC2;
        Thu, 14 Jul 2022 11:28:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6257EC341CA;
        Thu, 14 Jul 2022 11:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657798083;
        bh=9ohwBQS9o/0eQWGzO9pBqXpDkfHCagUjBWWDKn5wNw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QkBcA0xOxbZqDCuGkJ7ygm1jVxMqSFVVfQ9Ich8Wwlo7Wp2YMy77JoAzeaiKqZgKX
         grNU7pvKFtU6xkOFXQUuZOFN3/NRuvX7B1fPNvnsibfjNuUOU0M1gdGk0DbhO9XtSK
         2r1sWZ4dXbQguu5mlNWrdHhvrLKVduWNR1EfWBZdR4YEwxebvQsQYRQxWYeFO58uku
         8FKbtPbyNi8Mz5ud7HoSsic0QdRj5a5pad1uRtqF8jcMvNlIxf9Bi/Bbetk4QCYdSq
         r3+bW58nRHSGFuyqGYzDLK1WI+4NzXABcgjWs9ejAwP+FY2qGsIv5kBX4Hx7rOGFco
         r2UN5KAEAAZNg==
From:   Lee Jones <lee@kernel.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 8/8] dt-bindings: regulator: pwm: Update Lee Jones' email address
Date:   Thu, 14 Jul 2022 12:25:33 +0100
Message-Id: <20220714112533.539910-9-lee@kernel.org>
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
In-Reply-To: <20220714112533.539910-1-lee@kernel.org>
References: <20220714112533.539910-1-lee@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Going forward, I'll be using my kernel.org for upstream work.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org> (su
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-pwm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Lee Jones <lee@kernel.org>
---
 Documentation/devicetree/bindings/regulator/pwm-regulator.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/pwm-regulator.yaml b/Documentation/devicetree/bindings/regulator/pwm-regulator.yaml
index 0332fec48a883..82b6f2fde422b 100644
--- a/Documentation/devicetree/bindings/regulator/pwm-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/pwm-regulator.yaml
@@ -8,7 +8,7 @@ title: Bindings for the Generic PWM Regulator
 
 maintainers:
   - Brian Norris <briannorris@chromium.org>
-  - Lee Jones <lee.jones@linaro.org>
+  - Lee Jones <lee@kernel.org>
   - Alexandre Courbot <acourbot@nvidia.com>
 
 description: |
-- 
2.37.0.144.g8ac04bfd2-goog


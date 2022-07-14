Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F251574C18
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238907AbiGNL2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238847AbiGNL2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:28:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30800599DE;
        Thu, 14 Jul 2022 04:28:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F42961BFD;
        Thu, 14 Jul 2022 11:28:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD82C34114;
        Thu, 14 Jul 2022 11:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657798080;
        bh=N1fNSRCueq/ZQuGKF7Mf1VOJKbVklZ0O06iKTAUyTMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kMzUz7CD1tFQgTBqA1lYx3oX15IN1LcOyvkJ2mjldZUc+ahxb/cfLuF8DofcrfcSL
         SzmW+dKIEGR2cIHW7xj1bbdEwkf5VPql8Fsw0WDaGPEDdolCWn8EgWqc59KhOZJIpR
         DHQb00+urstAOR5kPkBCOlcldtaKi/NTCu/gh4bujRtr+9Ai0v+wW+BgQ5MgVB9hJk
         c+iqK0IzeFTHiqUrrfy8lcMLO1ZJpeggFGoC4jxK4WXLiOf0gwd10EXqxhD3yg/UYi
         sEVGqLQooX/SCGGbTgnyRzZxT/rSdm1DQ+p0Im8hKr2FkQmxuMCu4jdCRis8Pwl82r
         yfiCOz5rguLRw==
From:   Lee Jones <lee@kernel.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 7/8] dt-bindings: mfd: syscon: Update Lee Jones' email address
Date:   Thu, 14 Jul 2022 12:25:32 +0100
Message-Id: <20220714112533.539910-8-lee@kernel.org>
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

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Lee Jones <lee@kernel.org>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index fb784045013f5..c10f0b577268e 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -17,7 +17,7 @@ description: |
   and access the registers directly.
 
 maintainers:
-  - Lee Jones <lee.jones@linaro.org>
+  - Lee Jones <lee@kernel.org>
 
 select:
   properties:
-- 
2.37.0.144.g8ac04bfd2-goog


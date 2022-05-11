Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E32F52369A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245492AbiEKPCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245504AbiEKPBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:01:23 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4E931DFF;
        Wed, 11 May 2022 08:01:21 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id n10so2271298qvi.5;
        Wed, 11 May 2022 08:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ocj5V1R4ifR3GEVhPfDRyP1I/Y6r02zd9DJpazO+vcc=;
        b=R3AnWGneJSrwRojHEzs+rDub3VWTmhlKRgjZficmVLIVjzQrmIXOyhMlSA+RNkfVtM
         AFW9hSLnb+T66FyTWg8v533eZkUGl/XH0w6gneWnUsucvG5zk2CqVEVNfr0lRURfzdsb
         LGpZx2XkXoNFzTldtCOGeQ61n1LPeUUf0a22l1+U0vlXrXBaJMw9SWyHj5AM1eCs3vfv
         ANxIdADtTwaMlojsAhWstTW1L0FQsfPh4T71/CD4quaVz20bMe4K94QC9/dKb1m6a3oI
         LDwUjcRwd4U+CFSGop/sA96X10J5PEpC7GAqKtIp7GtsoSMNWGbDnJ2QKIfMgzZ6CluO
         3yZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ocj5V1R4ifR3GEVhPfDRyP1I/Y6r02zd9DJpazO+vcc=;
        b=Wqbrgp2lOhYUUFwGFjnqWpEWsVwgZtmkJScL4wF7gvvlNh6AL1TLXmqQo5Y15BL35h
         BtA46gzv+ABJhDvQZwEctBMnCv0zO1zsrmGgmwZd803BxRCf3ZofHeFctgTS2AmlFvC/
         vovSRNjV/4MHtD3/kqmWI5MYdkfdaDgr6/f4P+HjXamA28NkbyDGhYfOg1rB+v/eGTAh
         k5W2AjJ1ClODmqgXksGwW5M9IS7Btq+Ur2YvU7HY7VrTCi56++z27BqR6nId6WDKcy2u
         R5sZsoaFGecg0SI2B06JTYEINsEr+qhk0JvbCG2+uVjFOuhatyBQtsn1k4K+z0H6wEft
         xU5w==
X-Gm-Message-State: AOAM532nPo4b0rXY67eYiOxIP6vt5NSCXvxVn7v+uENPHZeV8Stq8oTA
        HqJvw77ZmWAcPI+JGreZn6k=
X-Google-Smtp-Source: ABdhPJwRTBO6xSgCqxxLRIYnj5Gs2ENLGS7w8UvQ3g43LWvgE7ieEfSxxAsHPNP68tqkvCipMvshww==
X-Received: by 2002:a05:6214:2503:b0:45a:a294:510e with SMTP id gf3-20020a056214250300b0045aa294510emr22162937qvb.49.1652281281039;
        Wed, 11 May 2022 08:01:21 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id h1-20020a05620a244100b0069fc6484c06sm1487134qkn.23.2022.05.11.08.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 08:01:20 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Elaine Zhang <zhangqing@rock-chips.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH v1 1/6] dt-binding: clock: Add missing rk3568 cru bindings
Date:   Wed, 11 May 2022 11:01:12 -0400
Message-Id: <20220511150117.113070-2-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511150117.113070-1-pgwipeout@gmail.com>
References: <20220511150117.113070-1-pgwipeout@gmail.com>
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

The rk3568 cru requires a clock input and a phandle to the grf node. Add
these bindings to clear some dtbs_check warnings.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 .../bindings/clock/rockchip,rk3568-cru.yaml         | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3568-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3568-cru.yaml
index b2c26097827f..fc7546f521c5 100644
--- a/Documentation/devicetree/bindings/clock/rockchip,rk3568-cru.yaml
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3568-cru.yaml
@@ -34,6 +34,19 @@ properties:
   "#reset-cells":
     const: 1
 
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: xin24m
+
+  rockchip,grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the syscon managing the "general register files" (GRF),
+      if missing pll rates are not changeable, due to the missing pll
+      lock status.
+
 required:
   - compatible
   - reg
-- 
2.25.1


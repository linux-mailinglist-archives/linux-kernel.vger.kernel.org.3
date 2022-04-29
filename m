Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF475148A0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358745AbiD2L4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239302AbiD2L42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:56:28 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16C5C6EE8;
        Fri, 29 Apr 2022 04:53:09 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id k12so5153252qvc.4;
        Fri, 29 Apr 2022 04:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/0BzL8B3OkyLX9kPF01T/3su20f1yiIHSqjn4IIxTHE=;
        b=EWQyr3BtXtid12435zlUXMdpotNXe7nlWXj21MJoKVVQ0kdevcfwpx9/gTwuT+d4n3
         ZlmSRcLRaOVwcQHYDZmpsqyhyWCyAKpy5CXg0CLKxF/TsK3iTPrZUZCAIWYtFbJdF8Oy
         2L/7EWvQMVU3UHIRS6ApD0VCHvQGcoWTpJxi2IF8b8hQL9DKh39G5OO0prIEcyu0LhVF
         p1vGUTpZDQllC+jW0+1pNKvD20+P4wf13knEF1aBjVhqLIMZQ8BdRAxLtjaAn7vmY8Vk
         O/s1KiUdbmD/BS8r5haUjw6uX/QfU/a9Ekw08kKtk6fHc1eMfd/43RhTn87fiuo1VbGW
         +IfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/0BzL8B3OkyLX9kPF01T/3su20f1yiIHSqjn4IIxTHE=;
        b=yCNlHXT2wzIrk5N3rfOMyaw5hIy3JIj9sxm6lwmwv0LHH0OjT/YFxlnPLGgp65Mayh
         w5JS2B/kUDy+/nGcpJx/ApIBOBF92R9SkhajgATeWWxckngPNLZS9vTUD4o+A39LqG08
         wpJa+sUMMfiyg+g0gyCPS2cTUxx7i2pZt5PHKIyLO84AKz1Zf1CLWKAS/McwxAAcERUh
         xSlH4xUtD0+g/+2/LZoA82UQ2yRz3ocibRyX0co53a5SQw2Gutgl5+6jDLFXyrCaTlt9
         EcWL54CAOz86dtoHEBEqp82+miYd2zQHZUSQ7bC3JkhSSfNBVZXCgtEhNZs603Oi4GvG
         e8Yw==
X-Gm-Message-State: AOAM530C2qO693IIKd2uQgTpBTTvKUFagPuvrnW8LyPmYKrOnQeIWrKp
        vf1bq46NkzVxhzfIQBxu6qw=
X-Google-Smtp-Source: ABdhPJw1Q6hPXonGtQBvISs/6ZWPt5hrKsKtiTrqr280rT/+R3hNuoup9aJuXugDkKrDlFCrNeUAWw==
X-Received: by 2002:a05:6214:4104:b0:42c:1db0:da28 with SMTP id kc4-20020a056214410400b0042c1db0da28mr27420668qvb.67.1651233189032;
        Fri, 29 Apr 2022 04:53:09 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id 123-20020a370c81000000b0069fa408fdb7sm1382505qkm.24.2022.04.29.04.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 04:53:08 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] dt-bindings: arm: rockchip: Add Pine64 Quartz64 Model B
Date:   Fri, 29 Apr 2022 07:52:46 -0400
Message-Id: <20220429115252.2360496-2-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220429115252.2360496-1-pgwipeout@gmail.com>
References: <20220429115252.2360496-1-pgwipeout@gmail.com>
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

The Quartz64 Model B is a compact single board computer from Pine64
based on the rk3566 SoC. It outputs on uart2 for the debug console.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index eece92f83a2d..beb5b0ac1a2a 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -502,9 +502,11 @@ properties:
           - const: pine64,rockpro64
           - const: rockchip,rk3399
 
-      - description: Pine64 Quartz64 Model A
+      - description: Pine64 Quartz64 Model A/B
         items:
-          - const: pine64,quartz64-a
+          - enum:
+              - pine64,quartz64-a
+              - pine64,quartz64-b
           - const: rockchip,rk3566
 
       - description: Radxa Rock
-- 
2.25.1


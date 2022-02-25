Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D77A4C3FC8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 09:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238382AbiBYIK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 03:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237038AbiBYIK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 03:10:26 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA1B82D1D;
        Fri, 25 Feb 2022 00:09:55 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id ev16-20020a17090aead000b001bc3835fea8so4212723pjb.0;
        Fri, 25 Feb 2022 00:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=snzyDKm112X/dWlK/fWF6GVa+OsY1ecejjP+ijC4oRo=;
        b=LYCElDOg+CjHvRx2onDZfelCxF3NqVxw/wLpV2HojqgUVMuXCR6cVGdLxCH/EiMvy8
         HpcX9DQiDPYSgD+NbhXW3EAi4N2Ha0zkQ4nFs0ajmb7piR6J5lUYqIunshbqT7ucSjp5
         dSJp3XhbI8qn3npc0k7GrGFqGspAtn/6a4ddaxjygNinwpsors46AIXcO4kt+6vSpTPW
         OG6GUXhrKGE4Wb50L4y064hek3dkjo4zayWlftyMqboqxiBYcUevs4zXPu2wHFDoPAi2
         Xism414+yid+EJjDIwF5v25Yzgv/YS/x/vJQKW6pM7of8oUu4qTVVepqYgO+cHbqFfGq
         zw7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=snzyDKm112X/dWlK/fWF6GVa+OsY1ecejjP+ijC4oRo=;
        b=DyH9K+QIDnQFqy/AO8OLzdxEHQQdUEjE9aQ/sXXA01GMPzoUKvbxLfLlMpnNXXO9Cz
         PUAlwWYIUAR+hyMzSRajKbpYKROTIp2TEB+jAtc6p6M+yZcpSy5NiEXs11bu/6eBBh6o
         H05ZEWhnrjMvD/B0HNrbD5vwT5RnVpSUa0ueuqYbmgNiDZEoU9eJdAriG4GNuAOAVBSe
         swiyVeKvyNXc+qyDMFE4GzK+gMgyU+zb5w+PFeSmVvvdIcLxHZ29cJFME+wGE1YfuOVy
         l3XS+ZI3VrTFu971iaJ9q85C+Gl7vJE3YpJW2Qz2ZnAXUZ3opASLbZRo3aSL5ApFrGLE
         rkKA==
X-Gm-Message-State: AOAM5330tI7uHOMHb8mSdy4E51f3C2NFaUIRhlrF85XCQ9Ddo3ZMESXT
        PxcHKoo5DxgpiF746xhaGcE=
X-Google-Smtp-Source: ABdhPJyyQYodb2UX4wEGXZ3YjgNxFGD9h/tsvLdKC1Bqw3QjW4+ZViuLybZsmo6z6bq1fQMHCMO0Kg==
X-Received: by 2002:a17:90a:a385:b0:1b9:cfb8:de07 with SMTP id x5-20020a17090aa38500b001b9cfb8de07mr2018872pjp.162.1645776594794;
        Fri, 25 Feb 2022 00:09:54 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id pf15-20020a17090b1d8f00b001bc9d6a0f15sm1652842pjb.36.2022.02.25.00.09.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Feb 2022 00:09:54 -0800 (PST)
From:   Vincent Shih <vincent.sunplus@gmail.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wells.lu@sunplus.com
Cc:     Vincent Shih <vincent.sunplus@gmail.com>
Subject: [PATCH] nvmem: dt-bindings: Fix the error of dt-bindings check
Date:   Fri, 25 Feb 2022 16:10:11 +0800
Message-Id: <1645776611-24774-1-git-send-email-vincent.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Remove the unnecessary header file for dt-binding check
2. Replace OTPRX with 0x15 since it is not defined here.
3. Modify the name of the node of the clock driver.

Fixes: e15d2e3fd7("nvmem: Fix the compilation error for SP7021")

Reported-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
---
 Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
index 4b28f37..a7644eb 100644
--- a/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
@@ -60,13 +60,11 @@ unevaluatedProperties: false
 
 examples:
   - |
-    #include <dt-bindings/clock/sp-sp7021.h>
-
     otp: otp@9c00af00 {
         compatible = "sunplus,sp7021-ocotp";
         reg = <0x9c00af00 0x34>, <0x9c00af80 0x58>;
         reg-names = "hb_gpio", "otprx";
-        clocks = <&clks OTPRX>;
+        clocks = <&clkc 0x15>;
 
         #address-cells = <1>;
         #size-cells = <1>;
-- 
2.7.4


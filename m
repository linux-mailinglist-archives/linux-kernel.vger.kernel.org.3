Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543EF4BD813
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 09:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243415AbiBUIXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 03:23:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242232AbiBUIW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 03:22:59 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D419305
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 00:22:37 -0800 (PST)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 72E373F338
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 08:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645431755;
        bh=UYup4czZXEinhZ8A+loL8l38+8H7kahV8D36yzE2Kx4=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=cCe6dP25hNXsphZ5wwyWUJifa7oAAo19JMY1D95C0b03H1TMjHvpcwirbJ8yY7y/f
         KGrQOqHgd3Iqp/q87m9AWmpvwfk/r6wZI1shXOvt63D5FwrpIwO/1nnn68leNBIpPQ
         gcZkl7MBHYRNWwoXFlgJxa6laGokF3kk3lB08NYFYhHbZ37GqZ/2HiI9AMgCTXWkGN
         R2l0Lx1dVCcZkXNCfDU8BYDMN4vKvTw3rdqMx37VrKCZmt/okJS3rsKtBIOfj1I6I7
         YWmv50mneWQP7Ik4+dktmXU4Y/83CdtzSIcQAp6p4HO4PmhAjFCDqiDAtV+SRDU6/+
         12c62gDtHBQpA==
Received: by mail-wr1-f71.google.com with SMTP id k3-20020adfb343000000b001e463e6af20so7026066wrd.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 00:22:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UYup4czZXEinhZ8A+loL8l38+8H7kahV8D36yzE2Kx4=;
        b=x3+LD1au1DcnjzxWKCD0q+1tFuDwntWAGfPn3aPgq2PVdAfJS4T5ExxpPnRANZ1jST
         7szmPx6yeN0e0ENhyHznATs/GLsUzycNNP6dBXTe+GPYbWk+0HdjrlpC9/kYqvDR7stW
         DMeGbfL36UptBDQV/yPRYIkcQKAZbMN5Xd2aenlZPtHbDModziYeMEqj0J163fktv99P
         Euo+4JynLlMVvEcy6R8Xcan7ufpD1VZOOLentQHVT1uPcGedsXALcmViUeOMlaxKsjrI
         DFZEUkmwvz7TCjEZsyzBgZllIjpMgbhnxzEGBvq+1ZV5qKC4dKbNGeAnGY6XD9sIeESP
         U01g==
X-Gm-Message-State: AOAM533zol+KataB8Gjcq3AvqHNxKGn8qhPLY21IRnLB6gWs7GFSjdZv
        AQo6eyM+zkSgX4b5zcooQXABtBlKAPmplwS+N02J4iNIdNcUhO6MjGPEQjvRxddDr8Zt1eSqhNC
        AXDtlgePc9nbGfBq/gp1PJK91NYHIP2RnROhwLgYFPQ==
X-Received: by 2002:adf:ef07:0:b0:1e3:333f:a101 with SMTP id e7-20020adfef07000000b001e3333fa101mr15096229wro.301.1645431754276;
        Mon, 21 Feb 2022 00:22:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJypyE8opdg9kZ0jMU2jAqXHrMPRem+mxaIhRXByu/6CwdnMgET9Mt6N719YwGsOoVahoJ/E8Q==
X-Received: by 2002:adf:ef07:0:b0:1e3:333f:a101 with SMTP id e7-20020adfef07000000b001e3333fa101mr15096220wro.301.1645431754133;
        Mon, 21 Feb 2022 00:22:34 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id j5-20020a05600c410500b0037bc3e4b526sm6727615wmi.7.2022.02.21.00.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 00:22:33 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Roger Quadros <rogerq@ti.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: vendor-prefixes: add second Synopsys prefix
Date:   Mon, 21 Feb 2022 09:22:27 +0100
Message-Id: <20220221082228.34407-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220221082228.34407-1-krzysztof.kozlowski@canonical.com>
References: <20220221082228.34407-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are few bindings with compatibles starting with a "synopsys"
prefix.  Document it as deprecated, to be sure no new usages will
appear.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 79a172eaaaee..9eea9e01abe4 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1192,6 +1192,9 @@ patternProperties:
     description: Synaptics Inc.
   "^synology,.*":
     description: Synology, Inc.
+  "^synopsys,.*":
+    description: Synopsys, Inc. (deprecated, use snps)
+    deprecated: true
   "^tbs,.*":
     description: TBS Technologies
   "^tbs-biometrics,.*":
-- 
2.32.0


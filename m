Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55D55150D5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379201AbiD2QcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379139AbiD2Qb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:31:26 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06ED2D95E7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:28:08 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id q23so11476480wra.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wNZl86uMJorfXA8YdaBQDFZ0Yywm37xZeE+vqOeu9Ys=;
        b=tTtmG5ITracw98AElK2wGYZFgMVtS5GATrhIyywYnctxEqC2KdKXjU/sAfGJPEW61e
         u81nGj49K+HIxJvy3tHy9MpwjPbTx9TmiLP76mntO+kcTsPhBNttkwp2lLkqV2Ih6z5/
         oLhb//OMO02yvj6ih/K9gBWsUZ4v7eVA6fjQ/TzFXSfx30Ky78Ol/qgZB/6o/Wk7gQLM
         LLWyFKWOpc4SYCx96jl4O3b74UJRF/pa+wwuf72FHFP5swUQPOJGmatBlLuYTcFdodFU
         j5QQJ5yQY27CfFi3o1OvtHwxEB0vjUTrfWtjdLANqhYsTzX+TY6hHLaV1wop/ZJplV1l
         xsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wNZl86uMJorfXA8YdaBQDFZ0Yywm37xZeE+vqOeu9Ys=;
        b=h9WiE0O/yhWm3po02DW0q2OFduAynKpSDn2BcKXOAK7sSPQ0fQoKqVvLN7ddVfFdPe
         NoHwv9Kyvk6ogESirtVKcT/0B8nW/dVdn3cHmK9NtJiryvpocESBG1jXoE9UM0vykwRM
         8uqK1saUxZPUGQRh3rdWP7JCA+BhRL07y+nwPQS0ji56DC3tDYhDCCpqjlnK+h79Lchn
         hDgtt0qH45kcXkydtwzIk0srWPJX6FFJeGhVIMdmR3z6g3rLnclQXtZFAGbZW1v6QTXx
         qpA96JkxmA5fobupv+mAKVVOl0Ae8XmG9ks9oBoeoyCx8eqIeyOGemrn+kL3uZ2WSOr5
         I6GA==
X-Gm-Message-State: AOAM530DnlRTS7boDxlQ7bj/atr4uCdbwAfXps1ndfOupPD140wp/Kxw
        BS2EEx3tcuZuuOjp7H7GXbVaKg==
X-Google-Smtp-Source: ABdhPJxn+Wsf89S1prK+hMTL0miaxMXZ2a8Lx/22gTwY2kgtm/h7b3BpVWWX9iiwcQxsM+rgcimbtg==
X-Received: by 2002:adf:ef01:0:b0:20a:8068:ca5e with SMTP id e1-20020adfef01000000b0020a8068ca5emr30868564wro.661.1651249686606;
        Fri, 29 Apr 2022 09:28:06 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id b5-20020adff905000000b0020a8781be70sm2781801wrr.12.2022.04.29.09.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 09:28:06 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Sean Anderson <sean.anderson@seco.com>,
        Michael Walle <michael@walle.cc>, Andrew Lunn <andrew@lunn.ch>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 11/16] dt-bindings: nvmem: sfp: Fix typo
Date:   Fri, 29 Apr 2022 17:26:56 +0100
Message-Id: <20220429162701.2222-12-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220429162701.2222-1-srinivas.kandagatla@linaro.org>
References: <20220429162701.2222-1-srinivas.kandagatla@linaro.org>
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

From: Sean Anderson <sean.anderson@seco.com>

There is a small grammatical error in the description. Fix it.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
Reviewed-by: Michael Walle <michael@walle.cc>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
index 80914b93638e..b7798e903191 100644
--- a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Michael Walle <michael@walle.cc>
 
 description: |
-  SFP is the security fuse processor which among other things provide a
+  SFP is the security fuse processor which among other things provides a
   unique identifier per part.
 
 allOf:
-- 
2.21.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D58F569D32
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbiGGIUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235425AbiGGITw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:19:52 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B02031DCE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 01:18:59 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id v12so9536742edc.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 01:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MwipOXb6LRRiT5bisXBXsYDVKLh0i5fzf+d3OONFKdQ=;
        b=XF+ORnPfOh8IEmMJrmcDE/nhbYDTvEqsNhkOoIyya3QZDqpdeLCkK/GBlPGvh6iM6E
         46wUsFol0pTRJHinlg9kifNtEVQfXViXRtk0mTu6NoJ5vXkJWwvl7cJSVzAqfzfS/iMz
         Yeu8bE+87jXB0kzBZD4Kox+kOGfYu4wstdUxLz2o66amSRIT94OmO2JQBr58DK1Fv7u7
         7mH3Ir8zHMnWEW+HS9Tra2cwoRUliJCUiIU39aFPtIIm6KkKZULTYkSz6UPAoi+QqNJt
         0/PHD9gDpIrj8HHhg4AgfhT5go0OGUe7ibB5+PWRrdIMvXOx73xLzgZjqGbCdpAlNq75
         x9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MwipOXb6LRRiT5bisXBXsYDVKLh0i5fzf+d3OONFKdQ=;
        b=rNclV9Zds/j5m/sxfbOVDbcTbd4cs22TJFD25fRVMc4aNzUSV/lSJ6gJWPV9CPczsz
         Bu6taW+Ll2mjuLS3kOHEBCxTeWJ5ckr9ch/AqKzihcdJISnQA2RE0hb6Iy+Jp2U3kjcK
         bZ4h33PZUxVRqR4Cwx27F8j32PYYI2GvB11+fuFFX/sud1ceO5rnTTK3C+F64jgriH1n
         ECrkN43SgzGr7iVHlkIAwUKVjd0PrAeMuSx3vuyTxinn4FG6EAJh1A7j7zM6H/PTKPaH
         JH8opJYembohO+m3B+bZ2Bux8ijKelCCLTGGclRh+ExjK5GOTq02qMiEV7v9SGv99VRM
         Vqcg==
X-Gm-Message-State: AJIora/TyhE4pXEKAfVmTnbXwzdYSuHEpMrvUOmEVaIZiMR+HdF66Maf
        05Jo/ZGVX2mh65KRBF5tzaeCn3/cfuCPkvVq
X-Google-Smtp-Source: AGRyM1tlGJouNKahbDS7auq8hdRSYNWEM2VA4KBmQStt7+TfT48n3vBmGrXDJfzkI4Hitl+a+XMy1A==
X-Received: by 2002:a05:6402:2802:b0:43a:9098:55a0 with SMTP id h2-20020a056402280200b0043a909855a0mr7942234ede.179.1657181937376;
        Thu, 07 Jul 2022 01:18:57 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id f13-20020a170906824d00b00726e108b566sm12871779ejx.173.2022.07.07.01.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 01:18:56 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v4 1/4] dt-bindings: vendor-prefixes: add 9elements
Date:   Thu,  7 Jul 2022 10:18:23 +0200
Message-Id: <20220707081826.953449-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220707081826.953449-1-Naresh.Solanki@9elements.com>
References: <20220707081826.953449-1-Naresh.Solanki@9elements.com>
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

The vendor prefix for 9elements GmbH [1].

[1] https://9elements.com/

Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 0496773a3c4d..2b3c929b1332 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -29,6 +29,8 @@ patternProperties:
     description: 70mai Co., Ltd.
   "^8dev,.*":
     description: 8devices, UAB
+  "^9elements,.*":
+    description: 9elements GmbH
   "^abb,.*":
     description: ABB
   "^abilis,.*":
-- 
2.35.3


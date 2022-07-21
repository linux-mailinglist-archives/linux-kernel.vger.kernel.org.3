Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465A057D443
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 21:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbiGUTft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 15:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiGUTfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 15:35:40 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077803E760;
        Thu, 21 Jul 2022 12:35:31 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id j22so4916395ejs.2;
        Thu, 21 Jul 2022 12:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GHH6iYGdl9sRkae4YTPPmdcP2BrajZ72JH5y9Uk/yV0=;
        b=BWrL/I1ohai9wnnCJivQfW7iGUyljMW6thN//Gt0b0YuZgcWVAZ6q8cAg0hgjQe0vA
         fqPeADOWiCxeGdt3zM+TsZf9jMlpRzo2ixDqCuOP8JP6XAK+TwpMVGpa4Cw6186XmY8X
         w6W+42nh2abwxICWO4zYaRfXGeTqGgjQbUZldYYK4RUQtiXMdkgWXn1XFYI2KP4SsmNC
         BXhGKh+jnI0swnWeMoua62g2H5RAbhdL0YlSIwGgWkEQSgFCx7TMdvtWB9PsTenDNFPW
         MW5CPz5cfqtMDvTWQ5dwuWIqieSZw7WYc8HIP/5aPXAIwI3LnUnDifRt1alLmZYWpuHz
         3MUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GHH6iYGdl9sRkae4YTPPmdcP2BrajZ72JH5y9Uk/yV0=;
        b=elZYhLNctFc/Vw6EF8MbB8C7vC5WexEAnlQ8lG1ssbDxStjns3E7dAN86gAH9aKZ69
         BFq8q3GSBI/MHplqwT5mTFYvmHjOwV409MmcGzmHF3OAQmZo4SRdLsACxUv3zJc7blqD
         6qowshYWgm8dpSkQgpZHANua3NmkQ2VanEn4gtBXrPuaoIFxhFDuVHnXIL8Ykqp82QRs
         V70yzqr8SC4NUgqXTrZgNtSQu6aHA7wUtXfcrA3KV0sm/8BF82dvK2jVVyVLYxzELK/m
         hRcUiXFimfnCjRFLnZaDDydD/LlHk2spiqoQllAE+JC1Sse0FCSpjxTFk4KiMXmD0mYV
         eXiQ==
X-Gm-Message-State: AJIora9EM2CoxiGx/YnxokZk7pXEPWW56iPa/gY3FEeC8ox373WpDqLa
        2TonqGRFfCdaWh5TLdZ36dpzEQMqqaJt4Q==
X-Google-Smtp-Source: AGRyM1su2XP8KCkdMroYDnyS+cQZQLQ+++KaDBvefFi6tGu1ne1BBy5vod6qsJUYyaG01GqlRqt/1A==
X-Received: by 2002:a17:907:2723:b0:72b:5af3:5a11 with SMTP id d3-20020a170907272300b0072b5af35a11mr107288ejl.584.1658432130151;
        Thu, 21 Jul 2022 12:35:30 -0700 (PDT)
Received: from localhost.localdomain ([155.133.219.250])
        by smtp.gmail.com with ESMTPSA id q6-20020a056402032600b0043574d27ddasm1430430edw.16.2022.07.21.12.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 12:35:29 -0700 (PDT)
From:   Daniel Kestrel <kestrelseventyfour@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Kestrel <kestrelseventyfour@gmail.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: vendor-prefixes: Add AVM
Date:   Thu, 21 Jul 2022 21:34:53 +0200
Message-Id: <20220721193455.2717-2-kestrelseventyfour@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220721193455.2717-1-kestrelseventyfour@gmail.com>
References: <20220721193455.2717-1-kestrelseventyfour@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for AVM Computersysteme Vertriebs GmbH (http://www.avm.de/en)

Signed-off-by: Daniel Kestrel <kestrelseventyfour@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 294093d45a23..0be52bb27f2b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -153,6 +153,8 @@ patternProperties:
     description: avia semiconductor
   "^avic,.*":
     description: Shanghai AVIC Optoelectronics Co., Ltd.
+  "^avm,.*":
+    description: AVM Computersysteme Vertriebs GmbH
   "^avnet,.*":
     description: Avnet, Inc.
   "^awinic,.*":
-- 
2.17.1


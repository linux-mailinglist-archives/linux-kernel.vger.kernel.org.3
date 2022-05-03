Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665385188FC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238853AbiECPuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237302AbiECPul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:50:41 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D055E33E8F;
        Tue,  3 May 2022 08:47:07 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id ay11-20020a05600c1e0b00b0038eb92fa965so1617581wmb.4;
        Tue, 03 May 2022 08:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=80Ajy3E8zr74DMwLvdHtBgD6k+JzeYDH65oyG0hvOck=;
        b=CfQAahfU+n8KZFyEVz4yGEntqne5VtENCybgdvVVfOHkdxKI1dSynIe76HkAAmBYhR
         VaZQYgBJwIVintv/q/oDTUnM/FO7x7Zg5NoiYM8fPyVIs525a8tuVNgif5KDWlK5Die2
         EurbCewLNat2XW7KsWN5MXYrwTewDT8Ea9B9J1ANnsNa6ExkCaNnsN8hr/1N0txrBG1C
         LKHJqwFlBq42CnCKnyZZAA1B7N6q4d0Fo9g2TGDwLQTTwBcP9IppKzgz+Hbp2xHfY+pL
         0W99f+knV/mYB//28Mx7Iio6J7PWEJOpM1Wcvs6fU+cmEAgLWeWF+JZn6sKELlQ0UeE/
         FAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=80Ajy3E8zr74DMwLvdHtBgD6k+JzeYDH65oyG0hvOck=;
        b=68kmf4mdaon1v6YoKMNetJxoHWrfjhSWbOXXB8WESVWPldSsrCs7KW7legsIX0mXc7
         clzzTbPBDozLT2x9gKZFDLgTznvOaGw5iGi42qGIpzjsLuQKX9OdLIS2uRy8p4qbQyTn
         Syn7PumC1emkvpHuw6QYjUFrz+8KgIgs5lAzLTVjO1LNsh7NvTZnzaEOmsuSu0NDAZfr
         5tl7cG2VAcrPKn2pMCauz2i1l0UTXPoZnjby9DFw4HCsatFek09vQ4T/akI/zjeLYnPJ
         7MoZCA1OHqTI25+SDmCz7wrBIpVPAlJjPz2/O4pT1Ha/nQfgINo+XbWQCW6TPDyPRwlA
         IqWw==
X-Gm-Message-State: AOAM530slq3XxsYnHp2ujnPi6Edlr9NoPkMOxdmjS0xSZ5h1mvjVACyN
        t8dA4p7OGzyiNYkMkp+nkok=
X-Google-Smtp-Source: ABdhPJwCH+6lVfB4Sqddsc3NgswMMhmULDQDl8FrAVs2ZeTHKe+xjOs06ldTX1Zh0UsH8qVC6O0qnQ==
X-Received: by 2002:a05:600c:1da9:b0:394:235f:f5de with SMTP id p41-20020a05600c1da900b00394235ff5demr3863342wms.120.1651592826369;
        Tue, 03 May 2022 08:47:06 -0700 (PDT)
Received: from vmu1804.lan ([2a06:a004:d009:c8fa:102c:912a:a6e3:41ea])
        by smtp.googlemail.com with ESMTPSA id c23-20020a7bc017000000b003942a244ecesm1861958wmb.19.2022.05.03.08.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 08:47:06 -0700 (PDT)
From:   Mikhail Zhilkin <csharper2005@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Karim <Karimdplay@gmail.com>, M <x1@disroot.org>,
        Mikhail Zhilkin <csharper2005@gmail.com>
Subject: [PATCH v3 1/3] dt-bindings: Add Sercomm (Suzhou) Corporation vendor prefix
Date:   Tue,  3 May 2022 15:47:00 +0000
Message-Id: <20220503154700.2339796-1-csharper2005@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220503154254.2339744-1-csharper2005@gmail.com>
References: <20220503154254.2339744-1-csharper2005@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update Documentation/devicetree/bindings/vendor-prefixes.yaml to include
"sercomm" as a vendor prefix for "Sercomm (Suzhou) Corporation".
Company website:
Link: https://www.sercomm.com/

Signed-off-by: Mikhail Zhilkin <csharper2005@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 01430973ecec..65ff22364fb3 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1082,6 +1082,8 @@ patternProperties:
     description: Sensirion AG
   "^sensortek,.*":
     description: Sensortek Technology Corporation
+  "^sercomm,.*":
+    description: Sercomm (Suzhou) Corporation
   "^sff,.*":
     description: Small Form Factor Committee
   "^sgd,.*":
-- 
2.25.1


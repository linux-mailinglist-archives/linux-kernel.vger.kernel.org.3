Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4857528485
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242545AbiEPMsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241098AbiEPMso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 08:48:44 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C443038BE4
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:48:42 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id tk15so4959122ejc.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hMdyF4If6ae6Tmly543kWlCuV298toa6OvkNM2U0cEM=;
        b=k3iAgjmc3ZkJRc3VOJ/SKmPGYWWzWQmCcwT2XhmXLs/SygErr4+WC9yo/tcrhvQn18
         8lmjEvTLjbcaS1jwZfhtLFRA9uGX3p2AWf9z4x8YvTt9anlpxaLblYyhV5n2t7bArO3t
         VaDCXhtjnpxqNzamjY+YTLEHe45niAyrabL40jp0DGYz8hNSLNiSzsgxg+Wr9UD69WIN
         bRXMe5+IlXQg793oUbiWbvN5xzfazuYhsWtZE7v/6ag34jpZKCwacPQrA2p39BwClsuZ
         PZJxFFe4C6wOi2uNwE+C2E3fvnsIpZzCInxij0D7nH0qrvxRjj1Ot5rpyCaH9LEMPfNf
         uGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hMdyF4If6ae6Tmly543kWlCuV298toa6OvkNM2U0cEM=;
        b=KJ12LOdCn+xb620UIo6NN5ddGz1bwf7IojlF49IUFb+yFT8gX1lyPjvw56Mck89AtJ
         Hhq4ijaX0h3IlEyNqLhotHZMZPk/Oi6RpXzWGQA5H+KMmVTHuIauyyhbNe93jcupRoJD
         p65fjKCxHd9zM1ovjbsG5bh1ZZJZrfjVkf+9xIfkMBudfym8i5WI2ZvkJyTd0tjKdH82
         jR+F5wr4MuQuqj9zE5zLwxWdi6b9nlYkdLQPGn8z3HZ5YbdDQkZKmt2sK0dXfGr3b5U4
         mJPyqGPe8/+m2y+hDrhyKxsRu8A1Ea2KDt4QaypzK/okJlyVengIJJlMVnDBY8HQbC0/
         X7YA==
X-Gm-Message-State: AOAM533hZveZUj0EyokJP9t6ua3HQVFTwMFdu4zHQrC0De5gOCo519CK
        GEBaWN0XcGRe/49N7XWN2lFGVA==
X-Google-Smtp-Source: ABdhPJwoIt83C38GsHPHd0kwSgf5SyF3isyKvMAg7kwCZJ0B+A8znq6BEPh+8ju0i1Nz/EwHGucT+A==
X-Received: by 2002:a17:906:328a:b0:6f4:8045:3fe3 with SMTP id 10-20020a170906328a00b006f480453fe3mr15700188ejw.752.1652705321266;
        Mon, 16 May 2022 05:48:41 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-105.xnet.hr. [88.207.98.105])
        by smtp.googlemail.com with ESMTPSA id e10-20020a056402330a00b0042617ba6386sm5093331eda.16.2022.05.16.05.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 05:48:40 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, kostap@marvell.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 01/10] dt-bindings: vendor-prefixes: add Methode Electronics
Date:   Mon, 16 May 2022 14:48:19 +0200
Message-Id: <20220516124828.45144-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for Methode Electronics, Inc. (https://www.methode.com)

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 8fc6ed566cf9..2ee5a62363ea 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -768,6 +768,8 @@ patternProperties:
     description: Cisco Meraki, LLC
   "^merrii,.*":
     description: Merrii Technology Co., Ltd.
+  "^methode,.*":
+    description: Methode Electronics, Inc.
   "^micrel,.*":
     description: Micrel Inc.
   "^microchip,.*":
-- 
2.36.1


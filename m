Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0218B58C756
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 13:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242908AbiHHLL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 07:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242896AbiHHLLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 07:11:19 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EC9627C
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 04:11:18 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id d14so12092924lfl.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 04:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b5CUxqI9Ftd/oBpD3raSgwrhoqEQ6WPkcBBtgt4LsSc=;
        b=HonQjNGD/mJ10kRpuWUhxZWMbrt8o+LuHpoFAtz2WQjrl5NmducLbP02SsS0AmU8Te
         SuO4nX7mdfmpqZ94LPlCNjNdUuncN7W9DMVHd0admzmkz7/Fp0PUuS2K05Ax+m4OprSq
         hKSmWX3IyMPao45v8A5zrWNUx3aFLiKgMj9MaTCDf/rDXoIBaaLvWW6R/q7SheuWXgbS
         oMfGsHa2nFYyQu6aifbPz3prMpbDihqMtJAU8WzXzp+ZdhYfHZmAWblYmfBpZRqj3ESw
         stdd7aWykbs+55OTqfvKmtxvZBJHKuBwRswruMr8Bn9SN6WiFLwLMu5Mv6xSg/OP2XZZ
         FErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b5CUxqI9Ftd/oBpD3raSgwrhoqEQ6WPkcBBtgt4LsSc=;
        b=8F6h9vO7vRIC+giR3UBl3pqDGuuF7xO3smg0bz0NUAFElVhb2S157PbmTKehqSLv5P
         hGMJ/irYGl/Dkf67Nr273OiMMl5yANj9xjoI9v2UXi/W2J+7durD5HBNmi+fl+dxI0p/
         zHJq5lhhbj6U3aCLKAI+drKWG+FRwj8wSDNCeELx2MnNGGoO7C7UxgNgXRwudO6HS56g
         nQ+Rri2M+dl7I/eQM+HnsCjK6+Dr88Fe1tpBwBysSTtxeaVQtzfldZ/Waya4x84hq9/x
         4d41va25kglVfXLuH6d5DG5NH7ztTOn5zt6B54Pci6+xNKTfdAyspIP6gHxP4j4kR2pC
         z2eA==
X-Gm-Message-State: ACgBeo12b4q32UyqqXFh9/8F2nvofv0qUdWQIza1echrryiT8jzg8W3L
        M1/7Pj9zTXdQBLNqGgVZATr4vQ==
X-Google-Smtp-Source: AA6agR7KJ5yUkjQXEQZIB8HGmRM1xQ0z4iYfA/ZN7X8/6m16Gx9nIYmdRUJje8wFJPg7dxkYsYfWzg==
X-Received: by 2002:a05:6512:3183:b0:48b:a2c9:2632 with SMTP id i3-20020a056512318300b0048ba2c92632mr2666673lfe.408.1659957076754;
        Mon, 08 Aug 2022 04:11:16 -0700 (PDT)
Received: from localhost.localdomain ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id x4-20020a056512078400b0048a93325906sm1392136lfr.171.2022.08.08.04.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 04:11:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Tim Harvey <tharvey@gateworks.com>, Lee Jones <lee@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] MAINTAINERS: mfd: Drop Robert Jones
Date:   Mon,  8 Aug 2022 14:11:13 +0300
Message-Id: <20220808111113.71890-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Emails to Robert Jones bounce ("550 5.2.1 The email account that you
tried to reach is disabled").

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

For dt-bindings see:
https://lore.kernel.org/all/20220808104712.54315-1-krzysztof.kozlowski@linaro.org/T/#t
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4832b317fe05..ee8f04918d44 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8442,7 +8442,6 @@ F:	tools/testing/selftests/futex/
 
 GATEWORKS SYSTEM CONTROLLER (GSC) DRIVER
 M:	Tim Harvey <tharvey@gateworks.com>
-M:	Robert Jones <rjones@gateworks.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
 F:	drivers/mfd/gateworks-gsc.c
-- 
2.34.1


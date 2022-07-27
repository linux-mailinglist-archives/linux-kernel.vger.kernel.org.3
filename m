Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28EAD582E88
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 19:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241615AbiG0RNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 13:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiG0RNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 13:13:09 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44ACE76467
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:42:08 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id z25so27997035lfr.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eSPaxO046Ze33lKCriyBi8yHHhzQgKxgn//51vCRfws=;
        b=AbbhqBv9E178tMhwtsG5r7YM5oszCwrW9k1hW7z+DlAQTz6Lt/6jGLCEB0pJXBYqTb
         qGGCKjH1dHXi+rkpdvlJp4Gf41vcYJ/fDKD9Pb+DupvIZkF6xiEqz2EjjqyjJw5CxCea
         vcZYtGeykc+4WHvvwczUw+ZTAOJgAGMZxX75x8adytC0aQbpvCJuroAPPWboUeSG2JgP
         Sb/VvWX624MEMNeEhO7Kz1ZmX1fiEyXIg80rbAHqyvEy4stbPqAD3DjfypWtQb1h92b4
         nTxen8Y1UzzFj3pHKbdcwyIQiAjeXXsHqxdz4twV6JzQZoQ+J7ag9BannbCD1kKhcJnT
         idnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eSPaxO046Ze33lKCriyBi8yHHhzQgKxgn//51vCRfws=;
        b=aAC9eGBNwoONwArqaFzITdl7XRc1NSW0CkWGlOVrZnuIJ+uC7GYvoVYR0eArcYFHMr
         Q7cu7c2IIRKK9WyB0BmhzqeaDraBtsqSphjZ6POLzpFyNX81OHTZn5uPuQYEVe++R2BX
         b8dojwarGo5YLkqi5GLZ3belnlrP5LPiW7fxBUrO9aLhkuN9HRCu5yBZhA6OGyT6nleS
         UVJInECAZ76fF3Mvf61oy9d560a4e2tK4Khv88aNZFo4FFWkBEfFWyGX1UzagyyoEyCz
         s5b0Q1t+q71rI82ninQYzp0zdjTQBtZ1eylMAWYyHD5C1FRzB92Ny0y+dFQU8tuqd22H
         mpfw==
X-Gm-Message-State: AJIora9SMBYnAi764mk8CJZIc3SgdCCXjCL6g3GTJQrCcRoPYNrN1gjc
        hOpgNDdPIUABP/oxHPiBJz8SbxXQRERS4R3c
X-Google-Smtp-Source: AGRyM1uhBH6wuAdgpcLkgYgpaPQs3mxVcKJnj5iurbEFj6ZPkbZ2ibDfKFQvRyZPsqlhyOim+ut2cA==
X-Received: by 2002:ac2:4f06:0:b0:489:4a1b:ad7f with SMTP id k6-20020ac24f06000000b004894a1bad7fmr9274231lfr.311.1658940125963;
        Wed, 27 Jul 2022 09:42:05 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id c1-20020a056512238100b0048a706d9fe5sm3509260lfv.294.2022.07.27.09.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 09:42:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: mmc: mmc-spi-slot: drop unneeded spi-max-frequency
Date:   Wed, 27 Jul 2022 18:42:02 +0200
Message-Id: <20220727164202.385531-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

spi-max-frequency comes from spi-peripheral-props.yaml.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml b/Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml
index c45b91099325..c0662ce9946d 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml
@@ -23,8 +23,6 @@ properties:
   reg:
     maxItems: 1
 
-  spi-max-frequency: true
-
   interrupts:
     maxItems: 1
 
-- 
2.34.1


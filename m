Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD50B5A50A2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 17:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiH2PtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 11:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiH2Psu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 11:48:50 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E030695E7D
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 08:48:45 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 202so8043256pgc.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 08:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=na4Sz6ydBh+nZpxq8SeQ1xRZ15weaLtAwe8pYhePWlQ=;
        b=H/eRX2JHvSXkJJdPhRyEMhQay0u6/v3VJlRvqkaDLiX8aJ6JB7wbr4mxi+2Hg8Zqq2
         wgLgAmJXNSfZkyqAt8UqbVi05AVmdK3lK97m7KyVzKSpBzumTNyZkR/NnebO0Hu6YIPp
         9b+cAaCUPnMbmsKwimPuYHnbQdWH5PoHWBToQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=na4Sz6ydBh+nZpxq8SeQ1xRZ15weaLtAwe8pYhePWlQ=;
        b=hUixtTd//7rGXlNZzkfhvSId5tUoLGfJei471p0jP0cnLSVxV5YNpmou5FdpQsdvwL
         e7em1KvdQJngjA65JHz9SwZn4nry1DMfJbtgSxSJ/U/ygasE/cvo68euE0JotxEAI9Ed
         pwTfCX3he+EwoqbBhio4OX7Io+U3vgEzHnZCT2c2GwYRO3ESXfnywnG76S3fVDuRE6/P
         ZWUQSnJJUB9QYJ8E/bVePlwytWDKvd6TygvBLzH2lPwa7DaDkVJKQdO67nI71+bnVZHN
         9/k+e9PaSdoeWryCl675NXgZEJhE4Nfnrdd3875ZGcLMNDm4Sg82JFpoxFP1yQS3YOEO
         eg1Q==
X-Gm-Message-State: ACgBeo0pT/4rlYzIv4hep+6V5tPFjFSHxIyyDMha7SDnl/0vxXnpQDPR
        xceqscNQc5vZ0kT3nBO8ySijMA==
X-Google-Smtp-Source: AA6agR4OlrDGaxJKjoSqkWkpMpmBcD7IFDvSgoFmuuKaAuO4Q139yyfrGB75m7gKoFe16R1J0A8/wA==
X-Received: by 2002:a63:4558:0:b0:429:b6e6:6638 with SMTP id u24-20020a634558000000b00429b6e66638mr14377601pgk.83.1661788124956;
        Mon, 29 Aug 2022 08:48:44 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:3a97:5017:7e33:8964])
        by smtp.gmail.com with ESMTPSA id x196-20020a6286cd000000b00536816c0d4asm7613191pfd.147.2022.08.29.08.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 08:48:44 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Jimmy Chen <jinghung.chen3@hotmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: arm: qcom: Adjust LTE SKUs for sc7280-villager
Date:   Mon, 29 Aug 2022 08:48:23 -0700
Message-Id: <20220829084732.1.I9ef7f8b909a7afbef9ff2251a98c67033f37b516@changeid>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There have been a few changes since the patch ("dt-bindings: arm:
qcom: document sc7280 and villager board").
* New firmware reports LTE boards as "SKU 512" now. Old firmware will
  still report "SKU 0", but that's all pre-production and everyone
  will update.
* It's been relaized that no "-rev0" boards were ever built that were
  WiFi-only. Thus we don't two entries for -rev0.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This builds upon the patch ("dt-bindings: arm: qcom: document sc7280
and villager board") which hasn't landed yet. In theory this could be
squashed into that patch.

 Documentation/devicetree/bindings/arm/qcom.yaml | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 8e46a3c5160f..40705e2d56de 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -582,14 +582,9 @@ properties:
           - const: google,villager
           - const: qcom,sc7280
 
-      - description: Google Villager with LTE (rev0)
-        items:
-          - const: google,villager-rev0-sku0
-          - const: qcom,sc7280
-
       - description: Google Villager with LTE (newest rev)
         items:
-          - const: google,villager-sku0
+          - const: google,villager-sku512
           - const: qcom,sc7280
 
       - items:
-- 
2.37.2.672.g94769d06f0-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294BF5847BF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 23:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbiG1Vdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 17:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiG1Vdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 17:33:33 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867577478C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 14:33:32 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id v16-20020a17090abb9000b001f25244c65dso6535643pjr.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 14:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Oc/bWNh4wSfrPUVGN+ae9wVp1cO7IaMu60kdS0UEJ0=;
        b=bdWzyRDFqQ6bHrqG7NGUjjpofldwWnA5FJSctMR6m/RMzAiI1zGWzMMQFv8VtAQ2em
         n4RdT29yNWrECbQHHLtZo0vSOKzR5zHDYLaUuyJknhQg2ei9lJKasCiScMSkm4FhyNxw
         JgNdGjoY4D2SFaMmtwyDL3UXl1rMdN+O37fQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Oc/bWNh4wSfrPUVGN+ae9wVp1cO7IaMu60kdS0UEJ0=;
        b=rVpt/6e0YWaOs8nsXAB+HYWqaMANvbySXVmfUdSyzHP0P98ikk22uv6FFGtO/bJn8S
         jAIAgo/jWZABfbSWoB2BSRa4RGpFQZLxVeLch/izPyS2ARAiHj4xSOQYYp9fdHMEQTyf
         76lUwi/wg4dSXOds6SLKRGEMxzv7tphh1gCDlQJNDi5naRIeU/uacukRvjBkFFqYF8Dn
         kCwFP8ox11uFQmpA87kGANU52GJkwRf49kUaimdTwExn3bYKMsfgXg3bOgydNPT4X2mW
         P1ueXGNaQhl1gALNztSEi7vLJp6J4gjEHMfUUSVYme0pe0gI4ctZe+EskiKKBSftB+yI
         2huQ==
X-Gm-Message-State: ACgBeo0xwYQiq9kc0xZnZDJJlvxrERXdfUAXANDKNnfQo+C/pjgbASbt
        TRUGa1chrDrNEcdKp3ysb66Bz5+Kz+QajA==
X-Google-Smtp-Source: AA6agR4xOmrJNRtjUcXcNJExXEtJnz8QbF3P63CwItGjHnK9qM3n9r/mW8c2Op5tCD1R8cPB7gtwQA==
X-Received: by 2002:a17:902:d716:b0:16d:be4:40f9 with SMTP id w22-20020a170902d71600b0016d0be440f9mr755944ply.146.1659044011752;
        Thu, 28 Jul 2022 14:33:31 -0700 (PDT)
Received: from moragues-cloud.c.googlers.com.com (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id z1-20020a170902d54100b0016bf4428586sm1756930plf.208.2022.07.28.14.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 14:33:31 -0700 (PDT)
From:   Bob Moragues <moragues@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     swboyd@chromium.org, mka@chromium.org, dianders@chromium.org,
        Bob Moragues <moragues@chromium.org>,
        Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: arm: qcom: document zoglin board
Date:   Thu, 28 Jul 2022 14:33:20 -0700
Message-Id: <20220728143215.v3.1.I5b9006878bdabd6493b866b46dbd6149968d545b@changeid>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zoglin is a Hoglin Chromebook with SPI Flash reduced from 64MB to 8MB.
Zoglin is identical to Hoglin except for the SPI Flash.
The actual SPI Flash is dynamically probed at and not specified in DTS.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Bob Moragues <moragues@chromium.org>
---

Changes in v3:
- Fixed Author
- Fixed duplicate Signed-off-by

 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 581485392404..63091df3cbb3 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -475,6 +475,7 @@ properties:
 
       - description: Qualcomm Technologies, Inc. sc7280 CRD platform (newest rev)
         items:
+          - const: google,zoglin
           - const: google,hoglin
           - const: qcom,sc7280
 
-- 
2.37.1.455.g008518b4e5-goog


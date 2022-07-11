Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1AC570C65
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbiGKVGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiGKVGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:06:43 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBC75A451;
        Mon, 11 Jul 2022 14:06:42 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id j22so10928309ejs.2;
        Mon, 11 Jul 2022 14:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=87rHYw1h7ZiXA3EtL/T15oHp4poCj2yJmQAssY50qpE=;
        b=OSME6oao5WcH7dcN/CfQilh7jXArC9VmZ1ehPmxsaHWFDgiqhrVWen1yKwit80ZmaX
         TcmAyX2eSni8R1zQ3BLdj6ufSTreyqnQccI39XA1nNeGG6AeZhCmnbNyE6AiCpuyPX+n
         ON7UIwY1/I8U6h8LZ/SvkyIFb7GlvYOGSVNP3s818V11FixK9T0AVIF0vMqKPNlpp0lg
         zHOJ9sqb94iKhU/CDbVBi7XiABWY7cIatbco9BMAWx77R2T/R7RmwNIBs9LNv1JXQHrs
         FL7YnK9uPfmFDfH7jqMq1XtBq/bLvXNVg3Kd4lhjqx1jhiYJK5RtXrzS3p72dUkfj955
         Mx3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=87rHYw1h7ZiXA3EtL/T15oHp4poCj2yJmQAssY50qpE=;
        b=aDk5pNtxRxk9Tc2SMML9fW+miZj2CPRqRDih0oprkEVGt7OXNRzIujI6VeUWGoO5pc
         tzyApq2BzfcNSQvfdXVvIQysm+vvNI4n1SBGz0dZfiz3/LX0ivTE4yFFx0f49dZ+IhJy
         Feynf5qf2ibc4F5F9c3PeF5TvZbJ1cdlB/H5J5e4EBZzLIy9c6WrAtifOmBhvmgB6Hea
         03L0Z1ibMJI5ypRM3fwSvxxqlUme9jF0HUD7SspTaH6fgzmvVmbX6WalqB3fZWqGOJrX
         xB0+dtnosIHWKtE3EXsh/7mnx6mydtb5q884j9ndpQb8TY3Xa4Z5KjOWlURTm5YvyOWH
         nlrg==
X-Gm-Message-State: AJIora8YZvdeV8ZSS4l2XIJX90Z+lzlvNEV3lJwejFicXoqN4ThKXaHX
        TVlK4ghn1JAivW3ylyx7nIE=
X-Google-Smtp-Source: AGRyM1sHCAo2QnOaev3GH6c+tVTUpIWpHUr+ELOY4dVBRNVXhNsLaNc0aimpzzICufwnFVWc2B/jKA==
X-Received: by 2002:a17:907:2c57:b0:72b:32a8:7afc with SMTP id hf23-20020a1709072c5700b0072b32a87afcmr16243526ejc.129.1657573600684;
        Mon, 11 Jul 2022 14:06:40 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-104.zg.cable.xnet.hr. [94.253.165.104])
        by smtp.googlemail.com with ESMTPSA id lb17-20020a170907785100b0072a430d2abdsm3052562ejc.91.2022.07.11.14.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 14:06:40 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 4/7] dt-bindings: clock: qcom,a53pll: add IPQ8074 compatible
Date:   Mon, 11 Jul 2022 23:06:31 +0200
Message-Id: <20220711210634.3042092-4-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220711210634.3042092-1-robimarko@gmail.com>
References: <20220711210634.3042092-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add IPQ8074 compatible to A53 PLL bindings.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/clock/qcom,a53pll.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,a53pll.yaml b/Documentation/devicetree/bindings/clock/qcom,a53pll.yaml
index fbd758470b88..76830816982e 100644
--- a/Documentation/devicetree/bindings/clock/qcom,a53pll.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,a53pll.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     enum:
       - qcom,ipq6018-a53pll
+      - qcom,ipq8074-a53pll
       - qcom,msm8916-a53pll
       - qcom,msm8939-a53pll
 
-- 
2.36.1


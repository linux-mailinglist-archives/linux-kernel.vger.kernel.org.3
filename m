Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A45527A13
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 22:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238762AbiEOUqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 16:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238731AbiEOUpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 16:45:54 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9817237DE;
        Sun, 15 May 2022 13:45:52 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id i40so967481eda.7;
        Sun, 15 May 2022 13:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u5JzkCm9MWsKf/jb76u0rZ0O4lmlB8YYfn5r9Xj1Czg=;
        b=E1eKjexHxIwNHIOp7Cu3KTyTWAzm0tXz9Tyqdzx6ZHWdhg5YjSVhuu5yAwANvZa2K+
         V4I+JwrkJGo6tYyb+D7UdVEl/6Hiqw29nKDgx6UAhwg1zSuP1pjyTjjLdjQeVJnoLKnv
         +S9st70jRSFgJ7z/bNrzChhqWHaptKGQ2vd9mgZ9Ic0SbqgOv+c/L0vHctNP0F6BWCST
         xx98E8HeFY8SXdPdb5qbnZhV04Fqu/j8zy9J9HNViFnsIvV7G4TZR+k4fhSo9ZNo0NkK
         JSD6NmFCCxCLhEYJyQsM2hYq7ew2mACcK7hnTanyWaNhnCIqmOCRNaF68U/j/FHE0B3l
         ni4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u5JzkCm9MWsKf/jb76u0rZ0O4lmlB8YYfn5r9Xj1Czg=;
        b=eO4UocOllntrmFWclAsDh8WwFuf07WGtzjvfelJ3ZjTVLz8VAViO+RIoj0QUW7Vxzd
         xvin67GdoSObmAut9xdws7HEolikyPBm8JBkka0GaxjVhl/4ippX+9y1gCa+vvFxxgOV
         d3YWeAELkYb0XuBBSdzdi42NO1R3f0Q4Ry0h9S1qlj4bu7pe0z3FIKivrmcF2Oqw828r
         O7UKXLGIJMsBGyg9kACdTFT99vuEatPo8P7GLzr8kUjIf+ju2wPl+Cxptgu+1vUM6R75
         ukGFUF2grryOsT9LYSyHtgzSgZ+qSCrBtXgjy1Gr7Q/cQLaYBenas5vVqxSf6vK5S53g
         gaBQ==
X-Gm-Message-State: AOAM533JZGKzEveV+Hc+Ac7NNxJaHO0krPtKlblOIgFVe5B+V8U8K2kh
        ndLhjJaaMFJaJZHX2QdIAgA=
X-Google-Smtp-Source: ABdhPJyNjp9vI45/J9yukuOOdF6/Ay9N0jvqseMulDkHBqImglINKegNZN33wTcc2jZiQWJTbFrp7g==
X-Received: by 2002:a05:6402:2753:b0:423:3895:7031 with SMTP id z19-20020a056402275300b0042338957031mr9779158edd.170.1652647551248;
        Sun, 15 May 2022 13:45:51 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-105.xnet.hr. [88.207.98.105])
        by smtp.googlemail.com with ESMTPSA id i10-20020a50870a000000b0042617ba63cdsm4174156edb.87.2022.05.15.13.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 13:45:50 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        jassisinghbrar@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v4 6/6] arm64: dts: ipq8074: add APCS node
Date:   Sun, 15 May 2022 22:45:40 +0200
Message-Id: <20220515204540.477711-6-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220515204540.477711-1-robimarko@gmail.com>
References: <20220515204540.477711-1-robimarko@gmail.com>
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

APCS now has support for providing the APSS clocks as the child device
for IPQ8074.

So, add the required DT node for it as it will later be used as the CPU
clocksource.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v3:
* Node does not currently exist in the upstream kernel, so add it instead
of modifying.
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 0bc21b0c177f..271eb733f2c8 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -886,5 +886,13 @@ IRQ_TYPE_LEVEL_HIGH>, /* int_c */
 				      "axi_m_sticky";
 			status = "disabled";
 		};
+
+		apcs_glb: mailbox@b111000 {
+			compatible = "qcom,ipq8074-apcs-apps-global";
+			reg = <0x0b111000 0x6000>;
+
+			#clock-cells = <1>;
+			#mbox-cells = <1>;
+		};
 	};
 };
-- 
2.36.1


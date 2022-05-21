Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C6E52FE51
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 18:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355381AbiEUQq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 12:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355462AbiEUQqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 12:46:07 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472D91180F
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 09:46:06 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id br17so6705424lfb.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 09:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zRW+nitNdiyJveLQkWDP36MSIJ7syqdFIWi2TI2HCgY=;
        b=Bv/dAc+VzEsQCIsBmd0Miu5xiEkNXBxebVCMj/8aWCD9am4WJqyWegU7xw2vQsvkwm
         T5vRvJrNfW8Bt1SY95HmlqhePEgKlpHwPJUXLNnWl4lRRlogUt2a0WwKnig+0IKFsAuJ
         +RDcv+gZzj7FcD/8maBNwZHe7o2oMbfeQ4ztQehPP897xQu+HuI9dLaXL9dfCP8N36Zv
         8FeaAKQ9dgKCJslawUeU9KY6IjF4eoyAeh9HrqW2FerINJNtP3QqZxOLYbFuZWurtSnG
         HEKXgenjDHBcz1smtBZbmg8CJZsFgPpVlqxFREoILWN+uianc8vwgIQdt6508++tUKdT
         fEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zRW+nitNdiyJveLQkWDP36MSIJ7syqdFIWi2TI2HCgY=;
        b=MEPUxxuRbthnJOWGOZHoM++KbxDUUhjQ7mgBu6+FXwpMyI+8iOxwaYt2lAdrOa/V00
         hU2yYaxQn/LF6cjAgDe7khqcE4Mn8m4DLDehsDK9yKbBAoAGk8xJMp8z/gbnA91MjJRU
         tIBHakcRVTdYGAH2rLjrKssciY+aXL5kuKdQNc1BkOIHt/3z5EEXK6oMuoXNcEYhsPI1
         993f1CrmbgsQmhQV9Llw6KWw/fY73feuRGhcMLh7D/9ikVjdCigo2Jj8wwMiJPtmNN0N
         rgRSfniEYRqr6KrarCOfMvXt8JxZ17+FMN7MTEq/ZmgxoC6QtOvrhOKc7fzytM7qUfoZ
         +XlA==
X-Gm-Message-State: AOAM533vPkTv5FQLplq6beV2gnOIhpr+gDkFap39i4+RfZ8cpZC6YHjN
        cTclLprHSRUE840LOsb2qeolwdoPZZLl7kyL
X-Google-Smtp-Source: ABdhPJwMLxE9peJiV5bTCFMHmJLCBB/4xmpluVOGXyg/k2jOobRsPXPTbFA6benVUrkt7ZCzSk8jqA==
X-Received: by 2002:ac2:46e8:0:b0:477:ba2c:a68b with SMTP id q8-20020ac246e8000000b00477ba2ca68bmr10766667lfo.55.1653151565843;
        Sat, 21 May 2022 09:46:05 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f26-20020a19ae1a000000b0047255d211cesm1114282lfc.253.2022.05.21.09.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 09:46:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 11/12] arm64: dts: qcom: ipq6018-cp01-c1: fix Micron SPI NOR compatible
Date:   Sat, 21 May 2022 18:45:49 +0200
Message-Id: <20220521164550.91115-11-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220521164550.91115-1-krzysztof.kozlowski@linaro.org>
References: <20220521164550.91115-1-krzysztof.kozlowski@linaro.org>
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

The proper compatible for Micron n25q128a11 SPI NOR flash should include
vendor-prefix.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts b/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
index 821cb7c0c183..d9a8c2e68ae1 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
+++ b/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
@@ -43,7 +43,7 @@ flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		reg = <0>;
-		compatible = "n25q128a11";
+		compatible = "micron,n25q128a11", "jedec,spi-nor";
 		spi-max-frequency = <50000000>;
 	};
 };
-- 
2.32.0


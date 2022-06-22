Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFEE55483D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355383AbiFVIgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354879AbiFVIgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:36:07 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2A439143
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:35:57 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id g25so32576695ejh.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3StjZ2NWkaxmjTBx5S1Xrepsilctzd/Wb+GRJGm1YHU=;
        b=CMWoMJVAmkE5y8dJLdRAI8P4GBa0AQNWfPRlkJSmMM6W+B80tz53SP69YkeiEFsE3d
         2PR0jxYg5595HC1ZYNV5RVqFINVUC8W4QiUQuY1A4kRzllAzG64e8KZMuOt3HT7EKdx2
         pxjayD3rCWCtOK6FQ7gev7mmeRYEhw/2hhwyJQQhUIPNPI/x8alybGofM5hwZOR0Btm6
         If/Dgkqt/RxU6r0b9Sn5dngRUiBv0Knvqy/cudQggTl0WOfXCyMnsg3OrBUjWtKlb7GL
         atoB24gtHM4kOBvJGIzRi8zzbdhxQ0Ne0EqBHUju03uXseRugNJJ/UbknYLo2c7Qk1TF
         EQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3StjZ2NWkaxmjTBx5S1Xrepsilctzd/Wb+GRJGm1YHU=;
        b=LHSjBUTIfZHSkf4bjVd9rOn8HQeWtxfprhDTeAiuOCiuulJCVLSSbtt+oY4Wh5XG6W
         Wrm+ySRC/0kYZNf7FxCo5mmZY7viCiXVuFUxrw1+Kds7l31snhmcLvrjO9SgLFWb2ERu
         0mrECNHg0xYasHjw3evm2jfTRXKLaqNnZX9ihwv0HCNVXdDvG0XevfRnZrIs4WJk/LJi
         4tjfPcNyPbVuGihEF6D8h1cji5FWkXop4Gwhy+joDqKY9F4HWkRXI1F5bOpNAC+CaLzF
         9ZNwFO+rW5+LyXpGgmGCVZ2mzmq3xuubah9GeTaJc0grA70EDy97QLsLySC2+1srZso1
         SnIQ==
X-Gm-Message-State: AJIora8c+JTIpQuDkBroXHPJMCzuqBHjqrP6sFE0uh5e7piml1EcBewt
        SF1UL8wX1yl8qjsvuMrv05wdePCCSZXsQQ==
X-Google-Smtp-Source: AGRyM1tvusng6ATUlwi0iXkUZNOsIXpZiDmzXc2zMjA93nWzQWEkQt2SQZlBoi6gjmbM4HEPrf38PA==
X-Received: by 2002:a17:906:8a44:b0:722:e858:c97 with SMTP id gx4-20020a1709068a4400b00722e8580c97mr2003299ejc.476.1655886955878;
        Wed, 22 Jun 2022 01:35:55 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ku10-20020a170907788a00b00722e603c39asm1979733ejc.31.2022.06.22.01.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 01:35:55 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, krzysztof.kozlowski@linaro.org,
        agross@kernel.org
Subject: Re: (subset) [PATCH 6/6] arm64: dts: qcom: sdm630: correct QFPROM byte offsets
Date:   Wed, 22 Jun 2022 10:35:40 +0200
Message-Id: <165588692598.15720.7367676138170899411.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220505113802.243301-6-krzysztof.kozlowski@linaro.org>
References: <20220505113802.243301-1-krzysztof.kozlowski@linaro.org> <20220505113802.243301-6-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 May 2022 13:38:02 +0200, Krzysztof Kozlowski wrote:
> The NVMEM bindings expect that 'bits' property holds offset and size of
> region within a byte, so it applies a constraint of <0, 7> for the
> offset.  Using 25 as HSTX trim offset is within 4-byte QFPROM word, but
> outside of the byte:
> 
>   sdm630-sony-xperia-nile-discovery.dtb: qfprom@780000: hstx-trim@240:bits:0:0: 25 is greater than the maximum of 7
>   sdm630-sony-xperia-nile-discovery.dtb: qfprom@780000: gpu-speed-bin@41a0:bits:0:0: 21 is greater than the maximum of 7
> 
> [...]

Applied, thanks!

[6/6] arm64: dts: qcom: sdm630: correct QFPROM byte offsets
      https://git.kernel.org/krzk/linux/c/b4e7bcc945c6b8f3131460b94e28ff4bed23f847

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344A1515D25
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 14:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379427AbiD3NDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 09:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiD3NDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 09:03:02 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71D274DD6;
        Sat, 30 Apr 2022 05:59:40 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id m20so20042449ejj.10;
        Sat, 30 Apr 2022 05:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pqlb2CDncvPYE+UHM6oqSap1YjcS5KMGTqi0o7URon8=;
        b=olL/+zlZsep6oWP7Rrh8tA53O191n7Fe7a+sy3NbCbBls981RcbeFUhIjm4G78KYRc
         xENR1aBGj4DESg3PcnOn46jXrGORyw4auy6Vtd9Z9D6mfGNlWjTQ3c42rSK6X1oabCnj
         PPnka71x0eQcJZvrrS7PnEhkgsrpmq67Yp4jpEGVThC6WM68r/W+12yfSN0Rvj/7t6tM
         LRX6xirXGX9bqwwlSWZL85L+l9BrZobfcU9Uv0hYXMWgmQGgkFyrUkuHLPhgb7XDdEIa
         Fw/L06PPhDVArJyDhp1564tSQQDQnUoPcOm8f5qTxxTNZm+oeSIoIKPSZPm6SX5EdRJC
         d5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pqlb2CDncvPYE+UHM6oqSap1YjcS5KMGTqi0o7URon8=;
        b=3jcUZ4kIy9aJXZOYUpRhtS5rM3P5gXzu0oIvSL3QqHLPwWwe1Coj3KAMcnJ3Gcutwa
         ySQPMbUcv7RiH9uq5Hg2cFcsqZpqfXE5f0qVIojwALdzQxvnoRnh4vrGDzAKbOcr50VH
         lLCFTx8BUJlLgZPhJX83kQ67z3H+VkgK2xJWMy9Mge/2lSGKaKbSHekCf90YL8HTy10W
         12VTuAZ8eUwRXVt5qGJAxBkh83421PiCH7th1FXzACmHUGrGxfjXrEGYOV2dgPQqV5RJ
         dlrHmnDFYR8k4YJngYNcvvChCBx4dwj/PhZhBUhTqG5gZPcnabOEzEjWcvGtoelNONXf
         mxlw==
X-Gm-Message-State: AOAM533/JuW7AI6NBmnyfLqNsCosKba+SYc1CxlRO2WOIUE7++8KWS0O
        ZT+kLtYMZsRPIm2VqZO/aDo=
X-Google-Smtp-Source: ABdhPJw3diLUBhg2UjGkqI8k7gOZCaSdV6fEJieDUrrer27ThuJpUlQiDdgeG76sWHkUsnKPvlakuA==
X-Received: by 2002:a17:907:7f8e:b0:6f4:2d7c:1b75 with SMTP id qk14-20020a1709077f8e00b006f42d7c1b75mr351324ejc.726.1651323579297;
        Sat, 30 Apr 2022 05:59:39 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id a25-20020a056402169900b0042617ba63c8sm4125077edv.82.2022.04.30.05.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 05:59:38 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH v2 0/2] PXO fixes for ipq8064 dtsi
Date:   Sat, 30 Apr 2022 07:51:16 +0200
Message-Id: <20220430055118.1947-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small series is a fix for a long lasting error present in ipq8064
dtsi. At times the kpss-gcc driver was defined in the dts with
<&gcc PXO_SRC> a pxo clock. While PXO_SRC exist in the includes, the gcc
driver never expose it and if a driver try to actually use it the result
is a kernel panic even before any log is init.

To prepare for correct conversion of the different krait drivers to
parent data and to reflect what is defined in the Documentation with
actual driver and dts implementation, fix this error by using the now
defined pxo_board fixed clock.

v2:
- Swap patch 1 with patch 2 (fixes first changes second)
- Add fixes tag

Ansuel Smith (2):
  ARM: dts: qcom: replace gcc PXO with pxo_board fixed clock
  ARM: dts: qcom: add syscon and cxo/pxo clock to gcc node for ipq8064

 arch/arm/boot/dts/qcom-ipq8064.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

-- 
2.34.1


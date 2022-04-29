Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0898D51496B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359225AbiD2MgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238640AbiD2MgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:36:03 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA01BC90DF;
        Fri, 29 Apr 2022 05:32:44 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bv19so15169759ejb.6;
        Fri, 29 Apr 2022 05:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d/OGdX6ezZfA+C3V9bkjavIidBPFXQJ8k9aS4M9oYCU=;
        b=RNR5FBdfY2fbTwEZHpnPn5nrS4OjzLjJLlmWqKSanKzBjCEiva2xKgiAzqC/oYRkry
         t5RPSbnerXz+aQS7T1Hf6Yk+c15GvQ2wsguiNc1LS4y/nCDet00oJdqFlkWyr/OUBiWS
         3JbI0Djze8F0PNReQQjygqVA08gzB7o7QycgZm75Jn9S1qyk3K41naF703kPgzMvBVPa
         16NviTl86/v83NHgcpR/vGJq4uUnwgsRXf/JZCli4gGdxdcSgejwxW0hQ8s7jcYn9UaW
         0mTB60RLQ/0/S/Q9bR028GcVUe0I69fuQNPI6XB8u0zIHp0c5d08bIbqRfrv8px6CwRd
         IQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d/OGdX6ezZfA+C3V9bkjavIidBPFXQJ8k9aS4M9oYCU=;
        b=RdvxsRX7RlNOIHdID07Mrrad+B3t75wTk8FAK5TWZS279Zyr320ZCddkrEJ5PD5dDf
         wT7eBwOcA2XcaUVqcT1QodzZ6X2VZ2ZQMK8sbK4icZiAIrBrRKnfV/uCl0dMSzJIzzKw
         /nThdpA9z5onN7dUUV5LrD+fXGOFfTw+AuGAyIOyVcST8xNWRbsNTkyHA8XCOQSx2nr2
         rR8+hflf7gRu5DSTx85oEgqW/SwFejeZb4WdtzxsOxNA+X/Az7L6p4IappGU5hWDXHCW
         kUk+CBdL6JV3nUMdbmg+iY8Okln3VUAKdwpYwjJySdEGAzjoIRIngcT6PusMcEvMbYXg
         h6vw==
X-Gm-Message-State: AOAM533PPJGzPQFTev2mVLroObJGrdrBmkrTGJsoypYgppWi7WvG7Szx
        QHQhm4ksIgt7f84ttvSSbQ8=
X-Google-Smtp-Source: ABdhPJx6nxFL98kXdmVpNp7vq698ZpWhXj2R9jvlVWWQzwmDnbBITQOZM6fHRhopcYJ+00jwsMIV4A==
X-Received: by 2002:a17:906:8306:b0:6f3:da72:5ca1 with SMTP id j6-20020a170906830600b006f3da725ca1mr8025427ejx.606.1651235563426;
        Fri, 29 Apr 2022 05:32:43 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id hf27-20020a1709072c5b00b006f3ef214e33sm601176ejc.153.2022.04.29.05.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 05:32:43 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH 0/2] PXO fixes for ipq8064 dtsi
Date:   Fri, 29 Apr 2022 14:29:49 +0200
Message-Id: <20220429122951.13828-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

Ansuel Smith (2):
  ARM: dts: qcom: add syscon and cxo/pxo clock to gcc node for ipq8064
  ARM: dts: qcom: replace gcc PXO with pxo_board fixed clock

 arch/arm/boot/dts/qcom-ipq8064.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

-- 
2.34.1


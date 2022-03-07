Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53674D0795
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 20:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245094AbiCGTXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 14:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245082AbiCGTXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 14:23:11 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B3C654B5;
        Mon,  7 Mar 2022 11:22:16 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id r22so6429597ljd.4;
        Mon, 07 Mar 2022 11:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LDrUT6sV2tViEGsWl2j62Jr1hHkhvzMesMXewdPElpE=;
        b=Ab44LO1V1l+drb8J3EQkuDS0VWw3XpOdDKsmkoqJOeTLjFvqaVzlxQ6a/ND54UHYqa
         Ih/GvnWwl68bGwXTza+xAz/A9LcitkZcoi7+1l6EKx0Dz/xN/chD1hR55zt3g/eENKkm
         YJkh++Ndk+CQYovr0no8QrG6OP2uJOQETIvDwxARoS417RgeEOi9iAgTuOHao0T1+A0u
         1itTHiWfLEzsZaMbS+p1+iqkyAwigsR2/6XwirMF5cTuXTItsQhAGdMeE+e4mLuWKoCO
         runrbDkR2UdLFKMcmMBwcvEfVd97wBTZCB6P1C93HzSdn32LkkHrU0Ds05eVwk5K5+Hn
         43gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LDrUT6sV2tViEGsWl2j62Jr1hHkhvzMesMXewdPElpE=;
        b=0lNsxm6uE34/WjTpjx9XpTFCpKVo5iVLw88i7oteELn0B9+SzkpmfO1Yd8SeNUO4pu
         0tvMVQMWUPF+v3NndYGh5CWMYEYp0MpRStCDrp6kQNDDhAGNkQy/AY6MVtSLj47cYKzn
         BoWipvbyw+5AtnZE6ogoGAEwYF5dv5nVlMK9sZ/eQyjzBczkv4eMkMVm3DEbySFr33Sf
         bn93EzX2deA7HYivZ6V6NPvvNmAldj/Q9X3UrX+pxrxxayLekOIMEGlYchiqyObnD6ER
         Qt+zv1dbMr80rxwXo+vAJQWP/qAEbPtWVWqLBRIRJa1ktFgS9RGs5+Lp+M0lUD7cBTNv
         eX1A==
X-Gm-Message-State: AOAM531YlBEpb2Gs2/WOS93huK+LnKfbLW3kAsEMRiHLBqLoppOGI7eD
        AtQyfzvfcQS6+JSk4vbRtIlNmv1xCa39lw==
X-Google-Smtp-Source: ABdhPJyUfL6zf33zmp27jW30NjbZfHLHRLCFUrpkvTMcHjuUOWTbrNH4pTyjWnfx8tD8I+C3E2toXA==
X-Received: by 2002:a2e:9692:0:b0:247:e508:714e with SMTP id q18-20020a2e9692000000b00247e508714emr3930033lji.375.1646680933303;
        Mon, 07 Mar 2022 11:22:13 -0800 (PST)
Received: from localhost.localdomain (adsa4.neoplus.adsl.tpnet.pl. [79.185.186.4])
        by smtp.gmail.com with ESMTPSA id v12-20020a056512096c00b004437e92a5e8sm2995671lft.105.2022.03.07.11.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 11:22:13 -0800 (PST)
From:   Adam Skladowski <a39.skl@gmail.com>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] dt-bindings: firmware: qcom-scm: Document msm8976 bindings
Date:   Mon,  7 Mar 2022 20:17:24 +0100
Message-Id: <20220307191726.10869-4-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307191726.10869-1-a39.skl@gmail.com>
References: <20220307191726.10869-1-a39.skl@gmail.com>
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

SCM driver on MSM8976 requires 3 clocks.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.txt b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
index b1cd4ad1889ae..0f4e5ab264779 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.txt
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
@@ -19,6 +19,7 @@ Required properties:
  * "qcom,scm-msm8953"
  * "qcom,scm-msm8960"
  * "qcom,scm-msm8974"
+ * "qcom,scm-msm8976"
  * "qcom,scm-msm8994"
  * "qcom,scm-msm8996"
  * "qcom,scm-msm8998"
@@ -37,7 +38,7 @@ Required properties:
  * core clock required for "qcom,scm-apq8064", "qcom,scm-msm8660" and
    "qcom,scm-msm8960"
  * core, iface and bus clocks required for "qcom,scm-apq8084",
-   "qcom,scm-msm8916", "qcom,scm-msm8953" and "qcom,scm-msm8974"
+   "qcom,scm-msm8916", "qcom,scm-msm8953", "qcom,scm-msm8974" and "qcom,scm-msm8976"
 - clock-names: Must contain "core" for the core clock, "iface" for the interface
   clock and "bus" for the bus clock per the requirements of the compatible.
 - qcom,dload-mode: phandle to the TCSR hardware block and offset of the
-- 
2.25.1


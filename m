Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2F64D078F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 20:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245081AbiCGTXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 14:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbiCGTXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 14:23:06 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38625DA45;
        Mon,  7 Mar 2022 11:22:11 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id l12so21915251ljh.12;
        Mon, 07 Mar 2022 11:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LtQDpTBWNlm9F/etA2HBvgmoDYk50JyPS2902qGT/XE=;
        b=Rq6lqI/4oa+xO6gpKg3nxi0+ScpIxgrKSkSXo4n8wcQNIdQC5GvMzDDM8nYm/a2u1D
         Pg1OQFKEBSRjc03+39jKkgT7BNK9lD7owV1ByIwVTiJfP8Fw4UUdpVhnbrlrINjofo61
         3McEu/VSkvUZJpOl5d1kU7PyR+ZfPADTQBbMlHy+zJ7ouyv0kdGEcaWQagOFT53wM10Y
         uSxH4Aq/cGNEuvgytV2KRdt4CKOMpWmf3SmhyzTnn3Y1J9WTyXTqGNdW5yZpMMCCHcTS
         XJS8DWAb/gCRls3DtdhygqJTt98VX3cLzhbXTT67LGJuljy/Zk9yIhuKrYYlgrC9epWB
         DMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LtQDpTBWNlm9F/etA2HBvgmoDYk50JyPS2902qGT/XE=;
        b=XTXCKvuAuIT3/VNhC1p+O/IZYVZtYj2F+pQ35gRZzGbMDYjIHrdkJj6wMkh5WNjLN5
         xf5Y41LtnVHTObVTd7IchdoWXJStQ7oW6GLWwTYw2q7lWLX0T1kZIorpHmnI3IrOGler
         E53LSpcY3uZxVmCCOHMinmtJaGgvfBDjIt58aeqtElvKpDJ6dtok2j7AmMjCPwcvQ8LO
         YgyoOBMjw6HK7R9LUsievBviezZ8FVA/WkE4vUAwrV/bXcRtXEKLWIDZ1nWgtIOoEn/d
         4cq9ron2TC3qRhDI5xdgRiy2U2jx/qijyTtQvS5/r8N1xOC1+UNsOElILzyjvtV6FXvy
         lQ/w==
X-Gm-Message-State: AOAM533EKPjmkZCgaxxun08eZxNvg7TqJ/s3z7gvaGql51CoMotNHD/f
        vPAnZCe8ZXCUiy7cCqQuJ4wIrsGDoLA+0g==
X-Google-Smtp-Source: ABdhPJwqyghl7MPe5PRupJv5yNKFUr6BWPo7uxTPHlS2ydeGmCQYWsCl1PrIH3ci9LrTGOitef8FhA==
X-Received: by 2002:a2e:b014:0:b0:23c:9593:f7 with SMTP id y20-20020a2eb014000000b0023c959300f7mr8455051ljk.209.1646680929745;
        Mon, 07 Mar 2022 11:22:09 -0800 (PST)
Received: from localhost.localdomain (adsa4.neoplus.adsl.tpnet.pl. [79.185.186.4])
        by smtp.gmail.com with ESMTPSA id v12-20020a056512096c00b004437e92a5e8sm2995671lft.105.2022.03.07.11.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 11:22:09 -0800 (PST)
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
Subject: [PATCH v2 1/4] dt-bindings: mailbox: Add compatible for the MSM8976
Date:   Mon,  7 Mar 2022 20:17:22 +0100
Message-Id: <20220307191726.10869-2-a39.skl@gmail.com>
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

Add the mailbox compatible for the MSM8976 SoC.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
index 01e9d9155c836..3b5ba7ecc19d9 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
@@ -21,6 +21,7 @@ properties:
       - qcom,msm8916-apcs-kpss-global
       - qcom,msm8939-apcs-kpss-global
       - qcom,msm8953-apcs-kpss-global
+      - qcom,msm8976-apcs-kpss-global
       - qcom,msm8994-apcs-kpss-global
       - qcom,msm8996-apcs-hmss-global
       - qcom,msm8998-apcs-hmss-global
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F4C4CE60F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 17:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbiCEQxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 11:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiCEQw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 11:52:59 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79F83B293;
        Sat,  5 Mar 2022 08:52:08 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id bn33so14885263ljb.6;
        Sat, 05 Mar 2022 08:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NXBOGtKjZor4kHEcBajqFKD9IhDLmUrCqHHqsKR7Fys=;
        b=e8rwtz/hGxIQp1PmGiVkN0ltUdkBTYTALVKDnvyFT2kaYtiK+3UmOIziFX9AJQyGaq
         6blu0zQWUmIiMEF3LWsMB9z4WMAFBXLJWpEqt+1ncUn3Z8QWb5KnPKYVCnEwGDvKABIM
         WjQdx7zBtaHVHw+pv5o1I/wI0IpNimPR//b1K2HBLe5xkmvxXJkHtdHQ/WqgLIGjSBZy
         JkboI+SD+Yw2GvuYlQ4iszeilSSgoxeGi6agC1cbfEUdAD6yde4qcWRSAJuRthtjJqSH
         wwPBomRreyiJgxbi7D0dcXDw8S33faLj2RWUWsHqU8rewwwX0of6qsxE4kWTvgYyzM12
         Fu3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NXBOGtKjZor4kHEcBajqFKD9IhDLmUrCqHHqsKR7Fys=;
        b=puLhUgyafz2/dDg7WUJNaOu4fRJYJqixUw7CT0LnFkpTJ+o3E55DErJASWrr07TG8H
         xGhQr3vKn2sbqsfVPE8MgL4xfIpueVM8mfoJ3/E9REbCpd4fC98xonLW94PD95bOy+V1
         HS5Vwb+tusdGTdZmO36SfrkWxeOopUvXiXRgVcdOzPCmbasBaWR8XDSPtdbVzAf1C+u+
         HYEm3Iox6DlApBpvW8JN6HkljvQk9WE3oo9vJIlHevcVeixmKiTFuXjfViktFFKsay7S
         HhhS3kukZeZo/ocSATgD0ZJLeAZ/knqH6c9QCCraK9P625j2tYrWNIubt4QeXkvQWiD5
         LGoA==
X-Gm-Message-State: AOAM531WlkYmtDDUH7q6eApkHNnuUBDTI/tMZt8uAlQv4nfwAozNttYm
        HrFIO8oZo2tsI5w9B6MLgtPh9ekQ23eP7t0p
X-Google-Smtp-Source: ABdhPJyz26EvjS0PPG6ca4lpusHqibY8dxF7cgY5AE3rPJKa6SsOpsUaKtIG550Bjopur4wBeUKX5w==
X-Received: by 2002:a05:651c:124d:b0:246:1a54:cc17 with SMTP id h13-20020a05651c124d00b002461a54cc17mr2460934ljh.301.1646499124443;
        Sat, 05 Mar 2022 08:52:04 -0800 (PST)
Received: from localhost.localdomain (adsa4.neoplus.adsl.tpnet.pl. [79.185.186.4])
        by smtp.gmail.com with ESMTPSA id n16-20020a0565120ad000b00443c3f383c5sm1751287lfu.231.2022.03.05.08.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 08:52:04 -0800 (PST)
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
Subject: [PATCH 1/4] dt-bindings: mailbox: Add compatible for the MSM8976
Date:   Sat,  5 Mar 2022 17:49:02 +0100
Message-Id: <20220305164906.16853-2-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220305164906.16853-1-a39.skl@gmail.com>
References: <20220305164906.16853-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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


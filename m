Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D9F56B077
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 04:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236950AbiGHCJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 22:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236804AbiGHCJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 22:09:49 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA5B2B619;
        Thu,  7 Jul 2022 19:09:47 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id x18-20020a17090a8a9200b001ef83b332f5so563370pjn.0;
        Thu, 07 Jul 2022 19:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o6qXHBRggPv7WVxROCph+0wgkDdSGgA4sRqXZcZDbr8=;
        b=NPeIP2pUu2aHBT+CLpSNLeqNdc5JldNLrRPAL4jkiLioBWxBIwNWfLxp1AKnyuW4mr
         OSJNeVHwM+uF0+c+iiePEi7rrzH6vRB2KjndUyK8BgUiXqQLY3lkDQNlXE8oE70haxyH
         yhBi0qCyrWzeE1dJVcBKMPcqhd2o72NC5ag3QR+YEtx31XBnyhVd0Q6Qtyc4cizgmjkq
         vd31p+dnk9tv5vXmq0OAFo8hSyavsz1BTC6cmmyUpOKQ54uB5xN8FDmoni6EwAbwsNvE
         1gy4dr6axmnXbG5Jzd/+TgMVIOf/kq3kl7VTHserPoNLFFPSAEQJQ8UCRtp6Zq2Fgs3i
         dyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o6qXHBRggPv7WVxROCph+0wgkDdSGgA4sRqXZcZDbr8=;
        b=w8RQKgFSi8AkhtkEXbG9itjjtB/snF00UwUiPeFaaBEOVdInoWI5YVtnbBZSJqIk/N
         1v2cGH8sTH8l/KjceqwhdnYviLKjD8vTKhkIJVBNYpz3PyQsPAxM7FZF2Ek0og93q6Jt
         nUUYHg1/uxWrkEcqwm5kBzhRrSjf8T4fIsDrGxstyt45g3SSizjwpsA0UENMVWTNQeZv
         BvSozWANPw+t66PshfZnEmnifDKbDmKmJ5vFVLkDiIUxQV7c5mEqztqNt4AG1cYkLydz
         EKSmLyVng4bhWQqg9u3VAnkirLViYLfZuhuIKsZ14wRQEHaqcjopI1ViCT52Bk17XhYr
         4f2A==
X-Gm-Message-State: AJIora9qM+DwdtjE/qvEmkZQLjGpnE5bG+Lh1cQDwdnceYWZ2IrqkaQA
        6uy4P7+y4w8Rbu3pOVFfD9A=
X-Google-Smtp-Source: AGRyM1s9ycy3rrW+XaoYrzIvl3zHURJKJZxnIgd1Sooyr/upEx5lrbNVXmbXq0raFijKmwKlkf0lcQ==
X-Received: by 2002:a17:903:18f:b0:16a:5c43:9a85 with SMTP id z15-20020a170903018f00b0016a5c439a85mr1052850plg.122.1657246187246;
        Thu, 07 Jul 2022 19:09:47 -0700 (PDT)
Received: from localhost.localdomain ([112.0.189.16])
        by smtp.gmail.com with ESMTPSA id jb14-20020a170903258e00b0016bf10203fbsm6832259plb.12.2022.07.07.19.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 19:09:46 -0700 (PDT)
From:   MollySophia <mollysophia379@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        MollySophia <mollysophia379@gmail.com>
Subject: [PATCH v4 2/2] dt-bindings: arm: qcom: Add Xiaomi Mi Mix2s bindings
Date:   Fri,  8 Jul 2022 10:09:30 +0800
Message-Id: <20220708020930.7183-2-mollysophia379@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220708020930.7183-1-mollysophia379@gmail.com>
References: <20220708020930.7183-1-mollysophia379@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for "xiaomi,polaris" device.

Signed-off-by: MollySophia <mollysophia379@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 129cdd246223..80dff09bdc83 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -235,6 +235,11 @@ properties:
               - xiaomi,lavender
           - const: qcom,sdm660
 
+      - items:
+          - enum:
+              - xiaomi,polaris
+          - const: qcom,sdm845
+
       - items:
           - enum:
               - qcom,sdx55-mtp
-- 
2.37.0


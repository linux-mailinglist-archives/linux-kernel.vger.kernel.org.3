Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D1656C97F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 15:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiGINUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 09:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiGINUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 09:20:06 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757E03719B;
        Sat,  9 Jul 2022 06:20:05 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o31-20020a17090a0a2200b001ef7bd037bbso1033197pjo.0;
        Sat, 09 Jul 2022 06:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o6qXHBRggPv7WVxROCph+0wgkDdSGgA4sRqXZcZDbr8=;
        b=n/r1AVuD30RF1iz6AXcR1BaoKdV2rraUMnl5BOxZmCBreenRtmVnnuupWpZ1io/N0k
         4apC8n5DfO8A9PQi3lyA1I9FR0HcZSQCVEEJrTJk/jufk5bTj4NC4blHdPdpAh+miNE1
         5J2dlQLLx/cdv1Ev/9TWQWmJFFHesMVOY88vsvDHE3oWAJo9nVuW8AZ64tREELOau+Hv
         qmjjqvLHXi4nSXQULBGuo5UxlG1BTl9WgUEOg3+6D+ER+qOcRg2dngvh2b63oc2xJMBA
         lj5SMCyoH/VGdiu5h2XI1hp0jyeMR8i8TbEkW5NgVvLozpSM8yxu+NNlbNwiu6mRYaSY
         GUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o6qXHBRggPv7WVxROCph+0wgkDdSGgA4sRqXZcZDbr8=;
        b=dSP6/83JSzmpOpdHQXnsBZ0Ym//M6GD4zjB24SJCx2M78QU36XEtWK+o2LbqhRzCRH
         DGW1iqjTkMmhTS4oozSzwpRBQVIj8ITBAvu6R6w9QigrRcWx0a5ltcUbR2NIifLugrCM
         jyy9lRYU/v0eWYOEbMgyLMeqv+DT06nU2dnOVCmADlxy7rP30aPHwKasaFDQB/GHOo+7
         Nydmcc0gogu7/2At37NScNCUg1M6rPCTI3OefOH7gDc0bUpKvG1qM3WaxFy22NgVBk4K
         TYQzswZjeH4SjgbA5JsboTF9dm37rb36K2ukif11toDkmRP0cOQM3aaFq2NrzVlEZSnO
         qYCg==
X-Gm-Message-State: AJIora/O2D3y7bGo7f4x2YChdsSELEnOJ9Tjs7i48w9RQ+BfvfGxdors
        8PLuiBIgwSQPnIgugT+1JmU=
X-Google-Smtp-Source: AGRyM1v+eEPdr+JOT2lzFx4XLVpLP3VQIMI/CEbnh4u9yr1Ef/HUoj94OhBaGhzsTqv1U6YIHtk66Q==
X-Received: by 2002:a17:902:7d96:b0:16c:2f71:7809 with SMTP id a22-20020a1709027d9600b0016c2f717809mr4072750plm.149.1657372804934;
        Sat, 09 Jul 2022 06:20:04 -0700 (PDT)
Received: from localhost.localdomain ([112.0.189.16])
        by smtp.gmail.com with ESMTPSA id y7-20020a17090abd0700b001ec71be4145sm1151950pjr.2.2022.07.09.06.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 06:20:04 -0700 (PDT)
From:   MollySophia <mollysophia379@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        MollySophia <mollysophia379@gmail.com>
Subject: [PATCH v5 2/2] dt-bindings: arm: qcom: Add Xiaomi Mi Mix2s bindings
Date:   Sat,  9 Jul 2022 21:19:35 +0800
Message-Id: <20220709131935.50708-2-mollysophia379@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220709131935.50708-1-mollysophia379@gmail.com>
References: <20220709131935.50708-1-mollysophia379@gmail.com>
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


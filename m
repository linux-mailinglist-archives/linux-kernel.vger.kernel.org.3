Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5E74EAFEE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 17:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238290AbiC2PJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 11:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238274AbiC2PJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:09:43 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8491EE8D0;
        Tue, 29 Mar 2022 08:07:58 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r23so21092102edb.0;
        Tue, 29 Mar 2022 08:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CF0NDgYO3DvdL695eIgW2VcxkY0LtkB+XOQl4F9243I=;
        b=dORRr4G7IfaVjl+p1pp4IwpqhiZjWXRGTSpkFcVbJbbtQosrg633vKlWmWONC0ut5x
         0S1HDLhdh2e8RRu8T1X/QAk+roWpr/x4e8RZM/yt+bndeA6CvVyvNj+F238yQ6PxT2q4
         3khdsUz66QGUxXoQ40rT85fPWXSa5SetiFxCeisaCOKOSU8UTXCvNoDaGsVSF15JUCgH
         szdMgO87BZw/N09L/bpXJAj2fX/2IBjwUSX+QJJEIsF8/b0sy3md92gOOvgdCczYKxgg
         0l8Z8S8ggKsAViPm2BM3ElsoYlLmVOhRZiEwF/monCbL5wey+MukJz66MOn7KP7cua4G
         c9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CF0NDgYO3DvdL695eIgW2VcxkY0LtkB+XOQl4F9243I=;
        b=YSSrESNGMX/CGcYNsWyY+5xl7cNlRtEH7KcW0qdv4FuRs911t8Mec+vZfIlw86hLRP
         +D1XGuS49qcdq6JKQtcVOzlKceZqSdrjAY9NydYQ+iYktcu27U6dV41lR6vad4pjeSUP
         mhIwohBX8jbD99BbxHpx/h4XiI/mMtrSEhWADumVSiM/54hvf58wbNgeBCzK2+wYISTj
         GAT9JnMux9qLlAVULLRQUgcp2tUVykDTnjjxL4XoOhAUa3MC+n1vdiylsXwa+gcgYIta
         qTwxsFwHvbiqkDn3OKuolBcAFlSGBREuqZSwRKQhaKe56fWHtCDQboZS4BrLzkRdQbBe
         +dBw==
X-Gm-Message-State: AOAM533i8vt9dLRksGgynqL1Xdxz3nXYaKjJBxjte8I1GM1OtR+HIuMe
        HorEl9R47+SygGTkugBz6EY=
X-Google-Smtp-Source: ABdhPJxx5yBsg7xs/iYz7SucgyLj3wZ9zkiHLkulas8E2+Vc8i2RUEi84UAQP/INSizSxGMiR5DIUQ==
X-Received: by 2002:a05:6402:3d3:b0:419:4781:aac7 with SMTP id t19-20020a05640203d300b004194781aac7mr5130859edw.347.1648566473183;
        Tue, 29 Mar 2022 08:07:53 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id eq7-20020a056402298700b00419d8d46a8asm3261643edb.39.2022.03.29.08.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 08:07:52 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de, zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] dt-bindings: clock: use generic node name for pmucru example in rockchip,rk3399-cru.yaml
Date:   Tue, 29 Mar 2022 17:07:39 +0200
Message-Id: <20220329150742.22093-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220329150742.22093-1-jbx6244@gmail.com>
References: <20220329150742.22093-1-jbx6244@gmail.com>
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

The node names should be generic, so fix this for the pmucru node example
in the rockchip,rk3399-cru.yaml file and rename it to "clock-controller".

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../devicetree/bindings/clock/rockchip,rk3399-cru.yaml          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
index 3cc8398fd..18a009311 100644
--- a/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
@@ -77,7 +77,7 @@ additionalProperties: false
 
 examples:
   - |
-    pmucru: pmu-clock-controller@ff750000 {
+    pmucru: clock-controller@ff750000 {
       compatible = "rockchip,rk3399-pmucru";
       reg = <0xff750000 0x1000>;
       #clock-cells = <1>;
-- 
2.20.1


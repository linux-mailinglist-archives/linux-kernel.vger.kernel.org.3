Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF46B50E6B2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243789AbiDYRRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243756AbiDYRQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:16:56 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEC018364;
        Mon, 25 Apr 2022 10:13:50 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 1so1323931qvs.8;
        Mon, 25 Apr 2022 10:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s77Njj2Eom5x0HLbfJedPsYIdxNJX9SrLtCBw7r9BJI=;
        b=cWfu5B9KVG4HPZaLMMC3NeI9CrkUh8GOBVoOfmN6qUo+H5kY6oaJJD+9OCftTd+EmI
         x0V2FXej7qvvueaC/U0U7v+3OHbefL2JaM8+oFas//pE4IfJjj8MLZBFmt0+8DYfDbVh
         CJkMynhhbGoSJ1hS0zEyL9nr8NbaO1GnuPNFw/3IDcxpQidP26M00WTM64y3UaERiMvz
         vKOfS4fyuxGSMOwU6b8CyGwjvSQPNf4/RAh0m207E5eSrrIAcpF/bqQvPCjl+nzwlaSo
         Gzkhwz2QTnyED/MyzksxVD56lCDnVfC8LxEsdGooRX8V7J1U40HyY0MyEHAeedoXk+ss
         JN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s77Njj2Eom5x0HLbfJedPsYIdxNJX9SrLtCBw7r9BJI=;
        b=SZ9S4N/rKigXNY+7y+FCKNu7qPUCUCdBqspcThjRNIIZGX7QQDXDNiB3E1Bs9Fdj1Q
         qUMGRrAJ9BIcScqq1+JhK2EmaJGgjcmpkm68YE0BRbe+tpyZzRLSmsr5oHZwpIdadwSD
         o/SpSRpmhLcmmpqDF5cHaoQ6iMKGM/3E5Wbo4haxdQpGEU3gFPDlnHKhoUOl0DfsIXVV
         pdEb0fIG2qjHcTstx1vRqng9q2GuIgkfTLB8g5S2Yp3JQvvnRmINY+gvolZCMmJk/oKr
         qHwJWArYrEC0giV/6zqjLEE9VMloQZEAOGXH66IwQT7dHtlJ1RHekguKJR2gxXBmRYxm
         nNRQ==
X-Gm-Message-State: AOAM5331TzH2uirsydk0Wxs3qDWRSon3bPXuqRTLIdjtqJtYF0JkOtBg
        pIlzMgQCrI1+O4irI1vs/4c=
X-Google-Smtp-Source: ABdhPJyro5vTEBEMuwz58jmXSQvQ7tsKDOfZB5SwaI6jAUxxh0kmIsH4yE9T9NaRpmY5OGThtkH+TA==
X-Received: by 2002:a05:6214:20ab:b0:446:26a7:ef2f with SMTP id 11-20020a05621420ab00b0044626a7ef2fmr13622003qvd.37.1650906829286;
        Mon, 25 Apr 2022 10:13:49 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id v3-20020a05622a014300b002e1dcd4cfa9sm7154928qtw.64.2022.04.25.10.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 10:13:49 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/7] dt-bindings: arm: rockchip: Add Firefly Station M2
Date:   Mon, 25 Apr 2022 13:13:40 -0400
Message-Id: <20220425171344.1924057-4-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220425171344.1924057-1-pgwipeout@gmail.com>
References: <20220425171344.1924057-1-pgwipeout@gmail.com>
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

The Station M2 is a compact single board computer based on the rk3566
SoC. It outputs on uart2 for debug and console purposes.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index ad940e4127d9..b6254baffa67 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -133,6 +133,11 @@ properties:
               - firefly,roc-rk3399-pc-plus
           - const: rockchip,rk3399
 
+      - description: Firefly Station M2
+        items:
+          - const: firefly,rk3566-roc-pc
+          - const: rockchip,rk3566
+
       - description: FriendlyElec NanoPi R2S
         items:
           - const: friendlyarm,nanopi-r2s
-- 
2.25.1


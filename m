Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9E851A3F4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352433AbiEDP2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352075AbiEDP2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:28:23 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCBB44A08;
        Wed,  4 May 2022 08:24:47 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id u3so2521277wrg.3;
        Wed, 04 May 2022 08:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kc5mcOct0oUOKk+U4jtRUliz/FH5+TKvkz3rnonQevw=;
        b=M5OerQS/g1OAy8dhJWns5hn2/kBwqRnvELSPqnDascuvrHXdsCYPC+eeAXr9wMUWZ1
         BaOPdI09tKFF1m1/6NL12WRJPI1TXKB4BPCNaGlp/UQOY2R2mjvYyZ6yzFjThDU925HG
         DiMC1xzdgbs78MN4UJ+ym3PjMFXlf9Ml2rN/ucBqz+Gg5gvaszYv10KpceI3DarE7kCl
         R6NGYxMzhv/zpVymVBqOhpGacmAqvGOAig0WUZq8xk0IzCL7b3m2NXXN9msijGgwLtC2
         QLzEuQdphbqc4Y2fLO9b8cPdrsGWeb3rZQtQ0mIjuMIBIge56WHkas29sdr2wAp8Njga
         I0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kc5mcOct0oUOKk+U4jtRUliz/FH5+TKvkz3rnonQevw=;
        b=ccAr/6Abm5HIN6jLt0FmoU72TR/353arjmVr6t1VTjrphFF0K2yNntkNP0dTl1Fu33
         n1kkeQj5GOWBnrFsmvN+rkPSleFVe/+krz33svYwHmPuBGlLd+pqA7ZMLVovem3gWsne
         K7HVJjdF9rRzRoJiOPHUsVSKfdMBOiUME5kFDbfcq7wHNUB1Xul+jvTW4SHLze5IM2JV
         bGsRKWdSi6BOpeoqVymfdF8K2gxSexCTxkB6JuTR9r1gcy5Y30s9Xawr9H40spP4IhDU
         yJNOc7I1oXYaL0fO9DWIUYTsDkoy3kZRd5F35lZzUiTjwcfFimun8pvBF/r6JhZDvjC7
         S7iQ==
X-Gm-Message-State: AOAM530ZAUoZWxjNfUuCgOAKAWHPstGBDtPSz6+W7UcWYOC69GD/qq/L
        YzMhM3j4KPljq0CK9X0MKA/yOoKgpTE=
X-Google-Smtp-Source: ABdhPJy5xEHkSlk48t7udQi38eCM+wUHzZKt73nfAymRjVCJgVFj7xoAfLUxKNwnLQyLNZPWAdk+GA==
X-Received: by 2002:adf:f4d2:0:b0:20c:59b9:37bd with SMTP id h18-20020adff4d2000000b0020c59b937bdmr14286679wrp.677.1651677886125;
        Wed, 04 May 2022 08:24:46 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id s14-20020adfa28e000000b0020c5253d91csm11541041wra.104.2022.05.04.08.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 08:24:45 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Lin Meng-Bo <linmengbo0689@protonmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: input/touchscreen: Add compatible for IST3038B
Date:   Wed,  4 May 2022 18:24:04 +0300
Message-Id: <20220504152406.8730-3-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220504152406.8730-1-markuss.broks@gmail.com>
References: <20220504152406.8730-1-markuss.broks@gmail.com>
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

Imagis IST3038B is a variant (firmware?) of Imagis IST3038 IC,
add the compatible for it to the IST3038C bindings.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 .../devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml   | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
index e3a2b871e50c..a283040cd2aa 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
@@ -18,6 +18,7 @@ properties:
 
   compatible:
     enum:
+      - imagis,ist3038b
       - imagis,ist3038c
 
   reg:
-- 
2.35.1


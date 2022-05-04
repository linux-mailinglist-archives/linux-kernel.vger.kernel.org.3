Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245A251AC5B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376489AbiEDSKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377025AbiEDSJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:09:19 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9798274860;
        Wed,  4 May 2022 10:25:12 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id n8so2028855plh.1;
        Wed, 04 May 2022 10:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=94a9pX/GV/eEl+QtDLHnwc8lloWm9uKODw2DiIxPFzg=;
        b=hMPZh8mGU2zFa2VGOGkN5717mRU5gahpNVPrU0T0mjj9ZFEBhCtxltxSAJW/xOoGxi
         nntHAqGXVTwhbqVV9VFbrGos70fFk2waKaiBz7hqE4JYtiPiTnS9S4TlYavhfdk6sRJV
         wCDhpgFuirek7zmZDSBvyBy1W1xbadu4YlxzGLha0Z4Jhr2R45sUJOYDy5iOzMONRlQg
         xFLu2D0Cvm63VQsJnFafDjrc+0CwL3+M1jAMfJxj7e2nc9rEqzp+McZSBM2EpX/+B+jQ
         +FG0Pbhc0DWHx/K/WKARoZKZWG6kinRg34w0iPfyRr0YekXngBsyRyLAGAZ0Yiyuuh0S
         3vUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=94a9pX/GV/eEl+QtDLHnwc8lloWm9uKODw2DiIxPFzg=;
        b=ITkORjr7VAvt8EUZQ/+TwkETNBxjdmWauCj1eGG2bmXTeAKABI+LKeQAIIzZXzGLIC
         tEoXMKbz2ZmelZQXIZB1c8V1Y4WUjEIKT3z02JWyyiOBga5pu101KY6txhXhEUClXZ0o
         YGFJzvS2L2LnXLiqnS4GqVAxCYFOOiKUb0exwif0N8MXw2hh431NUpoTId/xNxXKRave
         clhJF1+76GTyXMGOQpcy1fJoKm55mO6FsJLt3qTsNyUlDiTBtvnrUe+fQcp8namrNWyn
         xleKD/1ofS5GNsezS5sK7Jid80cdcS9971ZEZIisBpqQnamhbNXJnNKXcUzQGQnN9Xxf
         GVkg==
X-Gm-Message-State: AOAM53371Kj0Qe5TU3kKLYv0Qtu64UFzKGfrEEGFRtzXMbS205VTGKlB
        JR8WdG/zqw/tq3BceabqONY=
X-Google-Smtp-Source: ABdhPJz5Wr0yzyr0iUGy8R03R4GV1la4/GHvqE06XPHjNppfYxsf1zwfEtO4ZGPxmT1SDM+Or4PKhw==
X-Received: by 2002:a17:902:c403:b0:15e:8d3a:b018 with SMTP id k3-20020a170902c40300b0015e8d3ab018mr22776104plk.94.1651685112072;
        Wed, 04 May 2022 10:25:12 -0700 (PDT)
Received: from stbirv-lnx-2.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s21-20020aa78295000000b0050dc76281b7sm8772104pfm.145.2022.05.04.10.25.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 May 2022 10:25:11 -0700 (PDT)
From:   Justin Chen <justinpopo6@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, f.fainelli@gmail.com,
        Justin Chen <justinpopo6@gmail.com>
Subject: [PATCH 2/2] dt-bindings: gpio: pca95xx: add entry for pca6408
Date:   Wed,  4 May 2022 10:25:00 -0700
Message-Id: <1651685100-44687-3-git-send-email-justinpopo6@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1651685100-44687-1-git-send-email-justinpopo6@gmail.com>
References: <1651685100-44687-1-git-send-email-justinpopo6@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NXP PCA5608 is the 8-bit version of PCA5616.

Signed-off-by: Justin Chen <justinpopo6@gmail.com>
---
 Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml b/Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml
index dc0fc8f..977b14d 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml
+++ b/Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml
@@ -30,6 +30,7 @@ properties:
       - maxim,max7325
       - maxim,max7326
       - maxim,max7327
+      - nxp,pca6408
       - nxp,pca6416
       - nxp,pca9505
       - nxp,pca9506
-- 
2.7.4


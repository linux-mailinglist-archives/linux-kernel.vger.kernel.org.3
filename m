Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2CB51B1F0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 00:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378973AbiEDWeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 18:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379000AbiEDWeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:34:05 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1CE25C44;
        Wed,  4 May 2022 15:30:27 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id cq17-20020a17090af99100b001dc0386cd8fso2457794pjb.5;
        Wed, 04 May 2022 15:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=94a9pX/GV/eEl+QtDLHnwc8lloWm9uKODw2DiIxPFzg=;
        b=GV0I9cg8N6KOAkYcoZKr2Gy5fEOZp2sOAgVEexp+9Jf715ipyYq30icc9NgQDWDrlG
         meR7Y3IzOE2HxeiifnOKvm56q35EILWsUW4yNvt3hTg80m08NT4z3/nsEeVAtbTGGFuI
         b1DJTRQht4wxbmiuZwTVI2cjqMn+0CUTXlF+jU8ikKKyoGtZOSGoNjCaKxNJC+Qyd9Yj
         goesqFL/kjlLghbT676ldhQkddlo5btqmnDZIpqb0u3Yn8ycTZAI6kSstgQEVJXHG7Zs
         epDj6PdIqhUFJ8kI+ERkGKvbg9cGLBzNkXaARnPh5CYbd86BpgkNROciT8wxFP6J6XJ1
         xpKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=94a9pX/GV/eEl+QtDLHnwc8lloWm9uKODw2DiIxPFzg=;
        b=nJOBmIQaWPkE3+/sfdKu43DESxyga95M+jhPH1vi2hR7I6lQzqXke2GACWebAYK4QK
         HEjOCJXLa/RNr/BJLKhAeKuFpVa4ejKGoc5gl/Nj9N1w6+/TLcROM3vy7cqkdJeeXkmi
         XuK9yda8zw9kVUgKFyTCEfdeb6NnOldBE9q72fQF7MyXPlK+BtGtHX4gO2VimoN9rJzc
         IDDi39uFTzemekWnYHlkQGe+0Xmb5uCXWKB8sAoeUv0tL/aWEQz9W5ixoSJHkAC6xK3X
         wPlQi+KmvWTtinIBzaolxUP41BoOog+V8Mz0cOWGuOoc7MaA2JdY8U5XOdqQ4EO7N6Kk
         K/DQ==
X-Gm-Message-State: AOAM531GKe5F6G6T91ftA1M4MupWR9bodrsB+YiZgUDvITVAHDBiPDJ2
        FFJDJEHO9hGuH+3tSXIpaI8=
X-Google-Smtp-Source: ABdhPJyAOefCc6L+2qUMnOCdFHcUwXWTa0u7mL4Sqe6/qy44e0e8MDs0PsXzTErnF79Kpa1zlv9PsQ==
X-Received: by 2002:a17:90b:1d87:b0:1dc:a9c0:3d49 with SMTP id pf7-20020a17090b1d8700b001dca9c03d49mr2176020pjb.12.1651703427150;
        Wed, 04 May 2022 15:30:27 -0700 (PDT)
Received: from stbirv-lnx-2.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p4-20020a1709028a8400b0015e8d4eb257sm8882284plo.161.2022.05.04.15.30.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 May 2022 15:30:26 -0700 (PDT)
From:   Justin Chen <justinpopo6@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, f.fainelli@gmail.com,
        justinpopo6@gmail.com
Subject: [PATCH v2 2/2] dt-bindings: gpio: pca95xx: add entry for pca6408
Date:   Wed,  4 May 2022 15:29:17 -0700
Message-Id: <1651703357-25154-3-git-send-email-justinpopo6@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1651703357-25154-1-git-send-email-justinpopo6@gmail.com>
References: <1651703357-25154-1-git-send-email-justinpopo6@gmail.com>
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


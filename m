Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF434F6ED1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 01:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238151AbiDFXkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 19:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237885AbiDFXjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 19:39:19 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D303B1FF232
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 16:37:15 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id j17so2438660pfi.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 16:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vwEJdK6mP4HLwzlF0NPpDB80vAiIJPOce5ra0JhLa38=;
        b=GlwNdB8zBVCXaFx26HpKx7WELFJMmt4kNuhMN8vvHeN5vX0zCQdLS3NJDz8Fn5CnHW
         3xeqY1ZBMDisFyF4etaO1RPGXFVSlD8jEj2q1YJ3qTyZ1S2gizpIv5zBXI+afVoYmVUP
         Ko4jbM0TFMXDMw8zydt1oduC4mvUu9q7FExp1ZVzvm4wdcFWJJ0LV46x0JzoFEJ1zcgW
         MV8/FqqM20hcX0EwicLISB+WCDT8k4wl6u8qEPs+7VZEAhCyVqBEy58v2s+igTNztzXd
         z7Da+eVH7UfNXRSFD574IS0YzwbxtFXX3YBUIDv/vN5fRZSmMxrvWla9q2U5jvwa90yi
         RyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vwEJdK6mP4HLwzlF0NPpDB80vAiIJPOce5ra0JhLa38=;
        b=ddKTqp7CMkL+0nGOzPJV9QfWu8eHhYFg1Z3G491xhaLZh1yn37cpwwrQ+/WcbONLLu
         rj8Txx3yjjUE0i+W02ZUZP2BcUErFc2HXW+x+0ATuLWjUshQrviAWeVvvhisRcutSl4N
         G/7lWLmg7sswv2Faq8OlRMsw3T7AiHD+VtD5QsKhscETG0Dfs79qYGhVaxKVzgFQgWCR
         yDhzVXPxt9b5OoBYt/IYzp37kuzlvRv2JiUYCqiG7KMhCZkOEVVLBn2YIIuWjTPuIiTn
         WK7Q1uft0WU6s8Ri5aoQkVFotxZ9fCiBDElUJPErK2j/pO2s9K/pTONAGK1XKaEVZgJA
         MCDw==
X-Gm-Message-State: AOAM533HasXsmW9HLIMmaZf8g6Jg2CKdSz8fn6gCWy+WL0qz1S5Lunk2
        0SQxlYtDT2K3M4tWnKtoKCNCdQXQm9HIpA==
X-Google-Smtp-Source: ABdhPJyxcbTU9ZBcO9y89jqsqr4/jfNurjGIi6t4DNl6SvL7WcLDdfJNS9GAdP8Mq6nLARE8qXq19A==
X-Received: by 2002:a65:57cc:0:b0:384:3370:e161 with SMTP id q12-20020a6557cc000000b003843370e161mr8998868pgr.364.1649288235387;
        Wed, 06 Apr 2022 16:37:15 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090a7f9500b001c97c6bcaf4sm6903667pjl.39.2022.04.06.16.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 16:37:14 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        brad@pensando.io, dac2@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] MAINTAINERS: Add entry for PENSANDO
Date:   Wed,  6 Apr 2022 16:36:43 -0700
Message-Id: <20220406233648.21644-7-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220406233648.21644-1-brad@pensando.io>
References: <20220406233648.21644-1-brad@pensando.io>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entry for PENSANDO maintainer and files

Signed-off-by: Brad Larson <brad@pensando.io>
---
Change from V3:
- Change Maintained to Supported

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4cb7fd127e68..456d50921b3a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2509,6 +2509,13 @@ S:	Maintained
 W:	http://hackndev.com
 F:	arch/arm/mach-pxa/palmz72.*
 
+ARM/PENSANDO ARM64 ARCHITECTURE
+M:	Brad Larson <brad@pensando.io>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+F:	Documentation/devicetree/bindings/*/pensando*
+F:	arch/arm64/boot/dts/pensando/
+
 ARM/PLEB SUPPORT
 M:	Peter Chubb <pleb@gelato.unsw.edu.au>
 S:	Maintained
-- 
2.17.1


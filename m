Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C84554503D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343490AbiFIPJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344174AbiFIPJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:09:42 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D52E13C085;
        Thu,  9 Jun 2022 08:09:41 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id s12so40882517ejx.3;
        Thu, 09 Jun 2022 08:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3J+2F6ZfBSIgfwGocYbqrYrqA9Z3MmOOsaSL5QbKYPk=;
        b=oHvlg8FIU2fxSCOr9OIzVCODy6vlSOWWRzrc2QfW23DxE4C7MSyLkCBNG33VPhxJUF
         76GroJoSydus5WseMvp6GnJrA6SZcuWZ/edlYZWw/vt7B1qCKfsr17WrQRncrBWH2hUd
         I3csQ7qaUP1NBsyKcYy8LYbH6KGmJn1wGwYLbhLr34gCIA1oqfDWq7fHMimYReAIL5Hx
         o45tFSeB2eMJfjTFyVVOoTcSKwbJFAvdHwLBRneb9oB1ZDIjxHumnvlU9KVgXEApSO0Y
         io66tBQasdT+GvzKnAPkv1GLJt+548AMs6cUxwfmYk6SyVGg2GY85u12KKCJRcp7kN7P
         XjZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3J+2F6ZfBSIgfwGocYbqrYrqA9Z3MmOOsaSL5QbKYPk=;
        b=nOVG623CxZMgvAVMsjJk0wYM3GwRW2yLsKWNVuxQ3JcY2WsZzhP1oyOlZz2tgCUY47
         MhefjrUbbnplKA3s1cyyY6Zi+TsgyZnE0q7LHnPQS/f/yyyXQu+qkgM+4Xb2IErWNkuU
         2wRuaEjA2XXpovcyvWSRAp2sO1BCBd6InNS3dcNox7njIa6DOyNvZtwSj6QVrNuG50kQ
         4F638fq3tQjObKwEGdce4ZypR6RoUySTp1daMRsWwlk4QYoXCPQgDKxS9m/9oH3VG84I
         PxW2/grrg7lmeedZhml8q4B0aZvhxH7OwwHaj686LS6kYoNyUzsWM6j/PXw2pUb2IJEb
         IpgQ==
X-Gm-Message-State: AOAM531L189tK72f+ke++F5egd+Jfg7+w3fBxbs8k65+rDEd/YkP+OrD
        h93gTVgVLlb5uJWXVLXYjeI=
X-Google-Smtp-Source: ABdhPJyV33S+916JlIVVB26zHawx/4cYmmdejG3N3q3TAcMtQtkyyVsrBhHphDAyuihnpWVY+wRD6Q==
X-Received: by 2002:a17:907:608b:b0:711:f36c:847f with SMTP id ht11-20020a170907608b00b00711f36c847fmr8735239ejc.558.1654787380780;
        Thu, 09 Jun 2022 08:09:40 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id n24-20020aa7c698000000b0042bb229e81esm14395135edq.15.2022.06.09.08.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 08:09:39 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/5] MAINTAINERS: add REGULATOR POWER DOMAIN
Date:   Thu,  9 Jun 2022 17:08:49 +0200
Message-Id: <20220609150851.23084-4-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220609150851.23084-1-max.oss.09@gmail.com>
References: <20220609150851.23084-1-max.oss.09@gmail.com>
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

From: Max Krummenacher <max.krummenacher@toradex.com>

Create a maintainer entry for the newly added regulator power domain
controller driver.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a6d3bd9d2a8d..cb0cf81034c2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16922,6 +16922,15 @@ F:	Documentation/devicetree/bindings/regmap/
 F:	drivers/base/regmap/
 F:	include/linux/regmap.h
 
+REGULATOR POWER DOMAIN
+M:	Max Krummenacher <max.krummenacher@toradex.com>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/power/regulator-power-domain.yaml
+F:	drivers/power/domain/Kconfig
+F:	drivers/power/domain/Makefile
+F:	drivers/power/domain/regulator-pdc.c
+
 REISERFS FILE SYSTEM
 L:	reiserfs-devel@vger.kernel.org
 S:	Supported
-- 
2.20.1


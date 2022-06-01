Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998C8539EA2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 09:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350362AbiFAHmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 03:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346125AbiFAHme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 03:42:34 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AFD23BF3;
        Wed,  1 Jun 2022 00:42:31 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so556770wms.3;
        Wed, 01 Jun 2022 00:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=grT2FadLkZhaPhNWlxLPz+bbGoKf4X6gH2fwHZzC5Ic=;
        b=NWF07lD0qvP5uxnFwih1JU76Y1m7R4fAY3/kx+7nYtTziG+sPDXwZmmHMbqh7ehIDc
         lk0vGkxu3P94kCWWYPm/6atvt95KupXtMNDeUk1UcPR0BJKuxpt7GSGTRR7+gxFIJwvj
         +QxmwxOmO0NkpRTsLhXvW4W/lE0jJfCtwPmHqK7jweJSUIKWtVD9eeArGUZcjnYVmqz3
         6DjwKVlfH6qEaGC0MqpFDZ7AJ/05m9E1ICVO09s1N8Mr6OQ/29VIXc2r45KMvhEpO5H1
         jdhlT+rWmv3ZkITNvCd3BYE8sFe1p9ryI7mPUMJfnfx/ULi9msTzAXAmzBU5zKYPnsdo
         L+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=grT2FadLkZhaPhNWlxLPz+bbGoKf4X6gH2fwHZzC5Ic=;
        b=hfn+FmKst13yHob5wWlPGyaHiM8EusVpU5KUzF890vUWoWgXR1ShrM6ct9N9j0ah/P
         eai/nXe/mBUSDOblhYkKui8soRilQFn/o9goahaDvSuwZHq7cD61iOAMIi8xf4t3uEGs
         vKOdDTOhn9Tq68D1c3lCs0+/hThYOLmIC6u13vvhv7LfTDRZabMam8uE66gEMZQa1GP0
         61n9e2H/QGDAVgvghCOPeDUDP24MY2YNbuVfiuiY4Vsi2AFDh1X/o2CDaHAu+FTwP6I9
         slR/r4skMw2cpIZ+i06cFE7x6OQp9r8QyzS/JbMAph3+LwxghuiSDrqBPxrH+SU6rHNw
         nYDQ==
X-Gm-Message-State: AOAM531r/58l/o2KHwnbxGhTvW8jVZlt/gZwR/ItJv1EfJf3cebxyOw4
        64xJT0XyQaISaSRGiHBpCa8=
X-Google-Smtp-Source: ABdhPJxWSI5Hu27RaAgeQen5YZHQV4HIoaXVBAtRm51mH+bCPZ8WwU4rFyGDajF7hlBNz+EtHDOHCw==
X-Received: by 2002:a05:600c:4fce:b0:397:84e3:2297 with SMTP id o14-20020a05600c4fce00b0039784e32297mr25276014wmq.197.1654069349847;
        Wed, 01 Jun 2022 00:42:29 -0700 (PDT)
Received: from felia.fritz.box (200116b82620c00028af88788fa7d286.dip.versatel-1u1.de. [2001:16b8:2620:c000:28af:8878:8fa7:d286])
        by smtp.gmail.com with ESMTPSA id v19-20020a1cf713000000b0039c18d3fe27sm1034656wmh.19.2022.06.01.00.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 00:42:29 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-i3c@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: rectify entries for some i3c drivers after dt conversion
Date:   Wed,  1 Jun 2022 09:42:12 +0200
Message-Id: <20220601074212.19984-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
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

Commit 4bd69ecfa672 ("dt-bindings: i3c: Convert cdns,i3c-master to DT
schema") and commit 6742ca620bd9 ("dt-bindings: i3c: Convert
snps,dw-i3c-master to DT schema") convert some i3c dt-bindings to yaml,
but miss to adjust its reference in MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about
broken references.

Repair these file references in I3C DRIVER FOR CADENCE I3C MASTER IP and
I3C DRIVER FOR SYNOPSYS DESIGNWARE.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Alexandre, please pick this minor non-urgent clean-up patch. Thanks.

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 01e276fa6476..d5ea4ef223f8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9354,13 +9354,13 @@ F:	drivers/i2c/i2c-stub.c
 I3C DRIVER FOR CADENCE I3C MASTER IP
 M:	Przemysław Gaj <pgaj@cadence.com>
 S:	Maintained
-F:	Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt
+F:	Documentation/devicetree/bindings/i3c/cdns,i3c-master.yaml
 F:	drivers/i3c/master/i3c-master-cdns.c
 
 I3C DRIVER FOR SYNOPSYS DESIGNWARE
 M:	Vitor Soares <vitor.soares@synopsys.com>
 S:	Maintained
-F:	Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
+F:	Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
 F:	drivers/i3c/master/dw*
 
 I3C SUBSYSTEM
-- 
2.17.1


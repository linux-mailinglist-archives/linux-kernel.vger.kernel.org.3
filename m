Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08F5589F3D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 18:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbiHDQSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 12:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbiHDQSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 12:18:36 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9AE33E2A;
        Thu,  4 Aug 2022 09:18:35 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id i14so191065ejg.6;
        Thu, 04 Aug 2022 09:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=JNzjD6Vp5LwUhvOokMc6+3eMyLZefF/Ri/vBtG0eveI=;
        b=DHQYcgrqa2GwDeeyJeB33wUMV4b/yPgzPGYqUXFZn78l08PGfjX6q6vbCpMF0WS9Xk
         y3GuUCqRokBLS0lnk7jotp3LMz1xUh3NF35gLYue+YoXCU6PDKFlkIcp+j7Ky4vp6vHM
         fYApl8xYX9GHI9M46KU2igt9/GmxkvuGUyo8sttmweMTD9W4QZojLdyScpwIieUFiRlJ
         xRCMNuxcMlEacddEAfn2mPQqq5V9WXyAl0zwvkLDBRezNV0tScv1VuyCgXyQKSRvruzo
         1O5NqzJDhDVEopkMYPY65RyOkRSxrVblc6wC/th7r8DXqxVKx2+yW6WigDCv9F14ikbh
         g0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JNzjD6Vp5LwUhvOokMc6+3eMyLZefF/Ri/vBtG0eveI=;
        b=sOdkzOGaN+/G3y3a7/YfWFqQOIPLmg+cHF0OzSheXs2CXJGDmyxv4au28pCGY+Nj9+
         PzsGtXVwEjVPWlEiJDFyNGazTnL8ChdEc71iEM0RkchPA0WjklIvgTZ3xYWuXO79HprH
         TID7Va2+bJpASMwCP4HOdv50vBfoAfjQZXOLHFUWpsxMjjkoG2GNbyp8PONPCgWOdUUi
         BSNJXWK4bcrySOADfq8IZ4ZkPk/dWubekflonOBY0LDbyuEgZD5p66cUGrZdoSn5RoKs
         bwMa94aPGKho+NLY4nCX2YENgigDGdnTgALO+0Nuy0zL/u6SfjZIMI54SpD8oL+xIDL9
         bZ7A==
X-Gm-Message-State: ACgBeo3wAMldQ8EeDBbuD/O6yk/OZ5gEbA0aJNy5WzUnbaX/0MI3Tg5t
        LNKZf2eGR/P3Kjvk9rci32c=
X-Google-Smtp-Source: AA6agR5ZOB8sjiTqaPDAVWzLh5ayOqoz3XnVWJIqWejRe2w8NJ0c2y7Z/5YN8Aqk/ihviXIjdVDbVQ==
X-Received: by 2002:a17:906:6a0f:b0:730:df34:6ec4 with SMTP id qw15-20020a1709066a0f00b00730df346ec4mr753635ejc.659.1659629913878;
        Thu, 04 Aug 2022 09:18:33 -0700 (PDT)
Received: from felia.fritz.box (200116b826aef000cd273e5ddbcf3899.dip.versatel-1u1.de. [2001:16b8:26ae:f000:cd27:3e5d:dbcf:3899])
        by smtp.gmail.com with ESMTPSA id v18-20020a170906293200b0072b51fb36f7sm471371ejd.196.2022.08.04.09.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 09:18:33 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jean-Marie Verdun <verdun@hpe.com>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: rectify entry for ARM/HPE GXP ARCHITECTURE
Date:   Thu,  4 Aug 2022 18:18:23 +0200
Message-Id: <20220804161823.20912-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8cc35b86546d ("spi: dt-bindings: add documentation for
hpe,gxp-spifi") adds the spi dt-binding file hpe,gxp-spifi.yaml and commit
a1848b0fa251 ("MAINTAINERS: add spi support to GXP") adds a file entry
hpe,gxp-spi.yaml in ARM/HPE GXP ARCHITECTURE. Note the different file name.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Repair this file reference in ARM/HPE GXP ARCHITECTURE.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cf7906eaa5ca..a0873a2d7d3d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2177,7 +2177,7 @@ M:	Jean-Marie Verdun <verdun@hpe.com>
 M:	Nick Hawkins <nick.hawkins@hpe.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/hpe,gxp.yaml
-F:	Documentation/devicetree/bindings/spi/hpe,gxp-spi.yaml
+F:	Documentation/devicetree/bindings/spi/hpe,gxp-spifi.yaml
 F:	Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
 F:	arch/arm/boot/dts/hpe-bmc*
 F:	arch/arm/boot/dts/hpe-gxp*
-- 
2.17.1


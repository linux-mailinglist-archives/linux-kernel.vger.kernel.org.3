Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FD85699F1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 07:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbiGGFk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 01:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiGGFky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 01:40:54 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931BC31349;
        Wed,  6 Jul 2022 22:40:53 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id a15so17196183pfv.13;
        Wed, 06 Jul 2022 22:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ISrjqQrL8rQnKNyK/qFfZOQDFnDJ/r9wIWbFyBod+Kg=;
        b=hKtm+niY+AJV9SEYku9YboGeIFFltORehU6DocXrQf9QdlbiE9wygVGKFwXYyi+Sv/
         DUZX/3mKjcaSRhTPGV5RaEDoK3TjTkAky1GgFrDqNVdJhpIW5ISCc6o5n+SRBqIv2JSP
         2/2fig1ybyJHfjAnrw2lve/r6SSXgkWyu0gOzGWQ18s7IZ4fY6DUNL4Q5mCGAQmYV2bn
         uHDFzki8z/aEIWn/gnD5Sj3RTVLhq+lr2lNI33PU3aAVdteZGAPeNJn+TpBpWKQF0GWj
         jqJt4nNL2buodc3Lzz5NevPUFu/GOU0nszpIEA+PptI32H1HBtE81neWMRF/NTZwsvI7
         3b2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ISrjqQrL8rQnKNyK/qFfZOQDFnDJ/r9wIWbFyBod+Kg=;
        b=oSGyy9ubb+HgXfMMypmejpW4dG1+W/72rcqf+9YpaVpXBiPW8ERT8Bs+GiDJOs9At1
         WPx90a0I9ZOtELjFd+nS8bq10I1aTzolv1hhkP1ARzYVOWGLaPPNa5ZM1GXoJFAR4Nom
         dF1D+eTq6JQcy1cBXvhCGi7SA9h0VzLYo+TBJwxhDYJmQ7w0frWS88Jt6QWCgiCPmJzp
         8oyF0CKL6mv4qsArCERV5ZafhL5Yy5atDZ05tfv98GVkPge0ZcCraQcEA4x2CRcjqlbv
         jm+g/fK5OcQKU/7Syr853yTA3ljhBy221JLHFriLQoE65lT9uAdVTN4G6eM/3LPsCM/s
         ikUw==
X-Gm-Message-State: AJIora8PTJsf99J+QxrQLQhOcds684XjnD0nUJtnwjJnEcxOyJ/xwY7c
        PrjKZ5NvcrGEQF1Hw1la34Q=
X-Google-Smtp-Source: AGRyM1s/kYsePIZm457Bu28zuLw524wO+eDxG9fJOLzpQrwXk78+NliKZhLEx0TN9xbMrCxKHRptDg==
X-Received: by 2002:a65:490d:0:b0:40d:9867:2df with SMTP id p13-20020a65490d000000b0040d986702dfmr38447688pgs.171.1657172453073;
        Wed, 06 Jul 2022 22:40:53 -0700 (PDT)
Received: from debian.moxa.com ([123.51.145.104])
        by smtp.gmail.com with ESMTPSA id u16-20020a170902e81000b0015e8d4eb2e3sm3954190plg.301.2022.07.06.22.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 22:40:52 -0700 (PDT)
From:   Jimmy Chen <u7702045@gmail.com>
X-Google-Original-From: Jimmy Chen <jimmy.chen@moxa.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>
Cc:     Jimmy Chen <jimmy.chen@moxa.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: arm: fsl: Add Moxa UC8210/8220 series
Date:   Thu,  7 Jul 2022 13:40:43 +0800
Message-Id: <20220707054044.22266-1-jimmy.chen@moxa.com>
X-Mailer: git-send-email 2.20.1
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

Moxa UC8210/8220 use Freescale i.MX7d CPU

Signed-off-by: Jimmy Chen <jimmy.chen@moxa.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index ef524378d449..00b2df05087e 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -767,6 +767,8 @@ properties:
               - toradex,colibri-imx7d-emmc    # Colibri iMX7D 1GB (eMMC) Module
               - zii,imx7d-rmu2            # ZII RMU2 Board
               - zii,imx7d-rpu2            # ZII RPU2 Board
+              - moxa,uc-8210              # MOXA UC-8210 board
+              - moxa,uc-8220              # MOXA UC-8220 board
           - const: fsl,imx7d
 
       - description: TQ-Systems TQMa7D SoM on MBa7x board
-- 
2.20.1


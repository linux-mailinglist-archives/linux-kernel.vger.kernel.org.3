Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A2F58B857
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 23:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbiHFVCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 17:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiHFVCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 17:02:41 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB99E023;
        Sat,  6 Aug 2022 14:02:40 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id z187so5054331pfb.12;
        Sat, 06 Aug 2022 14:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LRe7Qi9ZOxXvGGMfrErpYT9kxajfvdTVrAFtsbgdYtk=;
        b=Ug8oeK4+D3PRIxzHwknKZrZEyz5wRGY0eZTjtvJ/IisX9fY+pJd4DjV6kbTOCPuvWA
         JMGnhLq882lBbVBOSJCjAGvBF9fJ39NK6e4/8u/YoMGFVuLyTQTpZjVcFgSoqD9153bs
         jfQRaUD1X9UyShSs0ZfIJLY/rNzIzI+2PD27si4QyvVAgqWwB2xLuhqZmQ0I7rarW4BH
         +Q3GQoXgu9f+HOGn4GZDygTAvt1OpEkUoL05rXcvpwCJ3uh7nQ8T9mOnbcygc8Wugg10
         wxJ7l9t4OjQDRp5y7gPEZDwL8McRD1ME7vTbMsVwoGwiq4513AnsBLg7EdmTjevfuWAO
         fRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LRe7Qi9ZOxXvGGMfrErpYT9kxajfvdTVrAFtsbgdYtk=;
        b=UAemWPNYCKDUk4rTPtq9cxFhv7Wu+ixDiBfFzabTDrU8Q0wx2cBazTGyHNRaxPBK9n
         JfUQbZHiPtqAnhrDiD36q5IZH3Fz9n2TvWQkuyniyU/EoHTdXIZZSo95/WzJIst20COI
         haiN5Rv0U8eedLikDXki+oYX2+Rc47w0AO6q14IJtPUIS4LYVHB7Vjs5HGTD7Vv2Z864
         tgyBewtYT4M+CR/GMW36cmP6YnC/8bvPYbTLCNV9uATVGpP35jdUBQjlRyGqxNUjzRKI
         tR1l5X8RjlqJMDecfQlEHV/ZzWiZQOZIngKnKgUPxhnMThr6PezK/O0Msla3ibE7xrfZ
         a5hQ==
X-Gm-Message-State: ACgBeo1zWMF4GOVkLr9v9gdi8exbjAotImp0kgimhiVmO5XhurykgJrW
        /mwVcTii3PCaxaVZQOymcFI=
X-Google-Smtp-Source: AA6agR4fGRyXz4+DR81zHSriz0QzC5MLOtri7MUFXE3EfZsE9ma3I9nTzb/JzAQCSCesgTPOL1crAQ==
X-Received: by 2002:a63:dd57:0:b0:41c:fd02:56d3 with SMTP id g23-20020a63dd57000000b0041cfd0256d3mr7787626pgj.427.1659819760145;
        Sat, 06 Aug 2022 14:02:40 -0700 (PDT)
Received: from fedora.. ([2405:201:e01d:6040:3f6e:eaa:537b:816f])
        by smtp.gmail.com with ESMTPSA id c203-20020a624ed4000000b0052ea306a1e8sm4538815pfb.210.2022.08.06.14.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 14:02:39 -0700 (PDT)
From:   Joel Selvaraj <joelselvaraj.oss@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Joel Selvaraj <joelselvaraj.oss@gmail.com>
Subject: [PATCH v3 0/2] Add support for Xiaomi Poco F1 EBBG variant
Date:   Sun,  7 Aug 2022 02:32:18 +0530
Message-Id: <20220806210220.31565-1-joelselvaraj.oss@gmail.com>
X-Mailer: git-send-email 2.37.1
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

There are two variants of Xiaomi Poco F1.
- Tianma variant with NOVATEK NT36672A panel + touchscreen manufactured
  by Tianma
- EBBG variant with Focaltech FT8719 panel + touchscreen manufactured
  by EBBG

The current sdm845-xiaomi-beryllium.dts represents Tianma panel variant.

To add support for the EBBG variant, 

In the PATCH 1/2, let's
-----------------------
- Rename sdm845-xiaomi-beryllium.dts to sdm845-xiaomi-beryllium-common.dtsi
- Generalize the display panel node by assigning label, removing
compatible property and renaming the panel endpoints to be generic.
- Create a dts for the Tianma variant called
sdm845-xiaomi-beryllium-tianma.dts which will inherit the common dtsi and
set the compatible property for the respective display panel.
- Adjust the Makefile since the sdm845-xiaomi-beryllium.dts is now called
sdm845-xiaomi-beryllium-tianma.dts for the tianma variant.

In the PATCH 2/2, let's
-----------------------
- Create sdm845-xiaomi-beryllium-ebbg.dts for the EBBG variant which will
inherit the common dtsi and set the compatible property for the respective
display panel.

Changes in v3:
--------------
- Approach suggested by Marijn Suijten and Krzysztof Kozlowski to make
git handle renames more appropriately and to avoid moving large chunks of
code. Helps with reviewing the patch.
 
Changes in v2:
--------------
- Fix issue with builds breaking across multiple commits making git bisect
harder to find where the rename has happened.

Note:
-----
Both the panels are already upstreamed and the split is based on them.
There were patches earlier for both the touchscreens, but they are not
accepted in upstream yet. Once they are accepted, we will add them to
respective variants.

Joel Selvaraj (2):
  arm64: dts: qcom: split beryllium dts into common dtsi and tianma dts
  arm64: dts: qcom: sdm845-xiaomi-beryllium-ebbg: introduce Xiaomi Poco
    F1 EBBG variant

 arch/arm64/boot/dts/qcom/Makefile                      |  3 ++-
 ...ryllium.dts => sdm845-xiaomi-beryllium-common.dtsi} |  9 +++++----
 .../boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts     | 10 ++++++++++
 .../boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts   | 10 ++++++++++
 4 files changed, 27 insertions(+), 5 deletions(-)
 rename arch/arm64/boot/dts/qcom/{sdm845-xiaomi-beryllium.dts => sdm845-xiaomi-beryllium-common.dtsi} (98%)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts

-- 
2.37.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8C54EDA00
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236421AbiCaM6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236420AbiCaM6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:58:42 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34442128ED;
        Thu, 31 Mar 2022 05:56:54 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id r13so47921327ejd.5;
        Thu, 31 Mar 2022 05:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UccPI0Vs3BzsfOsGfndf21BCZr1jQY6N7hAg1waRF/s=;
        b=HfBw6vWTgOJCYdKg8YHaESl+8G04ToxxeF63XQSjns6Dk+LBjFpbBsyMKo8RR9icBD
         +YR4nv9rtSCx5OGsTlaCwev6n1dE1syjwnmouQztZ2cmWQoA8hQrchrcjb/ebU9JgXOa
         lIlY/nrjEoeJG5A+IvN9TEgvVoSUeyGUzsJd71GFxt6/tJkDuZgBTqMid0URZoE4V7Tk
         H0mU6yhuHBdRwqlJ25JgCMpKt3BCBU4CCSkJAenBdHODIxshDWGsgjoLNQR32LvIoNwa
         L31o07H/PXupHDCPC5pHjrI3doD7IcnH6SbMgZBSh9W0WAbk7K0YN5I/0HpeXO+fPN8p
         BBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UccPI0Vs3BzsfOsGfndf21BCZr1jQY6N7hAg1waRF/s=;
        b=c2OXo4F1z57WD3KNVqnCTMJT3BuHvIEKWHhfHFV0qxoyOnJ1gi4QdQA7xX4213nja0
         EHhx7Pu9OYPCvxuDnRcWnseXgQAWpd+GiydQMlSFYdUbgsW37F1ncD/jVTp+pO6f0CBm
         oTBW49Tokvn5Kw3+NIHTvnD7PS0m85rtxjfcCvm/RgVwePjwd0y+rLm0EYs8Nf8OGsRW
         TEH2lOZIpQCY3BvHLu71aWOX5MH95kucH39DKSJmJKpiehL1iMrV9Q0nrxQhQI0LFveq
         4fFmfF/UHOijiZwI0/YFqtaTSfv/a+/tlGJcX9bNvehtEjhb7WRne2BXG4KYpKu1GJQB
         aunQ==
X-Gm-Message-State: AOAM533+p8wd8HgSljJ0lQcSyBQKtgKxFJTWYoB2UKZ77Id16nqO69kc
        6YFqRdUH7sO5JRgox09AGhGBdsqAlYc=
X-Google-Smtp-Source: ABdhPJwB1bY+CLWE7b4PuZ+68hjf+J3CT+jsxTI7VrbqdpniDeNCJLs0u5gD62CZ6M9aKGk6OHNNVQ==
X-Received: by 2002:a17:907:1606:b0:6df:f528:4033 with SMTP id hb6-20020a170907160600b006dff5284033mr4847028ejc.433.1648731413350;
        Thu, 31 Mar 2022 05:56:53 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id u4-20020aa7db84000000b004136c2c357csm11203745edt.70.2022.03.31.05.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 05:56:52 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM: dts: rockchip: use generic node name for dma rk3036/rk322x
Date:   Thu, 31 Mar 2022 14:56:44 +0200
Message-Id: <20220331125644.6841-1-jbx6244@gmail.com>
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

The node names should be generic, so fix this for the rk3036 and
rk322x dma node and rename it to "dma-controller".

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3036.dtsi | 2 +-
 arch/arm/boot/dts/rk322x.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index 24f868d06..9b0f04975 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -558,7 +558,7 @@
 		status = "disabled";
 	};
 
-	pdma: pdma@20078000 {
+	pdma: dma-controller@20078000 {
 		compatible = "arm,pl330", "arm,primecell";
 		reg = <0x20078000 0x4000>;
 		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 2547f46fe..ffc16d6b9 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -503,7 +503,7 @@
 			<75000000>;
 	};
 
-	pdma: pdma@110f0000 {
+	pdma: dma-controller@110f0000 {
 		compatible = "arm,pl330", "arm,primecell";
 		reg = <0x110f0000 0x4000>;
 		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.20.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F00257D5F6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 23:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbiGUVaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 17:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233591AbiGUVaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:30:20 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A43D27B11;
        Thu, 21 Jul 2022 14:30:19 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id h16so1467413ilc.10;
        Thu, 21 Jul 2022 14:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q4CuC/WYjQM/RT96qg2sYj3aPg2iiARQl9OFgHF9MtE=;
        b=LI559kmkLUDtOYMo65KazC/YcWhd4zx5wdizVkLGhNCc1lZoU5P35u/oykDuTwCoY6
         Be8NaWwCPN6dD2ERIl4OjpWB7GBN2F1g2LFE3jegtpzzpLycrWefMdL4Mu3mzObEPgKN
         MOF6jdCSPmRoT6TzNcbr5SS6vwtUmgo2tGmWynH1rtqQny7cUm2m3NapacQQClnZzzgd
         hhh2moCExtGyrOC4H3K913I72S/uLwr3Y1wCK6ulXSvtQPP5xtwAJlyE06w96A92+FW1
         eMKlgP8foVLLnCQ/+w6a+9lKAAEvoUcXZ2DM7UPzqIb7Ehz7sTNJsr9T6qC3c6mIEFlf
         y7NA==
X-Gm-Message-State: AJIora/WEYSoAROoxF2ZLOt7VXBakp4NqbGi6e7tePftT30s8b1dpLoJ
        F5kTyo43rK0E2q55asfOtw==
X-Google-Smtp-Source: AGRyM1sjispE0yfxZ6N5fmn3vErNnDMnKf5YChwThWvCKcWIphbObaSgwNMYwJhrlMnKw4MDdOAUpA==
X-Received: by 2002:a05:6e02:1645:b0:2da:e6be:3dfc with SMTP id v5-20020a056e02164500b002dae6be3dfcmr192299ilu.116.1658439018245;
        Thu, 21 Jul 2022 14:30:18 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id c1-20020a0566022d0100b0067b7966553fsm1297539iow.20.2022.07.21.14.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 14:30:17 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: arm: juno: Remove legacy Coresight 'slave-mode' property
Date:   Thu, 21 Jul 2022 15:29:52 -0600
Message-Id: <20220721212952.1984382-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'slave-mode' property is not valid under 'in-ports' as it was the
legacy way to find input ports. Warnings are generated from the Coresight
schema:

arch/arm64/boot/dts/arm/juno-r1.dtb: funnel@20150000: in-ports:port@0:endpoint: Unevaluated properties are not allowed ('slave-mode' was unexpected)
        From schema: Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi b/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
index 2e43f4531308..fbcdf63ad56d 100644
--- a/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
@@ -67,7 +67,6 @@ in-ports {
 			port@0 {
 				reg = <0>;
 				csys2_funnel_in_port0: endpoint {
-					slave-mode;
 					remote-endpoint = <&etf0_out_port>;
 				};
 			};
@@ -75,7 +74,6 @@ csys2_funnel_in_port0: endpoint {
 			port@1 {
 				reg = <1>;
 				csys2_funnel_in_port1: endpoint {
-					slave-mode;
 					remote-endpoint = <&etf1_out_port>;
 				};
 			};
-- 
2.34.1


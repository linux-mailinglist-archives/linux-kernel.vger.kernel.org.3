Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E67535BB4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348442AbiE0Iht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349831AbiE0IhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:37:15 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB6664BEC;
        Fri, 27 May 2022 01:36:30 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 24R8aEDj046324;
        Fri, 27 May 2022 03:36:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1653640574;
        bh=mOjyc69RQmsty71vyEDq/gFIx8VXd/jFX/msZkJ46Iw=;
        h=From:To:CC:Subject:Date;
        b=mSwMGFD7ei+PaTirj5kL+FDoNAprFj4PMeRE5X5p1moVg5uy6Ml9N4t6BDyoCgkVT
         /6hTffaecEpWHNI6gf8EqmWhzgGBIgOQ6JB9GXYNk+22H33PVSk/TnGnu5s+S0uM6G
         qzzWdtFgDASsBaKoQYD6LnMD/VwFsu89ZOvYmr1s=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 24R8aEnh015743
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 May 2022 03:36:14 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 27
 May 2022 03:36:14 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 27 May 2022 03:36:13 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 24R8aCIo105296;
        Fri, 27 May 2022 03:36:13 -0500
From:   Rahul T R <r-ravikumar@ti.com>
To:     <robh+dt@kernel.org>, <nm@ti.com>, <vigneshr@ti.com>,
        <kishon@ti.com>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <lee.jones@linaro.org>, <rogerq@kernel.org>,
        <devicetree@vger.kernel.org>, <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <s-anna@ti.com>,
        Rahul T R <r-ravikumar@ti.com>
Subject: [PATCH 0/3] Enable RPi header on j721e sk
Date:   Fri, 27 May 2022 14:05:53 +0530
Message-ID: <20220527083556.18864-1-r-ravikumar@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series of patches enables RPi header
on j721e sk. It is a 40 pin io expasion header which
brings out i2c5, ehrpwm 2,3 and some pins of gpio 0,1

Rahul T R (1):
  dt-bindings: mfd: ti,j721e-system-controller: Add clock property

Sinthu Raja (1):
  arm64: dts: ti: k3-j721e-sk: Add pinmux for RPi Header

Vijay Pothukuchi (1):
  arm64: dts: ti: k3-j721e-*: Add dts nodes for EHRPWMs

 .../mfd/ti,j721e-system-controller.yaml       |  12 +++
 .../dts/ti/k3-j721e-common-proc-board.dts     |  24 +++++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     |  62 ++++++++++-
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts        | 101 +++++++++++++++++-
 4 files changed, 193 insertions(+), 6 deletions(-)

-- 
2.17.1


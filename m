Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4190C5378BF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbiE3KBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 06:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbiE3KBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 06:01:14 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D80471D8D;
        Mon, 30 May 2022 03:01:13 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 24UA17l0068551;
        Mon, 30 May 2022 05:01:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1653904867;
        bh=3ftSmqfdQyqEHrlDTVtoTH7zweX0PVjOB8JAzW5Mgx0=;
        h=From:To:CC:Subject:Date;
        b=HY4Kl/p7aTgWs47aL9/VxSjjsL9ZIYmIsI+PY4feJczPqXuDBX400KjhLJA9mugNk
         znuF2LWRps5SJMTt1KtTT3Dp7eROvFRtsuUFAGc6HWIX8ddi524h9GEzwdmFzgUYwp
         Bt/9a058/NYi/L9ER+STu62BcvlT4MbFiTKQpzyA=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 24UA177N012486
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 May 2022 05:01:07 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 30
 May 2022 05:01:07 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 30 May 2022 05:01:06 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 24UA154P025616;
        Mon, 30 May 2022 05:01:06 -0500
From:   Rahul T R <r-ravikumar@ti.com>
To:     <robh+dt@kernel.org>, <nm@ti.com>, <vigneshr@ti.com>,
        <kishon@ti.com>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <lee.jones@linaro.org>, <rogerq@kernel.org>,
        <devicetree@vger.kernel.org>, <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <s-anna@ti.com>,
        Rahul T R <r-ravikumar@ti.com>
Subject: [PATCH v3 0/3] Enable RPi header on j721e sk
Date:   Mon, 30 May 2022 15:30:57 +0530
Message-ID: <20220530100100.10420-1-r-ravikumar@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

v3:
   - Change node name from clock to clock-controller
   - Add correct description for clock-controller node

v2:
   - Add full path for clock property $ref
   - Remove the discription for clock pattern property,
     since $ref is added
   - Remove the label in the example
   - Fix the indentation in the example

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


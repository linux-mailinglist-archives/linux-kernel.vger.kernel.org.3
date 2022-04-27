Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBD1511259
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358770AbiD0Hag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357336AbiD0Hae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:30:34 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406364550E;
        Wed, 27 Apr 2022 00:27:24 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23R7RFkj068057;
        Wed, 27 Apr 2022 02:27:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651044435;
        bh=mh5AHHLcm8CACr6+kU9hGv8yEmrfm0qh1IxEwoYWFx4=;
        h=From:To:CC:Subject:Date;
        b=ajKKOMAZ0X3OI16BP5uhlMJ8jKpx2PWO57YPAjaQthxNBh40j1dUye77p9A0ArL+u
         vR5uqOHPDkL3iKr9zmboguoFRCaEoxyoXxcw/vuDcZuOJn42gF4q12cB5geNO+n7D5
         xEM8ncMm8sisZNu1Dl2vMPL/wubVRwabc12h0huw=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23R7RFrK103690
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Apr 2022 02:27:15 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 27
 Apr 2022 02:27:14 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 27 Apr 2022 02:27:14 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23R7RBgP088380;
        Wed, 27 Apr 2022 02:27:12 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>
CC:     Santosh Shilimkar <ssantosh@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 0/2] soc: ti: Enable PRUSS-M on K3 AM62x SoCs
Date:   Wed, 27 Apr 2022 12:57:01 +0530
Message-ID: <20220427072703.4898-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Series adds AM62x specific compatible string to enable PRUSS-M in
AM62x SoCs.

Kishon Vijay Abraham I (2):
  dt-bindings: soc: ti: pruss: Update bindings for K3 AM62x SoCs
  soc: ti: pruss: Enable support for PRUSS-M subsystem on K3 AM62x SoCs

 Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml | 1 +
 drivers/soc/ti/pruss.c                                 | 1 +
 2 files changed, 2 insertions(+)

-- 
2.17.1


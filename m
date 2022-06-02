Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639D653B6D1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 12:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbiFBKTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 06:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbiFBKT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 06:19:28 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF36C297505;
        Thu,  2 Jun 2022 03:19:27 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 252AJOQ7004201;
        Thu, 2 Jun 2022 05:19:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1654165164;
        bh=5joeRwxlwsWA6qOIxNl/R7ka0zwV0w7W8CZHcTK6SAc=;
        h=From:To:CC:Subject:Date;
        b=KTSvAKS6IIts2cixywmKBsribc2GxnnfeAzA3s/4tqxu/yTxAORjMorzGAT/gIv0C
         O9zqBM+Y8OYj1l9v1YhY3Nw9oIFSK4rPdz41Ckb833xMTebPXpS17bt7zqMCBxCDGi
         pSTXS8NyJZ6dZHO4XO71jPpj4MmYxNkQ1LiBABbk=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 252AJOgg022106
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 2 Jun 2022 05:19:24 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 2
 Jun 2022 05:19:23 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 2 Jun 2022 05:19:23 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 252AJKGC063560;
        Thu, 2 Jun 2022 05:19:21 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Suman Anna <s-anna@ti.com>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/3] remoteproc: pru: Enable PRU cores on K3 AM62x SoCs
Date:   Thu, 2 Jun 2022 15:49:17 +0530
Message-ID: <20220602101920.12504-1-kishon@ti.com>
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

Series adds AM62x specific compatible string to enable PRUSS-M in
AM62x SoCs.

Changes from v1:
1) Added a new patch to re-arrange "compatible" in alphabetic
    order

v1: https://lore.kernel.org/r/20220427083509.14458-1-kishon@ti.com

Kishon Vijay Abraham I (3):
  dt-bindings: remoteproc: pru: Re-arrange "compatible" in alphabetic
    order
  dt-bindings: remoteproc: pru: Update bindings for K3 AM62x SoCs
  remoteproc: pru: Add support for various PRU cores on K3 AM62x SoCs

 .../devicetree/bindings/remoteproc/ti,pru-rproc.yaml         | 5 +++--
 drivers/remoteproc/pru_rproc.c                               | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.17.1


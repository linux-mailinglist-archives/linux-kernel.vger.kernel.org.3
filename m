Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A237E4BFED4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbiBVQeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbiBVQdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:33:20 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3AF162006;
        Tue, 22 Feb 2022 08:32:45 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21MGWZaT053060;
        Tue, 22 Feb 2022 10:32:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645547555;
        bh=b5zGZfrvG+yLErjAoFGzAo3G6Af6FpoDENZ4VIjCO3E=;
        h=From:To:CC:Subject:Date;
        b=XGxWdftUskbRYRjKcNTxhujZqwpcgidruzAAlIyIyP0LflFFFpe6qJvH4xhkkL86i
         OYitpBW2ls/tVtawBdkjqB+AWkOwAnMyAABFvcVyf7+mnHZs8bIyvJyamkPOfxOg6d
         bIuwEg67rnjxZOTcpQg3I0W+8xS2vV9hoVDwh7II=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21MGWZRt067311
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Feb 2022 10:32:35 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 22
 Feb 2022 10:32:35 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 22 Feb 2022 10:32:35 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21MGWXb2066738;
        Tue, 22 Feb 2022 10:32:34 -0600
From:   Rahul T R <r-ravikumar@ti.com>
To:     <nm@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@canonical.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tomi.valkeinen@ideasonboard.com>,
        <laurent.pinchart@ideasonboard.com>
Subject: [PATCH 0/2] DSS: Add support for DisplayPort
Date:   Tue, 22 Feb 2022 22:02:28 +0530
Message-ID: <20220222163230.1566-1-r-ravikumar@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series of patches enables DisplayPort on
j721e-evm

Tomi Valkeinen (2):
  arm64: dts: ti: k3-j721e-main: add DP & DP PHY
  arm64: dts: ti: k3-j721e-common-proc-board: add DP to j7 evm

 .../dts/ti/k3-j721e-common-proc-board.dts     |  66 +++++++++++-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 102 ++++++++++++++++++
 2 files changed, 164 insertions(+), 4 deletions(-)

-- 
2.17.1


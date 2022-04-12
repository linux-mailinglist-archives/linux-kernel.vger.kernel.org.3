Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F51A4FD648
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388424AbiDLJWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377966AbiDLHyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:54:51 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB039F8;
        Tue, 12 Apr 2022 00:33:32 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23C7XI09092329;
        Tue, 12 Apr 2022 02:33:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649748798;
        bh=VdCs/Pjh+iURxxt1j4N/dr32rlnP02nAMXE1v7NZKvs=;
        h=From:To:CC:Subject:Date;
        b=uzXEO5wn9Hu2ga7934M8A5BhJGO5x9fecsbpw54zw/DpGcfKp+mxw8cVaNFLtd3A0
         DgVTI/QZIUBM7pWIci4weKaSCfAhP2wXGqffpWi1ApRjMiDlX0NycQdByjtAONmUd3
         p5TaqJrZ0msS9f9xjR3q/uX1mzHqNfcTg7YdAWZk=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23C7XIrR126912
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Apr 2022 02:33:18 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 12
 Apr 2022 02:30:17 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 12 Apr 2022 02:30:17 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23C7UHL0026687;
        Tue, 12 Apr 2022 02:30:17 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <linux-crypto@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <krzysztof.kozlowski+dt@linaro.org>, <j-choudhary@ti.com>,
        <robh+dt@kernel.org>
Subject: [PATCH 0/2] New compatible for sa3ul for AM62x
Date:   Tue, 12 Apr 2022 13:00:14 +0530
Message-ID: <20220412073016.6014-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add the new compatible for sa3ul in the bindings and
driver file which will be used further in device tree nodes to
enable crypto support in TI SoC AM62x.

I will post the patch to enable crypto accelerator once this series
is merged.

Jayesh Choudhary (2):
  dt-bindings: crypto: ti,sa2ul: Add a new compatible for AM62
  crypto: sa2ul: Add the new compatible for AM62

 Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml | 1 +
 drivers/crypto/sa2ul.c                                 | 1 +
 2 files changed, 2 insertions(+)

-- 
2.17.1


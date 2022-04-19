Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A179150654D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 09:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349167AbiDSHGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 03:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237092AbiDSHGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:06:46 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29E62AC6C;
        Tue, 19 Apr 2022 00:04:04 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23J73fM2025664;
        Tue, 19 Apr 2022 02:03:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650351821;
        bh=GE9Plw/ZKj9bf211DOprV0mgq6L7hEDBT4cWIq5E0yo=;
        h=From:To:CC:Subject:Date;
        b=InXJW5fgW56RZTOTSJOaNefKs8N4t9eaDYTxjKpyQDRbZDmUJY+5qFprIY8HGzJy2
         a9SI59m3xiw4ImJBwTMXF77AR9088y+WS+aGceTSJPcN8zb1NYanEMZE8La3s1hY41
         XJIU5CRPOxgHvELgIssaOuh50ThCEXbIXxcuFLHg=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23J73fcX120926
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Apr 2022 02:03:41 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 19
 Apr 2022 02:03:40 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 19 Apr 2022 02:03:40 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23J73euZ005625;
        Tue, 19 Apr 2022 02:03:40 -0500
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Jyri Sarha <jyri.sarha@iki.fi>, Tomi Valkeinen <tomba@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>
CC:     DRI Development <dri-devel@lists.freedesktop.org>,
        Devicetree <devicetree@vger.kernel.org>,
        Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH 0/2] Update register & interrupt info in am65x DSS
Date:   Tue, 19 Apr 2022 12:33:00 +0530
Message-ID: <20220419070302.16502-1-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The Display SubSystem IP on the ti's am65x soc has an additional 
register space "common1" and services a maximum of 2 interrupts.

The first patch in the series adds the required updates to the yaml
file. The second patch then reflects the yaml updates in the DSS DT
node of am65x soc.

Aradhya Bhatia (2):
  dt-bindings: display: ti,am65x-dss: Add missing register & interrupt
  arm64: dts: ti: k3-am65: Add missing register & interrupt in DSS node

 .../devicetree/bindings/display/ti/ti,am65x-dss.yaml   | 10 +++++++---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi               |  6 ++++--
 2 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.35.3


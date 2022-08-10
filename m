Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729A358E9BF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 11:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbiHJJhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 05:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbiHJJhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 05:37:35 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C25D6EF22;
        Wed, 10 Aug 2022 02:37:33 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27A9bNJp044357;
        Wed, 10 Aug 2022 04:37:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1660124243;
        bh=LRZK/W/kDEs0O3d9V+G9LZ2YPLkzstDnPMZlHEQHeKg=;
        h=From:To:CC:Subject:Date;
        b=etq9DihoImGq+l40TzPW09pAejpP3HT7dmKGb+IOQTD4n8LhA4DYvnlrAPPEVhxd3
         vD7jhQdxlk+l+DetOsG2jfdq384ZKpzHmLhWJ/Z3qKuCDYyfdqOJSWK+NjUlXGGYwB
         HEoBBbrGdUHQITZNGPvxtRDzpUbGWjBOKW9YD+rI=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27A9bNL2022228
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Aug 2022 04:37:23 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 10
 Aug 2022 04:37:22 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 10 Aug 2022 04:37:22 -0500
Received: from ubuntu.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27A9bF6B105196;
        Wed, 10 Aug 2022 04:37:17 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <vigneshr@ti.com>
CC:     Matt Ranostay <mranostay@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND 0/6] J721S2: Add support for additional IPs
Date:   Wed, 10 Aug 2022 02:37:06 -0700
Message-ID: <20220810093712.248425-1-mranostay@ti.com>
X-Mailer: git-send-email 2.36.1
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

The following series of patches add support for the following
on J721S2 common processor board,

- USB
- SerDes
- OSPI

Aswath Govindraju (6):
  arm64: dts: ti: k3-j721s2-main: Add support for USB
  arm64: dts: ti: k3-j721s2-main: Add SERDES and WIZ device tree node
  arm64: dts: ti: k3-j721s2-mcu-wakeup: Add support of OSPI
  arm64: dts: ti: k3-j721s2-common-proc-board: Enable SERDES0
  arm64: dts: ti: k3-j721s2-common-proc-board: Add USB support
  arm64: dts: ti: k3-j721s2: Add support for OSPI Flashes

 .../dts/ti/k3-j721s2-common-proc-board.dts    |  78 ++++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    | 112 ++++++++++++++++++
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     |  40 +++++++
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi  |  42 +++++++
 4 files changed, 272 insertions(+)

-- 
2.36.1


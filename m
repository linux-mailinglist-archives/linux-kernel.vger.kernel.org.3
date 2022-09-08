Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF6B5B1204
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 03:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiIHBTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 21:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiIHBT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 21:19:28 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D36A1162;
        Wed,  7 Sep 2022 18:19:25 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2881JI90077176;
        Wed, 7 Sep 2022 20:19:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1662599958;
        bh=oK3qgLDr4WjOZ1BnDhKl+UBf5+MvUjH9QmydoZJtzTU=;
        h=From:To:CC:Subject:Date;
        b=XSNDvdmIUlf7OCpUTaMvUzhus+yTVHiOsgveaMCMVpr/3QNHxN+NzbEV0qVAL3t79
         wcpVxH2yxwzXzkmpiuIQd4pkOUsfxE89z4e/1ShdA72grc7YmjMwrcTa1kZNkRlbi1
         oyyTGKP05NaD65bc1mjGuz0bm+Uiw4aJjX9F+ky4=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2881JICS027910
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Sep 2022 20:19:18 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 7 Sep
 2022 20:19:18 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 7 Sep 2022 20:19:18 -0500
Received: from ubuntu.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2881JCKd007542;
        Wed, 7 Sep 2022 20:19:14 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <vigneshr@ti.com>, <nm@ti.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/6] J721S2: Add support for additional IPs
Date:   Wed, 7 Sep 2022 18:19:05 -0700
Message-ID: <20220908011911.3319-1-mranostay@ti.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The following series of patches add support for the following
on J721S2 common processor board,

- USB
- SerDes
- OSPI

Changes from v1:
* Resolve issues with dt schema reporting
* Minor changes related to consistency on node naming and value

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
2.30.2


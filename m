Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A204EDBB4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 16:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237632AbiCaOcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 10:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237581AbiCaOcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 10:32:42 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6491DA8D7;
        Thu, 31 Mar 2022 07:30:54 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 22VEUelF081474;
        Thu, 31 Mar 2022 09:30:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1648737040;
        bh=QvBBVCUYloyVm3Uwun8UUPb3BBfl9VEhJHX7V9TsLXY=;
        h=From:To:CC:Subject:Date;
        b=yNFTwG7UtF3PUzRVsXbpV4zAyJFFPxyI9zWZn6m5ZH+XI7o+cfLA2PBAd/GkWDcIw
         ItAtkBI9xwTiOeS4d8Kra6y9NgHxmRl5DRNQMWfo3ILVmCCIrdIu4O1PR2/9sYmIv+
         /MBWJb6g4nyVV5wQiB04zUNOzHC3hHk2n+GHy7zw=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 22VEUe3f058084
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Mar 2022 09:30:40 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 31
 Mar 2022 09:30:40 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 31 Mar 2022 09:30:40 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 22VEUdN1008328;
        Thu, 31 Mar 2022 09:30:39 -0500
From:   Rahul T R <r-ravikumar@ti.com>
To:     <nm@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@canonical.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tomi.valkeinen@ideasonboard.com>,
        <laurent.pinchart@ideasonboard.com>, <kishon@ti.com>,
        <r-ravikumar@ti.com>
Subject: [PATCH v2 0/2] DSS: Add support for DisplayPort
Date:   Thu, 31 Mar 2022 20:00:33 +0530
Message-ID: <20220331143035.16210-1-r-ravikumar@ti.com>
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

The following series of patches enables DisplayPort on
j721e-evm

Tomi Valkeinen (2):
  arm64: dts: ti: k3-j721e-main: add DP & DP PHY
  arm64: dts: ti: k3-j721e-common-proc-board: add DP to j7 evm

v2:
   - use phandle with a parameter to refer clocks insted of
     sub nodes in serdes_wiz node
   - move phy link node to board DTS file

boot logs:
   https://gist.githubusercontent.com/ravi-rahul/1bdbc3f77ab381e486c8394650c2e85d/raw/f04584c30181821c4ee83aee7781a9ba143cd3f3/j7_DP_upstream.log

kernel patch verify report:
   https://gist.githubusercontent.com/ravi-rahul/a982fef3fae03ec0dbdd5cb475a4cb25/raw/c8230370746e9878daf9527c3aa9d82eed7aa33c/report-kernel-patch-verify.txt

 .../dts/ti/k3-j721e-common-proc-board.dts     | 78 ++++++++++++++++++-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 65 ++++++++++++++++
 2 files changed, 139 insertions(+), 4 deletions(-)

-- 
2.17.1


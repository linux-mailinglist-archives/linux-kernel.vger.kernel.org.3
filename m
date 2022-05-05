Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A1151BB6E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 11:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351552AbiEEJLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 05:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351367AbiEEJLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 05:11:03 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89ADA4B871;
        Thu,  5 May 2022 02:07:24 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 24597E0L091469;
        Thu, 5 May 2022 04:07:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651741634;
        bh=cuNlpAakS45rBc8XBXO2gkkoHDbvVLiW7EmY+HgwLOY=;
        h=From:To:CC:Subject:Date;
        b=xh02vZf69oWa0NLyqR+e9Iql2/Q40Mw1IGBgP9txfkKSLjEwwe9wHdpWgfuQAK+c6
         L2aKuseb3/4V7EZd8p5nnH+TVw2X4EdoG+v03s6Edmp2nPjjevReJBLOEuSkFuF4e7
         FOqYi4Lm5JUWs4B/Kdhu1fsyJpEmcV1LZfuuP0rw=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 24597DXQ043661
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 May 2022 04:07:13 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 5
 May 2022 04:07:13 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 5 May 2022 04:07:13 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 24597B9d089648;
        Thu, 5 May 2022 04:07:12 -0500
From:   Rahul T R <r-ravikumar@ti.com>
To:     <nm@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tomi.valkeinen@ideasonboard.com>,
        <laurent.pinchart@ideasonboard.com>, <kishon@ti.com>,
        <a-bhatia1@ti.com>, <r-ravikumar@ti.com>
Subject: [PATCH v2 0/2] Add support for DP and HDMI on j721e-sk
Date:   Thu, 5 May 2022 14:37:07 +0530
Message-ID: <20220505090709.9252-1-r-ravikumar@ti.com>
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

The following series of patches enables DisplayPort and
HDMI on j721e-sk

v2:
   - Fix name for dpi1 dss endpoint

This series depends on
https://lore.kernel.org/all/20220429112639.13004-1-r-ravikumar@ti.com/
which adds required nodes in the SoC dtsi file

boot logs:
   https://gist.githubusercontent.com/ravi-rahul/d2e139d8ff9446ede003291a6a3e8be5/raw/ed51498efe7f7bc4848dffb27e2b37e0beb7a94d/j7_sk_DP_HDMI_boot.log

kernel patch verify report:
   https://gist.githubusercontent.com/ravi-rahul/1e2350b53ac7d6ba7694373c0b3bbb44/raw/f09f75821610b42ad1f8b4bf3e5ef7843de0c76e/report-kernel-patch-verify-sk-dp-hdmi.txt

Rahul T R (2):
  arm64: dts: ti: k3-j721e-sk: Enable DisplayPort
  arm64: dts: ti: k3-j721e-sk: Enable HDMI

 arch/arm64/boot/dts/ti/k3-j721e-sk.dts | 123 ++++++++++++++++++++++++-
 1 file changed, 119 insertions(+), 4 deletions(-)

-- 
2.17.1


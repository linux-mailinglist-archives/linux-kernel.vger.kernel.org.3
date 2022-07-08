Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585CF56B430
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237683AbiGHIJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237676AbiGHIJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:09:15 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007BF804A8
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 01:09:10 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 26888llU027708;
        Fri, 8 Jul 2022 03:08:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1657267727;
        bh=i2GIS/OLFhHxGpFZ0Kk9xkpHS+ilJXNNjAsoapRocc8=;
        h=From:To:CC:Subject:Date;
        b=AnjUF1fpDUdS0Y9f7vXm+DbD1/2kZlDA5/x5lKHQBnHvu3Q7+ZDl6H5otUYqiZ/rI
         a+2QjuY4NJ57xJvQ9mgVfAFqbJkYT1anTuNuzNUe7m1T4PyGn312WiAD6k3AzGXUK4
         5dPLhZAStWkunw+sOex46VTbX+6xe2rTS3w/OGuE=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 26888laI110783
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Jul 2022 03:08:47 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 8
 Jul 2022 03:08:46 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 8 Jul 2022 03:08:46 -0500
Received: from ubuntu.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 26888iof119145;
        Fri, 8 Jul 2022 03:08:45 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Matt Ranostay <mranostay@ti.com>
Subject: [PATCH 0/2] dmaengine: ti: k3-psil: add TX threads for J721E + J7200 platforms
Date:   Fri, 8 Jul 2022 01:08:34 -0700
Message-ID: <20220708080836.431043-1-mranostay@ti.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add additional PSI-L TX threads for peripherals on both J721E and J7200 platforms

Matt Ranostay (2):
  dmaengine: ti: k3-psil: add additional TX threads for j721e
  dmaengine: ti: k3-psil: add additional TX threads for j7200

 drivers/dma/ti/k3-psil-j7200.c | 67 ++++++++++++++++++++++++++++
 drivers/dma/ti/k3-psil-j721e.c | 79 ++++++++++++++++++++++++++++++++++
 2 files changed, 146 insertions(+)

-- 
2.36.1


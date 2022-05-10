Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7C0521386
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240861AbiEJLXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240853AbiEJLX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:23:27 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AF32AACC8
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:19:29 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 24ABJBo1125790;
        Tue, 10 May 2022 06:19:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1652181551;
        bh=OeAyXVccjY3hm+MWAfdIaWBN7g5ZIOZUI4gJYrjNDbg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=pyu8URTAdstc87XBeUdr6md9Ycr3d07FXPTmt2VvvnABQ2ek0qUXC5MRCzAiAdkyJ
         3WKr8rJ9Xbb7RCBIXXLqbUCgJySLdjKFbjkZsDNd8xg8VmfJaLlBux4pZ0IhR63eu5
         xoOoMYTNWou/XS9jhtX13/Yfrx12FI3CbXILemDc=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 24ABJB0A094124
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 May 2022 06:19:11 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 10
 May 2022 06:19:11 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 10 May 2022 06:19:11 -0500
Received: from pratyush-4F-325.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 24ABJ3fq127309;
        Tue, 10 May 2022 06:19:07 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <richard@nod.at>, Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <michael@walle.cc>,
        <tudor.ambarus@microchip.com>
CC:     <quic_asutoshd@quicinc.com>, <linux-mtd@lists.infradead.org>,
        <quic_sartgarg@quicinc.com>, <quic_rampraka@quicinc.com>,
        <quic_nitirawa@quicinc.com>, <quic_pragalla@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <quic_sayalil@quicinc.com>
Subject: Re: [PATCH V9] mtd: spi-nor: winbond: add support for W25Q512NW-IM
Date:   Tue, 10 May 2022 16:49:02 +0530
Message-ID: <165218141900.322959.6753840624278997521.b4-ty@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <1651234239-32217-1-git-send-email-quic_c_sbhanu@quicinc.com>
References: <1651234239-32217-1-git-send-email-quic_c_sbhanu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Apr 2022 17:40:39 +0530, Shaik Sajida Bhanu wrote:
> Add support for winbond W25Q512NW-IM chip.
> 
> Below are the tests done:
> 
> 1. Verified flashing binary image on spi card using flashrom tool.
> 2. Verified OTP support, below are the test results:
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-nor/next, thanks!
[1/1] mtd: spi-nor: winbond: add support for W25Q512NW-IM
      https://git.kernel.org/mtd/c/89051ff5dd

--
Regards,
Pratyush Yadav
Texas Instruments Inc.


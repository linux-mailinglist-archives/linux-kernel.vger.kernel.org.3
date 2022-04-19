Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1BE5075C7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354973AbiDSRDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356407AbiDSRDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:03:37 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDD642A23;
        Tue, 19 Apr 2022 09:53:56 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23JGreZd096708;
        Tue, 19 Apr 2022 11:53:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650387220;
        bh=QSI3PLwKbEJCUrBle6uYB9wA895+tkkVHQLd1uDimr4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=XKbTfnycxjrM94oI0i7Yw3+2rydSUPYJcuFc0b5VRT134vSy85B5+ALiYT+YpSSS1
         DPCgIYSWsZwyBtY3mJRQke2DW8TrAeP2fb1LITPw5VPUl8kwJjQw67vGSx8Y+uAhHx
         K/3nN3ALDzBPhu5vdhlc7MpaiZEzk1OXDBHa7zQ8=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23JGreFl010855
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Apr 2022 11:53:40 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 19
 Apr 2022 11:53:40 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 19 Apr 2022 11:53:40 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23JGreYF007427;
        Tue, 19 Apr 2022 11:53:40 -0500
Date:   Tue, 19 Apr 2022 11:53:40 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     Aparna M <a-m1@ti.com>
CC:     <nm@ti.com>, <vigneshr@ti.com>, <kishon@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <praneeth@ti.com>, <nikhil.nd@ti.com>
Subject: Re: [RESEND PATCH v3] arm64: dts: ti: k3-am642-sk: Enable WLAN
 connected to SDHCI0
Message-ID: <20220419165340.7ijajo4pekaqi6yh@bryanbrattlof.com>
References: <20220414133612.13365-1-a-m1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20220414133612.13365-1-a-m1@ti.com>
User-Agent: NeoMutt/20171215
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

On April 14, 2022 thus sayeth Aparna M:
> From: Kishon Vijay Abraham I <kishon@ti.com>
> 
> WL1837 module is connected to SDHCI0 in AM642 SK. Enable it here.
> This will enable the WiFi functionaliy on the board.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Nikhil Devshatwar <nikhil.nd@ti.com>
> Signed-off-by: Aparna M <a-m1@ti.com>

Looks good to me!

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan

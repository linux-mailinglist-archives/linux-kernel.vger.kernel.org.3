Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F28E5A6F61
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 23:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiH3VpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 17:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbiH3Vos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 17:44:48 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00758FD6D;
        Tue, 30 Aug 2022 14:44:19 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27ULiBbK012170;
        Tue, 30 Aug 2022 16:44:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661895851;
        bh=z2NpbXDIb3DC16WpA+fL1a0l8vRBTWpRJulyloiQvqw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=N3oCaYFPvGM9nSkpBChbc6zf0n4gMR+V2oVfEc8yOQJlxVqztedH2heIWp+7wLluv
         w6h8GMZrZ3nHci4WgJX9AaAR59yPjZz5eW6x2dqJMM3rbX9wzuMah21kWTi1Rlu4IH
         qdjXG+39ovbVFrKJBJRUjw2tVklLE0KbIpFn19ps=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27ULiBQh087521
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Aug 2022 16:44:11 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 30
 Aug 2022 16:44:11 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 30 Aug 2022 16:44:11 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27ULiBHI011808;
        Tue, 30 Aug 2022 16:44:11 -0500
Date:   Tue, 30 Aug 2022 16:44:11 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     Roger Quadros <rogerq@kernel.org>
CC:     <nm@ti.com>, <vigneshr@ti.com>, <kishon@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/2] arm64: dts: ti: k3-am64-main: Add GPMC & ELM nodes
Message-ID: <20220830214411.rqbrt5mgnuhwojz4@bryanbrattlof.com>
References: <20220802104456.11069-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20220802104456.11069-1-rogerq@kernel.org>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
User-Agent: NeoMutt/20171215
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

Hi Roger!

On August  2, 2022 thus sayeth Roger Quadros:
> Hi Nishanth,
> 
> This series adds GPMC and ELM controller device tree nodes to
> AM64 SoC's dtsi file.
> 
> Changelog:
> v4
> - Rebased to v5.19
> - use 'ti,am64-elm' compatible for ELM node
> 
> v3
> - Rebased to v5.17-rc1
> 
> v2
> - Fix register sizes for GPMC node.
> - Disable GPMC and ELM nodes in board files. They will be enabled in
> NAND card device tree overlay.
> 
> Roger Quadros (2):
>   arm64: dts: ti: k3-am64-main: Add GPMC memory controller node
>   arm64: dts: ti: k3-am64-main: Add ELM (Error Location Module) node
>
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 28 ++++++++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am642-evm.dts  |  8 +++++++
>  arch/arm64/boot/dts/ti/k3-am642-sk.dts   |  8 +++++++
>  3 files changed, 44 insertions(+)

Reviewed-by: Bryan Brattlof <bb@ti.com>

These look good to me :)

~Bryan

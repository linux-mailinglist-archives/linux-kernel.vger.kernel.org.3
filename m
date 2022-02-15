Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E984B79D9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 22:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244300AbiBOVMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 16:12:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240904AbiBOVMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 16:12:33 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C4E6A06B;
        Tue, 15 Feb 2022 13:12:21 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21FLCCb5101189;
        Tue, 15 Feb 2022 15:12:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644959532;
        bh=QHA9FiW6sTQUWRL+Cb034HLnTWq6uprmaJl1T0uNhqY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=UFarTeK/bPvMdyiMUyA1ScG9YFTwhV8kioXvbduuBK1On+rNWWxXOSmR00Lg6/tZV
         kAaXLKqUGShKac4/Rz/wxQ+epmmWIaNqCN18750mGU+lEuGPGdCBw86X/aEITICN6w
         TxGFpyhDC8vrGbeQ02hyhqob8cBrjfqWkjxgSXF8=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21FLCCFm001929
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Feb 2022 15:12:12 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 15
 Feb 2022 15:12:12 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 15 Feb 2022 15:12:12 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21FLCClW017811;
        Tue, 15 Feb 2022 15:12:12 -0600
Date:   Tue, 15 Feb 2022 15:12:12 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] arm64: dts: ti: Introduce base support for AM62x SoC
Message-ID: <20220215211212.iqamp5dea6qrtus5@magma>
References: <20220208131827.1430086-1-vigneshr@ti.com>
 <20220208131827.1430086-5-vigneshr@ti.com>
 <bc6cb6e1adcf6860a595b71246778733@kernel.org>
 <20220210193459.nl6baranvmqs46bi@coastal>
 <87bkzdljt1.wl-maz@kernel.org>
 <20220211235513.cplmvgfuwe3dhzbs@nearby>
 <87k0e0tirw.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87k0e0tirw.wl-maz@kernel.org>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11:40-20220212, Marc Zyngier wrote:
[...]

> I expect the SRE settings to control all of this, most of which are
> under NS control. You could easily check this by advertising the 3
> missing regions in DT, booting an upstream kernel with KVM and boot a
> GICv2 guest. KVM will also warn if the DT regions are advertised but
> the HW doesn't actually support the MMIO accesses. Feel free to ping
> me offline if you need the runs for this,


Thanks for the offline guidance and clarification. fixup patches for
existing K3 devices posted in [1].

[1] https://lore.kernel.org/all/20220215201008.15235-1-nm@ti.com/

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

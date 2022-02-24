Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4EF4C3342
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 18:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiBXRL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 12:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiBXRLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 12:11:17 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515B8251E68;
        Thu, 24 Feb 2022 09:10:47 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21OHAW9T049160;
        Thu, 24 Feb 2022 11:10:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645722632;
        bh=S2mjOr0Y8RKyDx6kZWYCa3wZ97385sH3NdpLYNxuSGk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=xtTrob5jSLez6lJT9VF+2EtpoZBjRduO91jho9UKFL7fclCNIKIC8ofDVqe8I8ixl
         MiQYwEgYGrtMY7dYUrcPOkyvXkyvk/xjLE969yrhJ1mSZ+o1L2cUUdgONlilqKpy7I
         H5+71gzKjWcDWsUpDIZeYn+r8N4w8oTx31RYHvP8=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21OHAW8E111238
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Feb 2022 11:10:32 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 24
 Feb 2022 11:10:31 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 24 Feb 2022 11:10:32 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21OHAVVb106934;
        Thu, 24 Feb 2022 11:10:31 -0600
Date:   Thu, 24 Feb 2022 11:10:31 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] arm64: dts: ti: Add support for AM62-SK
Message-ID: <20220224171031.n5hd456zmtezhhdb@debug>
References: <20220216171815.384377-1-vigneshr@ti.com>
 <20220216171815.384377-6-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220216171815.384377-6-vigneshr@ti.com>
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

On 22:48-20220216, Vignesh Raghavendra wrote:
> From: Nishanth Menon <nm@ti.com>
> 
> AM62 StarterKit (SK) board is a low cost, small form factor board
> designed for TI’s AM625 SoC. It supports the following interfaces:
> * 2 GB DDR4 RAM

[...]
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		secure_tfa_ddr: tfa@9e780000 {
> +			reg = <0x00 0x9e780000 0x00 0x80000>;
> +			alignment = <0x1000>;
> +			no-map;
> +		};
> +
> +		secure_ddr: optee@9e800000 {
> +			reg = <0x00 0x9e800000 0x00 0x01800000>; /* for OP-TEE */
> +			alignment = <0x1000>;
> +			no-map;
> +		};
> +
> +		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@a0000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa0000000 0x00 0x200000>;
> +			no-map;
> +		};

Hate to bring this up so late in the review cycle.. but:

Could we update this so that we use 0xa0000000 (512MB as the outer
memory bound) and bring the firmware contiguous to that?

Else, we create a bit of holes in the memory map which will
create problems eventually as memory fragments.

While it is more optimal for this specific system to move the entire chunk
towards the far end of 2GB, I do realize that folks do use TI platforms
as the reference code and a reasonable usage of am62 (assuming gpu,
display, camera usage) is better done with 512MB.. Though smaller
systems may exist where further customizations is necessary..


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

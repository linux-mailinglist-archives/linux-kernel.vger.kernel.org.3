Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8804A79C4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 21:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347272AbiBBUwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 15:52:03 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56650 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiBBUwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:52:02 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 212Kq0FJ016697;
        Wed, 2 Feb 2022 14:52:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1643835120;
        bh=l4aWvodyZQrddXN83yNtuVGUBE2ly/4weD8xayGZ9Q4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=nq4C8qaMiy1eBK2QL8azSzyICyvsr0uGSurhU7QL/s0qeZgQKAdLKnpM60oX1mM74
         yhFZuKJ8sn9Y5fg8V3sa00VRmWNhP5enFjExa25uDgQWnCMGDnME5m9OwRFa/uhQr3
         3EEorRaOyG/NzL2ylv+GyOcsVF6VprbVg+DZTyxY=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 212Kq0eL040669
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Feb 2022 14:52:00 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 2
 Feb 2022 14:51:59 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 2 Feb 2022 14:51:58 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 212KpwMg106303;
        Wed, 2 Feb 2022 14:51:59 -0600
Date:   Wed, 2 Feb 2022 14:51:58 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 0/2] J721S2: Add support for PCIE
Message-ID: <20220202205158.5lijbovhp56rdxbx@dayroom>
References: <20220125131225.871-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220125131225.871-1-a-govindraju@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18:42-20220125, Aswath Govindraju wrote:
> The following series of patches add support for single
> instance of PCIe brought out on J721S2 common processor
> board.
> 
> Notes:
> - Applying this patch series **breaks the boot** of J721S2.
>   This is because of the following commit,
>   "19e863828acf PCI: j721e: Drop redundant struct device *"
>   Dicussions are currently ongoing regarding the required
>   fix.
> 
> - This needs to be merged after the following patch
>   to avoid dtbs_check errors
>   https://lkml.org/lkml/2021/11/29/1752

Lets pick this up in 5.18-rc1 window then for 5.19
(assuming this will make it to master by 5.18-rc1)

> 
> Aswath Govindraju (2):
>   arm64: dts: ti: k3-j721s2-main: Add PCIe device tree node
>   arm64: dts: ti: k3-j721s2-common-proc-board: Enable PCIe
> 
>  .../dts/ti/k3-j721s2-common-proc-board.dts    | 14 ++++++
>  arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    | 48 +++++++++++++++++++
>  2 files changed, 62 insertions(+)

Also, please notice the following in MAINTAINER file and make sure lakml
is in cc next time.
 L:      linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

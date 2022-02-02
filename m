Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4381F4A79C2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 21:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347300AbiBBUuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 15:50:21 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56340 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiBBUuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:50:20 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 212KoIhn016273;
        Wed, 2 Feb 2022 14:50:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1643835018;
        bh=w0kEcGmy4u4ohA9dsA+hA206cBEAO9DhwFWjLDSZzm4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=J3SjBhWYX8AoYbY+/MdBw2Bv41P/b3/i6070GrfXA5NZB0L9PhARMjEdpRVwgGewf
         fLYMM7//ejoBFo0IDOmUTIvLVS+gIvyL1MWcso5aAnLvYVMkMM5187aSpTPSmLlA18
         +1M8i71E4G/BlmslRLunDakc7jXHoE/C4kvHbD+E=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 212KoIFA088101
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Feb 2022 14:50:18 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 2
 Feb 2022 14:50:18 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 2 Feb 2022 14:50:18 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 212KoI0t071138;
        Wed, 2 Feb 2022 14:50:18 -0600
Date:   Wed, 2 Feb 2022 14:50:18 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 0/6] J721S2: Add support for additional IPs
Message-ID: <20220202205018.i3hvomfvfehjiew7@washcloth>
References: <20220125131113.727-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220125131113.727-1-a-govindraju@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18:41-20220125, Aswath Govindraju wrote:
> The following series of patches add support for the following
> on J721S2 common processor board,
> 
> - USB
> - SerDes
> - OSPI
> 
> Aswath Govindraju (6):
>   arm64: dts: ti: k3-j721s2-main: Add support for USB
>   arm64: dts: ti: k3-j721s2-main: Add SERDES and WIZ device tree node
>   arm64: dts: ti: k3-j721s2-mcu-wakeup: Add support of OSPI
>   arm64: dts: ti: k3-j721s2-common-proc-board: Enable SERDES0
>   arm64: dts: ti: k3-j721s2-common-proc-board: Add USB support
>   arm64: dts: k3-j721s2: Add support for OSPI Flashes
> 
>  .../dts/ti/k3-j721s2-common-proc-board.dts    |  78 ++++++++++++
>  arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    | 112 ++++++++++++++++++
>  .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     |  40 +++++++
>  arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi  |  42 +++++++
>  4 files changed, 272 insertions(+)


please rebase and repost with LAKML in loop.

Please notice the following in MAINTAINER file:
 L:      linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

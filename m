Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9624676AF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 12:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380508AbhLCLtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 06:49:47 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:47546 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbhLCLtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 06:49:46 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B3BkFfB012028;
        Fri, 3 Dec 2021 05:46:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638531975;
        bh=S843qUaoy9ANfMUAngWIervNBlNyhONi9iljLEuE674=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=fpmxGXorVBeGIeh9TiwwGYiIelR61a/2EnLdxJAS2GsumSkADQkn+pG/LTN4jz0HH
         KvWzzPVWd0BWEAXim9qGOGQCMmX7Hn5gZlG7roX7KpH8B9s1CMsgZyvr6F15cZb5Qx
         TGyeVcbPTPU8MppibfmDMI04GvJn0RaRIBIQDipM=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B3BkFgl095901
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Dec 2021 05:46:15 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 3
 Dec 2021 05:46:14 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 3 Dec 2021 05:46:14 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B3BkDhq011552;
        Fri, 3 Dec 2021 05:46:14 -0600
Date:   Fri, 3 Dec 2021 17:16:13 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>, Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2] arm64: dts: ti: k3-j7200: Correct the d-cache-sets
 info
Message-ID: <20211203114611.dqorti3g6q7k64sz@ti.com>
References: <20211113042640.30955-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211113042640.30955-1-nm@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/21 10:26PM, Nishanth Menon wrote:
> A72 Cluster (chapter 1.3.1 [1]) has 48KB Icache, 32KB Dcache and 1MB L2 Cache
>  - ICache is 3-way set-associative
>  - Dcache is 2-way set-associative
>  - Line size are 64bytes
> 
> 32KB (Dcache)/64 (fixed line length of 64 bytes) = 512 ways
> 512 ways / 2 (Dcache is 2-way per set) = 256 sets.
> 
> So, correct the d-cache-sets info.
> 
> [1] https://www.ti.com/lit/pdf/spruiu1
> 
> Fixes: d361ed88455f ("arm64: dts: ti: Add support for J7200 SoC")
> Reported-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.

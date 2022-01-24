Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2A9498ED8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 20:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351258AbiAXTtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 14:49:01 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:42272 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348547AbiAXTiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 14:38:24 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 20OJcBTK042171;
        Mon, 24 Jan 2022 13:38:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1643053091;
        bh=2VSm/1pDjpYX0i9rXqPyZApM6Xn24Z3fJlyvNFikfFU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=oFY7JIYojnI6Jn4vnGOBGAhzdDNEAf3Vt2ASSNODwJ8fo4TtSSDhdJqZwogXW+aj5
         4OmiWNYDQL09t4QV8TZe5y/bg6kAxI27a27LPJx0aLdPT70ZC/FN8L9HsfHS6cEMb0
         ZWRGTD33GobBbA3kvRthelIaJT1zagymQB7KQbs4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 20OJcBb6072923
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Jan 2022 13:38:11 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 24
 Jan 2022 13:38:11 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 24 Jan 2022 13:38:11 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 20OJcB9o056354;
        Mon, 24 Jan 2022 13:38:11 -0600
Date:   Mon, 24 Jan 2022 13:38:11 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <trini@konsulko.com>
Subject: Re: [PATCH v2] arm64: defconfig: Enable USB drivers for TI K3 SoC
Message-ID: <20220124193811.rsjikgyl3zo5lthi@undress>
References: <20211221152140.15151-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211221152140.15151-1-vigneshr@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20:51-20211221, Vignesh Raghavendra wrote:
> Enable Cadence USB, TI USB and required SERDES drivers to support USB on
> TI K3 SoCs.
> 
> Reported-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> ---
> 
> v2:
> Drop Cadence PCIe driver configs as they cannot be built as modules
> based on feedback at [1].
> 
> v1: https://lore.kernel.org/r/20211208060856.16106-1-vigneshr@ti.com
> 
> [1] https://lore.kernel.org/linux-arm-kernel/CAK8P3a2VSBvOn1o+q1PYZaQ6LS9U4cz+DZGuDbisHkwNs2dAAw@mail.gmail.com/
> 

Picked this up for the next window.

Confirmed with bloat-o-meter that there is no addition to vmlinux

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

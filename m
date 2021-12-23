Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C202847E096
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 09:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242852AbhLWIp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 03:45:57 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44992 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235252AbhLWIp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 03:45:56 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BN8jgCl079471;
        Thu, 23 Dec 2021 02:45:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1640249142;
        bh=Z+yQEI642RFQg+yDv/JXdgiV8iGwYMRMrb/uURPQh/M=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=iOlnEpTp9TLU7h/50Xlz7uj/yDJEkYHRj4ZNfgkmibZgVXCHFrA2jVv9ueFkLxW2u
         V3HuAQkcIGa6gg21VEf6T4hFPSElXs4wTvE1H11ASpUdJCCFWa1k1X3oc/8D74fYkw
         caB8vlKbjuYiaWaD2Dx1g6F+SmZsxlj2ZFYc0qCE=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BN8jg06043933
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Dec 2021 02:45:42 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 23
 Dec 2021 02:45:41 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 23 Dec 2021 02:45:40 -0600
Received: from [10.250.235.203] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BN8jbeC059256;
        Thu, 23 Dec 2021 02:45:38 -0600
Message-ID: <6cad0563-7d0d-a079-e4ba-0ac70b8b43b8@ti.com>
Date:   Thu, 23 Dec 2021 14:15:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] arm64: defconfig: Enable USB, PCIe and SERDES drivers for
 TI K3 SoC
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>
References: <20211208060856.16106-1-vigneshr@ti.com>
 <163955131473.14033.7244198185344623653.b4-ty@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <163955131473.14033.7244198185344623653.b4-ty@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 15/12/21 12:37 pm, Vignesh Raghavendra wrote:
> Hi Vignesh Raghavendra,
>  
> On Wed, 8 Dec 2021 11:38:56 +0530, Vignesh Raghavendra wrote:
>> Enable Cadence PCIe, Cadence USB, TI USB and PCIe wrappers and required
>> SERDES drivers to support USB and PCIe on TI K3 SoCs.
>>
>>
>  
> I have applied the following to branch ti-k3-config-next on [1].
> Thank you!
>  
> [1/1] arm64: defconfig: Enable USB, PCIe and SERDES drivers for TI K3 SoC
>       commit: 8d73aedca28cbed8030067b0d9423a0694139b9c
>  

Dropped this in favor or v2 [1] which only keeps USB driver configs. 
PCIe will be added once its build-able as module based on comments at [2]

[1] https://lore.kernel.org/all/20211221152140.15151-1-vigneshr@ti.com/
[2] https://lore.kernel.org/linux-arm-kernel/CAK8P3a2VSBvOn1o+q1PYZaQ6LS9U4cz+DZGuDbisHkwNs2dAAw@mail.gmail.com/

Regards
Vignesh

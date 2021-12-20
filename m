Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029C247B242
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 18:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbhLTRks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 12:40:48 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52728 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhLTRkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 12:40:47 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BKHeTTs113080;
        Mon, 20 Dec 2021 11:40:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1640022029;
        bh=yjMSPgS+YdxF6qi9e0afpWmUOzHLHzIDBDUpU3x/N3s=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=sTOL7PffNydu5v3HWs59GQ4Z28e2HBnINFdXotfzKZO8OjJBJxT4crGltAkcybEFW
         SCHJpta0n6010UcUu9r+siN19WMXNpKZZ2ij2IxtkFOLiJSDGYDvK8OPMA8Obu1BZI
         huCKfCbUzmZf85Lv4urOys15d/CzYjdL4D/XcwU8=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BKHeTNi023384
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Dec 2021 11:40:29 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 20
 Dec 2021 11:40:28 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 20 Dec 2021 11:40:28 -0600
Received: from [10.250.235.203] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BKHePwc021368;
        Mon, 20 Dec 2021 11:40:26 -0600
Message-ID: <06e60038-1365-fc35-801e-448c9025fb2a@ti.com>
Date:   Mon, 20 Dec 2021 23:10:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [GIT PULL 1/2] arm64: TI K3 SoC configs changes for v5.17
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Nishanth Menon <nm@ti.com>, Olof Johansson <olof@lixom.net>,
        SoC <soc@kernel.org>, arm-soc <arm@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211217172806.10023-1-vigneshr@ti.com>
 <CAK8P3a2VSBvOn1o+q1PYZaQ6LS9U4cz+DZGuDbisHkwNs2dAAw@mail.gmail.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <CAK8P3a2VSBvOn1o+q1PYZaQ6LS9U4cz+DZGuDbisHkwNs2dAAw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 20/12/21 8:57 pm, Arnd Bergmann wrote:
> On Fri, Dec 17, 2021 at 6:28 PM Vignesh Raghavendra <vigneshr@ti.com> wrote:
>>
>> The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:
>>
>>   Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)
>>
>> are available in the Git repository at:
>>
>>   https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-k3-config-for-v5.17
>>
>> for you to fetch changes up to 8d73aedca28cbed8030067b0d9423a0694139b9c:
>>
>>   arm64: defconfig: Enable USB, PCIe and SERDES drivers for TI K3 SoC (2021-12-14 16:22:25 +0530)
>>
>> ----------------------------------------------------------------
>> ARM64 defconfig changes for TI K3 platforms for v5.17 merge window:
>>
>> - Increase No. of 8250 UARTs supported in System to 16 for J721s2
> 
> This looks a little excessive, I'm holding off on this pull request
> for now, as I'm
> not sure exactly what the downsides are.
> 
> I see that your dtsi file has
> 
> +       aliases {
> +               serial0 = &wkup_uart0;
> +               serial1 = &mcu_uart0;
> +               serial2 = &main_uart0;
> +               serial3 = &main_uart1;
> +               serial4 = &main_uart2;
> +               serial5 = &main_uart3;
> +               serial6 = &main_uart4;
> +               serial7 = &main_uart5;
> +               serial8 = &main_uart6;
> +               serial9 = &main_uart7;
> +               serial10 = &main_uart8;
> +               serial11 = &main_uart9;
> +               mmc0 = &main_sdhci0;
> +               mmc1 = &main_sdhci1;
> +               can0 = &main_mcan16;
> +               can1 = &mcu_mcan0;
> +               can2 = &mcu_mcan1;
> +               can3 = &main_mcan3;
> +               can4 = &main_mcan5;
> +       };
> 
> which I think is the underlying problem here. The aliases are really meant to
> be board specific, and I would assume that none of the boards actually
> uses all the
> uart and can bus devices, usually this isn't even possible due to pinctrl
> constraints, so please follow up by moving these to the .dts files listing only
> the actually used devices instead of working around it in the defconfig.

Yes indeed, aliases can be trimmed and moved to board dts. With that,
defconfig patch in question can be dropped. Thanks for the hint.

> 
>> - Enable USB, PCIe and SERDES drivers on TI K3 SoC
> 
> I see the PCIe driver is built-in here. Is that necessary for booting?
> If not, please
> make it a loadable module.
> 

Currently its not possible to build PCIE_CADENCE_PLAT_HOST/EP drivers as
modules (symbols are bool only).
PCIe is not necessary for basic boot either. So, I can drop these
configs until these drivers are build able as modules, if you prefer.

Will respin the PRs with comments addressed. Sorry for the trouble.

Regards
Vignesh


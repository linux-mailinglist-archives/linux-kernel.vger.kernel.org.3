Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64A4473EAB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 09:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhLNItz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 03:49:55 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:55200 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhLNItx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 03:49:53 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BE8nJYj011323;
        Tue, 14 Dec 2021 02:49:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1639471759;
        bh=cHnX/tiU2wcWzH72p6sr7/qnhRlo54nxLs6LlSfFEC0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=eMKhfnJ+8/Bb6fs3wicmphZoqs5RyD6E+MF/Swe9tCW5KVxymdI17mYmDSzr+JU8d
         ErLhyt8YOcy7GlYbkHdfqi9L6uIQK0/5Fip3e0Aqs4VdoW9a/HpBZ8q+s+Hz0n6Jcs
         xsi2/tFBT7RHJLzRYhvI7mivwvxUUU9k/es1MSh0=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BE8nJk1063796
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Dec 2021 02:49:19 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 14
 Dec 2021 02:49:19 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 14 Dec 2021 02:49:19 -0600
Received: from [10.250.232.32] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BE8nAV3071856;
        Tue, 14 Dec 2021 02:49:12 -0600
Subject: Re: [PATCH] arm64: defconfig: Increase the maximum number of
 8250/16550 serial ports
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sameer Pujar <spujar@nvidia.com>,
        Zenghui Yu <yuzenghui@huawei.com>, Nishanth Menon <nm@ti.com>,
        Saravana Kannan <saravanak@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20211208080737.10761-1-a-govindraju@ti.com>
From:   Apurva Nandan <a-nandan@ti.com>
Message-ID: <3ab9addf-7938-fcf3-6147-15a998e37d2d@ti.com>
Date:   Tue, 14 Dec 2021 14:19:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211208080737.10761-1-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08/12/21 1:37 pm, Aswath Govindraju wrote:
> On some TI SoCs the number of UART instances used can be greater than 4.
> For example in TI's J721S2 SoC, 11th instance of UART is used as console.
> So, increase the maximum number of instances to 16.
>
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>

Reviewed-by: Apurva Nandan <a-nandan@ti.com>

> ---
>   arch/arm64/configs/defconfig | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 0da6a944d5cd..adb9f1f0802d 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -409,6 +409,8 @@ CONFIG_SERIAL_8250_SHARE_IRQ=y
>   CONFIG_SERIAL_8250_BCM2835AUX=y
>   CONFIG_SERIAL_8250_DW=y
>   CONFIG_SERIAL_8250_OMAP=y
> +CONFIG_SERIAL_8250_NR_UARTS=16
> +CONFIG_SERIAL_8250_RUNTIME_UARTS=16
>   CONFIG_SERIAL_8250_MT6577=y
>   CONFIG_SERIAL_8250_UNIPHIER=y
>   CONFIG_SERIAL_OF_PLATFORM=y

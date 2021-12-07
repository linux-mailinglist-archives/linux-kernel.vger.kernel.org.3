Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E3D46BC53
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 14:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236642AbhLGNXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 08:23:46 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36520 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbhLGNXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 08:23:44 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B7DJuYj025207;
        Tue, 7 Dec 2021 07:19:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638883196;
        bh=v/6aq2797oij1s5lipUAq6dL/uBHuD+VUvfMzrdyUdw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=FAfxRO7L0FQ3rTgTfhSQY2bjNf4WgveuuaMv1OG0GXjyFefkAJEG+mVfjoZMqKN34
         qCETLKCcuawOnT9RcBXgHQJH+AWL2sCoHPcOXKe11lYwPwwQjxiIeTaWPa6Dn2o/tC
         gKq8IAiVMtFQHXsIqF89KuPX3MZ1XVxuIIqIJ3+g=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B7DJuOE078582
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Dec 2021 07:19:56 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 7
 Dec 2021 07:19:56 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 7 Dec 2021 07:19:56 -0600
Received: from [10.250.232.32] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B7DJouG110240;
        Tue, 7 Dec 2021 07:19:51 -0600
Subject: Re: [PATCH v5 2/6] arm64: dts: ti:
 am654-base-board/am65-iot2050-common: Disable mcan nodes
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211122134159.29936-1-a-govindraju@ti.com>
 <20211122134159.29936-3-a-govindraju@ti.com>
From:   Apurva Nandan <a-nandan@ti.com>
Message-ID: <f5e66abb-5c84-eccd-dc7f-333b525fafae@ti.com>
Date:   Tue, 7 Dec 2021 18:49:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211122134159.29936-3-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22/11/21 7:11 pm, Aswath Govindraju wrote:
> AM654 base board and iot platforms do not have mcan instances pinned out.
> Therefore, disable all the mcan instances.
>
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>

Reviewed-by: Apurva Nandan <a-nandan@ti.com>

> ---
>   arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 8 ++++++++
>   arch/arm64/boot/dts/ti/k3-am654-base-board.dts     | 8 ++++++++
>   2 files changed, 16 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> index 65da226847f4..1e0112b90d9f 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> @@ -646,6 +646,14 @@
>   	reset-gpios = <&wkup_gpio0 27 GPIO_ACTIVE_HIGH>;
>   };
>   
> +&m_can0 {
> +	status = "disabled";
> +};
> +
> +&m_can1 {
> +	status = "disabled";
> +};
> +
>   &pcie1_ep {
>   	status = "disabled";
>   };
> diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> index cfbcebfa37c1..9043f91c9bec 100644
> --- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> @@ -416,6 +416,14 @@
>   	status = "disabled";
>   };
>   
> +&m_can0 {
> +	status = "disabled";
> +};
> +
> +&m_can1 {
> +	status = "disabled";
> +};
> +
>   &mailbox0_cluster0 {
>   	interrupts = <436>;
>   

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAAB472DBF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237893AbhLMNr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:47:29 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:61102 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbhLMNr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:47:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639403248; x=1670939248;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=KKsyEsLvCwdpx/lHfagjgXFAsOsM7vc7QnEmLu/Hv+E=;
  b=mA3AqVoKed1my2yikUnukzB9ucmaiNmYVwKUFj8hxDzG9OkFerrMGAeT
   26hJuc7nwoNKTxUsmA0nW8i8ujudybBB6cAjS8GaOV0RJ8Jl0LZiEA1CK
   1u0T1O5czhxrOK7/uS2k0msTdsQCt1wcvEy1ScNpbC1SiwuDSV0X//sFU
   +F7Q133AibC1GItTa3+nES5ImDCIazjpDnwMuLN43ioUXFq+UCdI0GsEl
   0ASREWiGDRskOUYdQI4BIVkLobiyWjlKUaG/lvMv7Ftiy35SMeSOuQBoQ
   oeOAS1fG+7sb58Ywl1P49Nwjb3Dv3qLdzz1kj4iB444QCmQ9LBpL43MTs
   Q==;
IronPort-SDR: adSRH73z+5u3KNr2tV9QV+zhEk15y6wsROniJaRlx3lEaxTSkMbou7BhHcGARBqr4/zhQsRTmH
 hrK7HkxU1z4M3UtjcL35HFrnt4EYVwTp7QN10qWhpaO/srSzU/o6+JgALay8lleTfJxCF0zYLW
 4Ij83RQLqijBA+IXGvd9oCtQTFI/jEwHTUFz72Fse/uCgHzLteFhXqSZ7xSWAz0zRn6M0hXQdI
 wkOmBmJYwVlPSY4PLHVya3NaIGWEhfBBaIiyZaQuX3QprnZkIO1//eJVww3RwhnAHs0W8iZH3w
 oO05nism4LwxS1AfCePGuezT
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="146465812"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Dec 2021 06:47:28 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Dec 2021 06:47:27 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 13 Dec 2021 06:47:26 -0700
Subject: Re: [PATCH] ARM: dts: at91: sama5d2: Name the qspi clock
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211209102542.254153-1-tudor.ambarus@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <050bb635-4462-793c-dcd4-97335ca2932c@microchip.com>
Date:   Mon, 13 Dec 2021 14:47:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211209102542.254153-1-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2021 at 11:25, Tudor Ambarus wrote:
> Naming clocks is a good practice. The atmel-quadspi driver supports
> an unnamed clock for the peripheral clock in order to be backward
> compatible with old DTs, but it is recommended to name the clocks
> on new DTs. The driver's bindings file requires the clock-names
> property, so name the clock.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Queued in at91-dt branch for 5.17.
Best regards,
   Nicolas

> ---
>   arch/arm/boot/dts/sama5d2.dtsi | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
> index 801969c113d6..09c741e8ecb8 100644
> --- a/arch/arm/boot/dts/sama5d2.dtsi
> +++ b/arch/arm/boot/dts/sama5d2.dtsi
> @@ -288,6 +288,7 @@ qspi0: spi@f0020000 {
>   				reg-names = "qspi_base", "qspi_mmap";
>   				interrupts = <52 IRQ_TYPE_LEVEL_HIGH 7>;
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 52>;
> +				clock-names = "pclk";
>   				#address-cells = <1>;
>   				#size-cells = <0>;
>   				status = "disabled";
> @@ -299,6 +300,7 @@ qspi1: spi@f0024000 {
>   				reg-names = "qspi_base", "qspi_mmap";
>   				interrupts = <53 IRQ_TYPE_LEVEL_HIGH 7>;
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 53>;
> +				clock-names = "pclk";
>   				#address-cells = <1>;
>   				#size-cells = <0>;
>   				status = "disabled";
> 


-- 
Nicolas Ferre

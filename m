Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC9D4C2ED1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbiBXPAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234948AbiBXPAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:00:03 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D243426834C;
        Thu, 24 Feb 2022 06:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645714769; x=1677250769;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ORDMBlKCGSdSfHM8GA+311LvkiZtIfohu3XDDYVXTUo=;
  b=avyvOQmmF4BPcZcaesDapZhEzVsXUXhtWe2l+KWfsHByG3VsWz/xiho9
   orMS5UNJokPWBNN1qxwpmasgdMXkoH6EcnL3PlNCLCxppWsvDnCzJiAW1
   7hMlI60fhpXPG1L7lT6TIfoIwxm3W7sjc9/fdhtK3ssUsHpjvrM3ErPA9
   /nJAxxD7vdf9MHdnRAUScamy7Cd0wMQHccULa8hLsiyvjYKKUQ5gTAiK1
   gPMhgBhbo+VqII3LS/ENTDXCQ0dy7NbhFskK8WzIecVmd0RaC2Oex7j3f
   Xw7dIIiCPVdcf6G6Rs5r8hcQe1OILPdufaeX10/UXR5YNJ1Sw2lkNRUID
   w==;
X-IronPort-AV: E=Sophos;i="5.90,134,1643698800"; 
   d="scan'208";a="154765321"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Feb 2022 07:59:29 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 24 Feb 2022 07:59:29 -0700
Received: from [10.12.73.51] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 24 Feb 2022 07:59:26 -0700
Message-ID: <d0c4262c-097d-18da-cb51-5409f6e02b61@microchip.com>
Date:   Thu, 24 Feb 2022 15:59:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 6/8] ARM: dts: at91: sama7g5: add opps
Content-Language: en-US
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <robh+dt@kernel.org>, <linux@armlinux.org.uk>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20211216141338.35144-1-claudiu.beznea@microchip.com>
 <20211216141338.35144-7-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20211216141338.35144-7-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/12/2021 at 15:13, Claudiu Beznea wrote:
> Add OPPs for SAMA7G5 along with clock for CPU.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Queued in at91-dt branch.

Regards,
   Nicolas

> ---
>   arch/arm/boot/dts/sama7g5.dtsi | 37 ++++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
> index 7039311bf678..22352ef5bc72 100644
> --- a/arch/arm/boot/dts/sama7g5.dtsi
> +++ b/arch/arm/boot/dts/sama7g5.dtsi
> @@ -30,6 +30,43 @@ cpu0: cpu@0 {
>   			device_type = "cpu";
>   			compatible = "arm,cortex-a7";
>   			reg = <0x0>;
> +			clocks = <&pmc PMC_TYPE_CORE PMC_CPUPLL>;
> +			clock-names = "cpu";
> +			operating-points-v2 = <&cpu_opp_table>;
> +		};
> +	};
> +
> +	cpu_opp_table: opp-table {
> +		compatible = "operating-points-v2";
> +
> +		opp-90000000 {
> +			opp-hz = /bits/ 64 <90000000>;
> +			opp-microvolt = <1050000 1050000 1225000>;
> +			clock-latency-ns = <320000>;
> +		};
> +
> +		opp-250000000 {
> +			opp-hz = /bits/ 64 <250000000>;
> +			opp-microvolt = <1050000 1050000 1225000>;
> +			clock-latency-ns = <320000>;
> +		};
> +
> +		opp-600000000 {
> +			opp-hz = /bits/ 64 <600000000>;
> +			opp-microvolt = <1050000 1050000 1225000>;
> +			clock-latency-ns = <320000>;
> +		};
> +
> +		opp-800000000 {
> +			opp-hz = /bits/ 64 <800000000>;
> +			opp-microvolt = <1150000 1125000 1225000>;
> +			clock-latency-ns = <320000>;
> +		};
> +
> +		opp-1000000002 {
> +			opp-hz = /bits/ 64 <1000000002>;
> +			opp-microvolt = <1250000 1225000 1300000>;
> +			clock-latency-ns = <320000>;
>   		};
>   	};
>   


-- 
Nicolas Ferre

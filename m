Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C03522B96
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 07:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238266AbiEKFSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 01:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbiEKFSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 01:18:43 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9E0236751;
        Tue, 10 May 2022 22:18:41 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 24B5IRwB055809;
        Wed, 11 May 2022 00:18:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1652246307;
        bh=ocp2OFn34/c6itK1bsa20Ar5O4tHoAj1bez1LMem7Mo=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=pdN63RpCupnJe1XBicp1C5TaGRaIm6BHbj7zXahdLcCcUvGMlHeUWpmPsYSlnuAGb
         ro779RPX2dy9ZQ60Pf9NwiwZZkIAu6DJbOtSLbEaW7ii8+KBys6Kc0NOTZUSTj9zZB
         Twcp2i2p+khx0IQcsvHIneUHbaXSIHIqleLiU8g0=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 24B5IR90122211
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 May 2022 00:18:27 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 11
 May 2022 00:18:26 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 11 May 2022 00:18:26 -0500
Received: from [172.24.145.176] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 24B5IOm2011450;
        Wed, 11 May 2022 00:18:24 -0500
Message-ID: <2536fe30-10ec-8e44-ddcc-e3eeb808b7e2@ti.com>
Date:   Wed, 11 May 2022 10:48:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 4/4] arm64: dts: ti: k3-am625-sk: Add DSS ports, HDMI
 tx & peripherals
Content-Language: en-US
To:     Aradhya Bhatia <a-bhatia1@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Rahul T R <r-ravikumar@ti.com>
References: <20220505134303.23208-1-a-bhatia1@ti.com>
 <20220505134303.23208-5-a-bhatia1@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20220505134303.23208-5-a-bhatia1@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aradhya,

On 05/05/22 19:13, Aradhya Bhatia wrote:
> +
> +	sii9022: sii9022@3b {
> +		compatible = "sil,sii9022";

Please convert 
Documentation/devicetree/bindings/display/bridge/sii902x.txt to YAML format

> +		reg = <0x3b>;
> +
> +		clocks = <&hdmi_mstrclk>;
> +		clock-names = "mclk";
> +
> +		interrupt-parent = <&exp1>;
> +		interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +
> +				sii9022_in: endpoint {
> +					remote-endpoint = <&dpi1_out>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +
> +				sii9022_out: endpoint {
> +					remote-endpoint = <&hdmi_connector_in>;
> +				};
> +			};
> +		};
> +	};

-- 
Regards
Vignesh

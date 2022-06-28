Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69F555CF63
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343530AbiF1Gep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 02:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245712AbiF1GeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 02:34:02 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7288DF6A;
        Mon, 27 Jun 2022 23:34:00 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25S6XnhV075706;
        Tue, 28 Jun 2022 01:33:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1656398029;
        bh=gQpauwvT+3IQ8TE9iAJyxTmOdu5H7mkPZ8142Alt/ZQ=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=CcedCWVNtcXPfdTNMyDG/eZ3M3lIqIfACq25+4HoyA/5yjJdWG99LBrDnLMdYpz57
         RRojxX1Ec3PV5Gl/B2hMWOaJrl2wSahEHyYhciFrmNcmnW2zqjge6q8iJGCMigsCXy
         ZQxwbWSMN/tpoM2rEN7GZcIgGqicjP+dPFlLbJ4k=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25S6Xnhk036982
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Jun 2022 01:33:49 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 28
 Jun 2022 01:33:48 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 28 Jun 2022 01:33:48 -0500
Received: from [172.24.145.182] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25S6XjNn026376;
        Tue, 28 Jun 2022 01:33:46 -0500
Message-ID: <894d0c03-487b-40fc-5634-5b1a78b48701@ti.com>
Date:   Tue, 28 Jun 2022 12:03:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] arm64: dts: ti: k3-j721s2-main: Enable crypto accelerator
Content-Language: en-US
To:     Jayesh Choudhary <j-choudhary@ti.com>, <devicetree@vger.kernel.org>
CC:     <nm@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220628054518.350717-1-j-choudhary@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20220628054518.350717-1-j-choudhary@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28/06/22 11:15, Jayesh Choudhary wrote:
> +	main_crypto: crypto@4e00000 {
> +		compatible = "ti,j721e-sa2ul";
> +		reg = <0x00 0x4e00000 0x00 0x1200>;
> +		power-domains = <&k3_pds 297 TI_SCI_PD_SHARED>;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges = <0x00 0x04e00000 0x00 0x04e00000 0x00 0x30000>;
> +
> +		dmas = <&main_udmap 0xca40>, <&main_udmap 0x4a40>,
> +				<&main_udmap 0x4a41>;
> +		dma-names = "tx", "rx1", "rx2";


> +		dma-coherent;


Crytpo device itself is not dma-coherent as it can never be bus master.
Its the DMAengine that does data movement and the buffers are to be
mapped to dmaengine provider. So this property should be dropped

> +	};
> +

-- 
Regards
Vignesh

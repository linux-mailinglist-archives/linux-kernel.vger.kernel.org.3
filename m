Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B494DC191
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 09:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbiCQIo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 04:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiCQIoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 04:44:25 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5069E7EA24;
        Thu, 17 Mar 2022 01:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qebBj+gkc2kvx9ifqFk+dfJTkCNI1DqTF7SnP32Vuks=; b=ZNJJWv2ZbPFVF2LACX980lcIsM
        UsQmGVp8skm6bSyA8lOWxxJOq+O4BplK76ULd6lo/DUg7r3uh4EdpnBTmkgvD3I/fMUHVeW+hYzwV
        3lXDMAkXt/6PKg41/gAEJ4GQfgYavL/kPj9PzT299BpPLllQfPr2IqnnEW6XJEqGFw9dSODtJqlfI
        jl+nSYzp7JPODWmmScSnmjkbk+Mhqul3wZhdqt9UsHFlBEWBHcsesZIB9xca+it3IAh5UCfAmjp4n
        nZiX57FoL3TMC5S+7I4yIB8qAkyyFp/8F6BLI4u1kxPufseFpzqd4CgUyOK7vQ2PAQarg/hthpcAz
        W5WfA9ig==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=[192.168.1.10])
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <cyndis@kapsi.fi>)
        id 1nUlim-0003mn-Ta; Thu, 17 Mar 2022 10:43:00 +0200
Message-ID: <8dff97ca-6de5-fa52-bdb8-49b11beddc16@kapsi.fi>
Date:   Thu, 17 Mar 2022 10:42:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 3/3] spi: dt-bindings: Add wait state polling flag
Content-Language: en-US
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>, broonie@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        ashishsingha@nvidia.com
Cc:     skomatineni@nvidia.com, ldewangan@nvidia.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220317012006.15080-1-kyarlagadda@nvidia.com>
 <20220317012006.15080-4-kyarlagadda@nvidia.com>
From:   Mikko Perttunen <cyndis@kapsi.fi>
In-Reply-To: <20220317012006.15080-4-kyarlagadda@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/22 03:20, Krishna Yarlagadda wrote:
> Add flag to enable tpm wait state polling and Tegra Grace binding.
> 
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>   .../devicetree/bindings/spi/nvidia,tegra210-quad.yaml       | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
> index 0296edd1de22..88b00fcad210 100644
> --- a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
> +++ b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
> @@ -20,6 +20,7 @@ properties:
>         - nvidia,tegra186-qspi
>         - nvidia,tegra194-qspi
>         - nvidia,tegra234-qspi
> +      - nvidia,tegra-grace-qspi

nvidia,tegra241-qspi. Similarly in other places that refer to the chip name.

Mikko

>   
>     reg:
>       maxItems: 1
> @@ -57,6 +58,11 @@ patternProperties:
>         spi-tx-bus-width:
>           enum: [1, 2, 4]
>   
> +      nvidia,wait-polling:
> +        description:
> +          Enable TPM wait state polling on supported chips.
> +	type: boolean
> +
>         nvidia,tx-clk-tap-delay:
>           description:
>             Delays the clock going out to device with this tap value.


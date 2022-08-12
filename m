Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1957590DF8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 11:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237882AbiHLJSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 05:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbiHLJST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 05:18:19 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BF2A8302;
        Fri, 12 Aug 2022 02:18:17 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27C9I60U016371;
        Fri, 12 Aug 2022 04:18:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1660295886;
        bh=P7wWzcIh1+Yf2Aevr38WIeunD/omf4ucYJkM7zuVXlI=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=yE5pwbN7FXAgc6taYSPZSuX7Kyp+CzEITgBnufhUTKozTr0MZrWpsrzfh6Z1vR902
         TDmp6ka2uRQ8gHjf/3ZCakF/p5ZAtlt7YA0bwoTgt5G9DWTtEJP+BZwutqZIMGRIT2
         gIe9QD1B4ainynp97W+A46wLa//CR0JuRnl4py2I=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27C9I6MG063002
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Aug 2022 04:18:06 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 12
 Aug 2022 04:18:05 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 12 Aug 2022 04:18:05 -0500
Received: from [10.24.69.12] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27C9I3kQ001924;
        Fri, 12 Aug 2022 04:18:03 -0500
Message-ID: <2e8f74eb-ea0b-bf4a-d5a9-715b30474a7e@ti.com>
Date:   Fri, 12 Aug 2022 14:48:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] spi: dt-bindings: Drop Pratyush Yadav
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220811063826.7620-1-krzysztof.kozlowski@linaro.org>
From:   Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <20220811063826.7620-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 11/08/22 12:08, Krzysztof Kozlowski wrote:
> Emails to Pratyush Yadav bounce ("550 Invalid recipient").  Generic SPI
> properties should be maintained by subsystem maintainer (Mark).  Add
> recent contributor Vaishnav Achath to the Cadence SPI bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Vaishnav Achath, are you ok with that?
Yes, I am good with that.
> ---
>   .../devicetree/bindings/spi/cdns,qspi-nor-peripheral-props.yaml | 2 +-
>   Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml        | 2 +-
>   Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor-peripheral-props.yaml
> index 553601a441a7..510b82c177c0 100644
> --- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor-peripheral-props.yaml
> +++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor-peripheral-props.yaml
> @@ -10,7 +10,7 @@ description:
>     See spi-peripheral-props.yaml for more info.
>   
>   maintainers:
> -  - Pratyush Yadav <p.yadav@ti.com>
> +  - Vaishnav Achath <vaishnav.a@ti.com>
>   
>   properties:
>     # cdns,qspi-nor.yaml
> diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> index 0a537fa3a641..4707294d8f59 100644
> --- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> +++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>   title: Cadence Quad SPI controller
>   
>   maintainers:
> -  - Pratyush Yadav <p.yadav@ti.com>
> +  - Vaishnav Achath <vaishnav.a@ti.com>
>   
>   allOf:
>     - $ref: spi-controller.yaml#
> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> index ce048e782e80..a4abe1588005 100644
> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> @@ -16,7 +16,7 @@ description:
>     their own separate schema that should be referenced from here.
>   
>   maintainers:
> -  - Pratyush Yadav <p.yadav@ti.com>
> +  - Mark Brown <broonie@kernel.org>
>   
>   properties:
>     reg:

-- 
Regards,
Vaishnav
